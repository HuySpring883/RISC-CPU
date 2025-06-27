LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY alu IS
	PORT(
		a			: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		b			: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		op			: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Cout		: OUT STD_LOGIC;
		zero		: OUT STD_LOGIC
		);
END alu;

ARCHITECTURE Behaviour OF alu IS
	COMPONENT adder32
		PORT(
			Cin	: IN 	STD_LOGIC;
			X, Y	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			S		: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Cout	: OUT STD_LOGIC
			);
	END COMPONENT;
	
	SIGNAL result_s	:	STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL result_add	:	STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL result_sub	:	STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Cout_s		:	STD_LOGIC := '0';
	SIGNAL Cout_add	:	STD_LOGIC := '0';
	SIGNAL Cout_sub	:	STD_LOGIC := '0';
	SIGNAL zero_s		:	STD_LOGIC;

BEGIN
	add0	:	adder32 port map(op(2), a, b, result_add, Cout_add);
	sub0	:	adder32 port map(op(2), a, NOT b, result_sub, Cout_sub);
	
	PROCESS(a, b, op)
	BEGIN
		CASE (op) IS
			WHEN "000" => -- "000" a AND b
				result_s <= a AND b;
				Cout_s <= '0';
			WHEN "001" => -- "001" a OR b
				result_s <= a OR b;
				Cout_s <= '0';
			WHEN "010" => -- "010" a + b
				result_s <= result_add;
				Cout_s <= Cout_add;
			WHEN "011" => -- "001" b
				result_s <= b;
				Cout_s <= '0';
			WHEN "110" => -- "110" a - b
				result_s <= result_sub;
				Cout_s <= Cout_sub;
			WHEN "100" => -- a sll 1
				result_s <= a(30 DOWNTO 0) & '0';
				Cout_s <= a(31);
			WHEN "101" => -- a srl 1
				result_s <= '0' & a(31 DOWNTO 1);
				Cout_s <= '0';
			WHEN OTHERS =>
				result_s <= a;
				Cout_s <= '0';
		END CASE;
		
		CASE (result_s) IS
			WHEN (OTHERS => '0') =>
				zero_s <= '1';
			WHEN OTHERS =>
				zero_s <= '0';
		END CASE;
	END PROCESS;
	
	result <= result_s;
	Cout <= Cout_s;
	zero <= zero_s;

END Behaviour;




















