
module PipelineRegister
(
	input clk,
	input reset,
	input [31:0] IP_0,
	input [31:0] IP_1,
	
	output reg [31:0] OP_0,
	output reg [31:0] OP_1
);

always@(negedge reset or posedge clk) begin
	OP_0<=IP_0;
	OP_1<=IP_1;
end


endmodule