library verilog;
use verilog.vl_types.all;
entity Pipeline is
    port(
        clk             : in     vl_logic;
        PC_IF_ID        : out    vl_logic_vector(31 downto 0);
        Op_IF_ID        : out    vl_logic_vector(5 downto 0);
        Rs_IF_ID        : out    vl_logic_vector(4 downto 0);
        Rt_IF_ID        : out    vl_logic_vector(4 downto 0);
        Rd_IF_ID        : out    vl_logic_vector(4 downto 0);
        Shamt_IF_ID     : out    vl_logic_vector(4 downto 0);
        Func_IF_ID      : out    vl_logic_vector(5 downto 0);
        PC_ID_EX        : out    vl_logic_vector(31 downto 0);
        Op_ID_EX        : out    vl_logic_vector(5 downto 0);
        Condition_ID_EX : out    vl_logic_vector(2 downto 0);
        Branch_ID_EX    : out    vl_logic;
        MemWrite_ID_EX  : out    vl_logic;
        Reg_Write_ID_EX : out    vl_logic;
        MemRead_ID_EX   : out    vl_logic;
        Jump_ID_EX      : out    vl_logic;
        ExResultSrc_ID_EX: out    vl_logic_vector(1 downto 0);
        ALUSrcA_ID_EX   : out    vl_logic;
        ALUSrcB_ID_EX   : out    vl_logic;
        ALUOp_ID_EX     : out    vl_logic_vector(3 downto 0);
        RegDst_ID_EX    : out    vl_logic_vector(1 downto 0);
        ShiftAmountSrc_ID_EX: out    vl_logic;
        ShiftOp_ID_EX   : out    vl_logic_vector(1 downto 0);
        A_in_ID_EX      : out    vl_logic_vector(31 downto 0);
        B_in_ID_EX      : out    vl_logic_vector(31 downto 0);
        A               : out    vl_logic_vector(31 downto 0);
        B               : out    vl_logic_vector(31 downto 0);
        Rs_ID_EX        : out    vl_logic_vector(4 downto 0);
        Rt_ID_EX        : out    vl_logic_vector(4 downto 0);
        Rd_ID_EX        : out    vl_logic_vector(4 downto 0);
        Imm32_ID_EX     : out    vl_logic_vector(31 downto 0);
        Shamt_ID_EX     : out    vl_logic_vector(4 downto 0);
        Branch_addr_EX_MEM: out    vl_logic_vector(31 downto 0);
        Op_EX_MEM       : out    vl_logic_vector(5 downto 0);
        Codition_EX_MEM : out    vl_logic_vector(2 downto 0);
        Branch_EX_MEM   : out    vl_logic;
        MemWrite_EX_MEM : out    vl_logic;
        Reg_Write_EX_MEM: out    vl_logic;
        MemRead_EX_MEM  : out    vl_logic;
        MemData_EX_MEM  : out    vl_logic_vector(31 downto 0);
        WBData_EX_MEM   : out    vl_logic_vector(31 downto 0);
        Less_EX_MEM     : out    vl_logic;
        Zero_EX_MEM     : out    vl_logic;
        Overflow_EX_MEM : out    vl_logic;
        Rd_EX_MEM       : out    vl_logic_vector(4 downto 0);
        MemData_MEM_WR  : out    vl_logic_vector(31 downto 0);
        Rd_write_byte_en_MEM_WR: out    vl_logic_vector(3 downto 0);
        WBData_MEM_WR   : out    vl_logic_vector(31 downto 0);
        MemRead_MEM_WR  : out    vl_logic;
        Reg_Write_MEM_WR: out    vl_logic;
        Rd_MEM_WR       : out    vl_logic_vector(4 downto 0);
        Mem_write_byte_en: out    vl_logic_vector(3 downto 0);
        IF_ID_Flush     : out    vl_logic;
        ID_EX_Flush     : out    vl_logic;
        IF_ID_Stall     : out    vl_logic;
        ID_EX_Stall     : out    vl_logic;
        Rs_out_EX       : out    vl_logic_vector(31 downto 0);
        Rt_out_EX       : out    vl_logic_vector(31 downto 0);
        A_in_sel        : out    vl_logic_vector(7 downto 0);
        B_in_sel        : out    vl_logic_vector(7 downto 0);
        RsOut_sel       : out    vl_logic_vector(3 downto 0);
        RtOut_sel       : out    vl_logic_vector(3 downto 0)
    );
end Pipeline;
