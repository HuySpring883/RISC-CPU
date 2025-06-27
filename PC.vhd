LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY PC IS
	PORT(
		clr	: IN STD_LOGIC;
		clk	: IN STD_LOGIC;
		ld		: IN STD_LOGIC;
		inc	: IN STD_LOGIC;
		d		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		q		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END PC;

ARCHITECTURE Behaviour OF PC IS
	COMPONENT add
		PORT(
			A	:	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			B	:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	end COMPONENT;
	COMPONENT mux2to1
		PORT(
			s			: IN 	STD_LOGIC;
			w0, w1	: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			f			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	COMPONENT register32
		PORT(
			d		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ld		: IN STD_LOGIC;
			clr	: IN STD_LOGIC;
			clk	: IN STD_LOGIC;
			Q		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT;
	SIGNAL add_out	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out	: STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	add0	:	add port map(q_out, add_out);
	mux0	: 	mux2to1 port map(inc, d, add_out, mux_out);
	reg0	: 	register32 port map(mux_out, ld, clr, clk, q_out);
	q <= q_out;
END Behaviour;