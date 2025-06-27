LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY LZE IS
	PORT(	
		data_in	: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_out	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END LZE;

ARCHITECTURE Behaviour of LZE IS
	
	SIGNAL LZE	:	STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	
BEGIN
	data_out <= LZE & data_in(15 DOWNTO 0);
END Behaviour;