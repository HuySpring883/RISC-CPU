LIBRARY ieee;

USE ieee.std_logic_1164.all;

ENTITY adder32 IS
	PORT(
		Cin	:	IN 	STD_LOGIC;
		X, Y	: 	IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		S		: 	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Cout	: 	OUT 	STD_LOGIC
		);
END adder32;

ARCHITECTURE Behaviour OF adder32 IS
	COMPONENT adder16
		PORT(
			Cin	:	IN		STD_LOGIC;
			X, Y	:	IN		STD_LOGIC_VECTOR(15 DOWNTO 0);
			S		:	OUT 	STD_LOGIC_VECTOR(15 DOWNTO 0);
			Cout	:	OUT 	STD_LOGIC
		);
	END COMPONENT;
	
	SIGNAL	C	: STD_LOGIC;

BEGIN
	stage0	:	adder16 port map(Cin, X(15 DOWNTO 0), Y(15 DOWNTO 0), S(15 DOWNTO 0), C);
	stage1	:	adder16 port map(C, X(31 DOWNTO 16), Y(31 DOWNTO 16), S(31 DOWNTO 16), Cout);
END Behaviour;