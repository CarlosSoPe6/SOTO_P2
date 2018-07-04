module IFBlackBox
#(
	parameter NBits=32,
	parameter MEMORY_DEPTH=512
)
(
input clk,
input reset,
input [NBits-1:0] PCOrReg_New_Value_wire,


output [NBits-1:0] Instruction_wire,
output [NBits-1:0] PC_4_wire
);

wire [NBits-1:0] Real_PC_Wire;
wire [NBits-1:0] PC_wire;

ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(Real_PC_Wire),
	.Instruction(Instruction_wire)
);


PC_Register
ProgramCounter(
	.clk(clk),
	.reset(reset),
	.NewPC(PCOrReg_New_Value_wire),
	.PCValue(PC_wire)
);


Adder32bits
PC_Minus_h40k
(
	.Data0(PC_wire),
	.Data1(32'hFFC0_0000),
	.Result(Real_PC_Wire)
);


Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),
	.Result(PC_4_wire)
);


endmodule