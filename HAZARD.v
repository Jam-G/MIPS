module HAZARD(
input [4:0] Rt_IF_ID,Rs_IF_ID,Rt_ID_EX,
input RtRead_IF_ID,
input Jump,
input MemRead_ID_EX,
input Branch,
output reg[1:0] PCSrc,
output reg IF_ID_Stall,IF_ID_Flush, 
output reg ID_EX_Stall,ID_EX_Flush, 
output reg EX_MEM_Stall,EX_MEM_Flush,
output reg MEM_REG_Stall,MEM_REG_Flush,
output reg loaduse
);

always @(*)
begin
//控制冒险，jump和branch
//数据冒险 load-use冒险
//我们只要处理这三种情况下的冒险就够了
	if(Jump == 1)begin
		PCSrc = 2'b01;//跳转指令
		ID_EX_Flush = 1;//
		ID_EX_Stall = 0;//
		IF_ID_Flush = 0;
		IF_ID_Stall = 0;
		MEM_REG_Stall = 0;
		MEM_REG_Flush = 0;
		EX_MEM_Stall = 0;
		EX_MEM_Flush = 0;
		loaduse = 0;
	end
	else if(Branch == 1)begin//分支指令
		PCSrc = 2'b10;
		ID_EX_Flush = 1;//
		EX_MEM_Flush = 0;
		ID_EX_Stall = 0;//
		IF_ID_Flush = 0;
		IF_ID_Stall = 0;
		MEM_REG_Stall = 0;
		MEM_REG_Flush = 0;
		EX_MEM_Stall = 0;
		loaduse = 0;
	end
	else if(MemRead_ID_EX == 1 && RtRead_IF_ID == 1 && (Rt_ID_EX == Rt_IF_ID || Rt_ID_EX == Rs_IF_ID))begin//load-use冒险
		PCSrc = 2'b00;
		IF_ID_Stall = 1;
		ID_EX_Flush = 1;//
		EX_MEM_Flush = 0;
		ID_EX_Stall = 0;//
		IF_ID_Flush = 0;
		MEM_REG_Stall = 0;
		MEM_REG_Flush = 0;
		EX_MEM_Stall = 0;
		loaduse = 1;
		end
	else begin//正常流水
		PCSrc = 2'b00;
		IF_ID_Stall = 0;
		ID_EX_Flush = 0;//
		EX_MEM_Flush = 0;
		ID_EX_Stall = 0;//
		IF_ID_Flush = 0;
		MEM_REG_Stall = 0;
		MEM_REG_Flush = 0;
		EX_MEM_Stall = 0;
		loaduse = 0;
	end

end
endmodule
