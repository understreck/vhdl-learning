LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY raknare_tb IS 
END raknare_tb;

ARCHITECTURE behavior OF raknare_tb IS
   -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT raknare  --'raknare' is the name of the module needed to be tested.
--just copy and paste the input and output ports of your module as such. 
    PORT( 
         clk : IN  std_logic;
         nrst : IN  std_logic;
         cout : OUT  std_logic_vector(3 downto 0);
         ud   : in std_logic_vector(1 downto 0)  
        );
    END COMPONENT;
   --declare inputs and initialize them
   signal clk : std_logic := '0';
   signal nrst : std_logic := '1';
   signal ud : std_logic_vector(1 downto 0);
   --declare outputs and initialize them
   signal cout : std_logic_vector(3 downto 0);
   -- Clock period definitions
   constant clk_period : time := 1 ns;
BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut:  raknare PORT MAP (
          clk => clk,
          cout => cout,
          nrst => nrst,
          ud => ud
        );       
 -- Clock process definitions( clock with 50% duty cycle is generated here.
  clk_process :process
        begin
             clk <= '0';
             wait for clk_period/2;  --for 0.5 ns signal is '0'.
             clk <= '1';
             wait for clk_period/2;  --for next 0.5 ns signal is '1'.
        end process;

   stim_proc: process
          begin 
              nrst <= '1';
              ud <="-1";
          wait for 2 ns;
              ud <="11";
          wait for 2 ns;
              ud <="01";
          wait for 2 ns;
              ud <="01";
              nrst <= '0';
          wait for 2 ns;
              nrst <= '1';
              ud <="11";
   end process;
END;
