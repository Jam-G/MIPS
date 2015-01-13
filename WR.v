module WR(
input [3:0]Rd_write_byte_en,
input RegWrite,
input [31:0] MemData_Wr,
input [31:0] WBData_Wr,
input MemRead,
output reg [31:0] Data,
output reg [3:0] Rd_write_byte_en_new
);
always @(*)
begin
case(MemRead)
1'b0:Data=WBData_Wr;
1'b1:Data=MemData_Wr;
endcase
if(RegWrite==0)
Rd_write_byte_en_new=4'b0000;
else
Rd_write_byte_en_new=Rd_write_byte_en;
end
endmodule
