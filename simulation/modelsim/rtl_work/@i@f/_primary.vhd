library verilog;
use verilog.vl_types.all;
entity \IF\ is
    port(
        clk             : in     vl_logic;
        PCSrc           : in     vl_logic_vector(1 downto 0);
        PC0             : in     vl_logic_vector(31 downto 0);
        PC1             : in     vl_logic_vector(31 downto 0);
        PC2             : in     vl_logic_vector(31 downto 0);
        PC3             : in     vl_logic_vector(31 downto 0);
        PC_IF_ID_in     : out    vl_logic_vector(31 downto 0);
        IR_out          : out    vl_logic_vector(31 downto 0)
    );
end \IF\;
