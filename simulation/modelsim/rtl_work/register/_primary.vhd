library verilog;
use verilog.vl_types.all;
entity \register\ is
    port(
        rs_addr         : in     vl_logic_vector(4 downto 0);
        rt_addr         : in     vl_logic_vector(4 downto 0);
        rd_addr         : in     vl_logic_vector(4 downto 0);
        rd_byte_w_en    : in     vl_logic_vector(3 downto 0);
        rd_in           : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rs_out          : out    vl_logic_vector(31 downto 0);
        rt_out          : out    vl_logic_vector(31 downto 0)
    );
end \register\;
