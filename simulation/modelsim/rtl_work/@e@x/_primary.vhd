library verilog;
use verilog.vl_types.all;
entity EX is
    port(
        PC_ID_EX_out    : in     vl_logic_vector(31 downto 0);
        PC_IF_ID        : in     vl_logic_vector(31 downto 0);
        ExResultSrc     : in     vl_logic_vector(1 downto 0);
        ALUSrcA         : in     vl_logic;
        ALUSrcB         : in     vl_logic;
        ALUOp           : in     vl_logic_vector(3 downto 0);
        RegDst          : in     vl_logic_vector(1 downto 0);
        ShiftAmountSrc  : in     vl_logic;
        ShiftOp         : in     vl_logic_vector(1 downto 0);
        A_in            : in     vl_logic_vector(31 downto 0);
        B_in            : in     vl_logic_vector(31 downto 0);
        Rs              : in     vl_logic_vector(4 downto 0);
        Rt              : in     vl_logic_vector(4 downto 0);
        Rd              : in     vl_logic_vector(4 downto 0);
        Imm32           : in     vl_logic_vector(31 downto 0);
        Shamt           : in     vl_logic_vector(4 downto 0);
        A_in_sel        : in     vl_logic_vector(7 downto 0);
        B_in_sel        : in     vl_logic_vector(7 downto 0);
        WBData_Mem      : in     vl_logic_vector(31 downto 0);
        Data            : in     vl_logic_vector(31 downto 0);
        Branch_Addr     : out    vl_logic_vector(31 downto 0);
        WBData_EX       : out    vl_logic_vector(31 downto 0);
        MemData         : out    vl_logic_vector(31 downto 0);
        A               : out    vl_logic_vector(31 downto 0);
        Less            : out    vl_logic;
        Zero            : out    vl_logic;
        Overflow        : out    vl_logic;
        Rd_Dst          : out    vl_logic_vector(4 downto 0);
        ALU_A           : out    vl_logic_vector(31 downto 0);
        ALU_B           : out    vl_logic_vector(31 downto 0)
    );
end EX;
