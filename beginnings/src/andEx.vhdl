library ieee;
use ieee.std_logic_1164.all;

entity andEx is
    port(
        input_1     : in std_logic;
        input_2     : in std_logic;
        input_3     : in std_logic;
        and_result  : out std_logic
    );
end andEx;

architecture rtl of andEx is
    signal and_gate : std_logic;
begin
    and_gate <= input_1 and input_2 and input_3;
    and_result <= and_gate;
end rtl;


