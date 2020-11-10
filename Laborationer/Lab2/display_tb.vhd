library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following  library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_tb is
 --   Port ( );
end display_tb;

architecture Behavioral of display_tb is
    -- Komponentdeklaration för unit under test (UUT).
    COMPONENT Display is                                    -- Ska ha samma namn som modulen som ska testas.
        Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);       -- Kopiera in-porten från modulen
               seg : out STD_LOGIC_VECTOR (6 downto 0);     -- Kopiera ut-porten från modulen
               an : out STD_LOGIC_VECTOR (7 downto 0));
    end COMPONENT;
     
    signal sw_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal seg_tb : STD_LOGIC_VECTOR (6 downto 0);

begin
    uut : Display PORT MAP (                              -- Instansiera unit under test (UUT).
        sw => sw_tb,                                      -- Komponentens portar kopplas till interna signaler.
        seg => seg_tb
        );
        
    test : process
    begin
    
            sw_tb <= "0000";
        wait for 100 ns;
            sw_tb <= "0001";
        wait for 100 ns;
            sw_tb <= "0010";
        wait for 100 ns;
            sw_tb <= "0011";
        wait for 100 ns;
            sw_tb <= "0100";
        wait for 100 ns;
            sw_tb <= "0101";
        wait for 100 ns;
            sw_tb <= "0110";
        wait for 100 ns;
            sw_tb <= "0111";
        wait for 100 ns;
             sw_tb <= "1000";
        wait for 100 ns;
             sw_tb <= "1001";
        wait for 100 ns;
            sw_tb <= "1010";
        wait for 100 ns;
            sw_tb <= "1011";
        wait for 100 ns;
            sw_tb <= "1100";
        wait for 100 ns;
            sw_tb <= "1101";
        wait for 100 ns;
            sw_tb <= "1110";
        wait for 100 ns;
            sw_tb <= "1111";
        wait for 100 ns;
    end process;

end Behavioral;