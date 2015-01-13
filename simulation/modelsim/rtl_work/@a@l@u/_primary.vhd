library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        ALU_op          : in     vl_logic_vector(3 downto 0);
        ALU_out         : out    vl_logic_vector(31 downto 0);
        less            : out    vl_logic;
        zero            : out    vl_logic;
        overflow        : out    vl_logic
    );
end ALU;
