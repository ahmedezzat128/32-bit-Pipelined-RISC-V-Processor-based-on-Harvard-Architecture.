module DATA_MEM(
input    wire                   CLK,
input    wire                   RST,
input    wire      [4:0]        A,
input    wire                   WE,
input    wire      [31:0]       WD,
output   wire      [31:0]       RD,
output   wire      [31:0]       OUT
 );
 
 // Internal Memory
 reg   [31:0]  internal_memory  [31:0];
 integer i ;
 
always@(posedge CLK or negedge RST)
	begin
		if(!RST)
			begin
				for(i = 0;i < 32;i = i + 1)
					begin
						internal_memory[i] <= 32'd0;
					end
			end
		else if(WE) 
			begin
				internal_memory [A] <= WD;
			end
	end


assign RD = internal_memory [A];

assign OUT = internal_memory[31];                  // for test purpose 




 endmodule
