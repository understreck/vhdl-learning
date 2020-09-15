library ieee;
use ieee.std_logic_1164.all;

entity twoBitComp is 
    port(
        left, right   : in std_logic_vector(1 downto 0);
        equality      : out std_logic
    );
end twoBitComp;

architecture dataFlow of twoBitComp is
    signal results : std_logic_vector(1 downto 0);
begin
    eq_bit0 : entity work.oneBit
        port map (x=>left(0), y=>right(0), z=>results(0));
    eq_bit1 : entity work.oneBit
        port map (x=>left(1), y=>right(1), z=>results(1));

    equality    <= results(1) or results(0);
end dataFlow;
