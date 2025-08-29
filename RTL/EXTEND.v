module EXTEND(
input         wire      [24:0]    INSTR,
input         wire      [1:0]     IMMSRC,
output        reg       [31:0]    IMMEXT
);



always@(*)
	begin
		case(IMMSRC)
		
		2'b00 : begin
			IMMEXT = {{20{INSTR[24]}},INSTR[24:13]};                                          // I_Type  12-bit signed immediate
		end
		
		2'b01 : begin
			IMMEXT = {{20{INSTR[24]}},INSTR[24:18],INSTR[4:0]};                              // S_Type   12-bit signed immediate
		end 
		
		2'b10 : begin
			IMMEXT = {{20{INSTR[24]}},INSTR[0],INSTR[23:18],INSTR[4:1],1'b0};               // B_Type   13-bit signed immediate
		end
		
		2'b11 : begin
			IMMEXT = {{12{INSTR[24]}},INSTR[12:5],INSTR[13],INSTR[23:14],1'b0};           // J_Type       21-bit signed immediate
		end
		endcase
	end
	
endmodule