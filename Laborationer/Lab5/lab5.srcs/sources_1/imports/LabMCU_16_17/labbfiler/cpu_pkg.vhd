--
-- Den här filen innehåller definitioner för signalerna StackOp, AddrSrc och OPCODE.
-- Efter att en rad avkomenterats och fått rätt värde kan konstanten användas i alla filer
-- där följande finns med:
--
--      library work;
--      use work.cpu_pkg.all;
--
-- Användning av konstanterna gör koden lättare att läsa och felsöka.
-- Testbäddarna kommer också att använda dessa konstanter så det är viktigt att de fylls i korrekt!

library ieee;
use ieee.std_logic_1164.all;



package cpu_pkg is

procedure vector_to_string(signal vector  : in  std_logic_vector; 
								signal str : out string);

    -- Fyll i rätt värde för för signalen StackOp som styr stackens operation.
    -- Glöm inte att avkommentera raderna!
    constant STACK_OP_POP          : std_logic_vector(1 downto 0) := "10";
    constant STACK_OP_PUSH         : std_logic_vector(1 downto 0) := "01";
    constant STACK_OP_HOLD         : std_logic_vector(1 downto 0) := "00";
    
     -- Fyll i rätt värde för för signalen AddrSrc som bestämmer varifrån nästa adress ska tas.
    constant ADDR_PC_PLUS_ONE   : std_logic_vector(1 downto 0) := "00";
    constant ADDR_TOS           : std_logic_vector(1 downto 0) := "01";
    constant ADDR_DATA          : std_logic_vector(1 downto 0) := "10";
    
     -- Fyll i rätt värde för för signalen OPCODE som avgör vilken instruktion det är.
	constant OPCODE_NOP				 : std_logic_vector(3 downto 0) := "0000";
    constant OPCODE_CALL             : std_logic_vector(3 downto 0) := "0001";
    constant OPCODE_RET              : std_logic_vector(3 downto 0) := "0010";
    constant OPCODE_BZ               : std_logic_vector(3 downto 0) := "0011";
    constant OPCODE_B                : std_logic_vector(3 downto 0) := "0100";
    constant OPCODE_ADD              : std_logic_vector(3 downto 0) := "0101";
    constant OPCODE_SUB              : std_logic_vector(3 downto 0) := "0110";
    constant OPCODE_LD               : std_logic_vector(3 downto 0) := "0111";
    constant OPCODE_IN               : std_logic_vector(3 downto 0) := "1000";
    constant OPCODE_OUT              : std_logic_vector(3 downto 0) := "1001";
    constant OPCODE_AND              : std_logic_vector(3 downto 0) := "1010";
	-- Lägg till OPCODEN DOUT .
	--värden för signalen ALU_OP som avgör vilken logisk operation som göres.
	
	constant ALUOP_A				:std_logic_vector(2 downto 0) := "000" ;
	constant ALUOP_B				:std_logic_vector(2 downto 0) := "001" ;
	constant ALUOP_A_PLUS_B			:std_logic_vector(2 downto 0) := "010" ;
	constant ALUOP_B_MINUS_A		:std_logic_vector(2 downto 0) := "011" ;
	constant ALUOP_A_AND_B			:std_logic_vector(2 downto 0) := "100" ;
	constant ALUOP_A_OR_B			:std_logic_vector(2 downto 0) := "101" ;
	constant ALUOP_A_MOD_B			:std_logic_vector(2 downto 0) := "110" ;
	constant ALUOP_NULL				:std_logic_vector(2 downto 0) := "111" ;
	

    
end package;

package body cpu_pkg is

	procedure vector_to_string (signal vector 	: in  std_logic_vector; 
								signal str 		: out string) is 
		
		variable the_str : string(vector'length downto 1);
		
	begin
	
		for J in the_str'range loop
		
			if vector(J-1) = '1' then
				
				the_str(J) := '1'; 
				
			else 

				the_str(J) := '0';
				
			end if;
		
		end loop;
	
	
		str <= the_str;
		
	end vector_to_string;
end cpu_pkg;