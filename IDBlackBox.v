
module IDBlackBox
#(
	parameter NBits=32,
	parameter MEMORY_DEPTH=512
)
(
	input clk,
	input reset,
	input in_RegWrite,
	input [NBits-1:0] Instruction,
	input [4:0] in_WriteRegister,
	input [NBits-1:0] WriteData,
	input in_ALUMemOrPC,
	input Stall,

	output BranchNE,
	output BranchEQ,
	output [2:0] ALUOp,
	output out_RegWrite,
	output MemWrite,
	output MemRead,
	output MemtoReg,
	output RegisterOrPC,
	output out_ALUMemOrPC,
	output JumpControl,
	output ShamtSelector,
	output ALUSrc,

	output [4:0] out_WriteRegister,
	output [NBits-1:0] ReadData1,
	output [NBits-1:0] ReadData2,
	output [NBits-1:0] InmmediateExtend,
	output [NBits-1:0] ShamtExtend
);

wire [4:0] WriteRegister_wire;
wire RegDst_wire;

wire [4:0] out_WriteRegister_wire;
wire BranchNE_wire;
wire BranchEQ_wire;
wire out_RegWrite_wire;
wire MemWrite_wire;
wire MemRead_wire;
wire RegisterOrPC_wire;
wire JumpControl_wire;

assign BranchNE = BranchNE_wire & ~Stall ;
assign BranchEQ = BranchEQ_wire & ~Stall ;
assign out_RegWrite =  out_RegWrite_wire & ~Stall ;
assign MemWrite =  MemWrite_wire & ~Stall ;
assign MemRead = MemRead_wire & ~Stall ;
assign JumpControl = JumpControl_wire & ~Stall;
assign RegisterOrPC = RegisterOrPC_wire & ~Stall;

Control
ControlUnit
(
	.OP(Instruction[31:26]),
	.Function(Instruction[5:0]),
	.RegDst(RegDst_wire),
	.BranchNE(BranchNE_wire),
	.BranchEQ(BranchEQ_wire),
	.ALUOp(ALUOp),
	.ALUSrc(ALUSrc),
	.RegWrite(out_RegWrite_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.MemtoReg(MemtoReg),
	.ShamtSelector(ShamtSelector),
	.RegisterOrPC(RegisterOrPC_wire),
	.ALUMemOrPC(out_ALUMemOrPC),
	.JumpControl(JumpControl_wire)
);

RegisterFile
Register_File
(
  .clk(clk),
  .reset(reset),
  .RegWrite(in_RegWrite),
  .WriteRegister(WriteRegister_wire),
  .ReadRegister1(Instruction[25:21]),
  .ReadRegister2(Instruction[20:16]),
  .WriteData(WriteData),
  .ReadData1(ReadData1),
  .ReadData2(ReadData2)
);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_NewWriteRegister
(
	.Selector(in_ALUMemOrPC),
	.MUX_Data0(in_WriteRegister),
	.MUX_Data1(31),
	
	.MUX_Output(WriteRegister_wire)

);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_wire),
	.MUX_Data0(Instruction[20:16]),
	.MUX_Data1(Instruction[15:11]),
	
	.MUX_Output(out_WriteRegister_wire)

);

Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRegisterWriteStall
(
	.Selector(Stall),
	.MUX_Data0(out_WriteRegister_wire),
	.MUX_Data1(0),
	
	.MUX_Output(out_WriteRegister)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction[15:0]),
   .SignExtendOutput(InmmediateExtend)
);

UnsignedExtend
UnsignedExtendForShamt
(
	.DataInput(Instruction[10:6]),
	.UnsignedExtendOutput(ShamtExtend)
);

endmodule