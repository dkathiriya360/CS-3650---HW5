library ieee;
use ieee.std_logic_1164.all;

entity controlUnit_tb is
end controlUnit_tb;

architecture tb of controlUnit_tb is
	-- inputs
	signal instr_tb : std_logic_vector(0 to 5);
	signal clk_tb, reset_tb : std_logic;
	
	--outputs
	signal RegDst_tb, Jump_tb, Branch_tb, MemRead_tb, MemtoReg_tb, MemWrite_tb, ALUSrc_tb, RegWrite_tb : std_logic;
	signal ALUOp_tb : std_logic_vector(0 to 1);


   begin
	uu_test: entity work.controlUnit port map (
		instr => instr_tb,
		clk => clk_tb,
		reset => reset_tb,
		RegDst => RegDst_tb,
		Jump => Jump_tb,
		Branch => Branch_tb,
		MemRead => MemRead_tb,
		MemtoReg => MemtoReg_tb,
		MemWrite => MemWrite_tb,
		ALUSrc => ALUSrc_tb,
		RegWrite => RegWrite_tb,
		ALUOp => ALUOp_tb
	);
	
	 tb_C : process
	       	constant clk_period : time := 10 ns;
		begin 
			-- reset_tb <= '1';
			-- clk_tb <= '0';
			wait for clk_period;

			-- reset_tb <= '0';	
			-- R-types instruction
			instr_tb <= "000000";
			wait for clk_period;

			-- Load word 
			instr_tb <= "100011";
			wait for clk_period;

			-- Store word
			instr_tb <= "101011";
			wait for clk_period;

			-- Branch equal
			instr_tb <= "000100";
			wait for clk_period;

			-- Jump
			instr_tb <= "000010";
			wait for clk_period;

			-- Fail test
			instr_tb <= "111000";
			wait for clk_period;
			assert false
			report "Test failed for instruction = 111000" severity error;

			wait;
		end process;
   end tb;
	


	

		
