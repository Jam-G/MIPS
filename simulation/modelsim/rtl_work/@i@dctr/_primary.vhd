library verilog;
use verilog.vl_types.all;
entity IDctr is
    port(
        Op              : in     vl_logic_vector(5 downto 0);
        Func            : in     vl_logic_vector(5 downto 0);
        Condition       : out    vl_logic_vector(2 downto 0);
        Branch          : out    vl_logic;
        MemWrite        : out    vl_logic;
        RegWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        Jump            : out    vl_logic_vector(1 downto 0);
        ExResultSrc     : out    vl_logic_vector(1 downto 0);
        ALUSrcA         : out    vl_logic;
        ALUSrcB         : out    vl_logic;
        ALUOp           : out    vl_logic_vector(3 downto 0);
        RegDst          : out    vl_logic_vector(1 downto 0);
        ShiftAmountSrc  : out    vl_logic;
        ShiftOp         : out    vl_logic_vector(1 downto 0);
        IF_ID_RtRead    : out    vl_logic;
        ExtendI         : out    vl_logic_vector(1 downto 0)
    );
end IDctr;
