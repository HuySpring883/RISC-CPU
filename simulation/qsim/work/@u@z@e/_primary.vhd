library verilog;
use verilog.vl_types.all;
entity UZE is
    port(
        data_in         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end UZE;
