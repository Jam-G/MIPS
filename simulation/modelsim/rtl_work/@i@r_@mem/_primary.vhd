library verilog;
use verilog.vl_types.all;
entity IR_Mem is
    port(
        clk             : in     vl_logic;
        Mem_addr_in     : in     vl_logic_vector(31 downto 0);
        Mem_data_out    : out    vl_logic_vector(31 downto 0)
    );
end IR_Mem;
