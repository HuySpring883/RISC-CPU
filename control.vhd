LIBRARY ieee;

USE ieee.std_logic_1164.all;

ENTITY Control_New IS
	PORT(
		Clk, mClk									: 	IN	STD_LOGIC;
		Sen											: 	IN STD_LOGIC;
		status_C, status_Z						:	IN STD_LOGIC;
		A_MUX, B_MUX, IM_MUX1, Reg_MUX		: OUT STD_LOGIC;
		IM_MUX2, Data_MUX							: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		INST											: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_Op										: OUT	STD_LOGIC_VECTOR(2 DOWNTO 0);
		inc_PC										: OUT STD_LOGIC;
		ld_PC, ld_IR, ld_C, ld_Z, ld_A, ld_B: OUT STD_LOGIC;
		clr_IR, clr_A, clr_B, clr_C, clr_Z	: OUT STD_LOGIC;
		T												: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		en, Wen										: OUT STD_LOGIC
		);
END Control_New;

ARCHITECTURE Behaviour OF Control_New IS
	
	TYPE STATE_TYPE IS (state_0, state_1, state_2);
	
	SIGNAL present_state	: STATE_TYPE;
	SIGNAL INST_sig1		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL INST_sig2		: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	BEGIN
		INST_sig1 <= INST(31 DOWNTO 28);
		INST_sig2 <= INST(31 DOWNTO 24);
		
		---- Operation Decoder ----
		PROCESS (present_state, INST, status_C, status_Z, Sen, INST_sig1, INST_sig2)
			BEGIN
				IF Sen = '1' THEN
					IF present_state = state_0 THEN
						-- Fetch address of next instruction
						Data_MUX <= "00";
						clr_IR 	<= '0';
						ld_IR 	<= '1';
						ld_PC		<= '0';
						inc_PC	<= '0';
						clr_A 	<= '0';
						clr_B 	<= '0';
						clr_C 	<= '0';
						clr_Z 	<= '0';
						ld_A 		<= '0';
						ld_B 		<= '0';
						ld_C 		<= '0';
						ld_Z 		<= '0';
						en 		<= '0';
						Wen 		<= '0';
					ELSIF present_state = state_1 THEN
						-- Increment PC counter
						clr_IR 	<= '0';
						ld_IR 	<= '0';
						ld_PC		<= '1';
						inc_PC	<= '1';
						clr_A 	<= '0';
						clr_B 	<= '0';
						clr_C 	<= '0';
						clr_Z 	<= '0';
						ld_A 		<= '0';
						ld_B 		<= '0';
						ld_C 		<= '0';
						ld_Z 		<= '0';
						en 		<= '0';
						Wen 		<= '0';
						IF	INST_sig1 = "0010" THEN
							-- STA
							Data_MUX <= "00";
							Reg_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '1';
							inc_PC	<= '1';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '1';
						ELSIF	INST_sig1 = "0011" THEN
							-- STB
							Data_MUX <= "00";
							Reg_MUX 	<= '1';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '1';
							inc_PC	<= '1';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '1';
						ELSIF	INST_sig1 = "1001" THEN
							-- LDA
							Data_MUX <= "01";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '1';
							inc_PC	<= '1';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '0';
						ELSIF	INST_sig1 = "1001" THEN
							-- LDB
							Data_MUX <= "01";
							B_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '1';
							inc_PC	<= '1';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '0';
						END IF; -- End If for Load Store in Stage 1
					-- Stage 2
					ELSIF present_state = state_2 THEN
						IF	INST_sig1 = "0101" THEN
							-- JUMP
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '1';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig1 = "0110" THEN
							-- BEQ
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '1';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig1 = "1000" THEN
							-- BNE
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '1';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig1 = "0110" THEN
							-- LDA
							Data_MUX <= "01";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '0';
						ELSIF	INST_sig1 = "1010" THEN
							-- LDB
							Data_MUX <= "01";
							B_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '1';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '0';
						ELSIF	INST_sig1 = "0010" THEN
							-- STA
							Data_MUX <= "00";
							Reg_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '1';
						ELSIF	INST_sig1 = "0011" THEN
							-- STB
							Data_MUX <= "00";
							Reg_MUX 	<= '1';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
							en 		<= '1';
							Wen 		<= '1';
						ELSIF	INST_sig1 = "0000" THEN
							-- LDAI
							A_MUX 	<= '1';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig1 = "0001" THEN
							-- LDBI
							B_MUX 	<= '1';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '1';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig1 = "0100" THEN
							-- LUI
							ALU_Op 	<= "001";
							Data_MUX <= "10";
							IM_MUX1 	<= '1';
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '1';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig2 = "01111001" THEN
							-- ANDI
							ALU_Op 	<= "000";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "01";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01111110" THEN
							-- DECA
							ALU_Op 	<= "110";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "10";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01110000" THEN
							-- ADD
							ALU_Op 	<= "010";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "00";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01110010" THEN
							-- SUB
							ALU_Op 	<= "110";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "00";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01110011" THEN
							-- INCA
							ALU_Op 	<= "010";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "10";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01111011" THEN
							-- AND
							ALU_Op 	<= "000";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "00";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01110001" THEN
							-- ADDI
							ALU_Op 	<= "010";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "01";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01111101" THEN
							-- ORI
							ALU_Op 	<= "001";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							IM_MUX2	<= "01";
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01110100" THEN
							-- ROL
							ALU_Op 	<= "100";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01111111" THEN
							-- ROR
							ALU_Op 	<= "101";
							Data_MUX <= "10";
							IM_MUX1 	<= '0';
							A_MUX 	<= '0';
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '1';
							ld_Z 		<= '1';
						ELSIF	INST_sig2 = "01110101" THEN
							-- CLR_A
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '1';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig2 = "01110110" THEN
							-- CLR_B
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '1';
							clr_C 	<= '0';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig2 = "01110111" THEN
							-- CLR_C
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '1';
							clr_Z 	<= '0';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig2 = "01111000" THEN
							-- CLR_Z
							clr_IR 	<= '0';
							ld_IR 	<= '0';
							ld_PC		<= '0';
							inc_PC	<= '0';
							clr_A 	<= '0';
							clr_B 	<= '0';
							clr_C 	<= '0';
							clr_Z 	<= '1';
							ld_A 		<= '0';
							ld_B 		<= '0';
							ld_C 		<= '0';
							ld_Z 		<= '0';
						ELSIF	INST_sig2 = "01111010" THEN
							-- TSTZ
							IF(status_Z = '1') THEN 
								-- Increment PC counter
								clr_IR 	<= '0';
								ld_IR 	<= '0';
								ld_PC		<= '1';
								inc_PC	<= '1';
								clr_A 	<= '0';
								clr_B 	<= '0';
								clr_C 	<= '0';
								clr_Z 	<= '0';
								ld_A 		<= '0';
								ld_B 		<= '0';
								ld_C 		<= '0';
								ld_Z 		<= '0';
							END IF;
						ELSIF	INST_sig2 = "01111100" THEN
							-- TSTC
							IF(status_C = '1') THEN 
								-- Increment PC counter
								clr_IR 	<= '0';
								ld_IR 	<= '0';
								ld_PC		<= '1';
								inc_PC	<= '1';
								clr_A 	<= '0';
								clr_B 	<= '0';
								clr_C 	<= '0';
								clr_Z 	<= '0';
								ld_A 		<= '0';
								ld_B 		<= '0';
								ld_C 		<= '0';
								ld_Z 		<= '0';
							END IF;
						END IF; -- End for state 2 Ops
					END IF;
				END IF; -- End for enable
		END PROCESS;
			
		---- STATE MACHINE ----
		PROCESS (clk, Sen)
			BEGIN
				IF Sen = '1' THEN
					IF rising_edge(clk) THEN
						IF present_state = state_0 THEN
							present_state <= state_1;
						ELSIF present_state <= state_1 THEN
							present_state <= state_2;
						ELSE
							present_state <= state_0;
						END IF;
					END IF;
				ELSE
					present_state <= state_0;
				END IF;
		END PROCESS;
		
		WITH present_state SELECT
			T <=	"001" WHEN state_0,
					"010" WHEN state_1,
					"100" WHEN state_2,
					"001" WHEN OTHERS;
END Behaviour;
					
					
					
					
					
					
					
					
					
					
					
					