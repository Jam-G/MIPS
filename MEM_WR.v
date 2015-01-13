module MEM_WR(
input clk,
input stall,
input flush,
input [31:0] MemData_Mem,
input [3:0] Rd_write_byte_en_Mem,
input [31:0] WBData_Mem,
input MemRead_Mem,
input RegWrite_Mem,
input [4:0] Rd_Mem,
output reg [31:0] MemData_Wr,
output reg [3:0] Rd_write_byte_en_Wr,
output reg [31:0] WBData_Wr,
output reg MemRead_Wr,
output reg RegWrite_Wr,
output reg [4:0] Rd_Wr
);
initial
begin
MemData_Wr=32'b0;
Rd_write_byte_en_Wr=4'b0;
WBData_Wr=32'b0;
MemRead_Wr=0;
RegWrite_Wr=0;
Rd_Wr=5'b0;
end
always@(negedge clk)begin
	if(flush)begin//冲刷，防止出错
		MemData_Wr<= 32'h00000000;
		Rd_write_byte_en_Wr<= 4'b0000;
		WBData_Wr<= 32'b0;
		MemRead_Wr<= 0;
		RegWrite_Wr<= 0;
		Rd_Wr<= 4'b0000;
		//其他信号没有关系，不关心
	end
	else if(!stall)begin//如果不是保持就继续向下传递流水
		MemData_Wr<=MemData_Mem;
		Rd_write_byte_en_Wr<=Rd_write_byte_en_Mem;
		WBData_Wr<=WBData_Mem;
		MemRead_Wr<=MemRead_Mem;
		RegWrite_Wr<=RegWrite_Mem;
		Rd_Wr<= Rd_Mem;
	end
end
/*always @(negedge clk)begin
	
	
	// 否则就是保持，也即什么赋值也不需要做继续保持
end*/
endmodule
