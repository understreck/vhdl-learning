LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;

-- entity declaration for your testbench.Dont declare any ports here
ENTITY mealy_lejon_tb IS 
END mealy_lejon_tb;

ARCHITECTURE behavior OF mealy_lejon_tb IS
   -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT mealy_lejon  --'test' is the name of the module needed to be tested.
--just copy and paste the input and output ports of your module as such. 
    PORT( 
         clk  : IN  std_logic;
         g1   : IN  std_logic;
         g2   : IN  std_logic;
         nrst : IN  std_logic;
         ud   : OUT  std_logic_vector(1 downto 0)		
        );
    END COMPONENT;
   --declare inputs and initialize them
   signal clk  : std_logic := '0';
   signal nrst : std_logic := '1';
   signal g1   : std_logic := '0';
   signal g2   : std_logic := '0';
   --declare outputs and initialize them
   signal ud : std_logic_vector(1 downto 0) := (others =>'0');
   -- Clock period definitions
   constant clk_period : time := 1 ns;
BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: mealy_lejon PORT MAP (
         clk => clk,
          ud => ud,
          nrst => nrst,
		  g1 => g1,
		  g2 => g2
        );       

   -- Clock process definitions( clock with 50% duty cycle is generated here.
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;
   -- Stimulus process
  stim_proc: process
   begin         
        wait for 2 ns;
        nrst <='1';
        wait for 3 ns;
        nrst <='0';
       wait for 2 ns;	-- Exempel på stimulering
           g1 <= '0';
           g2 <= '0';
       wait for 2 ns;	-- Exempel på stimulering
           g1 <= '1';
           g2 <= '0';
       wait for 2 ns;	-- Exempel på stimulering
           g1 <= '1';
           g2 <= '1';
       wait for 2 ns;	-- Exempel på stimulering
           g1 <= '0';
           g2 <= '1';
		   
	   wait for 2 ns;	-- Exempel på stimulering
           g1 <= '0';
           g2 <= '0';
       wait for 2 ns;    -- Exempel på stimulering
           g1 <= '0';
           g2 <= '1';
       wait for 2 ns;    -- Exempel på stimulering
           g1 <= '1';
           g2 <= '1';
       wait for 2 ns;    -- Exempel på stimulering
           g1 <= '1';
           g2 <= '0';
          
wait;
  end process;

END;
