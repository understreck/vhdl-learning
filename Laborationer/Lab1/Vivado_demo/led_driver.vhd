library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity led_driver is
    Port ( C : in STD_LOGIC_VECTOR (2 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           N_RST : in STD_LOGIC);
end led_driver;

architecture Behavioral of led_driver is

    type state_type is (LIGHT_OFF, 
                        LIGHT_ON,
                        LIGHT_FLASH_STARTUP, 
                        LIGHT_FLASH, 
                        LIGHT_RUN_LEFT_RIGHT_STARTUP,
                        LIGHT_RUN_LEFT_RIGHT, 
                        LIGHT_RUN_EDGE_MIDDLE_STARTUP,
                        LIGHT_RUN_EDGE_MIDDLE 
                        );

    signal current_state, next_state: state_type;
    signal counter : integer range 0 to 2500000-1;
    constant counter_limit : integer := 2500000-1;   
    signal current_led_pattern, next_led_pattern : std_logic_vector(15 downto 0); 
    signal current_direction, next_direction : std_logic;
    
begin

    LED <= current_led_pattern;
     
    register_update:process(N_RST, CLK)
    begin
        if N_RST = '0' then
            counter <= 0;
            current_state <= LIGHT_OFF;
            current_direction <= '0';
            current_led_pattern <= (others => '0');
            
        elsif CLK='1' and CLK'event then
            if counter < counter_limit then
                counter <= counter + 1;
				
            else
                counter <= 0;
                current_state <= next_state;
                current_direction <= next_direction;
                current_led_pattern <= next_led_pattern;
            end if;
			
        end if;
		
    end process;
    
    next_state_logic:process(current_state, C)
    begin 
        next_state <= current_state;
        
        case C is
            when "000"=>
                next_state <= LIGHT_OFF;
                
            when "001" =>
                next_state <= LIGHT_ON;
                
            when "010" =>
                case current_state is
                    when LIGHT_FLASH_STARTUP | LIGHT_FLASH =>
                        next_state <= LIGHT_FLASH;
                        
                    when others =>
                        next_state <= LIGHT_FLASH_STARTUP;
						
                end case;
            
            when "011" =>
                case current_state is
                    when LIGHT_RUN_LEFT_RIGHT_STARTUP | LIGHT_RUN_LEFT_RIGHT =>
                        next_state <= LIGHT_RUN_LEFT_RIGHT;
                        
                    when others =>
                        next_state <= LIGHT_RUN_LEFT_RIGHT_STARTUP;
						
                end case;
                
            when "100" =>
                case current_state is
                    when LIGHT_RUN_EDGE_MIDDLE_STARTUP | LIGHT_RUN_EDGE_MIDDLE =>
                        next_state <= LIGHT_RUN_EDGE_MIDDLE;
                    
                    when others =>
                        next_state <= LIGHT_RUN_EDGE_MIDDLE_STARTUP;
						
                end case;
                
            when others => null;
			
        end case;
		
    end process;
    
    next_direction_logic:process(current_state, current_direction, current_led_pattern)
    begin
        next_direction <= current_direction;
        
        case current_state is
            when LIGHT_RUN_LEFT_RIGHT_STARTUP | LIGHT_RUN_EDGE_MIDDLE_STARTUP =>
                next_direction <= '0';
                
            when LIGHT_RUN_LEFT_RIGHT =>
                if current_led_pattern(14) = '1' then
                    next_direction <= '1';
                
                elsif current_led_pattern(1) = '1' then
                    next_direction <= '0';
					
                end if;
                
            when LIGHT_RUN_EDGE_MIDDLE =>
                if (current_led_pattern(9) = '1') and  (current_led_pattern(6) = '1') then
                    next_direction <= '1';
                
                elsif (current_led_pattern(14) = '1') and (current_led_pattern(1) = '1') then
                    next_direction <= '0';
					
                end if;
				
            when others => null;
			
        end case;
		
    end process;
    
    next_led_output_logic:process(current_state, current_direction, current_led_pattern)
    begin
        next_led_pattern <= current_led_pattern;
        
        case current_state is 
            when LIGHT_OFF =>
                next_led_pattern <= (others => '0');
                              
            when LIGHT_ON =>
                next_led_pattern <= (others => '1');
                
            when LIGHT_FLASH_STARTUP =>
                next_led_pattern <= (others => '1');
                
            when LIGHT_FLASH =>
                next_led_pattern <= NOT current_led_pattern;
                
            when LIGHT_RUN_LEFT_RIGHT_STARTUP =>
                next_led_pattern <= (0 => '1', others => '0');
                
            when LIGHT_RUN_LEFT_RIGHT =>
                if current_direction <= '0' then
                    next_led_pattern <= current_led_pattern(14 downto 0) & current_led_pattern(15);
					
                else
                    next_led_pattern <=  current_led_pattern(0) & current_led_pattern(15 downto 1);
					
                end if;

            when LIGHT_RUN_EDGE_MIDDLE_STARTUP =>
                next_led_pattern <= (0 => '1', 15=>'1', others => '0');
                
            when LIGHT_RUN_EDGE_MIDDLE =>
                if current_direction <= '0' then
                    next_led_pattern <= current_led_pattern(8) & current_led_pattern(15 downto 9) & current_led_pattern(6 downto 0) & current_led_pattern(7);
					
                else
                    next_led_pattern <= current_led_pattern(14 downto 8) & current_led_pattern(15) & current_led_pattern(0) & current_led_pattern(7 downto 1);
					
                end if;
        end case;
		
    end process;
	
end Behavioral;
