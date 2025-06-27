LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY datapath IS
	PORT(
		-- Clock Signals
		Clk, mClk		: IN 	STD_LOGIC;
		-- Memory Signals
		en, wen			: IN 	STD_LOGIC;
		-- Register Control Signals (CLR and LD)
		clr_A, ld_A		: IN 	STD_LOGIC;
		clr_B, ld_B		: IN 	STD_LOGIC;
		clr_C, ld_C		: IN 	STD_LOGIC;
		clr_Z, ld_Z		: IN 	STD_LOGIC;
		clr_PC, ld_PC	: IN 	STD_LOGIC;
		clr_IR, ld_IR	: IN 	STD_LOGIC;
		-- Register Outputs (Some needed to feed back to control unit. Others pulled out for testing)
		out_A				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		out_B				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		out_C				: OUT STD_LOGIC;
		out_Z				: OUT STD_LOGIC;
		out_PC			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		out_IR			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- Special inputs to PC
		inc_PC			: IN  STD_LOGIC;
		-- Address and Data Bus signals for debugging
		data_in			: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		addr_out			: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_out			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		mem_out			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		mem_in			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		mem_addr			: OUT UNSIGNED(7 DOWNTO 0);
		-- Various MUX controls
		data_mux			: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
		reg_mux			: IN 	STD_LOGIC;
		A_mux, B_mux	: IN 	STD_LOGIC;
		IM_mux1			: IN 	STD_LOGIC;
		IM_mux2			: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		-- ALU Operations
		ALU_Op			: IN  STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
END datapath;

ARCHITECTURE Behaviour OF datapath IS

	-- Component instantiations

	COMPONENT data_mem
		PORT(
			clk, wen, en	:	IN		STD_LOGIC;
			addr				:	IN		UNSIGNED(7 DOWNTO 0);
			data_in			:	IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_out			:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	COMPONENT PC
		PORT(
			clr	: IN STD_LOGIC;
			clk	: IN STD_LOGIC;
			ld		: IN STD_LOGIC;
			inc	: IN STD_LOGIC;
			d		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			q		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	COMPONENT register32
		PORT(
			d		: IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input
			ld		: IN STD_LOGIC; -- load/enable
			clr	: IN STD_LOGIC; -- async. clear.
			clk	: IN STD_LOGIC; -- clock
			Q		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
			);
	END COMPONENT;
	COMPONENT UZE
		PORT(
			data_in	: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_out	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	COMPONENT LZE
		PORT(
			data_in	: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_out	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	COMPONENT mux2to1
		PORT(
			s			: IN 	STD_LOGIC;
			w0, w1	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			f			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	COMPONENT mux4to1
		PORT(
			s					: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
			w0, w1, w2, w3	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			f					: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	COMPONENT ALU
		PORT(
			a			: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			b			: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			op			: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
			result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Cout		: OUT STD_LOGIC;
			zero		: OUT STD_LOGIC
			);
	END COMPONENT;
	COMPONENT RED
		PORT(
			data_in	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_out	: OUT UNSIGNED(7 DOWNTO 0)
			);
	END COMPONENT;
	
	-- Internal Signals
	
	SIGNAL IR_out				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL LZE_out_A			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL LZE_out_B			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL LZE_out_PC			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL LZE_out_IM_MUX2	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL UZE_out				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL A_MUX_out			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL B_MUX_out			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL A_out				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL B_out				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Reg_MUX_out		:  STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL IM_MUX1_out		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL IM_MUX2_out		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DATA_MUX_out		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DATA_BUS			:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DATA_MEM_out		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC_ADDR_out 		:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RED_out				: 	UNSIGNED(7 DOWNTO 0);
	SIGNAL ALU_out				: 	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Zero					:	STD_LOGIC;
	SIGNAL CarryOut 			:	STD_LOGIC;
	SIGNAL zeros				:	STD_LOGIC_VECTOR(30 DOWNTO 0) := (OTHERS => '0');
	
	BEGIN
		IR					:	register32 PORT MAP(DATA_BUS, ld_IR, clr_IR, Clk, IR_out);
		A					:	register32 PORT MAP(A_MUX_out, ld_A, clr_A, Clk, A_out);
		B					:	register32 PORT MAP(B_MUX_out, ld_B, clr_B, Clk, B_out);
		LZE_A_MUX		:	LZE PORT MAP(IR_out, LZE_out_A);
		LZE_B_MUX		:	LZE PORT MAP(IR_out, LZE_out_B);
		LZE_PC			:	LZE PORT MAP(IR_out, LZE_out_PC);
		LZE_IM_MUX2		:	LZE PORT MAP(IR_out, LZE_out_IM_MUX2);
		UZE_IM_MUX1		:	UZE PORT MAP(IR_out, UZE_out);
		PC_IM				:	PC PORT MAP(clr_PC, Clk, ld_PC, inc_PC, LZE_out_PC, PC_ADDR_out);
		A_MUX2			:	mux2to1 PORT MAP(A_mux, DATA_BUS, LZE_out_A, A_MUX_out);
		B_MUX2			:	mux2to1 PORT MAP(B_mux, DATA_BUS, LZE_out_B, B_MUX_out);
		Reg_MUX2			: 	mux2to1 PORT MAP(reg_mux, A_out, B_out, Reg_MUX_out);
		IM_MUX_1			: 	mux2to1 PORT MAP(IM_mux1, A_out, UZE_out, IM_MUX1_out);
		IM_MUX_2			: 	mux4to1 PORT MAP(IM_mux2, B_out, LZE_out_IM_MUX2, (zeros & '1'), (OTHERS => '0'), IM_MUX2_out);
		DATA_MUX_2		:	mux4to1 PORT MAP(data_mux, data_in, DATA_MEM_out, ALU_out, (OTHERS => '0'), DATA_BUS);
		ALU_1				: 	ALU PORT MAP(IM_MUX1_out, IM_MUX2_out, ALU_Op, ALU_out, Zero, CarryOut);
		RED_data_mem	: 	RED PORT MAP(IR_out, RED_out);
		DATA_mem1		: 	data_mem PORT MAP(mClk, wen, en, RED_out, Reg_MUX_out, DATA_MEM_out);
		
		data_out <= DATA_BUS;
		out_A <= A_out;
		out_B <= B_out;
		out_IR <= IR_out;
		addr_out <= PC_ADDR_out;
		out_PC <= PC_ADDR_out;
		mem_addr <= RED_out;
		mem_in <= Reg_MUX_out;
		mem_out <= DATA_MEM_out;
		
END Behaviour;























