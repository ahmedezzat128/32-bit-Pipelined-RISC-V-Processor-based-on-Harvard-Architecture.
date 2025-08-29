module Control_Unit (
input       wire        [6:0]        OP,
input       wire        [2:0]        funct3,
input       wire        			 funct75,
output      wire                     PCsrc,
output      wire      [1:0]          IMMSRC,
output      wire      [1:0]          ResultSrc,
output      wire                     MemWrite,
output      wire                     ALUSRC,
output      wire                     REGWRITE,
output      wire      [2:0]          ALU_CONTROL,
output      wire                     Jump,
output      wire                     Branch  
);

//internal wires
 wire      [1:0]          ALU_OP;




MAIN_DECODER MAIN_DECODER(
.OP(OP),
.IMMSRC(IMMSRC),
.ALU_OP(ALU_OP),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUSRC(ALUSRC),
.REGWRITE(REGWRITE),
.Branch(Branch),
.Jump(Jump)        
);



ALU_DECODER ALU_DECODER(
.ALUOP(ALU_OP),
.funct3(funct3),
.op5(OP[5]),
.funct75(funct75),
.ALU_CONTROL(ALU_CONTROL)
);

endmodule