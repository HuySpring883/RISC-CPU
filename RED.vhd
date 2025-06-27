LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY RED IS
	PORT(	
		data_in	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_out	: OUT UNSIGNED(7 DOWNTO 0));
END RED;

ARCHITECTURE Behaviour of RED IS
BEGIN
	data_out <= UNSIGNED(data_in(7 DOWNTO 0));
END Behaviour;