library verilog;
use verilog.vl_types.all;
entity cpu1 is
    port(
        clk             : in     vl_logic;
        Mem_Clk         : in     vl_logic;
        rst             : in     vl_logic;
        DataIn          : in     vl_logic_vector(31 downto 0);
        dataOUT         : out    vl_logic_vector(31 downto 0);
        addrOUT         : out    vl_logic_vector(31 downto 0);
        Wen             : out    vl_logic;
        Wen_Mem         : out    vl_logic;
        en_Mem          : out    vl_logic;
        dOutA           : out    vl_logic_vector(31 downto 0);
        dOutB           : out    vl_logic_vector(31 downto 0);
        dOutIR          : out    vl_logic_vector(31 downto 0);
        dOutPC          : out    vl_logic_vector(31 downto 0);
        dOutC           : out    vl_logic;
        dOutZ           : out    vl_logic;
        outT            : out    vl_logic_vector(2 downto 0)
    );
end cpu1;
