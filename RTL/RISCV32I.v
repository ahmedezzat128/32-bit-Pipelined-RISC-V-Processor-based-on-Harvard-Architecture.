module RISCV32I(
input       wire              CLK,
input       wire              RST,
output      wire   [31:0]     OUT
);






////////////////////////////////////////////// internal wires ////////////////////////////////////////
wire         		     ZeroE;
wire        [6:0]        OP;
wire        [2:0]        funct3;
wire        			 funct75;
wire                     PCsrcE;
wire        [1:0]        IMMSRC;
wire        [1:0]        ResultSrcD;
wire                     MemWriteD;
wire                     ALUSRCD;
wire                     REGWRITED;
wire      [2:0]          ALU_CONTROLD;
wire      [31:0]         ALU_RESULT_E;
wire      [31:0]         PCF;
wire      [31:0]         INSTRF;
wire      [31:0]         PCNEXT;
wire      [31:0]         RESULT;
wire      [31:0]         SRCA_D;
wire      [31:0]         SRCB_BM_D;
wire      [31:0]         SRCBE;
wire      [31:0]         IMMEXTD;
wire      [31:0]         ReadDataM;
wire      [31:0]         PC_PLUS4F;
wire      [31:0]         PC_Target;

wire                     JumpD;
wire                     BranchD;


//outputs from fetch stage
wire        [31:0]          INSTR_D;
wire        [31:0]          PC_D;
wire        [31:0]          PCPLUS4_D;


//outputs from decode stage
wire                    RegWriteE;
wire        [1:0]       ResultSrcE;
wire                    MemWriteE;
wire                    JumpE;
wire                    BranchE;
wire         [2:0]      ALUControlE;
wire                    ALUSrcE;
wire         [31:0]     RD1_E;
wire         [31:0]     RD2_E;
wire         [31:0]     PC_E;
wire         [4:0]      Rs1_E;
wire         [4:0]      Rs2_E;
wire         [4:0]      Rd_E;
wire         [31:0]     ImmExtE;
wire         [31:0]     PCPLUS4_E;

//outputs from muxes of Excute stage
wire         [31:0]         OUT_MUX_E1;
wire         [31:0]         OUT_MUX_E2;



//outputs from Memory stage 
wire                                  RegWriteM;
wire                     [1:0]        ResultSrcM;
wire                                  MemWriteM;
wire                     [31:0]       ALUResultM;
wire                     [31:0]       WriteDateM;
wire                     [4:0]        Rd_M;
wire                     [31:0]       PCPLUS4_M;


//outputs from Write Back Stage 
wire                         RegWriteW;
wire          [1:0]          ResultSrcW;
wire          [31:0]         RD_DATMEMO_W;
wire          [4:0]          Rd_W;
wire          [31:0]         PCPlus4W;
wire          [31:0]         ALUResultW;

//outputs form Hazard_Unit
wire                                         STALLF;
wire                                         STALLD;
wire                                         FLUSHD;
wire                                         FLUSHE;
wire                          [1:0]          ForwardAE;      
wire                          [1:0]          ForwardBE;   
////////////////////////////////////////////////////////////////////////////////////////////////////






IM IM(
.A1(PCF),
.RD(INSTRF)   
);



D_REG D_REG(
.CLK(CLK),
.RST(RST),
.CLR(FLUSHD),
.EN(STALLD),
.INSTR_F(INSTRF),
.PC_F(PCF),
.PCPLUS4_F(PC_PLUS4F),
.INSTR_D(INSTR_D),
.PC_D(PC_D),
.PCPLUS4_D(PCPLUS4_D)
);



Reg_File Reg_File(
.CLK(CLK),
.RST(RST),
.A1(INSTR_D[19:15]),
.A2(INSTR_D[24:20]),
.A3(Rd_W),
.WD3(RESULT),
.WE3(RegWriteW),
.RD1(SRCA_D),
.RD2(SRCB_BM_D)
);



EX_REG EX_REG(
.CLK(CLK),
.RST(RST),
.CLR(FLUSHE),
.RegWriteD(REGWRITED),
.ResultSrcD(ResultSrcD),
.MemWriteD(MemWriteD),
.JumpD(JumpD),
.BranchD(BranchD),
.ALUControlD(ALU_CONTROLD),
.ALUSrcD(ALUSRCD),
.RD1_D(SRCA_D),
.RD2_D(SRCB_BM_D),
.PC_D(PC_D),
.Rs1_D(INSTR_D[19:15]),
.Rs2_D(INSTR_D[24:20]),
.Rd_D(INSTR_D[11:7]),
.ImmExtD(IMMEXTD),
.PCPLUS4_D(PCPLUS4_D),
.RegWriteE(RegWriteE),
.ResultSrcE(ResultSrcE),
.MemWriteE(MemWriteE),
.JumpE(JumpE),
.BranchE(BranchE),
.ALUControlE(ALUControlE),
.ALUSrcE(ALUSrcE),
.RD1_E(RD1_E),
.RD2_E(RD2_E),
.PC_E(PC_E),
.Rs1_E(Rs1_E),
.Rs2_E(Rs2_E),
.Rd_E(Rd_E),
.ImmExtE(ImmExtE),
.PCPLUS4_E(PCPLUS4_E)
);



MUX_3x1 MUX_3x1_E1(
.A(RD1_E),
.B(RESULT),
.D(ALUResultM),
.sel(ForwardAE),
.C(OUT_MUX_E1)
);


MUX_3x1 MUX_3x1_E2(
.A(RD2_E),
.B(RESULT),
.D(ALUResultM),
.sel(ForwardBE),
.C(OUT_MUX_E2)
);





MUX_2x1 MUX_2x1_ua(
.A(OUT_MUX_E2),
.B(ImmExtE),
.sel(ALUSrcE),
.C(SRCBE)
);



ALU ALU(
.A(OUT_MUX_E1),
.B(SRCBE),
.ALU_CONTROL(ALUControlE),
.ALU_RESULT(ALU_RESULT_E),
.Zero(ZeroE)
);


MEM_REG MEM_REG(
.CLK(CLK),
.RST(RST),
.RegWriteE(RegWriteE),
.ResultSrcE(ResultSrcE),
.MemWriteE(MemWriteE),
.ALUResultE(ALU_RESULT_E),
.WriteDateE(OUT_MUX_E2),
.Rd_E(Rd_E),
.PCPLUS4_E(PCPLUS4_E),
.RegWriteM(RegWriteM),
.ResultSrcM(ResultSrcM),
.MemWriteM(MemWriteM),
.ALUResultM(ALUResultM),
.WriteDateM(WriteDateM),
.Rd_M(Rd_M),
.PCPLUS4_M(PCPLUS4_M)
);



DATA_MEM DATA_MEM(
.CLK(CLK),
.RST(RST),
.A(ALUResultM[4:0]),
.WE(MemWriteM),
.WD(WriteDateM),
.RD(ReadDataM),
.OUT(OUT)
 );
 
 
 
WB_REG WB_REG(
.CLK(CLK),
.RST(RST),
.ALU_RESULTM(ALUResultM),
.RegWriteM(RegWriteM),
.ResultSrcM(ResultSrcM),
.RD_DATMEMO(ReadDataM),
.Rd_M(Rd_M),
.PCPlus4M(PCPLUS4_M),
.RegWriteW(RegWriteW),
.ResultSrcW(ResultSrcW),
.RD_DATMEMO_W(RD_DATMEMO_W),
.Rd_W(Rd_W),
.ALUResultW(ALUResultW),
.PCPlus4W(PCPlus4W)          
);

 
 
 MUX_3x1 MUX_3x1(
.A(ALUResultW),
.B(RD_DATMEMO_W),
.D(PCPlus4W),
.sel(ResultSrcW),
.C(RESULT)
);



BJ_logic BJ_logic (
.ZeroE(ZeroE),
.BranchE(BranchE),
.JumpE(JumpE),
.PCsrcE(PCsrcE)
);




Hazard_Unit  Hazard_Unit(
.RegWriteW(RegWriteW),
.RDW(Rd_W),
.RegWriteM(RegWriteM),
.RDM(Rd_M),
.ResultSRCE(ResultSrcE[0]),
.PCSRCE(PCsrcE),
.RS1E(Rs1_E), 
.RS2E(Rs2_E), 
.RDE(Rd_E),
.RS1D(INSTR_D[19:15]), 
.RS2D(INSTR_D[24:20]),
.STALLF(STALLF),
.STALLD(STALLD),
.FLUSHD(FLUSHD),
.FLUSHE(FLUSHE),
.ForwardAE(ForwardAE),      
.ForwardBE(ForwardBE)      
);





Control_Unit Control_Unit(
.OP(INSTR_D[6:0]),
.funct3(INSTR_D[14:12]),
.funct75(INSTR_D[30]),
.PCsrc(PCsrc),
.IMMSRC(IMMSRC),
.ResultSrc(ResultSrcD),
.MemWrite(MemWriteD),
.ALUSRC(ALUSRCD),
.REGWRITE(REGWRITED),
.ALU_CONTROL(ALU_CONTROLD),
.Jump(JumpD),
.Branch(BranchD)
);



PC PC_U(
.CLK(CLK),
.RST(RST),
.STALLF(STALLF),
.PCNEXT(PCNEXT),
.PC(PCF)
);

///////////////////////////////////// MUX Before Pc ///////////////////////////////////
MUX_2x1 MUX_2x1(
.A(PC_PLUS4F),
.B(PC_Target),
.sel(PCsrcE),
.C(PCNEXT)
);
///////////////////////////////////////////////////////////////////////////////////////



  
 EXTEND EXTEND(
.INSTR(INSTR_D[31:7]),
.IMMSRC(IMMSRC),
.IMMEXT(IMMEXTD)
);

ADDER_4 ADDER_4(
.A(PCF),
.B(32'd4),
.C(PC_PLUS4F)    
);



ADDER ADDER(
.A(PC_E),
.B(ImmExtE),
.C(PC_Target)    
);


endmodule