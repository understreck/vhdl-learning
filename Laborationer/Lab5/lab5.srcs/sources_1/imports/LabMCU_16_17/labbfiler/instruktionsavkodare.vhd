----------------------------------------------------------------------------------
-- Namn:        instruktionsavkodare
-- Filnamn:     instruktionsavkodare.vhd
-- Testbench:   instruktionsavkodare_tb.vhd
--
-- Insignaler:
--      OPCODE - operationskod från instruktionen
--      Z      - zero-flagga från beräkningsenhet
--
-- Utsignaler:
--      StackOp - styr stacken i adressväljaren
--      AddrSrc - styr varifrån nästa adress ska hämtas
--      ALUOp   - bestämmer operatinen för ALU i beräkningsenhet
--      ALUSrc  - väljer om ett register eller insignalen från IO-blocket ska 
--                vara operand till ALU
--      RegEna  - laddsignal till registerblocket
--      OutEna  - laddsignal till utsignalsregistret i IO-blocket
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity instruktionsavkodare is
    port(
        OPCODE : in std_logic_vector(3 downto 0);
        Z : in std_logic;
        StackOp : out std_logic_vector(1 downto 0);
        AddrSrc : out std_logic_vector(1 downto 0);
        ALUOp : out std_logic_vector(2 downto 0);
        ALUSrc : out std_logic;
        RegEna : out std_logic;
        OutEna : out std_logic
    );
end entity;

architecture behaviour of instruktionsavkodare is
    
begin

inst_decode:process(OPCODE, Z)
begin
    -- default values
    StackOp <= STACK_OP_HOLD;
    AddrSrc <= ADDR_PC_PLUS_ONE;
    ALUOp <= "111";
    ALUSrc <= '0';
    RegEna <= '0';
    OutEna <= '0';

    case OPCODE is
	
  -- Fyll i det som saknas!!
  
        when others =>

    end case;
end process;
end architecture;