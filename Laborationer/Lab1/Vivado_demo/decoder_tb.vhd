library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity decoder_tb is
end decoder_tb;

architecture Behavioral of decoder_tb is

    signal SW : std_logic_vector(3 downto 0);
    signal C  : std_logic_vector(2 downto 0);
    
begin

    DUT_i: entity work.decoder port map(
        SW => SW,
        C => C
    );
    
    wave_gen:process
    begin
        for i in 0 to 10 loop
            SW <= std_logic_vector(to_unsigned(i, 4));
            wait for 100 ns;
        end loop;
		
    end process;
	
end Behavioral;
