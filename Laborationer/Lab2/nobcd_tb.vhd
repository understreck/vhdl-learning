----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2018 14:28:13
-- Design Name: 
-- Module Name: nobcd_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following  library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nobcd_tb is
 --   Port ( );
end nobcd_tb;

architecture Behavioral of nobcd_tb is
    -- Komponentdeklaration för unit under test (UUT).
    COMPONENT nobcd is                                  -- Ska ha samma namn som modulen som ska testas.
        Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);    -- Kopiera in-porten från modulen
               led : out STD_LOGIC);                      -- Kopiera ut-porten från modulen
    end COMPONENT;
     
    signal x_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal b_tb : STD_LOGIC;

begin
    uut : nobcd PORT MAP (                              -- Instansiera unit under test (UUT).
        sw => x_tb,                                      -- Komponentens portar kopplas till interna signaler.
        led => b_tb
        );
        
    test : process
    begin
    
            x_tb <= "0000";
        wait for 100 ns;
            x_tb <= "0001";
        wait for 100 ns;
            x_tb <= "0010";
        wait for 100 ns;
            x_tb <= "0011";
        wait for 100 ns;
            x_tb <= "0100";
        wait for 100 ns;
            x_tb <= "0101";
        wait for 100 ns;
            x_tb <= "0110";
        wait for 100 ns;
            x_tb <= "0111";
        wait for 100 ns;
             x_tb <= "1000";
        wait for 100 ns;
             x_tb <= "1001";
        wait for 100 ns;
            x_tb <= "1010";
        wait for 100 ns;
            x_tb <= "1011";
        wait for 100 ns;
            x_tb <= "1100";
        wait for 100 ns;
            x_tb <= "1101";
        wait for 100 ns;
            x_tb <= "1110";
        wait for 100 ns;
            x_tb <= "1111";
        wait for 100 ns;
    end process;

end Behavioral;