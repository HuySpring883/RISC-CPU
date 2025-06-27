LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY cpu1 IS
	PORT(
		clk									: 	IN STD_LOGIC;
		Mem_Clk								:	IN STD_LOGIC;
		rst									:  IN STD_LOGIC;
		DataIn								:  IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dataOUT, addrOUT 					: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Wen, Wen_Mem, en_Mem				: OUT STD_LOGIC;
		dOutA, dOutB, dOutIR, dOutPC	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dOutC, dOutZ						: OUT STD_LOGIC;
		outT									: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
END cpu1;

ARCHITECTURE Behaviour OF cpu1 IS
	
	COMPONENT datapath IS
		PORT(
			-- Clock Signals
			Clk, mClk		: 	IN STD_LOGIC;
			-- Memory Signals
			en, wen			: 	IN STD_LOGIC;
			-- Register Control Signals (CLR and LD)
			clr_A, ld_A		: 	IN STD_LOGIC;
			clr_B, ld_B		: 	IN STD_LOGIC;
			clr_C, ld_C		: 	IN STD_LOGIC;
			clr_Z, ld_Z		: 	IN STD_LOGIC;
			clr_PC, ld_PC	: 	IN STD_LOGIC;
			clr_IR, ld_IR	: 	IN STD_LOGIC;
			-- Register Outputs (Some needed to feed back to control unit. Others pulled out for testing)
			out_A				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			out_B				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			out_C				: OUT STD_LOGIC;
			out_Z				: OUT STD_LOGIC;
			out_PC			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			out_IR			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			-- Special inputs to PC
			inc_PC			: 	IN STD_LOGIC;
			-- Address and Data Bus signals for debugging
			data_in			: 	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
			addr_out			: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_out			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			mem_out			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			mem_in			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			mem_addr			: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			-- Various MUX controls
			data_mux			: 	IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
			reg_mux			: 	IN STD_LOGIC;
			A_mux, B_mux	: 	IN STD_LOGIC;
			IM_mux1			: 	IN STD_LOGIC;
			IM_mux2			: 	IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			-- ALU Operations
			ALU_Op			: 	IN STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
	END COMPONENT;
		
	COMPONENT Control_New IS
		PORT(
			Clk, mClk									: 	IN	STD_LOGIC;
			Sen											: 	IN STD_LOGIC;
			status_C, status_Z						:	IN STD_LOGIC;
			A_MUX, B_MUX, IM_MUX1, Reg_MUX		: OUT STD_LOGIC;
			IM_MUX2, Data_MUX							: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			INST											: 	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ALU_Op										: OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);
			inc_PC										: OUT STD_LOGIC;
			ld_PC, ld_IR, ld_C, ld_Z, ld_A, ld_B: OUT STD_LOGIC;
			clr_IR, clr_A, clr_B, clr_C, clr_Z	: OUT STD_LOGIC;
			T												: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			en, Wen										: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT reset_circuit IS
		PORT(
			Reset, Clk	:  IN STD_LOGIC;
			en_PD			: OUT STD_LOGIC;	
			Clr_PC		: OUT STD_LOGIC
		);
	END COMPONENT;
	
	SIGNAL Sen_out	: STD_LOGIC;
	SIGNAL sClr_PCout : STD_LOGIC;
	SIGNAL sC_out	: STD_LOGIC; 
	SIGNAL sZ_out	: STD_LOGIC;
	SIGNAL sIM_MUX1, sReg_MUX, sA_MUX, sB_MUX: STD_LOGIC;
	SIGNAL sIM_MUX2, sData_MUX : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL sALU_Op : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL sInc_PC, sClr_PC, sLd_PC : STD_LOGIC;
	SIGNAL sClr_IR, sLd_IR : STD_LOGIC;
	SIGNAL sClr_A, sClr_B, sClr_C, sClr_Z : STD_LOGIC;
	SIGNAL sLd_A, sLd_B, sLd_C, sLd_Z : STD_LOGIC;
	SIGNAL sWen, sEn, out_Wen, out_Sen, sEn_out: STD_LOGIC;
	SIGNAL sOut_IR : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	BEGIN
		
		reset : reset_circuit PORT MAP(reset => rst, Clk => clk, en_PD => sEn_out, Clr_PC => sClr_PCout);
		
		control_unit : Control_New PORT MAP(
			Clk => clk, mClk => Mem_Clk, Wen => sWen, en => sEn, Sen => Sen_out,
			ALU_Op => sALU_Op, status_C => sC_out, status_Z => sZ_out, INST => sOut_IR, T => outT,
			IM_MUX1 => sIM_MUX1, IM_MUX2 => sIM_MUX2, Reg_MUX => sReg_MUX, Data_MUX => sData_MUX, A_MUX => sA_MUX, B_MUX => sB_MUX, 
			inc_PC => sInc_PC, ld_PC => sLd_PC, ld_IR => sLd_IR, ld_A => sLd_A, ld_B => sLd_B, ld_C => sLd_C, ld_Z => sLd_Z,
			clr_IR => sClr_IR, clr_A => sClr_A, clr_B => sClr_B, clr_C => sClr_C, clr_Z => sClr_Z
			);
			
		dp : datapath PORT MAP(
			ALU_Op => sALU_Op, data_in => DataIn, addr_out => addrOUT, data_out => dataOUT,
			out_PC => dOutPC, out_IR => sOut_IR, out_A => dOutA, out_B => dOutB, out_C => sC_out, out_Z => sZ_out,
			Clk => clk, mClk => Mem_Clk, wen => sWen, en => sEn,
			A_mux => sA_MUX, B_mux => sB_MUX, IM_mux1 => sIM_MUX1, IM_mux2 => sIM_MUX2, data_mux => sData_MUX, reg_mux => sReg_MUX,
			inc_PC => sInc_PC, ld_PC => sLd_PC, clr_PC => sClr_PC, ld_IR => sLd_IR, clr_IR => sClr_IR,
			clr_A => sClr_A, clr_B => sClr_B, clr_C => sClr_C, clr_Z => sClr_Z,
			ld_A => sLd_A, ld_B => sLd_B, ld_C => sLd_C, ld_Z => sLd_Z
			);
		
		dOutC <= sC_out;
		dOutZ <= sZ_out;
		dOutIR <= sOut_IR;
		Wen_Mem <= out_Wen;
		en_Mem <= out_Sen;

END Behaviour;