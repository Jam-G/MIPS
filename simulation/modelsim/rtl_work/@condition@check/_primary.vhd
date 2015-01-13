library verilog;
use verilog.vl_types.all;
entity ConditionCheck is
    port(
        Condition       : in     vl_logic_vector(2 downto 0);
        Branch          : in     vl_logic;
        RegWrite        : in     vl_logic;
        Less            : in     vl_logic;
        Zero            : in     vl_logic;
        Overflow        : in     vl_logic;
        BranchValid     : out    vl_logic;
        RegWriteValid   : out    vl_logic
    );
end ConditionCheck;
