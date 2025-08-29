module  Hazard_Unit(
input             wire                       RegWriteW,
input             wire        [4:0]          RDW,
input             wire                       RegWriteM,
input             wire        [4:0]          RDM,
input             wire                       ResultSRCE,
input             wire                       PCSRCE,
input             wire        [4:0]          RS1E, 
input             wire        [4:0]          RS2E, 
input             wire        [4:0]          RDE,
input             wire        [4:0]          RS1D, 
input             wire        [4:0]          RS2D, 
output            reg                        STALLF,
output            reg                        STALLD,
output            reg                        FLUSHD,
output            reg                        FLUSHE,
output            reg         [1:0]          ForwardAE,      
output            reg         [1:0]          ForwardBE      
);



reg                  lwstall;



// bypass for source 1 
always@(*)
begin
	if ( ((RS1E == RDM) & RegWriteM) & (RS1E != 5'd0) )
		begin
			ForwardAE = 2'b10;
		end
			
	else if (((RS1E == RDW) & RegWriteW) & (RS1E != 5'd0) )

		begin
			ForwardAE = 2'b01;
		end
	else 
		begin
			ForwardAE = 2'b00;
		end

end


// bypass for source 2
always@(*)
begin
	if (((RS2E == RDM) & RegWriteM) & (RS2E != 5'd0) )
		begin
			ForwardBE = 2'b10;
		end
			
	else if (((RS2E == RDW) & RegWriteW) & (RS2E != 5'd0) )

		begin
			ForwardBE = 2'b01;
		end
	else 
		begin
			ForwardBE = 2'b00;
		end

end



//stall and flush logic
always@(*)
begin
	lwstall = ResultSRCE & ((RS1D == RDE) | (RS2D == RDE));
	STALLF = lwstall;
	STALLD = lwstall;
	FLUSHE = lwstall | PCSRCE ;
	FLUSHD = PCSRCE;
end










endmodule