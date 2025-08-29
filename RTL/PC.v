module PC(
input     wire             CLK,
input     wire             RST,
input     wire             STALLF,
input     wire   [31:0]    PCNEXT,
output    reg    [31:0]    PC
);




always@(posedge CLK or negedge RST)
	begin
		if(!RST)
			begin
				PC <= 32'd0;
			end
		else if(!STALLF)
			begin	
				PC <= PCNEXT;
			end
		else
			begin
					PC <= PC;
			end	
	end


endmodule