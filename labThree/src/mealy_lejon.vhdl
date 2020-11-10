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
    type State_t is (looping, middle);
    signal state, nextState : State_t := looping;

    signal gate : std_logic_vector(1 downto 0);

    constant increment  : std_logic_vector(1 downto 0) := "11";
    constant decrement  : std_logic_vector(1 downto 0) := "01";
    constant dontCare   : std_logic_vector(1 downto 0) := "-0";
begin

    gate(1) <= g1;
    gate(0) <= g2;

    state <= nextState;

    output_p : process(clk)
    begin

        if rising_edge(clk) then
            if state = looping then
                ud <= dontCare;
            elsif state = middle then
                ud <=
                    increment when gate = "01" else
                    decrement when gate = "10" else
                    dontCare;
            end if;
        end if;

    end process output_p;

    state_p : process(clk, nrst)
    begin

        if nrst = '0' then
            nextState <= looping;
        elsif rising_edge(clk) then
            nextState <=
                middle when gate = "11" else
                looping;
        end if;

    end process state_p;

end architecture;
