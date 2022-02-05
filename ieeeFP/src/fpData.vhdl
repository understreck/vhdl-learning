library ieee;
use ieee.std_logic_1164.all;

package Common is

type FPNum is record
    sign : std_logic;
    exponent : std_logic_vector(6 downto 0);
    mantissa : std_logic_vector(23 downto 0);
end record FPNum;

end package Common;
