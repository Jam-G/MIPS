library verilog;
use verilog.vl_types.all;
entity IF_ID is
    port(
        clk             : in     vl_logic;
        stall           : in     vl_logic;
        flush           : in     vl_logic;
        PC_4_IF         : in     vl_logic_vector(31 downto 0);
        op_IF           : in     vl_logic_vector(5 downto 0);
        Rs_IF           : in     vl_logic_vector(4 downto 0);
        Rt_IF           : in     vl_logic_vector(4 downto 0);
        Rd_IF           : in     vl_logic_vector(4 downto 0);
        Shamt_IF        : in     vl_logic_vector(4 downto 0);
        Func_IF         : in     vl_logic_vector(5 downto 0);
        PC_4_ID         : out    vl_logic_vector(31 downto 0);
        op_ID           : out    vl_logic_vector(5 downto 0);
        Rs_ID           : out    vl_logic_vector(4 downto 0);
        Rt_ID           : out    vl_logic_vector(4 downto 0);
        Rd_ID           : out    vl_logic_vector(4 downto 0);
        Shamt_ID        : out    vl_logic_vector(4 downto 0);
        Func_ID         : out    vl_logic_vector(5 downto 0)
    );
end IF_ID;
