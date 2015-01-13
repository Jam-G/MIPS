module IF_ID(
input clk,
input stall,
input flush,
input [31:0]PC_4_IF,
input [5:0]op_IF,
input [4:0]Rs_IF,
input [4:0]Rt_IF,
input [4:0]Rd_IF,
input [4:0]Shamt_IF,
input [5:0]Func_IF,
output reg[31:0]PC_4_ID,
output reg[5:0]op_ID,
output reg[4:0]Rs_ID,
output reg[4:0]Rt_ID,
output reg[4:0]Rd_ID,
output reg[4:0]Shamt_ID,
output reg[5:0]Func_ID
);
initial
begin
PC_4_ID=32'b0;
op_ID=6'b0;
Rs_ID=5'b0;
Rt_ID=5'b0;
Rd_ID=5'b0;
Shamt_ID=5'b0;
Func_ID=6'b0;
end

always @(negedge clk)begin
	if(flush)begin//冲刷，防止出错
		PC_4_ID <= 32'h00000000;
		{op_ID, Rs_ID, Rt_ID, Rd_ID, Shamt_ID, Func_ID} <= 32'h00000000;
	end
	else if(!stall)begin//如果不是保持就继续向下传递流水
		PC_4_ID <= PC_4_IF;
		{op_ID, Rs_ID, Rt_ID, Rd_ID, Shamt_ID, Func_ID} <= {op_IF, Rs_IF, Rt_IF, Rd_IF, Shamt_IF, Func_IF};
	end
	// 否则就是保持，也即什么赋值也不需要做继续保持
end
endmodule
