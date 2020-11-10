
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Display is
    Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0));
end Display;

architecture Behavioral of Display is

begin
    an(0) <= '0';
    
-- Fyll i kod

end Behavioral;
