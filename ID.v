module ID(
input clk,
input [5:0] Op,
input [4:0] Rs,
input [4:0] Rt,
input [4:0] Rd,
input [4:0] Shamt,
input [5:0] Func,
input [3:0] Rd_write_byte_en,
input [3:0] RsOut_sel,
input [3:0] RtOut_sel,
input [31:0] Data,
output [31:0] A_in,
output [31:0] B_in,
output [31:0] Immediate32,
output [2:0] Condition,
output Branch,
output MemWrite,
output RegWrite,
output MemRead,
output Jump,
output [1:0] ExResultSrc,
output ALUSrcA,
output ALUSrcB,
output [3:0] ALUOp,
output [1:0] RegDst,
output ShiftAmountSrc,
output [1:0] ShiftOp,
output IF_ID_RtRead,
output [31:0]Rs_out, Rt_out
);
//wire [31:0] Rs_out;
//wire [31:0] Rt_out;
wire [1:0] ExtendI;

register register(Rs,Rt,Rd,Rd_write_byte_en,Data,clk,Rs_out,Rt_out);
IDctr IDctr(Op,Func,Condition,Branch,MemWrite,RegWrite,MemRead,Jump,ExResultSrc,ALUSrcA,ALUSrcB,ALUOp,RegDst,ShiftAmountSrc,ShiftOp,IF_ID_RtRead,ExtendI);
Extend Extend({Rd,Shamt,Func},ExtendI,Immediate32);
select2_8  a(Rs_out[31:24],Data[31:24],RsOut_sel[3],A_in[31:24]);
select2_8  b(Rs_out[23:16],Data[23:16],RsOut_sel[2],A_in[23:16]);
select2_8  c(Rs_out[15:8],Data[15:8],RsOut_sel[1],A_in[15:8]);
select2_8  d(Rs_out[7:0],Data[7:0],RsOut_sel[0],A_in[7:0]);
select2_8  e(Rt_out[31:24],Data[31:24],RtOut_sel[3],B_in[31:24]);
select2_8  f(Rt_out[23:16],Data[23:16],RtOut_sel[2],B_in[23:16]);
select2_8  g(Rt_out[15:8],Data[15:8],RtOut_sel[1],B_in[15:8]);
select2_8  h(Rt_out[7:0],Data[7:0],RtOut_sel[0],B_in[7:0]);
endmodule

module IDctr(
input [5:0] Op,
input [5:0] Func,
output reg [2:0] Condition,
output reg Branch,
output reg MemWrite,
output reg RegWrite,
output reg MemRead,
output reg [1:0] Jump,
output reg [1:0] ExResultSrc,
output reg ALUSrcA,
output reg ALUSrcB,
output reg [3:0] ALUOp,
output reg [1:0] RegDst,
output reg ShiftAmountSrc,
output reg [1:0] ShiftOp,
output reg IF_ID_RtRead,
output reg [1:0] ExtendI
);
always @(*)
begin
case(Op)
6'b000000://R-type
begin
case(Func)
6'b100000://add
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b1110;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b100010://sub
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b1111;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b100011://subu
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0001;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b100111://nor
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b1000;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b101011://sltu
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0101;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b101010://slt
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0111;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b100100://and
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0100;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b100101://or
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0110;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b000111://srav
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b10;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0000;
RegDst=2'b00;
ShiftAmountSrc=1;
ShiftOp=2'b10;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
6'b000010://rotr
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b10;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0000;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b11;
IF_ID_RtRead=1;
ExtendI=2'b00;
end
default:
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=0;
MemRead=0;
Jump=0;
ExResultSrc=2'b00;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0000;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b00;
end

endcase
end
6'b011100://clo,clz
if(Func==100001)//clo
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0011;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b00;
end
else //clz
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0010;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b00;
end
6'b001000://addi
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b1110;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b01;
end
6'b001001://addiu
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b0000;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b00;
end
6'b001110://xori
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b1001;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b00;
end
6'b001010://slti
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b0111;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b01;
end
6'b000010://j
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=0;
MemRead=0;
Jump=1;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0000;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b00;
end
6'b000001://bgezal
begin
Condition=3'b011;
Branch=1;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=1;
ALUSrcB=0;
ALUOp=4'b1111;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b10;
IF_ID_RtRead=0;
ExtendI=2'b11;
end
6'b001111://lui
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b0000;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b10;
end
6'b100010://lwl
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=1;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b0000;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b01;
end
6'b100011://lw
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=1;
MemRead=1;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b0000;
RegDst=2'b01;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b01;
end
6'b101011://sw
begin
Condition=3'b000;
Branch=0;
MemWrite=1;
RegWrite=0;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b0000;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b01;
end
6'b101110://swr
begin
Condition=3'b000;
Branch=0;
MemWrite=1;
RegWrite=0;
MemRead=0;
Jump=0;
ExResultSrc=2'b01;
ALUSrcA=0;
ALUSrcB=1;
ALUOp=4'b0000;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b01;
end
default:
begin
Condition=3'b000;
Branch=0;
MemWrite=0;
RegWrite=0;
MemRead=0;
Jump=0;
ExResultSrc=2'b00;
ALUSrcA=0;
ALUSrcB=0;
ALUOp=4'b0000;
RegDst=2'b00;
ShiftAmountSrc=0;
ShiftOp=2'b00;
IF_ID_RtRead=0;
ExtendI=2'b00;
end
endcase
end
endmodule
/*
module Extend(
input [15:0] Imm16,
input [1:0] ExtendI,
output reg [31:0] Imm32
);
always @(*)
begin
case(ExtendI)
2'b00:Imm32={16'h0000,Imm16};
2'b01:Imm32 = {{16{Imm16[15]}}, Imm16};
2'b10:Imm32 = {Imm16, 16'h0000};
2'b11:Imm32 ={{{16{Imm16[15]}}, Imm16}[29:0],2'b00};
default:Imm32 = 32'b0;
end
endmodule*/

module Extend(
input [15:0] Imm16,
input [1:0] ExtendI,
output reg [31:0] Imm32
);
always @(*)begin
case(ExtendI)
2'b00:Imm32={16'h0000,Imm16};
2'b01:Imm32 = {{16{Imm16[15]}}, Imm16};
2'b10:Imm32 = {Imm16, 16'h0000};
2'b11:Imm32 = {{16{Imm16[15]}}, Imm16} << 2;//bgezal
endcase
end
endmodule

module register(
input [4:0] rs_addr,
input [4:0] rt_addr,
input [4:0] rd_addr,
input [3:0] rd_byte_w_en,
input [31:0] rd_in,
input clk,
output reg [31:0] rs_out,
output reg [31:0] rt_out 
);

integer i;
reg [31:0] registers[31:0]; //寄存器0~32
initial
begin
for(i=0;i<=31;i=i+1) registers[i]=32'h8;
/*registers[1]=32'h0abcde23;
registers[2]=32'h86782030;
registers[3]=32'h85232321;
registers[4]=32'h05bb7766;
registers[5]=32'h70bb7766;
registers[6]=32'habababab;
registers[7]=32'hcdcdcdcd;
registers[8]=32'h0f0f0f0f;
registers[9]=32'heeeeeeee;
registers[10]=32'hbbbbbbb0;
registers[16]=32'h23333333;
registers[24]=32'h99999966;
registers[30]=32'h00000080;
registers[31]=32'h69696969;
*/
		registers[0] = 32'h00000000; registers[1] = 32'h19946224;
		registers[2] = 32'h20140603; registers[4] = 32'h20120901;
		registers[5] = 32'hfedcba98; registers[7] = 32'h7baba789;
		registers[8] = 32'h80acd568; registers[9] = 32'hea578709;
		registers[10] = 32'h8ffafe72; registers[11] = 32'h8ff75616;
		registers[12] = 32'h52027749;registers[16]=32'h23333333;
		
		registers[23] = 32'h00000100;//256
		registers[24] = 32'h99999966;
		registers[25] = 32'h867a69eb;
		registers[29] = 32'h76543291;
		registers[30] = 32'h00000080;
		registers[31] = 32'h69696969;
end


always @(negedge clk)     //写寄存器
begin
  registers[0]<=32'h00000000; //0号寄存器为32位0
  if(rd_addr!=00000)   //0号寄存器不能被改写
    begin
      if(rd_byte_w_en[3])
        registers[rd_addr][31:24]<=rd_in[31:24];
      if(rd_byte_w_en[2])
        registers[rd_addr][23:16]<=rd_in[23:16];
      if(rd_byte_w_en[1])
        registers[rd_addr][15:8]<=rd_in[15:8];
      if(rd_byte_w_en[0])
        registers[rd_addr][7:0]<=rd_in[7:0];
    end 	
end
always @(posedge clk) 
 begin                //读寄存器rs rt
     rs_out<=registers[rs_addr];
     rt_out<=registers[rt_addr];
 end
endmodule

