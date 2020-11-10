----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/12/2017 01:30:11 PM
-- Design Name: 
-- Module Name: ett_lejon - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mealy_lejon is
    Port ( g1 : in STD_LOGIC;
           g2 : in STD_LOGIC;
           clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           ud : out STD_LOGIC_vector(1 downto 0));
end mealy_lejon;

architecture Behavioral of mealy_lejon is
begin
end architecture;
