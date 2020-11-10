library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_demo is
    Port ( SW : in STD_LOGIC_VECTOR (3 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           CLK : in STD_LOGIC;
           N_RST : in STD_LOGIC);
end led_demo;

architecture Behavioral of led_demo is

    signal C : std_logic_vector(2 downto 0);
    
begin

    decoder_i: entity work.decoder port map(
        SW => SW,
        C => C
    );
    
    led_driver_i: entity work.led_driver port map(
        C => C,
        LED => LED,
        CLK => N_RST,
        N_RST => N_RST
    );

end Behavioral;
