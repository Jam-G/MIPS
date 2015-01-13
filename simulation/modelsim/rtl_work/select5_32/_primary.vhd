library verilog;
use verilog.vl_types.all;
entity select5_32 is
    port(
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        in3             : in     vl_logic_vector(31 downto 0);
        in4             : in     vl_logic_vector(31 downto 0);
        in5             : in     vl_logic_vector(31 downto 0);
        choose          : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end select5_32;
