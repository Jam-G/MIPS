library verilog;
use verilog.vl_types.all;
entity mem_shifter is
    port(
        mem_data_out    : in     vl_logic_vector(31 downto 0);
        mem_addr_in     : in     vl_logic_vector(1 downto 0);
        IR_out          : in     vl_logic_vector(5 downto 0);
        mem_data_shift  : out    vl_logic_vector(31 downto 0);
        Rd_write_byte_en: out    vl_logic_vector(3 downto 0)
    );
end mem_shifter;
