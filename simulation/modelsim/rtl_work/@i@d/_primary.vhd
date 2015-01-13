library verilog;
use verilog.vl_types.all;
entity ID is
    port(
        clk             : in     vl_logic;
        Op              : in     vl_logic_vector(5 downto 0);
        Rs              : in     vl_logic_vector(4 downto 0);
        Rt              : in     vl_logic_vector(4 downto 0);
        Rd              : in     vl_logic_vector(4 downto 0);
        Shamt           : in     vl_logic_vector(4 downto 0);
        Func            : in     vl_logic_vector(5 downto 0);
        Rd_write_byte_en: in     vl_logic_vector(3 downto 0);
        RsOut_sel       : in     vl_logic_vector(3 downto 0);
        RtOut_sel       : in     vl_logic_vector(3 downto 0);
        Data            : in     vl_logic_vector(31 downto 0);
        A_in            : out    vl_logic_vector(31 downto 0);
        B_in            : out    vl_logic_vector(31 downto 0);
        Immediate32     : out    vl_logic_vector(31 downto 0);
        Condition       : out    vl_logic_vector(2 downto 0);
        Branch          : out    vl_logic;
        MemWrite        : out    vl_logic;
        RegWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        Jump            : out    vl_logic;
        ExResultSrc     : out    vl_logic_vector(1 downto 0);
        ALUSrcA         : out    vl_logic;
        ALUSrcB         : out    vl_logic;
        ALUOp           : out    vl_logic_vector(3 downto 0);
        RegDst          : out    vl_logic_vector(1 downto 0);
        ShiftAmountSrc  : out    vl_logic;
        ShiftOp         : out    vl_logic_vector(1 downto 0);
        IF_ID_RtRead    : out    vl_logic;
        Rs_out          : out    vl_logic_vector(31 downto 0);
        Rt_out          : out    vl_logic_vector(31 downto 0)
    );
end ID;
