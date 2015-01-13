module Pipeline(
input clk,
output [31:0] PC_IF_ID,
output [5:0] Op_IF_ID,
output [4:0] Rs_IF_ID,
output [4:0] Rt_IF_ID,
output [4:0] Rd_IF_ID,
output [4:0] Shamt_IF_ID,
output [5:0] Func_IF_ID,
output [31:0] PC_ID_EX,
output [5:0] Op_ID_EX,
output [2:0] Condition_ID_EX,
output Branch_ID_EX,
output MemWrite_ID_EX,
output Reg_Write_ID_EX,
output MemRead_ID_EX,
output Jump_ID_EX,
output [1:0] ExResultSrc_ID_EX,
output ALUSrcA_ID_EX,
output ALUSrcB_ID_EX,
output [3:0] ALUOp_ID_EX,
output [1:0] RegDst_ID_EX,
output ShiftAmountSrc_ID_EX,
output [1:0] ShiftOp_ID_EX,
output [31:0] A_in_ID_EX,B_in_ID_EX,
output [31:0] A, B,
output [4:0] Rs_ID_EX,Rt_ID_EX,Rd_ID_EX,
output [31:0] Imm32_ID_EX,
output [4:0] Shamt_ID_EX,
output [31:0] Branch_addr_EX_MEM,
output [5:0] Op_EX_MEM,
output [2:0] Codition_EX_MEM,
output Branch_EX_MEM,
output MemWrite_EX_MEM,
output Reg_Write_EX_MEM,
output MemRead_EX_MEM,
output [31:0] MemData_EX_MEM,
output [31:0] WBData_EX_MEM,
output Less_EX_MEM,Zero_EX_MEM,Overflow_EX_MEM,
output [4:0] Rd_EX_MEM,
output [31:0] MemData_MEM_WR,
output [3:0] Rd_write_byte_en_MEM_WR,
output [31:0] WBData_MEM_WR,
output MemRead_MEM_WR,
output Reg_Write_MEM_WR,
output [4:0] Rd_MEM_WR,
output [3:0] Mem_write_byte_en,
output IF_ID_Flush, ID_EX_Flush, IF_ID_Stall, ID_EX_Stall,
output [31:0]Rs_out_EX, Rt_out_EX,
output [7:0] A_in_sel, B_in_sel,
output [3:0] RsOut_sel, RtOut_sel
);

wire [31:0] PC3;
wire [1:0] PCSrc;
wire [31:0] PC_IF;
wire [31:0] IR_out;
//wire IF_ID_Stall,IF_ID_Flush;
wire [31:0] Data;
//wire [3:0] RsOut_sel,RtOut_sel;
wire [31:0] A_in_ID;
wire [31:0] B_in_ID;
wire [31:0] Immediate32_ID;
wire [2:0] Condition_ID;
wire Branch_ID;
wire MemWrite_ID;
wire RegWrite_ID;
wire MemRead_ID;
wire Jump_ID;
wire [1:0] ExResultSrc_ID;
wire ALUSrcA_ID;
wire ALUSrcB_ID;
wire [3:0] ALUOp_ID;
wire [1:0] RegDst_ID;
wire ShiftAmountSrc_ID;
wire [1:0] ShiftOp_ID;
wire IF_ID_RtRead_ID;
wire loadusein, loaduseout;
//wire ID_EX_Stall,ID_EX_Flush;
//wire [7:0] A_in_sel,B_in_sel;

wire [31:0] Branch_Addr;
wire [31:0] WBData_EX;
wire [31:0] MemData;
wire Less,Zero,Overflow;
wire [4:0] Rd_Dst;
wire EX_MEM_Stall,EX_MEM_Flush;
wire [31:0] MemData_MEM;
wire [3:0] Rd_write_byte_en_MEM;
wire RegWriteValid,BranchValid;
wire MEM_WR_Stall,MEM_WR_Flush;
wire [3:0] Rd_write_byte_en_new;
//取指令
IF IF(clk,PCSrc,PC_IF_ID,{PC_ID_EX[31:28],Rs_ID_EX,Rt_ID_EX,Imm32_ID_EX[15:0],2'b00},Branch_addr_EX_MEM,PC3,PC_IF,IR_out);


IF_ID IF_ID(clk,IF_ID_Stall,IF_ID_Flush,PC_IF,IR_out[31:26],
		IR_out[25:21],IR_out[20:16],IR_out[15:11],IR_out[10:6],
		IR_out[5:0],PC_IF_ID,Op_IF_ID,Rs_IF_ID,Rt_IF_ID,Rd_IF_ID,
		Shamt_IF_ID,Func_IF_ID);

//译码取数
ID ID(clk,Op_IF_ID,Rs_IF_ID,Rt_IF_ID,Rd_IF_ID,Shamt_IF_ID,
		Func_IF_ID,Rd_write_byte_en_new,RsOut_sel,RtOut_sel,
		Data,A_in_ID,B_in_ID,Immediate32_ID,Condition_ID,Branch_ID,
		MemWrite_ID,RegWrite_ID,MemRead_ID,Jump_ID,ExResultSrc_ID,
		ALUSrcA_ID,ALUSrcB_ID,ALUOp_ID,RegDst_ID,ShiftAmountSrc_ID,
		ShiftOp_ID,IF_ID_RtRead_ID, Rs_out_EX, Rt_out_EX);
		
ID_EX ID_EX(clk,ID_EX_Stall,ID_EX_Flush,PC_IF_ID,Op_IF_ID,Condition_ID,
		Branch_ID,MemWrite_ID,RegWrite_ID,MemRead_ID,Jump_ID,ExResultSrc_ID,
		ALUSrcA_ID,ALUSrcB_ID,ALUOp_ID,RegDst_ID,ShiftAmountSrc_ID,
		ShiftOp_ID,A_in_ID,B_in_ID,Rs_IF_ID,Rt_IF_ID,Rd_IF_ID,Immediate32_ID,
		Shamt_IF_ID,loadusein, PC_ID_EX,Op_ID_EX,Condition_ID_EX,Branch_ID_EX,MemWrite_ID_EX,
		Reg_Write_ID_EX,MemRead_ID_EX,Jump_ID_EX,ExResultSrc_ID_EX,ALUSrcA_ID_EX,
		ALUSrcB_ID_EX,ALUOp_ID_EX,RegDst_ID_EX,ShiftAmountSrc_ID_EX,ShiftOp_ID_EX,
		A_in_ID_EX,B_in_ID_EX,Rs_ID_EX,Rt_ID_EX,Rd_ID_EX,Imm32_ID_EX,Shamt_ID_EX,loaduseout
);
//执行
EX EX(PC_ID_EX,PC_IF_ID,ExResultSrc_ID_EX,ALUSrcA_ID_EX,ALUSrcB_ID_EX,ALUOp_ID_EX,
		RegDst_ID_EX,ShiftAmountSrc_ID_EX,ShiftOp_ID_EX,A_in_ID_EX,B_in_ID_EX,Rs_ID_EX,
		Rt_ID_EX,Rd_ID_EX,Imm32_ID_EX,Shamt_ID_EX,A_in_sel,B_in_sel,WBData_EX_MEM,Data,
		Branch_Addr,WBData_EX,MemData,PC3,Less,Zero,Overflow,Rd_Dst, A, B
);

EX_MEM EX_MEM(clk,EX_MEM_Stall,EX_MEM_Flush,Branch_Addr,Op_ID_EX,Condition_ID_EX,
		Branch_ID_EX,MemWrite_ID_EX,Reg_Write_ID_EX,MemRead_ID_EX,MemData,WBData_EX,
		Less,Zero,Overflow,Rd_Dst,Branch_addr_EX_MEM,Op_EX_MEM,Codition_EX_MEM,Branch_EX_MEM,
		MemWrite_EX_MEM,Reg_Write_EX_MEM,MemRead_EX_MEM,MemData_EX_MEM,WBData_EX_MEM,
		Less_EX_MEM,Zero_EX_MEM,Overflow_EX_MEM,Rd_EX_MEM

);
//读写存储器
MEM MEM(clk,Op_EX_MEM,Codition_EX_MEM,Branch_EX_MEM,MemWrite_EX_MEM,Reg_Write_EX_MEM,
		MemData_EX_MEM,Less_EX_MEM,Zero_EX_MEM,Overflow_EX_MEM,WBData_EX_MEM,MemData_MEM,
		Rd_write_byte_en_MEM,RegWriteValid,BranchValid, Mem_write_byte_en
);

MEM_WR MEM_WR(clk,MEM_WR_Stall,MEM_WR_Flush,MemData_MEM,Rd_write_byte_en_MEM,WBData_EX_MEM,
		MemRead_EX_MEM,RegWriteValid,Rd_EX_MEM,MemData_MEM_WR,Rd_write_byte_en_MEM_WR,
		WBData_MEM_WR,MemRead_MEM_WR,Reg_Write_MEM_WR,Rd_MEM_WR

);
//写回寄存器
WR WR(Rd_write_byte_en_MEM_WR,Reg_Write_MEM_WR,MemData_MEM_WR,WBData_MEM_WR,MemRead_MEM_WR,Data,
		Rd_write_byte_en_new
);
//冒险检测
HAZARD HAZARD(Rt_IF_ID,Rs_IF_ID,Rt_ID_EX,IF_ID_RtRead_ID,Jump_ID_EX,MemRead_ID_EX,BranchValid,
		PCSrc,IF_ID_Stall,IF_ID_Flush,ID_EX_Stall,ID_EX_Flush, EX_MEM_Stall,EX_MEM_Flush,MEM_WR_Stall,
		MEM_WR_Flush, loadusein		
);

//转发控制单元
FORWARD FORWARD(Rs_ID_EX,Rt_ID_EX,Rd_EX_MEM,Rs_IF_ID,Rt_IF_ID,Rd_MEM_WR,RegWriteValid,Reg_Write_MEM_WR,
		Rd_write_byte_en_new,loaduseout, RsOut_sel,RtOut_sel,A_in_sel,B_in_sel
);

endmodule
		
		







