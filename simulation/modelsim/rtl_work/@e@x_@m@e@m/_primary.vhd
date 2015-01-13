library verilog;
use verilog.vl_types.all;
entity EX_MEM is
    port(
        Clk             : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        Branch_addr_EX  : in     vl_logic_vector(31 downto 0);
        op_EX           : in     vl_logic_vector(5 downto 0);
        Condition_EX    : in     vl_logic_vector(2 downto 0);
        Branch_EX       : in     vl_logic;
        MemWrite_EX     : in     vl_logic;
        RegWrite_EX     : in     vl_logic;
        MemRead_EX      : in     vl_logic;
        MemData_EX      : in     vl_logic_vector(31 downto 0);
        WBData_EX       : in     vl_logic_vector(31 downto 0);
        Less_EX         : in     vl_logic;
        Zero_EX         : in     vl_logic;
        Overflow_EX     : in     vl_logic;
        Rd_EX           : in     vl_logic_vector(4 downto 0);
        Branch_addr_MEM : out    vl_logic_vector(31 downto 0);
        op_MEM          : out    vl_logic_vector(5 downto 0);
        Condition_MEM   : out    vl_logic_vector(2 downto 0);
        Branch_MEM      : out    vl_logic;
        MemWrite_MEM    : out    vl_logic;
        RegWrite_MEM    : out    vl_logic;
        MemRead_MEM     : out    vl_logic;
        MemData_MEM     : out    vl_logic_vector(31 downto 0);
        WBData_MEM      : out    vl_logic_vector(31 downto 0);
        Less_MEM        : out    vl_logic;
        Zero_MEM        : out    vl_logic;
        Overflow_MEM    : out    vl_logic;
        Rd_MEM          : out    vl_logic_vector(4 downto 0)
    );
end EX_MEM;
