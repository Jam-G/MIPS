module IF(
input clk,
input [1:0] PCSrc,
input [31:0] PC0,PC1,PC2,PC3,
output reg [31:0] PC_IF_ID_in,
output  [31:0] IR_out
);

wire [31:0] PC_in;
wire [31:0] PC_out;

select4_32 s1(PC0,PC1,PC2,PC3,PCSrc,PC_in); 
PC PC(PC_in,clk,PC_out);
IR_Mem IR_Mem(clk,PC_out,IR_out);

always @(PC_out)
PC_IF_ID_in=PC_out+32'h4;

endmodule

//IR memory
module IR_Mem(
//input [3:0]Mem_byte_wr_in,
input clk,
//input [31:0]Mem_data,
input [31:0]Mem_addr_in,
output reg [31:0]Mem_data_out
);
integer i;
reg [7:0] IR_reg [255:0];
initial
begin
for(i=0;i<=255;i=i+1) IR_reg[i]=8'b0;

   //add
  /* IR_reg[0]=8'b00000000; 
	IR_reg[1]=8'b01000011;
	IR_reg[2]=8'b01011000;
	IR_reg[3]=8'b00100000;
	//sub
	IR_reg[4]=8'b00000000;
	IR_reg[5]=8'b01000010;
	IR_reg[6]=8'b01100000;
	IR_reg[7]=8'b00100010;
	//subu
	IR_reg[8]=8'b00000000;
	IR_reg[9]=8'b01000001;
	IR_reg[10]=8'b01101000;
	IR_reg[11]=8'b00100011;
	//slt
	IR_reg[12]=8'b00000000;
	IR_reg[13]=8'b01000001;
	IR_reg[14]=8'b01110000;
	IR_reg[15]=8'b00101010;
	//sltu
	IR_reg[16]=8'b00000000;
	IR_reg[17]=8'b01000001;
	IR_reg[18]=8'b01111000;
	IR_reg[19]=8'b00101011;
	//srav
	IR_reg[20]=8'b00000010;
	IR_reg[21]=8'b00100010;
	IR_reg[22]=8'b10010000;
	IR_reg[23]=8'b00000111;
	//rotr
	IR_reg[24]=8'b00000000;
	IR_reg[25]=8'b00100001;
	IR_reg[26]=8'b10011010;
	IR_reg[27]=8'b00000010;
	//addi
	IR_reg[28]=8'b00100000;
	IR_reg[29]=8'b01010100;
	IR_reg[30]=8'b10101010;
	IR_reg[31]=8'b10101010;
	//addiu
	IR_reg[32]=8'b00100100;
	IR_reg[33]=8'b00110101;
	IR_reg[34]=8'b10101010;
	IR_reg[35]=8'b10101010;
	//seb
	IR_reg[36]=8'b00011000;
	IR_reg[37]=8'b00001001;
	IR_reg[38]=8'b10110100;
	IR_reg[39]=8'b00100000;
	//lui
	IR_reg[40]=8'b00111100;
	IR_reg[41]=8'b00010111;
	IR_reg[42]=8'b10101010;
	IR_reg[43]=8'b10101010;
	//xori
	IR_reg[44]=8'b00111000;
	IR_reg[45]=8'b01011000;
	IR_reg[46]=8'b10101010;
	IR_reg[47]=8'b10010110;
	//clz
	IR_reg[48]=8'b01110000;
	IR_reg[49]=8'b00100000;
	IR_reg[50]=8'b11001000;
	IR_reg[51]=8'b00100000;
	//clo
	IR_reg[52]=8'b01110000;
	IR_reg[53]=8'b01000000;
	IR_reg[54]=8'b11010000;
	IR_reg[55]=8'b00100001;
	//bgezal
	IR_reg[56]=8'b00000100;
	IR_reg[57]=8'b10001011;
	IR_reg[58]=8'b00000000;
	IR_reg[59]=8'b00000000;
	//sw
	IR_reg[60]=8'b10101111;
	IR_reg[61]=8'b11000001;
	IR_reg[62]=8'b00000000;
	IR_reg[63]=8'b00000000;
	//lw
	IR_reg[64]=8'b10001111;
	IR_reg[65]=8'b11011101;
	IR_reg[66]=8'b00000000;
	IR_reg[67]=8'b00000000;
	//swr
	IR_reg[68]=8'b10111011;
	IR_reg[69]=8'b11011101;
	IR_reg[70]=8'b00000000;
	IR_reg[71]=8'b00000000;
	//lwl
	IR_reg[72]=8'b10001011;
	IR_reg[73]=8'b11011100;
	IR_reg[74]=8'b00000000;
	IR_reg[75]=8'b00000001;
	//swr
	IR_reg[76]=8'b10111011;
	IR_reg[77]=8'b11011100;
	IR_reg[78]=8'b00000000;
	IR_reg[79]=8'b00000010;
	//lwl
	IR_reg[80]=8'b10001011;
	IR_reg[81]=8'b11011011;
	IR_reg[82]=8'b00000000;
	IR_reg[83]=8'b00000011;
	//nor
	IR_reg[84]=8'b00000000;
	IR_reg[85]=8'b01000011;
	IR_reg[86]=8'b11010000;
	IR_reg[87]=8'b00100111;
	//sw
	IR_reg[88]=8'b10101111;
	IR_reg[89]=8'b11011111;
	IR_reg[90]=8'b00000000;
	IR_reg[91]=8'b00000000;
	//j
	IR_reg[92]=8'b00001000;
	IR_reg[93]=8'b00000000;
	IR_reg[94]=8'b00000000;
	IR_reg[95]=8'b00000000;
	*/
	{IR_reg[0], IR_reg[1], IR_reg[2], IR_reg[3]} = 32'b00000000001001000110100000100000;     //add R13=R1+R4 不溢出
	{IR_reg[4], IR_reg[5], IR_reg[6], IR_reg[7]} = 32'b00000001010001110110100000100000;     //add R13=R7+R10 溢出
	{IR_reg[8], IR_reg[9], IR_reg[10], IR_reg[11]} = 32'b00100000010011101010101111001101;   //addi R14=R2+0xabcd 不溢出
	{IR_reg[12], IR_reg[13], IR_reg[14], IR_reg[15]} = 32'b00100001010011110111101111001101; //addi R15=R10+0x0abcd 溢出
	{IR_reg[16], IR_reg[17], IR_reg[18], IR_reg[19]} = 32'b00100101010011110111101111001101; //addiu R15=R10+0x07bcd 无视溢出，写入
	
	{IR_reg[20], IR_reg[21], IR_reg[22], IR_reg[23]} = 32'b00000001010011000110100000100010; //sub R13=R10-R12 不溢出，写入
	{IR_reg[24], IR_reg[25], IR_reg[26], IR_reg[27]} = 32'b00000001100010100110100000100010; //sub R13=R12-R10 溢出，不写入
	{IR_reg[28], IR_reg[29], IR_reg[30], IR_reg[31]} = 32'b00000001100010100110100000100011; //subu R13=R12-R0 无视溢出，写入
	
	{IR_reg[32], IR_reg[33], IR_reg[34], IR_reg[35]} = 32'b01111100000000010001010000100000; //seb R2=signex(R1)
	{IR_reg[36], IR_reg[37], IR_reg[38], IR_reg[39]} = 32'b01111100000001110110110000100000; //seb R13=signex(R7)
	{IR_reg[40], IR_reg[41], IR_reg[42], IR_reg[43]} = 32'b01110001101000001000000000100001; //clo(R13)->R16
	{IR_reg[44], IR_reg[45], IR_reg[46], IR_reg[47]} = 32'b01110001100000001000100000100000; //clz(R2) ->R17
	
	{IR_reg[48], IR_reg[49], IR_reg[50], IR_reg[51]} = 32'b00111100000100101000100110101101; //lui R18=0x89ad<<16
	{IR_reg[52], IR_reg[53], IR_reg[54], IR_reg[55]} = 32'b00111001011101001000011010100101; //xori R20=R11 xor 0x86a5 无符号扩展
	
	{IR_reg[56], IR_reg[57], IR_reg[58], IR_reg[59]} = 32'b00000010000010101001000000000111; //srav R18=R10>>R16
	{IR_reg[60], IR_reg[61], IR_reg[62], IR_reg[63]} = 32'b00000010001010111001100000000111; //srav R19=R11>>R17
	
	{IR_reg[64], IR_reg[65], IR_reg[66], IR_reg[67]} = 32'b00000000001011111010001101000010; //rotr R20=R15 >>13
	
	{IR_reg[68], IR_reg[69], IR_reg[70], IR_reg[71]} = 32'b00000010100010011010100000101011; //sltu R21=R20<R9
	
	{IR_reg[72], IR_reg[73], IR_reg[74], IR_reg[75]} = 32'b00101010101101101001010000100001; //slti R22=R21<0x9421
	
	{IR_reg[76], IR_reg[77], IR_reg[78], IR_reg[79]} = 32'b00001000000000000000000000011000; //J to PC=96
	
	
	
	{IR_reg[84], IR_reg[85], IR_reg[86], IR_reg[87]} = 32'b00000001000001101011100000100111; //R23=R8 nor R6
	{IR_reg[88], IR_reg[89], IR_reg[90], IR_reg[91]} = 32'b10101110111010000000000000000100; //sw mem[R23+0x4]=R8 
	{IR_reg[92], IR_reg[93], IR_reg[94], IR_reg[95]} = 32'b10001110111000110000000000000100; //lw R3=mem[R23+0x4]
	{IR_reg[96], IR_reg[97], IR_reg[98], IR_reg[99]} = 32'b10111010111110010000000000000010; //swr mem[R23+0x2]=R25
	{IR_reg[100], IR_reg[101], IR_reg[102], IR_reg[103]} = 32'b10001010111001000000000000000010; //lwl R4=mem[R23+0x2](130)
	{IR_reg[104], IR_reg[105], IR_reg[106], IR_reg[107]} = 32'b00000000001001000110100000100000;     //add R13=R1+R4 不溢出  load-use 冒险 R4
	{IR_reg[108], IR_reg[109], IR_reg[110], IR_reg[111]} = 32'b00000001101010010001100000100010;//sub R3 R13 R9
	{IR_reg[112], IR_reg[113], IR_reg[114], IR_reg[115]} = 32'b00000001001011010011100000100111;//nor R7 R9 R13
	{IR_reg[116], IR_reg[117], IR_reg[118], IR_reg[119]} = 32'b00000001101001100101000000100000;//add R10 R13 R6	
	{IR_reg[120], IR_reg[121], IR_reg[122], IR_reg[123]} = 32'b00000111101100011111111111110110; //bgezal R29>=0 to PC=84pc = pc -10(条指令)
	IR_reg[124] = 8'h00;
	IR_reg[125] = 8'h00;
	IR_reg[126] = 8'h00;
	IR_reg[127] = 8'h00;
	IR_reg[128] = 8'h00;
	IR_reg[129] = 8'h00;
	IR_reg[130] = 8'h00;
	IR_reg[131] = 8'h00;
	IR_reg[132] = 8'h00;
	IR_reg[133] = 8'h00;
	IR_reg[134] = 8'h00;
	IR_reg[135] = 8'h00;
	IR_reg[136] = 8'h00;
	IR_reg[137] = 8'h00;
	IR_reg[138] = 8'h00;
	IR_reg[139] = 8'h00;
	IR_reg[140] = 8'h00;
	IR_reg[141] = 8'h00;
	IR_reg[142] = 8'h00;
	IR_reg[143] = 8'h00;
	IR_reg[144] = 8'h00;
	end
always@(*)
begin
//if(Mem_byte_wr_in[3])
//IR_reg[Mem_addr_in]<=Mem_data[31:24];
//if(Mem_byte_wr_in[2])
//IR_reg[Mem_addr_in+1]<=Mem_data[23:16];
//if(Mem_byte_wr_in[1])
//IR_reg[Mem_addr_in+2]<=Mem_data[15:8];
//if(Mem_byte_wr_in[0])
//IR_reg[Mem_addr_in+3]<=Mem_data[7:0];
Mem_data_out[31:24]<=IR_reg[Mem_addr_in];
Mem_data_out[23:16]<=IR_reg[Mem_addr_in+1];
Mem_data_out[15:8]<=IR_reg[Mem_addr_in+2];
Mem_data_out[7:0]<=IR_reg[Mem_addr_in+3];
end
endmodule


//PC register
module PC(
input [31:0] PC_in,
//input PC_write_en,
input clk,
output reg [31:0]PC_out
);

reg [31:0]PC_in_r;
initial
PC_out=32'b0;
always@(posedge clk)
begin
//if(PC_write_en)
PC_out<=PC_in;
end
endmodule
