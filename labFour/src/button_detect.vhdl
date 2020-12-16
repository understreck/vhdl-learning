-- button_detector.vhd
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

entity button_detector is
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           row : in unsigned (3 downto 0);
           col : out unsigned (3 downto 0);
           number : out signed (3 downto 0));
           
end button_detector;

architecture Behavioral of button_detector is

type state_type is(s0, s1, s2, s3);

signal present_state, next_state: state_type;

signal bit_pattern : unsigned (7 downto 0); 
signal col_i : unsigned (3 downto 0);
signal row_i : unsigned (3 downto 0);
signal delay1 : unsigned (3 downto 0);
signal delay2 : unsigned (3 downto 0);
signal delay3 : unsigned (3 downto 0);

signal counter : integer range 0 to 100000-1;  -- 1 ms
constant counter_limit : integer := 100000-1; 

begin

scan_logic_Moore: process(present_state)
        begin 
		
-- Fyll i kod  för Moore-maskin  labbuppgift 4.1.1

            end case;        
        end process;
    
    row_i <= delay1 and delay2 and not delay3;      -- Debouncer och pulsgivare.
--  row_i <= row;                                   -- Används vid simulering.    
    col <= col_i;                   -- Signalen col_i används för att sätta ihop
                                    -- rader och kolumner till ett bitmönster.   
    bit_pattern(7 downto 4) <= col_i; 
    bit_pattern(3 downto 0) <= row_i;
           
     with bit_pattern select  -- Omvandlar bitmönstret från tangentbordet till binära tal
         number <= "0000" when "00010001",   -- 0
		 
         -- fyii i kod till tabell labbuppgift 4.1.2
		 
                   "1111" when others;       
 
 
state_register: process(clk, nrst)      -- dela mer frekvensen till 100 Hz
    begin                               
        if(nrst = '1') then
            counter <= 0;
            present_state <= S0;

            delay1 <= "0000";           -- Fördröjningsregister till pulsgivare.
            delay2 <= "0000";
            delay3 <= "0000";
            
        elsif clk='1' and clk'event then
        
        delay1 <= row;    
        delay2 <= delay1;
        delay3 <= delay2;
           
            if counter < counter_limit then
                counter <= counter + 1;
            else
                counter <= 0;
                present_state <= next_state;
            end if;
        end if;       
        
    end process;

end Behavioral;
