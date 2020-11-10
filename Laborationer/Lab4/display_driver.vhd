-- display_driver.vhd
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

entity display_driver is
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           a_out : in signed (3 downto 0);
           b_out : in signed (3 downto 0);
           result_out : in signed (3 downto 0);
           temp_out : in signed (3 downto 0);
           led_a : out signed (3 downto 0);
           led_b : out signed (3 downto 0);
           led_c : out signed (3 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0));
end display_driver;

architecture Behavioral of display_driver is

type state_type2 is(first, second);
signal present_state, next_state: state_type2;
signal display : signed (3 downto 0);
signal counter : integer range 0 to 100000-1;  -- 1 ms
constant counter_limit : integer := 100000-1; 

begin

    led_c <= a_out;
    led_b <= b_out;
    led_a <= result_out;

    with display select  -- Omvandlar binära tal till siffror som skrivs ut på displayen
        seg <= "1000000" when "0000",   -- 0
               "1111001" when "0001",   -- 1
               "0100100" when "0010",   -- 2
               "0110000" when "0011",   -- 3
               "0011001" when "0100",   -- 4
               "0010010" when "0101",   -- 5
               "0000010" when "0110",   -- 6
               "1111000" when "0111",   -- 7
               "0000000" when "1000",   -- 8
               "0010000" when "1001",   -- 9
               "1011011" when "1010",   -- +
               "0111111" when "1011",   -- -
               "1111111" when others;   -- Displayen släckt

disp_logic: process(present_state)      -- Väljer display: (ingen, D0 eller D1).
        begin                                                            
            case present_state is
                when first =>
                    next_state <= second;
                    an <= "11111110";   -- Dipsplay D0.
                    
                when second =>
                    next_state <= first;
                    an <= "11111101";   -- Dipsplay D1.

                when others =>
                    next_state <= first;
                    an <= "11111111";   -- Ingen utskrift.
        end case;                
    end process;
    
out_logic_Mealy: process(present_state, a_out, b_out, result_out, temp_out)
            begin                                                            
                case present_state is
                    when first =>
                        if (result_out > "0000") then
                            display <= result_out;                  -- Skriv ut resultatet på display D0.
                            
                        elsif (result_out = "0000") and ((a_out and b_out) > "0000") then   -- ex. 5 - 5 = 0
                                display <= (result_out);            -- Skriv ut resultatet på display D0.
                                
                        elsif (result_out < "0000") then
                            display <= ((result_out xor "1111")+1); -- Ta 2-komplement på resultatet och skriv ut det på display D0.
                        else
                            display <= temp_out;                   -- Skriv ut innehållet i tmp_reg på display D0.
                        end if;
                        
                    when second =>
                        if(result_out < 0) then                     -- Om resultatet är < 0
                            display <= "1011";                  -- Skriv ut -tecken på display D1.
                        else
                            display <= "1111";                  -- Inget skrivs ut på display D1.
                        end if;
            end case;                
        end process;

state_reg: process(clk, nrst)      -- Asynkron reset
    begin                               -- 100 Hz
        if(nrst = '1') then
            counter <= 0;
            present_state <= first;
            
        elsif CLK='1' and CLK'event then

            if counter < counter_limit then
                counter <= counter + 1;
            else
                counter <= 0;
                present_state <= next_state;
            end if;
        end if;
    end process;

end Behavioral;
