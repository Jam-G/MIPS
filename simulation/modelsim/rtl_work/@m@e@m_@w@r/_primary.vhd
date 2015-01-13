library verilog;
use verilog.vl_types.all;
entity MEM_WR is
    port(
        clk             : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        MemData_Mem     : in     vl_logic_vector(31 downto 0);
        Rd_write_byte_en_Mem: in     vl_logic_vector(3 downto 0);
        WBData_Mem      : in     vl_logic_vector(31 downto 0);
        MemRead_Mem     : in     vl_logic;
        RegWrite_Mem    : in     vl_logic;
        Rd_Mem          : in     vl_logic_vector(4 downto 0);
        MemData_Wr      : out    vl_logic_vector(31 downto 0);
        Rd_write_byte_en_Wr: out    vl_logic_vector(3 downto 0);
        WBData_Wr       : out    vl_logic_vector(31 downto 0);
        MemRead_Wr      : out    vl_logic;
        RegWrite_Wr     : out    vl_logic;
        Rd_Wr           : out    vl_logic_vector(4 downto 0)
    );
end MEM_WR;
