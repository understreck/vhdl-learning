library ieee;
use ieee.std_logic_1164.all;

entity oneBit is
    port(
        x, y  : in  std_logic;
        z     : out std_logic
    );
end oneBit;

architecture dataFlow of oneBit is
    signal a : std_logic;
    signal b : std_logic;
begin
    a <= x and y;
    b <= (not x) and (not y);

    z <= a or b;
end dataFlow;
