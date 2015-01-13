library verilog;
use verilog.vl_types.all;
entity MEM is
    port(
        clk             : in     vl_logic;
        Op              : in     vl_logic_vector(5 downto 0);
        Condition       : in     vl_logic_vector(2 downto 0);
        Branch          : in     vl_logic;
        MemWrite        : in     vl_logic;
        RegWrite        : in     vl_logic;
        MemData         : in     vl_logic_vector(31 downto 0);
        Less            : in     vl_logic;
        Zero            : in     vl_logic;
        Overflow        : in     vl_logic;
        WBData          : in     vl_logic_vector(31 downto 0);
        MemData_Mem     : out    vl_logic_vector(31 downto 0);
        Rd_write_byte_en: out    vl_logic_vector(3 downto 0);
        RegWriteValid   : out    vl_logic;
        BranchValid     : out    vl_logic;
        Mem_write_byte_en: out    vl_logic_vector(3 downto 0)
    );
end MEM;
