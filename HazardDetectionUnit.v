module HazardDetectionUnit(
	input clk,
	input reset,
	input ID_EX_MemRead,
	input ID_EX_RegisterRt,
	input IF_ID_RegisterRs,
	input ID_EX_RegisterRt,
	input IF_ID_RegisterRt,
	input in_BranchControl,

	output Stall
);

	always @(*) 
	begin
		if 
		(
			ID_EX_MemRead &&
			((ID_EX_RegisterRt == IF_ID_RegisterRs) || (ID_EX_RegisterRt == IF_ID_RegisterRt))
		) 
		begin
		  assign Stall = 1;
		end
		else
		begin
			assign Stall = 0;
		end
	end

endmodule // HazardDetectionUnit