module ALU_DECODER(
input    wire      [1:0]        ALUOP,
input    wire      [2:0]        funct3,
input    wire                   op5,
input    wire                   funct75,
output   reg      [2:0]         ALU_CONTROL
);


always@(*)
	begin
		casex({ALUOP,funct3,op5,funct75})
			7'b00xxxxx : begin
					ALU_CONTROL = 3'b000;                           // add for lw,sw
				end
			
			7'b01xxxxx : begin
					ALU_CONTROL = 3'b001;                           // sub for beq
				end
			
			7'b1000000 : begin
					ALU_CONTROL = 3'b000;                           // add 
				end	
			7'b1000001 : begin
					ALU_CONTROL = 3'b000;                           // add
				end
			7'b1000010 : begin
					ALU_CONTROL = 3'b000; 	                        // add				
				end
			
			7'b1000011 : begin
					ALU_CONTROL = 3'b001; 	                        // sub				
				end
			
			7'b10010xx : begin
					ALU_CONTROL = 3'b101; 	                        // stl				
				end
			
			7'b10110xx : begin
					ALU_CONTROL = 3'b011; 	                        // or				
				end
		
			7'b10111xx : begin
					ALU_CONTROL = 3'b010; 	                        // and				
				end
			default:begin
				    ALU_CONTROL = 3'b000;                         
			end
		
		
		
		endcase
	end
endmodule