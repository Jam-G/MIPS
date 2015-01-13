library verilog;
use verilog.vl_types.all;
entity reg_shifter is
    port(
        rt_out          : in     vl_logic_vector(31 downto 0);
        mem_addr_in     : in     vl_logic_vector(1 downto 0);
        MemWrite        : in     vl_logic;
        IR_out          : in     vl_logic_vector(5 downto 0);
        rt_out_shift    : out    vl_logic_vector(31 downto 0);
        mem_byte_write_out: out    vl_logic_vector(3 downto 0)
    );
end reg_shifter;
