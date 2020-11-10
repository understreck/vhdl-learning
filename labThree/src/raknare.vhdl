----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/14/2017 02:11:55 PM
-- Design Name: 
-- Module Name: raknare - Behavioral
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
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity raknare is
    Port ( ud : in STD_LOGIC_VECTOR (1 downto 0);  -- input, räkna och upp eller ner
           clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR (3 downto 0));
end raknare;

architecture Behavioral of raknare is
Fyll i vad som behövs

end Behavioral;
