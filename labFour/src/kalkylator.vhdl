-- keyboard.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keyboard is
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           row : in unsigned (3 downto 0);
           col : out unsigned (3 downto 0);
           led_a : out signed (3 downto 0);
           led_b : out signed (3 downto 0);
           led_c : out signed (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0));
end keyboard;

architecture Behavioral of keyboard is

signal irow : unsigned (3 downto 0);
signal icol : unsigned (3 downto 0);
signal iled_a : signed (3 downto 0);
signal iled_b : signed (3 downto 0);
signal iled_c : signed (3 downto 0);
signal iseg : STD_LOGIC_VECTOR (6 downto 0);
signal inumber : signed (3 downto 0);
signal ibit_pattern : unsigned (7 downto 0);
signal temp_out : signed (3 downto 0);
signal itemp_out : signed (3 downto 0);
signal i_a_out : signed (3 downto 0);
signal i_b_out : signed (3 downto 0);
signal result_out : signed (3 downto 0);
signal iresult_out : signed (3 downto 0);
signal ian : STD_LOGIC_VECTOR (7 downto 0);

begin

bla: entity work.button_detector port map(
    row => irow,
    col => icol,
    number => inumber,
    clk => clk,
    nrst => nrst
    );

bli: entity work.display_driver port map(
    seg => iseg,
    an => ian,
    clk => clk,
    nrst => nrst,
    led_a => iled_a,
    led_b => iled_b,
    led_c => iled_c,
    temp_out => itemp_out,
    a_out => i_a_out,
    b_out => i_b_out,
    result_out => iresult_out
    );
    
blc: entity work.calculator port map(
    number => inumber,
    clk => clk,
    nrst => nrst,
    temp_out => itemp_out,
    a_out => i_a_out,
    b_out => i_b_out,
    result_out => iresult_out
    );
    
irow <= row;
an <= ian;
col <= icol;
led_a <= iled_a;
led_b <= iled_b;
led_c <= iled_c;
seg <= iseg;

end Behavioral;
