transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/UZE.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/register32.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/RED.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/PC.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/mux4to1.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/mux2to1.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/LZE.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/fulladd.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/datapath.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/data_mem.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/ALU.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/adder32.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/adder16.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/adder4.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/add.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/system_memory.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/CPU_TEST_Sim.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/reset_circuit.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/cpu1.vhd}
vcom -93 -work work {/home/student2/t11ngo/COE608/Lab 6/Control_New.vhd}

