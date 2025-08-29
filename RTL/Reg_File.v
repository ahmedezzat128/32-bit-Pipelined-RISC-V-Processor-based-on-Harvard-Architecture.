module Reg_File(
input      wire                 CLK,
input      wire                 RST,
input      wire      [4:0]      A1,
input      wire      [4:0]      A2,
input      wire      [4:0]      A3,
input      wire      [31:0]     WD3,
input      wire      		    WE3,
output     wire      [31:0]     RD1,
output     wire      [31:0]     RD2
);

//internal variable
integer i;

// Internal Memory
reg  [31:0] memory [31:0];


always@(negedge CLK or negedge RST)
	begin
		if(!RST)
			begin
				for(i = 0;i < 32;i = i + 1)
					begin
						memory[i] <= 32'd0;
					end
			end
		else if(WE3) 
			begin
				memory [A3] <= WD3;
			end
	end


assign RD1 = memory[A1];
assign RD2 = memory[A2];

endmodule