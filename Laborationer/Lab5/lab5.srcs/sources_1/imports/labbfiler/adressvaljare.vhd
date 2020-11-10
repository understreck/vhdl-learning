----------------------------------------------------------------------------------
-- Namn:        adressvaljare
-- Filnamn:     adressvaljare.vhd
-- Testbench:   adressvaljare_tb.vhd
--
-- Insignaler:
--      clk     - klocksignal, all uppdatering av register sker vid stigande flank
--      n_rst   - synkron resetsignal, aktiv låg
--      DATA    - de 6 minst signifikanta bitarna från instruktionen, används då 
--                nästa adress anges av instruktionen
--      AddrSrc - bestämmer varifrån nästa adress ska hämtas
--      StackOp - styr stacken i adressväljaren
--
-- Utsignaler:
--      A           - nästa adress
--      pc_debug    - nuvarande adress, används för att visa adressen på 
--                    Nexys4 display
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity adressvaljare is
    port(
        clk, n_rst : in std_logic;
        DATA : in std_logic_vector(5 downto 0);
        A : out std_logic_vector(5 downto 0);
        AddrSrc : in std_logic_vector(1 downto 0);
        StackOp : in std_logic_vector(1 downto 0);
        pc_debug : out std_logic_vector(5 downto 0)
    );
end entity;

architecture structural of adressvaljare is
   signal pc, pc_plus_one, A_internal, Tos : STD_LOGIC_VECTOR(5 downto 0);
   signal pc_padded_zero, pc_plus_one_padded_zero : STD_LOGIC_VECTOR(7 downto 0);
begin

pc_padded_zero <= "00" & pc;
pc_plus_one <= pc_plus_one_padded_zero(5 downto 0);

pc_i:entity REG6 port map(
    CLR => n_rst,
    CLK => clk, 
    D => A_internal,
    ENA => '1',
    Q => pc
);
    
pc_incrementer_i:entity ALU8 port map(
    A => pc_padded_zero,
    B => "00000001",
    S => "010",
    Z => open,
    F => pc_plus_one_padded_zero
);

address_mux_i:entity MUX3x6 port map(
    IN0 => pc_plus_one,
    IN1 => Tos,
    IN2 => DATA,
    O => A_internal,
    SEL => AddrSrc
);

stack_i:entity stack port map(
    clk => clk,
    n_rst => n_rst,
    D => pc_plus_one,
    ToS => Tos,
    StackOp => StackOp
);

pc_debug <= pc;
A <= A_internal;

end architecture;