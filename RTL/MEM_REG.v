module MEM_REG (
input        wire                     CLK,
input        wire                     RST,
input        wire                     RegWriteE,
input        wire         [1:0]       ResultSrcE,
input        wire                     MemWriteE,
input        wire         [31:0]      ALUResultE,
input        wire         [31:0]      WriteDateE,
input        wire         [4:0]       Rd_E,
input        wire         [31:0]      PCPLUS4_E,
output       reg                      RegWriteM,
output       reg         [1:0]        ResultSrcM,
output       reg                      MemWriteM,
output       reg         [31:0]       ALUResultM,
output       reg         [31:0]       WriteDateM,
output       reg        [4:0]        Rd_M,
output       reg        [31:0]       PCPLUS4_M
);




always@(posedge CLK or negedge RST)
begin
	if(!RST)
		begin
			RegWriteM <= 1'd0;
			ResultSrcM <= 2'd0;
			MemWriteM <= 1'd0;
			ALUResultM <= 32'd0 ;
			WriteDateM <= 32'd0;
			Rd_M <= 5'd0 ;
			PCPLUS4_M <= 32'd0;
		end
	else 
		begin
			
			RegWriteM <=  RegWriteE;
			ResultSrcM <= ResultSrcE;
			MemWriteM <=  MemWriteE ;
			ALUResultM <= ALUResultE;
			WriteDateM <= WriteDateE;
			Rd_M <= Rd_E;
			PCPLUS4_M <= PCPLUS4_E;
			
			
		end
end



endmodule

