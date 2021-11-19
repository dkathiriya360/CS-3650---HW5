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
			-- R-types instruction
			instr_tb <= "000000";
			reset_tb <= '0';	
			clk_tb <= '0';
			wait for clk_period;
			
			clk_tb <= '1';
			wait for clk_period;

			assert(RegDst_tb = '1' and RegWrite_tb = '1' and ALUSrc_tb = '0' and Memwrite_tb = '0' and MemRead_tb = '0' and MemtoReg_tb = '0' and ALUOp_tb = "10" and Jump_tb = '-' and Branch_tb = '-')
				report "test faile for R type instruction" severity error;

			-- Load word 
			instr_tb <= "100011";
			clk_tb <= '0';
			wait for clk_period;

			clk_tb <= '1';
			wait for clk_period;

			
			assert(RegDst_tb = '0' and RegWrite_tb = '1' and ALUSrc_tb = '1' and Memwrite_tb = '0' and MemRead_tb = '1' and MemtoReg_tb = '1' and ALUOp_tb = "00" and Jump_tb = '-' and Branch_tb = '-')
				report "test faile for LW instruction" severity error;

			-- Store word
			instr_tb <= "101011";
			clk_tb <= '0';
			wait for clk_period;

			clk_tb <= '1';
			wait for clk_period;

			
			assert(RegDst_tb = '-' and RegWrite_tb = '0' and ALUSrc_tb = '1' and Memwrite_tb = '1' and MemRead_tb = '0' and MemtoReg_tb = '-' and ALUOp_tb = "00" and Jump_tb = '-' and Branch_tb = '-')
				report "test faile for SW instruction" severity error;

			-- Branch equal
			instr_tb <= "000100";
			clk_tb <= '0';
			wait for clk_period;

			clk_tb <= '1';
			wait for clk_period;

			
			assert(RegDst_tb = '-' and RegWrite_tb = '0' and ALUSrc_tb = '0' and Memwrite_tb = '0' and MemRead_tb = '0' and MemtoReg_tb = '-' and ALUOp_tb = "01" and Jump_tb = '1' and Branch_tb = '1')
				report "test faile for SW instruction" severity error;

			-- Jump
			instr_tb <= "000010";
			clk_tb <= '0';
			wait for clk_period;

			clk_tb <= '1';
			wait for clk_period;

			
			assert(RegDst_tb = '-' and RegWrite_tb = '0' and ALUSrc_tb = '0' and Memwrite_tb = '0' and MemRead_tb = '0' and MemtoReg_tb = '-' and ALUOp_tb = "11" and Jump_tb = '1' and Branch_tb = '0')
				report "test faile for SW instruction" severity error;

			wait;
		end process;
   end tb;
