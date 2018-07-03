
module PipelineRegister
(
	input clk,
	input reset,
	input [31:0] Instruction,
	
	output reg [31:0] Instr
);

always@(negedge reset or posedge clk) begin
	Instr<=Instruction;
end


endmodule