library verilog;
use verilog.vl_types.all;
entity Mem is
    port(
        Mem_byte_wr_in  : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        Mem_data        : in     vl_logic_vector(31 downto 0);
        Mem_addr_in     : in     vl_logic_vector(31 downto 0);
        Mem_data_out    : out    vl_logic_vector(31 downto 0)
    );
end Mem;
