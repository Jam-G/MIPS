module MEM(
	input clk,
	input [5:0] Op,
	input [2:0] Condition,
	input Branch,
	input MemWrite,
	input RegWrite,
	input [31:0] MemData,
	input Less,Zero,Overflow,
	input [31:0] WBData,
	output [31:0] MemData_Mem,
	output [3:0] Rd_write_byte_en,
	output RegWriteValid,
	output BranchValid,
	output [3:0]Mem_write_byte_en
);
wire [31:0] Mem_data_in;
wire [31:0] Mem_data_out;
//wire [3:0] Mem_write_byte_en;
ConditionCheck ConditionCheck(Condition,Branch,RegWrite,Less,Zero,Overflow,BranchValid,RegWriteValid);
reg_shifter reg_shifter(MemData,WBData[1:0],MemWrite,Op,Mem_data_in,Mem_write_byte_en);
Mem Mem(Mem_write_byte_en,clk,Mem_data_in,WBData,Mem_data_out);
mem_shifter mem_shifter(Mem_data_out,WBData[1:0],Op,MemData_Mem,Rd_write_byte_en);
endmodule

//Conditiion检测模块
module ConditionCheck(
	input [2:0] Condition,
	input Branch,
	input RegWrite,
	input Less,Zero,Overflow,
	output reg BranchValid,RegWriteValid
);

always @(*)
begin
if(Branch==0)
BranchValid=0;
else
begin
case(Condition)
3'b000:
BranchValid=0;
3'b001:
BranchValid=Zero;
3'b010:
BranchValid=~Zero;
3'b011:
BranchValid=Less|Zero;//>=0
3'b100:
BranchValid=Less;//>0
3'b101:
BranchValid=~Less;//<=0
3'b110:
BranchValid=~(Less|Zero);//<0
3'b111:
BranchValid=0;
endcase
end

if(RegWrite==0)
RegWriteValid=0;
else if(Overflow==1)
RegWriteValid=0;
else
RegWriteValid=1;
end
//
endmodule
//寄存器移位器
module reg_shifter(
	//	 [31:0] Rt_out,
	//	 [31:0] IR,
	//	 [1:0] Mem_addr_in,
	//output reg [31:0] Rt_out_shift
	input [31:0] rt_out,
	input	[1:0] mem_addr_in,
	input	MemWrite,
	input [5:0] IR_out,
	output reg [31:0] rt_out_shift,
	output reg [3:0] mem_byte_write_out
);
reg [3:0]mem_byte_write;
always @ (*)
begin
	if (IR_out == 6'b101011) begin rt_out_shift = rt_out;mem_byte_write=4'b1111;end
	else begin
		case (mem_addr_in)
			2'b00: begin rt_out_shift = {rt_out[7:0],  24'b0};mem_byte_write=4'b1000;end
			2'b01: begin rt_out_shift = {rt_out[15:0], 16'b0};mem_byte_write=4'b1100;end
			2'b10: begin rt_out_shift = {rt_out[23:0], 8'b0};mem_byte_write=4'b1110;end
			2'b11: begin rt_out_shift = rt_out;mem_byte_write=4'b1111;end
		endcase
	end
	mem_byte_write_out = mem_byte_write & {4{MemWrite}};
end

endmodule


/*
module reg_shifter(
input [31:0] rt_out,
input [1:0] mem_addr_in,
input MemWrite,
input [5:0] IR_out,
output [31:0] rt_out_shift,
output reg [3:0] mem_byte_write
);

wire [2:0] rt_out_shift_ctr;
wire [31:0] rt_out_r,rt_out_l;
always @(MemWrite or mem_addr_in or IR_out)
begin
if(MemWrite==0)
mem_byte_write=4'b0000;
else 
begin
if(IR_out==6'b101110)
				begin
					case(mem_addr_in)
					2'b00:mem_byte_write=4'b1000;
					2'b01:mem_byte_write=4'b1100;
					2'b10:mem_byte_write=4'b1110;
					2'b11:mem_byte_write=4'b1111;
					default:mem_byte_write=4'b0000;
					endcase
				end
				else if(IR_out==6'b101011)
						mem_byte_write=4'b1111;
				else mem_byte_write=4'b1111;
end		
end							
assign rt_out_shift_ctr[2]=IR_out[5]&&(!IR_out[4])&&IR_out[3]&&(((!IR_out[2])&&IR_out[1])||(IR_out[1]&&(!IR_out[0])));
assign rt_out_shift_ctr[1]=IR_out[5]&&(!IR_out[4])&&IR_out[3]&&(((!IR_out[2])&&(!IR_out[1])&&IR_out[0])||(IR_out[2]&&IR_out[1]&&(!IR_out[0])));
assign rt_out_shift_ctr[0]=IR_out[5]&&(!IR_out[4])&&IR_out[3]&&((!IR_out[2])&&IR_out[1]&&(!IR_out[0]));

select4_8 s31(rt_out[31:24],8'b0,8'b0,8'b0,mem_addr_in,rt_out_l[31:24]);
select4_8 s32(rt_out[7:0],rt_out[15:8],rt_out[23:16],rt_out[31:24],mem_addr_in,rt_out_r[31:24]);
select4_8 s33(rt_out[23:16],rt_out[31:24],8'b0,8'b0,mem_addr_in,rt_out_l[23:16]);
select4_8 s34(8'b0,rt_out[7:0],rt_out[15:8],rt_out[23:16],mem_addr_in,rt_out_r[23:16]);
select4_8 s35(rt_out[15:8],rt_out[23:16],rt_out[31:24],8'b0,mem_addr_in,rt_out_l[15:8]);
select4_8 s36(8'b0,8'b0,rt_out[7:0],rt_out[15:8],mem_addr_in,rt_out_r[15:8]);
select4_8 s37(rt_out[7:0],rt_out[15:8],rt_out[23:16],rt_out[31:24],mem_addr_in,rt_out_l[7:0]);
select4_8 s38(8'b0,8'b0,8'b0,rt_out[7:0],mem_addr_in,rt_out_r[7:0]);

select8_8 s39(rt_out[7:0],8'b0,rt_out[15:8],8'b0,rt_out_l[31:24],rt_out_l[31:24],rt_out_r[31:24],8'b0,rt_out_shift_ctr,rt_out_shift[31:24]);
select8_8 s310(rt_out[7:0],8'b0,rt_out[7:0],8'b0,rt_out_l[23:16],rt_out_l[23:16],rt_out_r[23:16],8'b0,rt_out_shift_ctr,rt_out_shift[23:16]);
select8_8 s311(rt_out[7:0],8'b0,rt_out[15:8],8'b0,rt_out_l[15:8],rt_out_l[15:8],rt_out_r[15:8],8'b0,rt_out_shift_ctr,rt_out_shift[15:8]);
select8_8 s312(rt_out[7:0],8'b0,rt_out[7:0],8'b0,rt_out_l[7:0],rt_out_l[7:0],rt_out_r[7:0],8'b0,rt_out_shift_ctr,rt_out_shift[7:0]);
endmodule
*/
//存储器移位器
/*
module mem_shifter(
input [31:0] mem_data_out,
input [1:0] mem_addr_in,
input [5:0] IR_out,
output [31:0] mem_data_shift,
output reg [3:0] Rd_write_byte_en
);
wire [2:0] mem_data_shift_ctr;
wire [31:0] mem_d_l,mem_d_r;
always@(IR_out or mem_addr_in)
begin
if(IR_out==6'b100010)
				begin
					case(mem_addr_in)
					2'b00:Rd_write_byte_en=4'b0000;
					2'b01:Rd_write_byte_en=4'b0001;
					2'b10:Rd_write_byte_en=4'b0011;
					2'b11:Rd_write_byte_en=4'b0111;
					default:Rd_write_byte_en=4'b0000;
					endcase
				end
else if(IR_out==6'b100011)
				Rd_write_byte_en=4'b1111;
else Rd_write_byte_en=4'b1111;
end						
assign mem_data_shift_ctr[2]=IR_out[5]&&(!IR_out[4])&&(!IR_out[3])&&(((!IR_out[2])&&IR_out[1])||(IR_out[1]&&(!IR_out[0])));
assign mem_data_shift_ctr[1]=IR_out[5]&&(!IR_out[4])&&(!IR_out[3])&&(((!IR_out[1])&&IR_out[0])||(IR_out[2]&&IR_out[1]&&(!IR_out[0])));
assign mem_data_shift_ctr[0]=IR_out[5]&&(!IR_out[4])&&(!IR_out[3])&&(((!IR_out[1])&&IR_out[2])||((!IR_out[2])&&IR_out[1]&&(!IR_out[0])));
select4_8 s21(mem_data_out[31:24],mem_data_out[23:16],mem_data_out[15:8],mem_data_out[7:0],mem_addr_in,mem_d_l[31:24]);
select4_8 s22(8'b0,8'b0,8'b0,mem_data_out[31:24],mem_addr_in,mem_d_r[31:24]);
select4_8 s23(mem_data_out[23:16],mem_data_out[15:8],mem_data_out[7:0],8'b0,mem_addr_in,mem_d_l[23:16]);
select4_8 s24(8'b0,8'b0,mem_data_out[31:24],mem_data_out[23:16],mem_addr_in,mem_d_r[23:16]);
select4_8 s25(mem_data_out[15:8],mem_data_out[7:0],8'b0,8'b0,mem_addr_in,mem_d_l[15:8]);
select4_8 s26(8'b0,mem_data_out[31:24],mem_data_out[23:16],mem_data_out[15:8],mem_addr_in,mem_d_r[15:8]);
select4_8 s27(mem_data_out[7:0],8'b0,8'b0,8'b0,mem_addr_in,mem_d_l[7:0]);
select4_8 s28(mem_data_out[31:24],mem_data_out[23:16],mem_data_out[15:8],mem_data_out[7:0],mem_addr_in,mem_d_r[7:0]);
select8_8 s29({8{mem_d_l[31]}},8'b0,{8{mem_d_l[31]}},8'b0,mem_d_l[31:24],mem_d_l[31:24],mem_d_r[31:24],8'b0,mem_data_shift_ctr,mem_data_shift[31:24]);
select8_8 s210({8{mem_d_l[31]}},8'b0,{8{mem_d_l[31]}},8'b0,mem_d_l[23:16],mem_d_l[23:16],mem_d_r[23:16],8'b0,mem_data_shift_ctr,mem_data_shift[23:16]);
select8_8 s211({8{mem_d_l[31]}},8'b0,mem_d_l[31:24],mem_d_l[31:24],mem_d_l[15:8],mem_d_l[15:8],mem_d_r[15:8],8'b0,mem_data_shift_ctr,mem_data_shift[15:8]);
select8_8 s212(mem_d_l[31:24],mem_d_l[31:24],mem_d_l[23:16],mem_d_l[23:16],mem_d_l[7:0],mem_d_l[7:0],mem_d_r[7:0],8'b0,mem_data_shift_ctr,mem_data_shift[7:0]);
endmodule

*/
module mem_shifter(
	//input [1:0] Mem_addr_in,
	//	 [31:0] Mem_data_out,
	//	 [31:0] IR,
	//output reg [31:0] Mem_data_shift
	input [31:0] mem_data_out,
	input	[1:0] mem_addr_in,
	input [5:0] IR_out,
	output reg [31:0] mem_data_shift,
	output reg [3:0] Rd_write_byte_en
);

always @ (*)
begin
	if (IR_out == 6'b100011)begin
		mem_data_shift = mem_data_out;
		Rd_write_byte_en=4'b1111;
	end
	else begin
		case (mem_addr_in)
			2'b00: begin mem_data_shift = mem_data_out; Rd_write_byte_en=4'b1111;end
			2'b01: begin mem_data_shift = {mem_data_out[23:0], 8'b0};Rd_write_byte_en=4'b1110; end
			2'b10: begin mem_data_shift = {mem_data_out[15:0], 16'b0};Rd_write_byte_en=4'b1100; end
			2'b11: begin mem_data_shift = {mem_data_out[7:0],  24'b0};Rd_write_byte_en=4'b1000; end
		endcase
	end
end

endmodule

//!!!!!需要解决存储器写使能问题!
module Mem(
	input [3:0]Mem_byte_wr_in,
	input clk,
	input [31:0]Mem_data,
	input [31:0]Mem_addr_in,
	output reg [31:0]Mem_data_out
);
reg [31:0]addr;
integer i;
reg [7:0] IR_reg [500:0];
initial
begin
for(i=0;i<=500;i=i+1) IR_reg[i]=8'b0;
IR_reg[256] = 8'b10011000;
IR_reg[257] = 8'b10010110;
IR_reg[258] = 8'b10011100;
IR_reg[259] = 8'b11001110;
end
always@(posedge clk)
begin
addr = {Mem_addr_in[31:2],2'b00};
if(Mem_byte_wr_in[3])
	IR_reg[addr+3]<=Mem_data[31:24];
if(Mem_byte_wr_in[2])
	IR_reg[addr+2]<=Mem_data[23:16];
if(Mem_byte_wr_in[1])
	IR_reg[addr+1]<=Mem_data[15:8];
if(Mem_byte_wr_in[0])
	IR_reg[addr]<=Mem_data[7:0];
if(addr >= 496)
		Mem_data_out <= 32'h00000000;
else begin
	Mem_data_out[31:24]<=IR_reg[addr + 3];
	Mem_data_out[23:16]<=IR_reg[addr+2];
	Mem_data_out[15:8]<=IR_reg[addr+1];
	Mem_data_out[7:0]<=IR_reg[addr];
end
end
endmodule


