-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 14.0.2 Build 209 09/17/2014 SJ Full Version"

-- DATE "06/22/2023 13:08:08"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	reset_circuit IS
    PORT (
	Reset : IN std_logic;
	Clk : IN std_logic;
	en_PD : OUT std_logic;
	Clr_PC : OUT std_logic
	);
END reset_circuit;

-- Design Ports Information
-- en_PD	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Clr_PC	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Reset	=>  Location: PIN_L3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Clk	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF reset_circuit IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Reset : std_logic;
SIGNAL ww_Clk : std_logic;
SIGNAL ww_en_PD : std_logic;
SIGNAL ww_Clr_PC : std_logic;
SIGNAL \Clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \en_PD~output_o\ : std_logic;
SIGNAL \Clr_PC~output_o\ : std_logic;
SIGNAL \Clk~input_o\ : std_logic;
SIGNAL \Clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \Reset~input_o\ : std_logic;
SIGNAL \en_PD~2_combout\ : std_logic;
SIGNAL \present_Clk.clk0~0_combout\ : std_logic;
SIGNAL \present_Clk.clk0~q\ : std_logic;
SIGNAL \present_Clk~6_combout\ : std_logic;
SIGNAL \present_Clk.clk1~q\ : std_logic;
SIGNAL \present_Clk~7_combout\ : std_logic;
SIGNAL \present_Clk.clk2~q\ : std_logic;
SIGNAL \present_Clk~8_combout\ : std_logic;
SIGNAL \present_Clk~9_combout\ : std_logic;
SIGNAL \present_Clk.clk3~q\ : std_logic;
SIGNAL \en_PD~0_combout\ : std_logic;
SIGNAL \en_PD~1_combout\ : std_logic;
SIGNAL \en_PD~reg0_q\ : std_logic;
SIGNAL \Clr_PC~reg0_q\ : std_logic;

BEGIN

ww_Reset <= Reset;
ww_Clk <= Clk;
en_PD <= ww_en_PD;
Clr_PC <= ww_Clr_PC;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\Clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \Clk~input_o\);

-- Location: IOOBUF_X0_Y52_N2
\en_PD~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \en_PD~reg0_q\,
	devoe => ww_devoe,
	o => \en_PD~output_o\);

-- Location: IOOBUF_X0_Y52_N23
\Clr_PC~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Clr_PC~reg0_q\,
	devoe => ww_devoe,
	o => \Clr_PC~output_o\);

-- Location: IOIBUF_X0_Y36_N8
\Clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Clk,
	o => \Clk~input_o\);

-- Location: CLKCTRL_G2
\Clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X0_Y52_N15
\Reset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Reset,
	o => \Reset~input_o\);

-- Location: LCCOMB_X1_Y52_N16
\en_PD~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \en_PD~2_combout\ = !\Reset~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Reset~input_o\,
	combout => \en_PD~2_combout\);

-- Location: LCCOMB_X1_Y52_N26
\present_Clk.clk0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_Clk.clk0~0_combout\ = !\Reset~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Reset~input_o\,
	combout => \present_Clk.clk0~0_combout\);

-- Location: FF_X1_Y52_N27
\present_Clk.clk0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clk~inputclkctrl_outclk\,
	d => \present_Clk.clk0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_Clk.clk0~q\);

-- Location: LCCOMB_X1_Y52_N28
\present_Clk~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_Clk~6_combout\ = (!\present_Clk.clk0~q\ & !\Reset~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \present_Clk.clk0~q\,
	datac => \Reset~input_o\,
	combout => \present_Clk~6_combout\);

-- Location: FF_X1_Y52_N29
\present_Clk.clk1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clk~inputclkctrl_outclk\,
	d => \present_Clk~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_Clk.clk1~q\);

-- Location: LCCOMB_X1_Y52_N12
\present_Clk~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_Clk~7_combout\ = (\present_Clk.clk0~q\ & (!\Reset~input_o\ & \present_Clk.clk1~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \present_Clk.clk0~q\,
	datac => \Reset~input_o\,
	datad => \present_Clk.clk1~q\,
	combout => \present_Clk~7_combout\);

-- Location: FF_X1_Y52_N13
\present_Clk.clk2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clk~inputclkctrl_outclk\,
	d => \present_Clk~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_Clk.clk2~q\);

-- Location: LCCOMB_X1_Y52_N22
\present_Clk~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_Clk~8_combout\ = (!\Reset~input_o\ & (\present_Clk.clk0~q\ & ((\present_Clk.clk3~q\) # (\present_Clk.clk2~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Reset~input_o\,
	datab => \present_Clk.clk3~q\,
	datac => \present_Clk.clk0~q\,
	datad => \present_Clk.clk2~q\,
	combout => \present_Clk~8_combout\);

-- Location: LCCOMB_X1_Y52_N14
\present_Clk~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_Clk~9_combout\ = (\present_Clk~8_combout\ & !\present_Clk.clk1~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \present_Clk~8_combout\,
	datad => \present_Clk.clk1~q\,
	combout => \present_Clk~9_combout\);

-- Location: FF_X1_Y52_N15
\present_Clk.clk3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clk~inputclkctrl_outclk\,
	d => \present_Clk~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_Clk.clk3~q\);

-- Location: LCCOMB_X1_Y52_N20
\en_PD~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \en_PD~0_combout\ = (\present_Clk.clk2~q\) # (!\present_Clk.clk3~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \present_Clk.clk3~q\,
	datad => \present_Clk.clk2~q\,
	combout => \en_PD~0_combout\);

-- Location: LCCOMB_X1_Y52_N30
\en_PD~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \en_PD~1_combout\ = (\Reset~input_o\) # ((\present_Clk.clk0~q\ & (!\present_Clk.clk1~q\ & !\en_PD~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \present_Clk.clk0~q\,
	datab => \present_Clk.clk1~q\,
	datac => \Reset~input_o\,
	datad => \en_PD~0_combout\,
	combout => \en_PD~1_combout\);

-- Location: FF_X1_Y52_N17
\en_PD~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clk~inputclkctrl_outclk\,
	d => \en_PD~2_combout\,
	ena => \en_PD~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \en_PD~reg0_q\);

-- Location: FF_X1_Y52_N31
\Clr_PC~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clk~inputclkctrl_outclk\,
	asdata => \Reset~input_o\,
	sload => VCC,
	ena => \en_PD~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Clr_PC~reg0_q\);

ww_en_PD <= \en_PD~output_o\;

ww_Clr_PC <= \Clr_PC~output_o\;
END structure;


