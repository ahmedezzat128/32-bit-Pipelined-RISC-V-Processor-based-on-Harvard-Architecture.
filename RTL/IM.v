module IM(
input    wire     [31:0]   A1,
output   wire     [31:0]   RD   
);

// Internal Memory
reg  [31:0]   memory_ins  [31:0] ;



initial
	begin
		$readmemh("INS.txt",memory_ins);
	end


assign RD = memory_ins[A1 >> 2];



endmodule