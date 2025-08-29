module D_REG (
input       wire                   CLK,
input       wire                   RST,
input       wire                   CLR,
input       wire                   EN,
input       wire       [31:0]      INSTR_F,
input       wire       [31:0]      PC_F,
input       wire       [31:0]      PCPLUS4_F,
output      reg        [31:0]      INSTR_D,
output      reg        [31:0]      PC_D,
output      reg        [31:0]      PCPLUS4_D
);



always@(posedge CLK or negedge RST)
begin
	if(!RST)
		begin
			INSTR_D <= 32'd0;
			PC_D <= 32'd0;
			PCPLUS4_D <= 32'd0;
		end
	else if (CLR)
		begin
			INSTR_D <= 32'd0;
			PC_D <= 32'd0;
			PCPLUS4_D <= 32'd0;
		end
	else if(!EN)
		begin
			INSTR_D <= INSTR_F ;
			PC_D <= PC_F ;
			PCPLUS4_D <= PCPLUS4_F;
		end
end



endmodule