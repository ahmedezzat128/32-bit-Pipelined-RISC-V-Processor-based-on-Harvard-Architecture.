module RISCV32I_tb();


reg                           CLK_tb;
reg                           RST_tb;
wire               [31:0]     OUT_tb;






initial
	begin
		CLK_tb = 1'b0;
		RST_tb = 1'b0;
		#3
		RST_tb = 1'b1;
		#100
		$stop;
	
	
	
	
	
	end



///////////////////////////// Clock Generator /////////////////////////
always #5 CLK_tb = ~ CLK_tb ;
///////////////////////////////////////////////////////////////////////


RISCV32I DUT(
.CLK(CLK_tb),
.RST(RST_tb),
.OUT(OUT_tb)
);
endmodule