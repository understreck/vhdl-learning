library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DispDriver is
    port(
        clock         : in std_logic;
        incrementBtn  : in std_logic;
        resetBtn      : in std_logic;
        
        blue      : out std_logic := '1';
        green     : out std_logic := '1';

        led       : out std_logic_vector(3 downto 0);
        red       : out std_logic;
        
        anodeOne  : out std_logic;
        anodeTwo  : out std_logic;

        a : out std_logic;
        b : out std_logic;
        c : out std_logic;
        d : out std_logic;
        e : out std_logic;
        f : out std_logic;
        g : out std_logic
    );
end entity DispDriver;

architecture behavioral of DispDriver is
    signal memory: unsigned(3 downto 0) := X"0";

    type BtnState_t is (pressed, released);
    
    signal incrementState, nextIncrementState : BtnState_t := released;

    signal commonTerms : std_logic;
begin
    anodeOne <= '1';
    anodeTwo <= '1';

    led   <= std_logic_vector(memory);

    commonTerms <=
        (memory(3) and memory(2)) or (memory(3) and memory(1));
    red <= not commonTerms;

    nextIncrementState <= pressed when incrementBtn = '1' else released;

    process(clock)
    begin
        if rising_edge(clock) then
            if resetBtn = '1' then
                memory <= X"0";
            elsif 
                nextIncrementState = pressed and
                incrementState = released
            then
                memory <= memory + 1;
            end if;

            incrementState <= nextIncrementState;
        end if;
    end process;

    a <=
        commonTerms or
        (memory(2) and not memory(1) and not memory(0)) or
        (not memory(3) and not memory(2) and not memory(1) and memory(0));

    b <=
        commonTerms or
        (memory(2) and memory(1) and not memory(0)) or
        (memory(2) and not memory(1) and memory(0));

    c <=
        commonTerms or
        (not memory(2) and memory(1) and not memory(0));

    d <=
        commonTerms or
        (memory(2) and not memory(1) and not memory(0)) or
        (not memory(3) and not memory(2) and not memory(1) and memory(0)) or
        (memory(2) and memory(1) and memory(0));

    e <=
        (memory(3) and memory(1)) or
        (memory(0)) or
        (memory(2) and not memory(1));

    f <=
        commonTerms or
        (not memory(2) and memory(1)) or
        (not memory(3) and not memory(2) and memory(0)) or
        (memory(1) and memory(0));

    g <=
        commonTerms or
        (memory(2) and memory(1) and memory(0)) or
        (not memory(3) and not memory(2) and not memory(1));

end architecture behavioral;
