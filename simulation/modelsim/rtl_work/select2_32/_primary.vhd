library verilog;
use verilog.vl_types.all;
entity select2_32 is
    port(
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        choose          : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end select2_32;
