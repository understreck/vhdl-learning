-- calculator.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity calculator is
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           number : in signed (3 downto 0);
           temp_out : out signed (3 downto 0);
           a_out : out signed (3 downto 0);
           b_out : out signed (3 downto 0);
           result_out : out signed (3 downto 0));
end calculator;

architecture Behavioral of calculator is

signal bit_pattern : unsigned (7 downto 0);

signal a_reg : signed (3 downto 0);
signal b_reg : signed (3 downto 0);
signal result_reg : signed (3 downto 0);
signal tmp_reg : signed (3 downto 0);
signal en_a, en_b, en_result, en_temp, zero : STD_LOGIC;
signal calc : signed (3 downto 0);

begin
                       
    temp_out <= tmp_reg;                            -- tmp_reg till utgång temp_out.
    a_out <= a_reg;                                 -- a_reg till a_out.
    b_out<= b_reg;                                  -- b_reg till utgång b_out.
    result_out <= result_reg;                       -- c_reg till utgång result_out.

btn_pressed: process(number, a_reg, b_reg)
    begin
        en_a <= '0';                                -- Registerna behåller sitt gamla värde.
        en_b <= '0';
        en_result <= '0';
        en_temp <= '0';
        zero <= '0';
        calc <= "0000";
        
        if (number = "1100") then                   -- Clear
            zero <= '1';
        
         elsif (unsigned(number) <= "1001") then    -- Om number <= 9
            en_temp <= '1';                         -- 0 - 9 kan skrivas in i temp_reg.

        elsif (number = "1110") then                -- Enter
            en_a <= '1';                            -- a_reg <= tmp_reg.

        elsif (number = "1010") then                -- + tecken.
            en_b <= '1';                            -- b_reg <= tmp_reg.
            calc <= (a_reg + b_reg);                -- calc <= a_reg + b_reg.
            en_result <= '1';                       -- result_reg <= calc, resultatet av beräkningen.
            
        elsif (number = "1011") then                -- - tecken.
            en_b <= '1';                            -- b_reg <= tmp_reg.
            calc <= (a_reg - b_reg);                -- calc <= a_reg - b_reg.
            en_result <= '1';                       -- result_reg <= calc, resultatet av beräkningen.
        else
            en_a <= '0';                            -- Registerna behåller sitt gamla värde.
            en_b <= '0';
            en_result <= '0';
            calc <= "0000";
        end if;
         
    end process;

state_register: process(clk, nrst, tmp_reg, zero)         -- Asynkron reset
    begin
        if(nrst = '1') or (zero = '1') then
        
            a_reg <= (others => '0');               -- Nollställ samtliga register.
            b_reg <= (others => '0');
            result_reg <= (others => '0');
            tmp_reg <= (others => '0');

        elsif CLK='1' and CLK'event then
        
            if (en_a = '1') then
                 a_reg <= tmp_reg;
            end if;
                                 
            if (en_b = '1') then
                 b_reg <= tmp_reg;
            end if;
             
            if (en_result = '1') then
                result_reg <= calc;
            end if;
            
             if (en_temp = '1') then
                tmp_reg <= number;
            end if;           

        end if;
    end process;

end Behavioral;
