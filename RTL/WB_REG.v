module WB_REG(
input          wire                        CLK,
input          wire                        RST,
input          wire        [31:0]          ALU_RESULTM,
input          wire                        RegWriteM,
input          wire         [1:0]          ResultSrcM,
input          wire         [31:0]         RD_DATMEMO,
input          wire     	[4:0]          Rd_M,
input          wire       	[31:0]         PCPlus4M,
output         reg                         RegWriteW,
output         reg          [1:0]          ResultSrcW,
output         reg          [31:0]         RD_DATMEMO_W,
output         reg          [4:0]          Rd_W,
output         reg          [31:0]         PCPlus4W,
output         reg          [31:0]         ALUResultW          
);




always@(posedge CLK or negedge RST)
begin
	if(!RST)
		begin
			RegWriteW <= 0;
			ResultSrcW <= 2'd0;
			RD_DATMEMO_W <= 32'd0;
			Rd_W <= 5'd0;
			PCPlus4W <= 32'd0;
			ALUResultW <= 32'd0;
		
		end
	
	else
		begin
		    RegWriteW <= RegWriteM;
			ResultSrcW <= ResultSrcM;
			RD_DATMEMO_W <= RD_DATMEMO;
			Rd_W <= Rd_M;
			PCPlus4W <= PCPlus4M;
			ALUResultW <= ALU_RESULTM;
		end


end




endmodule