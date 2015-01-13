module EX(
input [31:0] PC_ID_EX_out,
input [31:0] PC_IF_ID,
input [1:0] ExResultSrc,
input ALUSrcA,
input ALUSrcB,
input [3:0] ALUOp,
input [1:0] RegDst,
input ShiftAmountSrc,
input [1:0] ShiftOp,
input [31:0] A_in,
input [31:0] B_in,
input [4:0] Rs,Rt,Rd,
input [31:0] Imm32,
input [4:0] Shamt,
input [7:0]  A_in_sel,
input [7:0]  B_in_sel,
input [31:0] WBData_Mem,
input [31:0] Data,
output reg [31:0] Branch_Addr,
output [31:0] WBData_EX,
output [31:0] MemData,
output [31:0] A,
output Less,Zero,Overflow,
output [4:0] Rd_Dst,
output [31:0] ALU_A, ALU_B
//output [31:0]Rs_out_EX, Rt_out_EX
);
//wire [31:0] ALU_A,ALU_B;
wire [4:0] ShiftAmount;
wire [31:0] ALU_out;
wire [31:0] Shift_out;
//转发选择单元
always@(PC_ID_EX_out or Imm32)begin
	Branch_Addr[31:2] <= PC_ID_EX_out[31:2] + Imm32[31:2];
	Branch_Addr[1:0] <= 2'b00;
end
select3_8 s41(A_in[31:24],WBData_Mem[31:24],Data[31:24],A_in_sel[7:6],A[31:24]);
select3_8 s42(A_in[23:16],WBData_Mem[31:24],Data[23:16],A_in_sel[5:4],A[23:16]);
select3_8 s43(A_in[15:8],WBData_Mem[31:24],Data[15:8],A_in_sel[3:2],A[15:8]);
select3_8 s44(A_in[7:0],WBData_Mem[31:24],Data[7:0],A_in_sel[1:0],A[7:0]);
select3_8 s45(B_in[31:24],WBData_Mem[31:24],Data[31:24],B_in_sel[7:6],MemData[31:24]);
select3_8 s46(B_in[23:16],WBData_Mem[31:24],Data[23:16],B_in_sel[5:4],MemData[23:16]);
select3_8 s47(B_in[15:8],WBData_Mem[31:24],Data[15:8],B_in_sel[3:2],MemData[15:8]);
select3_8 s48(B_in[7:0],WBData_Mem[31:24],Data[7:0],B_in_sel[1:0],MemData[7:0]);

//A操作数选择
select2_32 s2(A,32'b0,ALUSrcA,ALU_A);
//B操作数选择
select2_32 s3(MemData,Imm32,ALUSrcB,ALU_B);
//ALU
ALU ALU(ALU_A,ALU_B,ALUOp,ALU_out,Less,Zero,Overflow);
//Rd写入地址xuanze
select3_5 s4(Rd,Rt,5'b11111,RegDst,Rd_Dst);
//移位位数选择
select3_32 s5(Shamt,A[4:0],ShiftAmountSrc,ShiftAmount);
//桶形移位器
Shifter Shifter(ShiftAmount,MemData,ShiftOp,Shift_out);
//EX段结果选择
select3_32 s6(PC_IF_ID,ALU_out,Shift_out,ExResultSrc,WBData_EX);

endmodule



//ALU 
module ALU(
input [31:0] a,
input [31:0] b,
input [3:0] ALU_op,
output reg [31:0] ALU_out,
output reg less,
output reg zero,
output reg overflow
);

reg [2:0] ALU_ctr;
reg [31:0] result [7:0];
reg carry;
reg OF;
reg negative;
reg [31:0] temp;
reg [31:0] b_not;
reg flag;
integer i;

always@(*)
begin
case(ALU_op)  //由ALU_op产生对应ALU_ctr控制信号
4'b0000:ALU_ctr=3'b111;
4'b0001:ALU_ctr=3'b111;
4'b0010:ALU_ctr=3'b000;
4'b0011:ALU_ctr=3'b000;
4'b0100:ALU_ctr=3'b100;
4'b0101:ALU_ctr=3'b101;
4'b0110:ALU_ctr=3'b010;
4'b0111:ALU_ctr=3'b101;
4'b1000:ALU_ctr=3'b011;
4'b1001:ALU_ctr=3'b001;
4'b1010:ALU_ctr=3'b110;
4'b1011:ALU_ctr=3'b110;
4'b1110:ALU_ctr=3'b111;
4'b1111:ALU_ctr=3'b111;
default:ALU_ctr=3'b000;
endcase
if(ALU_op[0]==0)  //由ALU_op[0]控制加减法
b_not=b^32'h00000000;
else
b_not=b^32'hffffffff;

{carry,result[7]}=b_not+a+ALU_op[0];//计算a+b+ALU_op[0]
OF=((~a[31])&(~b_not[31])&result[7][31])|(a[31]&(b_not[31])&(~result[7][31]));//ALU运算产生的Overflow
negative=result[7][31];
if(result[7]==32'b0)
zero=1;
else
zero=0;


overflow=OF&ALU_op[1]&&ALU_op[2]&&ALU_op[3];//最终Overflow


if(ALU_op[0]&&ALU_op[1]&&ALU_op[2]&&(!ALU_op[3]))
less=!carry;
else
less=OF^negative;

if(ALU_op[0]==1) //seb/seh
begin
if(b[15]==0)
result[6]={16'h0000,b[15:0]};
else
result[6]={16'hffff,b[15:0]};
end
else
begin
if(b[7]==0)
result[6]={24'h000000,b[7:0]};
else
result[6]={24'hffffff,b[7:0]};
end

if(less==0) //slt/slti/sltu/sltiu 

result[5]=32'h00000000;
else
result[5]=32'hffffffff;

result[4]=a&b;//与

result[3]=~(a|b);//或非

result[2]=(a|b);//或

result[1]=a^b;//异或

if(ALU_op[0]==0) //计算前导0前导1
temp=a^32'h00000000;
else
temp=a^32'hffffffff;

result[0]=32'h00000000;
flag=0;
for(i=31;i>=0;i=i-1)
begin
if(flag==0&&temp[i]==0)
result[0]=result[0]+32'h00000001;
if(temp[i]==1)
flag=1;
end

ALU_out=result[ALU_ctr];
end
endmodule

module Shifter(
input [4:0] shift_amount,
input [31:0] shift_in,
input [1:0] shift_op,
output reg [31:0] shift_out
);
integer i;  //循环计数
always@(shift_in or shift_op or shift_amount)
begin
shift_out={shift_in[31:0]};    
for(i=0;i<shift_amount;i=i+1)  //由移位位数控制循环次数
case(shift_op)
2'b00:
shift_out={shift_out[30:0],1'b0}; //逻辑左移一位
2'b01:
shift_out={1'b0,shift_out[31:1]};//逻辑右移一位
2'b10:
begin
if(shift_out[31]==0)  //算数右移一位
shift_out={1'b0,shift_out[31:1]};
else
shift_out={1'b1,shift_out[31:1]};
end
2'b11:
shift_out={shift_out[0],shift_out[31:1]}; //循环右移一位
endcase
end
endmodule

