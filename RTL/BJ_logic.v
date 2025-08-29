module BJ_logic (
input     wire            ZeroE,
input     wire            BranchE,
input     wire            JumpE,
output    reg             PCsrcE
);






//// or and operations for jump and branch instructions ///
always@(*)
	begin
		PCsrcE = (ZeroE & BranchE) | JumpE ;
	end




endmodule