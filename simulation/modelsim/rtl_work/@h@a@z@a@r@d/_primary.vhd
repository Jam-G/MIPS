library verilog;
use verilog.vl_types.all;
entity HAZARD is
    port(
        Rt_IF_ID        : in     vl_logic_vector(4 downto 0);
        Rs_IF_ID        : in     vl_logic_vector(4 downto 0);
        Rt_ID_EX        : in     vl_logic_vector(4 downto 0);
        RtRead_IF_ID    : in     vl_logic;
        Jump            : in     vl_logic;
        MemRead_ID_EX   : in     vl_logic;
        Branch          : in     vl_logic;
        PCSrc           : out    vl_logic_vector(1 downto 0);
        IF_ID_Stall     : out    vl_logic;
        IF_ID_Flush     : out    vl_logic;
        ID_EX_Stall     : out    vl_logic;
        ID_EX_Flush     : out    vl_logic;
        EX_MEM_Stall    : out    vl_logic;
        EX_MEM_Flush    : out    vl_logic;
        MEM_REG_Stall   : out    vl_logic;
        MEM_REG_Flush   : out    vl_logic;
        loaduse         : out    vl_logic
    );
end HAZARD;
