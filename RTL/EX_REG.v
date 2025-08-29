module EX_REG (
input        wire                    CLK,
input        wire                    RST,
input        wire                    CLR,
input        wire                    RegWriteD,
input        wire         [1:0]      ResultSrcD,
input        wire                    MemWriteD,
input        wire                    JumpD,
input        wire                    BranchD,
input        wire         [2:0]      ALUControlD,
input        wire                    ALUSrcD,
input        wire         [31:0]     RD1_D,
input        wire         [31:0]     RD2_D,
input        wire         [31:0]     PC_D,
input        wire         [4:0]      Rs1_D,
input        wire         [4:0]      Rs2_D,
input        wire         [4:0]      Rd_D,
input        wire         [31:0]     ImmExtD,
input        wire         [31:0]     PCPLUS4_D,
output        reg                    RegWriteE,
output        reg         [1:0]      ResultSrcE,
output        reg                    MemWriteE,
output        reg                    JumpE,
output        reg                    BranchE,
output        reg         [2:0]      ALUControlE,
output        reg                    ALUSrcE,
output        reg         [31:0]     RD1_E,
output        reg         [31:0]     RD2_E,
output        reg         [31:0]     PC_E,
output        reg         [4:0]      Rs1_E,
output        reg         [4:0]      Rs2_E,
output        reg         [4:0]      Rd_E,
output        reg         [31:0]     ImmExtE,
output        reg         [31:0]     PCPLUS4_E
);




always@(posedge CLK or negedge RST)
begin
	if(!RST)
		begin
		   RegWriteE <= 1'd0;
           ResultSrcE <= 2'd0;
           MemWriteE <= 1'd0;
		   JumpE <= 1'd0;
           BranchE <= 1'd0;
           ALUControlE <= 2'd0;
           ALUSrcE <= 1'd0;
           RD1_E <= 32'd0;
           RD2_E <= 32'd0;
           PC_E <= 32'd0;
           Rs1_E <= 5'd0;
           Rs2_E <= 5'd0;
           Rd_E <= 5'd0;
           ImmExtE <= 32'd0;
           PCPLUS4_E <= 32'd0;
		end
	else if (CLR)
		begin
		   RegWriteE <= 1'd0;
           ResultSrcE <= 2'd0;
           MemWriteE <= 1'd0;
		   JumpE <= 1'd0;
           BranchE <= 1'd0;
           ALUControlE <= 2'd0;
           ALUSrcE <= 1'd0;
           RD1_E <= 32'd0;
           RD2_E <= 32'd0;
           PC_E <= 32'd0;
           Rs1_E <= 5'd0;
           Rs2_E <= 5'd0;
           Rd_E <= 5'd0;
           ImmExtE <= 32'd0;
           PCPLUS4_E <= 32'd0;
			
		end
	else 
		begin
		   RegWriteE <= RegWriteD;
           ResultSrcE <= ResultSrcD;
           MemWriteE <= MemWriteD;
		   JumpE <=  JumpD;
           BranchE <= BranchD;
           ALUControlE <= ALUControlD;
           ALUSrcE <= ALUSrcD;
           RD1_E <= RD1_D;
           RD2_E <= RD2_D;
           PC_E <= PC_D;
           Rs1_E <= Rs1_D;
           Rs2_E <= Rs2_D;
           Rd_E <= Rd_D;
           ImmExtE <= ImmExtD;
           PCPLUS4_E <= PCPLUS4_D;
		end
end



endmodule






