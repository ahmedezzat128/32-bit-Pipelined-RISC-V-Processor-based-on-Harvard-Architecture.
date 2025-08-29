module ALU(
input       wire       [31:0]     A,
input       wire       [31:0]     B,
input       wire       [2:0]      ALU_CONTROL,
output      reg        [31:0]     ALU_RESULT,
output      reg                   Zero
);


always @(*)
	begin
		case(ALU_CONTROL)
		
		3'b000 : begin
			ALU_RESULT = A + B ;                           // add
		end
		
		3'b001 : begin
			ALU_RESULT = A - B ;                          // sub
		end
		
		3'b010 : begin
			ALU_RESULT = A & B ;                         // and
		end
		
		3'b011 : begin
			ALU_RESULT = A | B ;                        // or
		end
		
		3'b101 : begin                              
			if (A < B)                                // set less than
				begin
					ALU_RESULT = 32'd1 ;
				end
			else
				begin
					ALU_RESULT = 32'd0 ;
				end
		end
		
		default:begin
			ALU_RESULT = 32'd13 ;
		end
		
		endcase
	end

// check if result equal to zero
always@(*)
begin
  if (ALU_RESULT == 32'd0)
    begin
      Zero =  1'b1;
    end
else
  begin
    Zero = 1'b0; 
  end
end


endmodule