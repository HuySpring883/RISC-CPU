LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY UZE IS
	PORT(	
		data_in	: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_out	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END UZE;

ARCHITECTURE Behaviour of UZE IS
	
	SIGNAL UZE	:	STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	
BEGIN
	data_out <= data_in(15 DOWNTO 0) & UZE;
END Behaviour;