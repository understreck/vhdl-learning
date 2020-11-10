library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use work.cpu_pkg.all;

entity instruktionsavkodare_tb is
end entity;

architecture behaviour of instruktionsavkodare_tb is
    
    signal OPCODE 	: std_logic_vector(3 downto 0) := "1011";
    signal Z 		: std_logic;
    signal StackOp 	: std_logic_vector(1 downto 0);
    signal AddrSrc 	: std_logic_vector(1 downto 0);
    signal ALUOp 	: std_logic_vector(2 downto 0);
    signal ALUSrc 	: std_logic;
    signal RegEna 	: std_logic;
    signal OutEna 	: std_logic;
    
    constant some_time 	: time := 10 ns;
    signal message 		: string(1 to 4);
    
	
	signal str_StackOp 	: string(2 downto 1);
    signal str_AddrSrc 	: string(2 downto 1);
    signal str_ALUOp 	: string(3 downto 1);
	
	signal error_count	: integer := 0;

	
begin

    DUT_i: entity instruktionsavkodare port map(
        OPCODE 	=> OPCODE,
        Z 		=> Z,
        StackOp => StackOp,
        AddrSrc => AddrSrc,
        ALUOp 	=> ALUOp,
        ALUSrc 	=> ALUSrc,
        RegEna 	=> RegEna,
        OutEna 	=> OutEna
    );  
    
	
    wavegen:process
    begin
    
        Z <= '1';
		
		
		
		OPCODE 	<= OPCODE_NOP;
        message <= " NOP";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD 	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if AddrSrc /= ADDR_PC_PLUS_ONE 	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_NULL 		then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;
		
		
		
		
		assert StackOp = STACK_OP_HOLD 		report "NOP: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" 	 severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE	report "NOP: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_NULL			report "NOP: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" 		 severity error;
		assert ALUSrc  = '0'				report "NOP: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" 	 severity error;
		assert RegEna  = '0'				report "NOP: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" 	 severity error;
		assert OutEna  = '0'				report "NOP: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" 	 severity error;
        wait for some_time;
		
		
		-- ####################################################################################################################################

		OPCODE 	<= OPCODE_CALL;
        message <= "CALL";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_PUSH 	then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_DATA 		then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_NULL 		then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_PUSH      report "CALL: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_DATA 	    	report "CALL: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" 	   severity error;
		assert ALUOp   = ALUOP_NULL 	    report "CALL: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ"    severity error;
		assert ALUSrc  = '0'				report "CALL: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" severity error;
		assert RegEna  = '0'				report "CALL: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" severity error;
		assert OutEna  = '0'				report "CALL: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" severity error;
        wait for some_time;
	
		-- -- ####################################################################################################################################

		OPCODE 	<= OPCODE_RET;
        message <= " RET";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_POP 		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_TOS 			then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_NULL 		then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_POP 	    report "RET: Fel! StackOp = " & str_StackOp & " ska vara: XYZ"  severity error;
		assert AddrSrc = ADDR_TOS 			report "RET: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ"  severity error;
		assert ALUOp   = ALUOP_NULL 	    report "RET: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ"  severity error;
		assert ALUSrc  = '0'				report "RET: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" severity error;
		assert RegEna  = '0'				report "RET: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" severity error;
		assert OutEna  = '0'				report "RET: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" severity error;
        wait for some_time;
		
		-- -- ####################################################################################################################################

		OPCODE 	<= OPCODE_BZ;
        message <= "  BZ";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD 	then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_DATA			then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_B	 		then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "BZ Z=1: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" 	severity error;
		assert AddrSrc = ADDR_DATA 			report "BZ Z=1: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" 	severity error;
		assert ALUOp   = ALUOP_B	 	    report "BZ Z=1: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" 	severity error;
		assert ALUSrc  = '0'				report "BZ Z=1: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" 	severity error;
		assert RegEna  = '0'				report "BZ Z=1: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" 	severity error;
		assert OutEna  = '0'				report "BZ Z=1: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" 	severity error;
        wait for some_time;

		-- -- ####################################################################################################################################
		
		Z <= '0';
			
		OPCODE 	<= OPCODE_BZ;
        message <= "  BZ";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_PC_PLUS_ONE	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_B	 		then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "BZ Z=0: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE	report "BZ Z=0: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_B	 	    report "BZ Z=0: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '0'				report "BZ Z=0: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" 	severity error;
		assert RegEna  = '0'				report "BZ Z=0: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" 	severity error;
		assert OutEna  = '0'				report "BZ Z=0: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" 	severity error;
        wait for some_time;		

		-- -- ####################################################################################################################################
		

			
		OPCODE 	<= OPCODE_B;
        message <= "   B";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_DATA			then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_NULL	 		then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "B: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_DATA			report "B: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_NULL	 	    report "B: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '0'				report "B: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" severity error;
		assert RegEna  = '0'				report "B: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" severity error;
		assert OutEna  = '0'				report "B: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" severity error;
        wait for some_time;
		
		-- -- ####################################################################################################################################
		

			
		OPCODE 	<= OPCODE_ADD;
        message <= " ADD";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_PC_PLUS_ONE	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_A_PLUS_B	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '1' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "ADD: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE	report "ADD: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_A_PLUS_B	 	report "ADD: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '0'				report "ADD: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ"   severity error;
		assert RegEna  = '1'				report "ADD: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ"   severity error;
		assert OutEna  = '0'				report "ADD: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ"   severity error;
        wait for some_time;

		-- -- ####################################################################################################################################
		

			
		OPCODE 	<= OPCODE_SUB;
        message <= " SUB";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_PC_PLUS_ONE	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_B_MINUS_A 	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '1' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "SUB: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE   report "SUB: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_B_MINUS_A 	report "SUB: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '0'				report "SUB: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ"   severity error;
		assert RegEna  = '1'				report "SUB: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ"   severity error;
		assert OutEna  = '0'				report "SUB: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ"   severity error;
        wait for some_time;
		
		-- -- ####################################################################################################################################
		

			
		OPCODE 	<= OPCODE_LD;
        message <= "  LD";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_PC_PLUS_ONE	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_A		 	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '1' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "LD: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE   report "LD: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_A		 	report "LD: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '0'				report "LD: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" 	severity error;
		assert RegEna  = '1'				report "LD: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" 	severity error;
		assert OutEna  = '0'				report "LD: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" 	severity error;
        wait for some_time;
		
		-- -- ####################################################################################################################################
		

			
		OPCODE 	<= OPCODE_IN;
        message <= "  IN";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_PC_PLUS_ONE	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_B		 	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '1' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '1' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "IN: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE   report "IN: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_B		 	report "IN: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '1'				report "IN: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" 	severity error;
		assert RegEna  = '1'				report "IN: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" 	severity error;
		assert OutEna  = '0'				report "IN: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" 	severity error;
        wait for some_time;
		
		-- -- ####################################################################################################################################
		

			
		OPCODE 	<= OPCODE_OUT;
        message <= " OUT";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_PC_PLUS_ONE	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_B		 	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '1' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		-- regEna ??
		
		assert StackOp = STACK_OP_HOLD 	    report "OUT: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE   report "OUT: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_B		 	report "OUT: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '0'				report "OUT: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" 	severity error;
		assert RegEna  = '0'				report "OUT: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" 	severity error;
		assert OutEna  = '1'				report "OUT: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" 	severity error;
        wait for some_time;
		
		-- -- ####################################################################################################################################
		

			
		OPCODE 	<= OPCODE_AND;
        message <= " AND";
		
		wait for 1 ns;
		vector_to_string(StackOp, str_StackOp);
		vector_to_string(AddrSrc, str_AddrSrc);
		vector_to_string(ALUOp  , str_ALUOp);
		
		if StackOp /= STACK_OP_HOLD		then error_count <= error_count + 1; end if; wait for 1 ns;		
		if AddrSrc /= ADDR_PC_PLUS_ONE	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUOp   /= ALUOP_A_AND_B	 	then error_count <= error_count + 1; end if; wait for 1 ns;	
		if ALUSrc  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if RegEna  /= '1' then error_count <= error_count + 1; end if; wait for 1 ns;	
		if OutEna  /= '0' then error_count <= error_count + 1; end if; wait for 1 ns;	
		
		
		
		
		assert StackOp = STACK_OP_HOLD 	    report "AND: Fel! StackOp = " & str_StackOp & " ska vara: XYZ" severity error;
		assert AddrSrc = ADDR_PC_PLUS_ONE   report "AND: Fel! AddrSrc = " & str_AddrSrc & " ska vara: XYZ" severity error;
		assert ALUOp   = ALUOP_A_AND_B	 	report "AND: Fel! ALUOp = "   & str_ALUOp & " ska vara: XYZ" severity error;
		assert ALUSrc  = '0'				report "AND: Fel! ALUSrc = "  & std_logic'image(ALUSrc) & " ska vara: XYZ" 	severity error;
		assert RegEna  = '1'				report "AND: Fel! RegEna = "  & std_logic'image(RegEna) & " ska vara: XYZ" 	severity error;
		assert OutEna  = '0'				report "AND: Fel! OutEna = "  & std_logic'image(OutEna) & " ska vara: XYZ" 	severity error;
        wait for some_time;
		
		if error_count = 0 then 
			report "################### Bra jobbat. Inga fel! :) ###################" severity note; 
		else
			report "Antal fel = " & integer'IMAGE(error_count) severity warning; 
		end if;
		
        wait for some_time;
        
        wait;
    end process;

end architecture;