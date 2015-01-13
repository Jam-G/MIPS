library verilog;
use verilog.vl_types.all;
entity Shifter is
    port(
        shift_amount    : in     vl_logic_vector(4 downto 0);
        shift_in        : in     vl_logic_vector(31 downto 0);
        shift_op        : in     vl_logic_vector(1 downto 0);
        shift_out       : out    vl_logic_vector(31 downto 0)
    );
end Shifter;
