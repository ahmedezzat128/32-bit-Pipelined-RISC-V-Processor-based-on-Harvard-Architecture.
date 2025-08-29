module MUX_2x1(
input   wire    [31:0]      A,
input   wire    [31:0]      B,
input   wire               sel,
output  reg     [31:0]      C
);


always@(*)
	begin
		if (!sel)
			begin
				C = A;
			end
		else
			begin
				C = B ;
			end
	end
endmodule