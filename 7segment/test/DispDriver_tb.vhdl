library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DispDriver_tb is
end entity DispDriver_tb;

architecture behavioral of DispDriver_tb is
       signal clock         : std_logic := '0';
       signal incrementBtn  : std_logic := '0';
       signal resetBtn      : std_logic := '0';

       signal led   : std_logic_vector(3 downto 0);

       signal a : std_logic;
       signal b : std_logic;
       signal c : std_logic;
       signal d : std_logic;
       signal e : std_logic;
       signal f : std_logic;
       signal g : std_logic;
begin

    dispDriver_e: entity work.DispDriver
    port map(
        clock         => clock,
        incrementBtn  => incrementBtn,
        resetBtn      => resetBtn,

        led   => led,

        a => a,
        b => b,
        c => c,
        d => d,
        e => e,
        f => f,
        g => g);

    process
    begin
        for i in 0 to 100 loop
            wait for 10 ns;
            clock <= not clock;

            if clock = '1' then
                incrementBtn <= not incrementBtn;
            end if;
        end loop;
    end process;

end architecture behavioral;
