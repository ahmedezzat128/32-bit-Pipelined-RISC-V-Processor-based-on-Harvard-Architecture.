module MUX_3x1(
input   wire    [31:0]      A,
input   wire    [31:0]      B,
input   wire    [31:0]      D,
input   wire    [1:0]       sel,
output  reg     [31:0]      C
);


always@(*)
	begin
		case(sel)
			2'b00: begin
				C = A ;
			end
			
			2'b01: begin
				C = B ;
			end
			
			2'b10: begin
				C = D ;
			end
			
			default:begin
				C = 32'd0 ;
			end
		endcase
	end
endmodule