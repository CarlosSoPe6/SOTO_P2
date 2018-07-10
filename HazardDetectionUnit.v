module HazardDetectionUnit(
	input clk,
	input reset,
	input ID_EX_MemRead,
	input ID_EX_RegisterRt,
	input IF_ID_RegisterRs,
	input IF_ID_RegisterRt,
	input in_BranchControl,

	output reg Stall,
	output reg Flush
);

	always @(*) 
	begin
		if 
		(
			ID_EX_MemRead &&
			((ID_EX_RegisterRt == IF_ID_RegisterRs) || (ID_EX_RegisterRt == IF_ID_RegisterRt))
		) 
		begin
			Stall = 1;
		end
		else
		begin
			Stall = 0;
		end

		// Branch not taken
		// If the branch had to be taken flush the pipeline
		if(in_BranchControl)
		begin
		  assign Flush = 1;
		end
		else
		begin
		  assign Flush = 0;
		end
	end

endmodule // HazardDetectionUnit