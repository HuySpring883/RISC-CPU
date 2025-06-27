LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux4to1 IS
PORT(	s					: IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
		w0, w1, w2, w3	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		f					: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END mux4to1;

ARCHITECTURE Behaviour of mux4to1 IS
BEGIN
	WITH s select
		f <= w0 WHEN "00",
			  w1 WHEN "01",
			  w2 WHEN "10",
			  w3 WHEN "11";
END Behaviour;