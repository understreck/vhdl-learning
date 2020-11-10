----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2017 11:32:29 AM
-- Design Name: 
-- Module Name: Fler_lejon - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Fler_lejon is
    Port ( g1   : in STD_LOGIC;
           g2   : in STD_LOGIC;
           clk  : in STD_LOGIC;
           nrst : in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR (3 downto 0)
           );
end entity;

architecture structural of Fler_lejon is
-- component mealy_legon
--   port(
--             g1   : in STD_LOGIC;
--             g2   : in STD_LOGIC;
--             clk  : in STD_LOGIC;
--             nrst : in STD_LOGIC;
--             ud   : out STD_LOGIC_vector(0 to 1)
--              );
-- end component;
   
-- component raknare
--   port (
--               ud  : in STD_LOGIC_VECTOR (1 downto 0);  
--              clk  : in STD_LOGIC;
--              nrst : in STD_LOGIC;
--              cout : out STD_LOGIC_VECTOR (3 downto 0)
--   );
-- end component;
   
signal ig1, ig2 : STD_LOGIC;
signal iud : STD_LOGIC_VECTOR(1 downto 0);
signal icout : STD_LOGIC_VECTOR (3 downto 0);

begin 


bla: entity work.raknare port map(
    ud => iud,
    cout => icout,
    clk => clk,
    nrst => nrst
);

bli: entity work.mealy_lejon port map(
    g1 => ig1,
    g2 => ig2,
    clk => clk,
    nrst => nrst,
    ud => iud
);

ig1 <= g1;
ig2 <= g2;
cout <= icout;



end structural;
