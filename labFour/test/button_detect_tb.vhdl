
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity button_detector_tb is
--  Port ( );
end button_detector_tb;

architecture Behavioral of button_detector_tb is
   -- Component Declaration for the Unit Under Test (UUT)
   
   COMPONENT button_detector
       
       Port ( clk : in STD_LOGIC;
          nrst : in STD_LOGIC;
          row : in unsigned (3 downto 0);
          col : out unsigned (3 downto 0);
          number : out signed (3 downto 0));
              
   END COMPONENT;
   
    --declare inputs and initialize them
    signal clk  : std_logic := '0';
    signal nrst : std_logic := '1';
    signal row : unsigned (3 downto 0);
   --declare outputs and initialize them
    signal col : unsigned (3 downto 0);
    --signal col_i : unsigned (3 downto 0);
    signal number : signed (3 downto 0);
    
    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
uut: button_detector PORT MAP (
    clk => clk,
    nrst => nrst,
    row => row,
    col => col,
    number => number
    );       

   -- Clock process definitions( clock with 50% duty cycle is generated here.
  clk_process :process
   begin
        clk <= '0';
        wait for clk_period/10000; 
        clk <= '1';
        wait for clk_period/10000; 
   end process;

   -- Stimulus process
  stim_proc: process
   begin         
        wait for 2 ns;
        nrst <='1';
        wait for 2 ns;
        nrst <='0';
     
        row <= "0001";
     wait for 800 ns;
        row <= "0010";
    wait for 800 ns;
        row <= "0100";
    wait for 800 ns;
        row <= "1000";
    wait for 800 ns;

  end process;

end Behavioral;
