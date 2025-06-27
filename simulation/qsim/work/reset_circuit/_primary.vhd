library verilog;
use verilog.vl_types.all;
entity reset_circuit is
    port(
        Reset           : in     vl_logic;
        Clk             : in     vl_logic;
        en_PD           : out    vl_logic;
        Clr_PC          : out    vl_logic
    );
end reset_circuit;
