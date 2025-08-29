module MAIN_DECODER(
input     wire     [6:0]     OP,
output    reg      [1:0]     IMMSRC,
output    reg      [1:0]     ALU_OP,
output    reg      [1:0]     ResultSrc,
output    reg                MemWrite,
output    reg                ALUSRC,
output    reg                REGWRITE,
output    reg                Branch,
output    reg                Jump        
);

localparam        lw = 7'b0000011,
			      sw = 7'b0100011,
			      beq = 7'b1100011,
			      r_type = 7'b0110011,
			      i_type_alu = 7'b0010011,
			      jal = 7'b1101111;
			 



always@(*)
	begin
		IMMSRC = 2'b00;
		ALU_OP = 2'b00;
		ResultSrc = 2'b00;
		MemWrite = 1'b0;
		ALUSRC = 1'b0;
		REGWRITE = 1'b0;
		Branch = 1'b0;
		Jump = 1'b0;  
		case(OP)
			lw : begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b00;
				ResultSrc = 2'b01;
				MemWrite = 1'b0;
				ALUSRC = 1'b1;
				REGWRITE = 1'b1;
				Branch = 1'b0;
				Jump = 1'b0; 
			end
			
			sw:begin
				IMMSRC = 2'b01;
				ALU_OP = 2'b00;
				MemWrite = 1'b1;
				ALUSRC = 1'b1;
				REGWRITE = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0; 
			end
			
			r_type:begin
				ALU_OP = 2'b10;
				ResultSrc = 2'b00;
				MemWrite = 1'b0;
				ALUSRC = 1'b0;
				REGWRITE = 1'b1;
				Branch = 1'b0;
				Jump = 1'b0; 
			end
			
			beq:begin
				IMMSRC = 2'b10;
				ALU_OP = 2'b01;
				MemWrite = 1'b0;
				ALUSRC = 1'b0;
				REGWRITE = 1'b0;
				Branch = 1'b1;
				Jump = 1'b0; 
			end
			
			i_type_alu:begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b10;
				ResultSrc = 2'b00;
				MemWrite = 1'b0;
				ALUSRC = 1'b1;
				REGWRITE = 1'b1;
				Branch = 1'b0;
				Jump = 1'b0; 
			end
			
			jal:begin
				IMMSRC = 2'b11;  
				ResultSrc = 2'b10;
				MemWrite = 1'b0;
				REGWRITE = 1'b1; 
				Branch = 1'b0;
				Jump = 1'b1; 
			end
			
			default:begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b00;
				ResultSrc = 2'b00;
				MemWrite = 1'b0;
				ALUSRC = 1'b0;
				REGWRITE = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0; 
			end
		endcase
	end
endmodule