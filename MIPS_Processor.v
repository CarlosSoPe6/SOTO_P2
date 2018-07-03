/******************************************************************
* Description
*	This is the top-level of a MIPS processor that can execute the next set of instructions:
*		add
*		addi
*		sub
*		ori
*		or
*		bne
*		beq
*		and
*		nor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	12/06/2016
******************************************************************/


module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 512
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);

//******************************************************************/
//******************************************************************/
assign  PortOut = 0;

//******************************************************************/
//******************************************************************/
// Data types to connect modules
wire BranchNE_wire;
wire BranchEQ_wire;
wire RegDst_wire;
wire BranchControl_wire;

// Control Unit wires
wire ALUSrc_wire;
wire RegWrite_wire;
wire MemWrite_wire;
wire MemRead_wire;
wire MemtoReg_wire;
wire ShamtSelector_wire;
wire RegisterOrPC_wire;
wire ALUMemOrPC_wire;
wire JumpControl_wire;

wire Zero_wire;
wire [2:0] ALUOp_wire;
wire [3:0] ALUOperation_wire;
wire [4:0] WriteRegister_wire;
wire [4:0] New_WriteRegister_wire;
wire [31:0] PC_wire;
wire [31:0] Real_PC_Wire;
wire [31:0] Instruction_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;
wire [31:0] InmmediateExtend_wire;
wire [31:0] ShamtExtend_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] RegisterOrShamt_wire;
wire [31:0] ALUResult_wire;
wire [31:0] JumpAddress_wire;
wire [31:0] PC_New_Value_wire;
wire [31:0] PCOrReg_New_Value_wire; 
wire [31:0] PC_4_wire;
wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] PCOrBranch_wire;
wire [31:0] MemoryData_wire;
wire [31:0] MemoryDataOrALU_wire;
wire [31:0] Real_Data_Address_wire;
wire [31:0] New_ALUMemOrPC_wire;
wire [31:0] Branch_Shifter_wire;
wire [31:0] Branch_Address_wire;
integer ALUStatus;


//******************************************************************/
//******************************************************************/
//*****************************STAGE 1******************************/
//******************************************************************/
//******************************************************************/

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


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForRegisterOrPC
(
	.Selector(RegisterOrPC_wire),
	.MUX_Data0(PC_New_Value_wire),
	.MUX_Data1(RegisterOrShamt_wire),
	
	.MUX_Output(PCOrReg_New_Value_wire)

);

Multiplexer2to1
#(
	.NBits(32)
)
MuxForNextPcOrJump
(
	.Selector(JumpControl_wire),
	.MUX_Output(PC_New_Value_wire),
	.MUX_Data0(PCOrBranch_wire),
	.MUX_Data1({PC_4_wire[31:28], JumpAddress_wire[27:0]})
);

//******************************************************************/
//******************************************************************/
//*****************************STAGE 2******************************/
//******************************************************************/
//******************************************************************/

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


//******************************************************************/
//******************************************************************/
//*****************************STAGE 3******************************/
//******************************************************************/
//******************************************************************/

Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForRegOrShamt
(
	.Selector(ShamtSelector_wire),
	.MUX_Data0(ReadData1_wire),
	.MUX_Data1(ShamtExtend_wire),
	.MUX_Output(RegisterOrShamt_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_wire),
	.MUX_Data0(ReadData2_wire),
	.MUX_Data1(InmmediateExtend_wire),
	
	.MUX_Output(ReadData2OrInmmediate_wire)

);

ALUControl
ArithmeticLogicUnitControl
(
  .ALUOp(ALUOp_wire),
  .ALUFunction(Instruction_wire[5:0]),
  .ALUOperation(ALUOperation_wire)
 
);

ALU
ArithmeticLogicUnit 
(
	.ALUOperation(ALUOperation_wire),
	.A(RegisterOrShamt_wire),
	.B(ReadData2OrInmmediate_wire),
	.Zero(Zero_wire),
	.ALUResult(ALUResult_wire)
);

ShiftLeft2
JumpShifter
(
	.DataInput(Instruction_wire[25:0]),
	.DataOutput(JumpAddress_wire)
);

ShiftLeft2
BranchShifter
(
	.DataInput(InmmediateExtend_wire),
	.DataOutput(Branch_Shifter_wire)
);

Adder32bits
Branch_Address_Calculator
(
	.Data0(Branch_Shifter_wire),
	.Data1(PC_4_wire),
	.Result(Branch_Address_wire)
);

//******************************************************************/
//******************************************************************/
//*****************************STAGE 4******************************/
//******************************************************************/
//******************************************************************/

Adder32bits
Data_Memory_Calculator
(
	.Data0(ALUResultOut),
	.Data1(32'hFBFF_C000),
	.Result(Real_Data_Address_wire)
);

DataMemory
#(
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
RAM_Memory
(
	.WriteData(ReadData2_wire),
	.Address(Real_Data_Address_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.ReadData(MemoryData_wire),
	.clk(clk)
);

BranchModule
BranchController
(
	.Zero(Zero_wire),
	.BNEControl(BranchNE_wire),
	.BEQControl(BranchEQ_wire),
	.BranchControlSignal(BranchControl_wire)
);

Multiplexer2to1
#(
	.NBits(32)
)
MuxForNextPcOrBranch
(
	.Selector(BranchControl_wire),
	.MUX_Output(PCOrBranch_wire),
	.MUX_Data0(PC_4_wire),
	.MUX_Data1(Branch_Address_wire)
);

//******************************************************************/
//******************************************************************/
//*****************************STAGE 5******************************/
//******************************************************************/
//******************************************************************/

Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForALUMemOrPC
(
	.Selector(ALUMemOrPC_wire),
	.MUX_Data0(MemoryDataOrALU_wire),
	.MUX_Data1(PCOrBranch_wire),
	
	.MUX_Output(New_ALUMemOrPC_wire)

);

Multiplexer2to1
#(
	.NBits(32)
)
MuxForReadMemoryOrALU
(
	.Selector(MemtoReg_wire),
	.MUX_Data0(ALUResultOut),
	.MUX_Data1(MemoryData_wire),
	.MUX_Output(MemoryDataOrALU_wire)
);

assign ALUResultOut = ALUResult_wire;


endmodule

