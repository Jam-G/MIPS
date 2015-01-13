library verilog;
use verilog.vl_types.all;
entity Extend is
    port(
        Imm16           : in     vl_logic_vector(15 downto 0);
        ExtendI         : in     vl_logic_vector(1 downto 0);
        Imm32           : out    vl_logic_vector(31 downto 0)
    );
end Extend;
