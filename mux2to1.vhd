LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2to1 IS
PORT(	s			: IN 	STD_LOGIC;
		w0, w1	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		f			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END mux2to1;

ARCHITECTURE Behaviour of mux2to1 IS
BEGIN
	WITH s select
		f <= w0 WHEN '0',
			  w1 WHEN OTHERS;
END Behaviour;