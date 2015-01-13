library verilog;
use verilog.vl_types.all;
entity select2_8 is
    port(
        in1             : in     vl_logic_vector(7 downto 0);
        in2             : in     vl_logic_vector(7 downto 0);
        choose          : in     vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end select2_8;
