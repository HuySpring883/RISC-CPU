LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY add IS
PORT(	A	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		B	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END add;

ARCHITECTURE Behaviour OF add IS
BEGIN
	B <= A + 1;
END Behaviour;