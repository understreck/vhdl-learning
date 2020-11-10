----------------------------------------------------------------------------------
-- Namn:        registerblock
-- Filnamn:     registerblock.vhd
-- Testbench:   registerblock_tb.vhd
--
-- Insignaler:
--      clk     - klocksignal, all uppdatering av register sker vid stigande flank
--      n_rst   - synkron resetsignal, aktiv låg
--      F       - resultatet från ALU
--      DEST    - bestämmer vilket av registerna R0 och R1 som ska vara aktivt
--      RegEna  - laddsignal till det aktiva registret
--
-- Utsignaler:
--      RegOut  - det aktiva registrets innehåll
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity registerblock is
    port(
        clk : in std_logic;
        n_rst : in std_logic;
        F : in std_logic_vector(7 downto 0);
        DEST : in std_logic;
        RegEna : in std_logic;
        RegOut : out std_logic_vector(7 downto 0)
    );
end entity;

architecture structural of registerblock is
    
    signal R0, R1 : STD_LOGIC_VECTOR(7 downto 0);
    signal ena_R0, ena_R1 : STD_LOGIC;
    
begin

ena_R0 <= (not DEST) and RegEna;
ena_R1 <= DEST and RegEna;

R0_i:entity REG8 port map(
    CLR => n_rst,
    CLK => clk,
    ENA => ena_R0,
    D => F,
    Q => R0
);

R1_i:entity REG8 port map(
    CLR => n_rst,
    CLK => clk,
    ENA => ena_R1,
    D => F,
    Q => R1
);

reg_mux_i:entity MUX2x8 port map(
    IN0 => R0,
    IN1 => R1,
    O => RegOut,
    SEL => DEST
);

end architecture;