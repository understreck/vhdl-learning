----------------------------------------------------------------------------------
-- Namn:        cpu
-- Filnamn:     cpu.vhd
-- Testbench:   *ingen*
--
-- Insignaler:
--      clk     - klocksignal, all uppdatering av register sker vid stigande flank
--      n_rst   - synkron resetsignal, aktiv låg
--      INPUT   - insignalen JA synkroniserad i IO-blocket
--  
-- Utsignaler:
--      A        - adress till nästa instruktion
--      OUTPUT   - data som ska skrivs till signalen JB
--      OutEna   - laddsignal för utsignalsregistret i IO blocket
--      pc_debug - nuvarande adress, används för att visa adressen på 
--                 Nexys4 display
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity cpu is
    port(
        clk, n_rst : in std_logic;
        I : in std_logic_vector(12 downto 0);
        INPUT : in std_logic_vector(7 downto 0);
        A : out std_logic_vector(5 downto 0);
        OUTPUT : out std_logic_vector(7 downto 0);
        OutEna : out std_logic;
        pc_debug : out std_logic_vector(5 downto 0)
    );
    
end entity;

architecture structural of cpu is
    
    signal ALUSrc, RegEna, Z, DEST : STD_LOGIC;
    signal StackOp, AddrSrc : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUOp : STD_LOGIC_VECTOR(2 downto 0);
    
    signal DATA : STD_LOGIC_VECTOR(7 downto 0);
    signal OPCODE : STD_LOGIC_VECTOR(3 downto 0);
    signal ADDR_DATA : STD_LOGIC_VECTOR(5 downto 0);
    
begin
    
    DATA <= I(7 downto 0);
    DEST <= I(8);
    OPCODE <= I(12 downto 9); 
    
berakningenhet_i:entity berakningsenhet port map(
    clk => clk,
    n_rst => n_rst,
    DATA => DATA,
    INPUT => INPUT,
    DEST => DEST,
    ALUSrc => ALUSrc,
    ALUOp => ALUOp,
    RegEna => RegEna,
    OUTPUT => OUTPUT,
    Z => Z
);

instruktionsavkodare_i:entity instruktionsavkodare port map(
    OPCODE => OPCODE,
    Z => Z,
    StackOp => StackOp,
    AddrSrc => AddrSrc,
    ALUOp => ALUOp,
    ALUSrc => ALUSrc,
    RegEna => RegEna,
    OutEna => OutEna
);

adressvaljare_i:entity adressvaljare port map(
    clk => clk,
    n_rst => n_rst,
    DATA => DATA(5 downto 0),
    A => A,
    AddrSrc => AddrSrc,
    StackOp => StackOp,
    pc_debug => pc_debug
);

end architecture;