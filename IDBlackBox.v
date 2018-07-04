
module IDBlackBox
#(
	parameter NBits=32
	parameter MEMORY_DEPTH=512
)
(
	input clk,
	input reset,
	input [NBits-1:0] Instruction_wire,
	input [NBits-1:0] New_WriteRegister_wire,
	
	//Control Signals
	output RegDst_wire,
	output BranchNE_wire,
	output BranchEQ_wire,
	output [2:0] ALUOp_wire,
	output ALUSrc_wire,
	output RegWrite_wire,
	output MemWrite_wire,
	output MemRead_wire,
	output MemtoReg_wire,
	output ShamtSelector_wire,
	output RegisterOrPC_wire,
	output ALUMemOrPC_wire,
	output JumpControl_wire,
);

wire [NBits-1:0] New_ALUMemOrPC_wire;
 

Control
ControlUnit
(
	.OP(Instruction_wire[31:26]),
	.Function(Instruction_wire[5:0]),
	.RegDst(RegDst_wire),
	.BranchNE(BranchNE_wire),
	.BranchEQ(BranchEQ_wire),
	.ALUOp(ALUOp_wire),
	.ALUSrc(ALUSrc_wire),
	.RegWrite(RegWrite_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.MemtoReg(MemtoReg_wire),
	.ShamtSelector(ShamtSelector_wire),
	.RegisterOrPC(RegisterOrPC_wire),
	.ALUMemOrPC(ALUMemOrPC_wire),
	.JumpControl(JumpControl_wire)
);

RegisterFile
Register_File
(
  .clk(clk),
  .reset(reset),
  .RegWrite(RegWrite_wire),
  .WriteRegister(New_WriteRegister_wire),
  .ReadRegister1(Instruction_wire[25:21]),
  .ReadRegister2(Instruction_wire[20:16]),
  .WriteData(New_ALUMemOrPC_wire),
  .ReadData1(ReadData1_wire),
  .ReadData2(ReadData2_wire)
);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_NewWriteRegister
(
	.Selector(ALUMemOrPC_wire),
	.MUX_Data0(WriteRegister_wire),
	.MUX_Data1(31),
	
	.MUX_Output(New_WriteRegister_wire)

);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_wire),
	.MUX_Data0(Instruction_wire[20:16]),
	.MUX_Data1(Instruction_wire[15:11]),
	
	.MUX_Output(WriteRegister_wire)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_wire[15:0]),
   .SignExtendOutput(InmmediateExtend_wire)
);


UnsignedExtend
UnsignedExtendForShamt
(
	.DataInput(Instruction_wire[10:6]),
	.UnsignedExtendOutput(ShamtExtend_wire)
);

endmodule