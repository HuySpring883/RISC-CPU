LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY reset_circuit IS
	PORT(
		Reset, Clk	:  IN STD_LOGIC;
		en_PD			: OUT STD_LOGIC := '1';	
		Clr_PC		: OUT STD_LOGIC
		);
END reset_circuit;

ARCHITECTURE Behaviour OF reset_circuit IS

	TYPE clkNum IS (clk0, clk1, clk2, clk3);
	SIGNAL present_Clk : clkNum;
	
	BEGIN
		PROCESS(Clk) BEGIN
			IF rising_edge(Clk) THEN
				IF Reset = '1' THEN
					en_PD <= '0';
					present_Clk <= clk0;
					Clr_PC <= '1';
				ELSIF present_Clk <= clk0 THEN
					present_Clk <= clk1;
				ELSIF present_Clk <= clk1 THEN
					present_Clk <= clk2;
				ELSIF present_Clk <= clk2 THEN
					Present_Clk <= clk3;
				ELSIF present_Clk <= clk3 THEN
					Clr_PC <= '0';
					en_PD <= '1';
				END IF;
			END IF;
		END PROCESS;
END Behaviour;