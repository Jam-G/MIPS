library verilog;
use verilog.vl_types.all;
entity FORWARD is
    port(
        Rs_ID_EX        : in     vl_logic_vector(4 downto 0);
        Rt_ID_EX        : in     vl_logic_vector(4 downto 0);
        Rd_EX_MEM       : in     vl_logic_vector(4 downto 0);
        Rs_IF_ID        : in     vl_logic_vector(4 downto 0);
        Rt_IF_ID        : in     vl_logic_vector(4 downto 0);
        Rd_MEM_REG      : in     vl_logic_vector(4 downto 0);
        RegWrite_EX_MEM : in     vl_logic;
        RegWrite_MEM_REG: in     vl_logic;
        Rd_write_byte_en: in     vl_logic_vector(3 downto 0);
        loaduse         : in     vl_logic;
        RsOut_sel       : out    vl_logic_vector(3 downto 0);
        RtOut_sel       : out    vl_logic_vector(3 downto 0);
        A_in_sel        : out    vl_logic_vector(7 downto 0);
        B_in_sel        : out    vl_logic_vector(7 downto 0)
    );
end FORWARD;
