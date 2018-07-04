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
// Stage 1

wire [31:0] Instruction_wire;
wire [31:0] PC_wire;
wire [31:0] Real_PC_Wire;
wire [31:0] IF_PC_4_wire;
wire [31:0] ID_PC_4_wire;
wire [31:0] EX_PC_4_wire;
wire [31:0] MEM_PC_4_wire;
wire [31:0] PCOrReg_New_Value_wire;
wire [31:0] PC_New_Value_wire; 

/*
//Pipeline Resgiter 1
wire [31:0] Instruction_P1;
wire [31:0] PC_4_P1;

IF_ID_PipelineRegister
if_id_pipelineRegister(
   .clk(clk),
	.reset(reset),
	.IP_0(Instruction_wire),
	.IP_1(PC_4_wire),
	.OP_0(Instruction_P1),
	.OP_1(PC_4_P1)
);
*/

//******************************************************************/
//******************************************************************/
// Stage 2
//******************************************************************/
//******************************************************************/

// Control Unit wires
wire ID_BranchNE_wire;
wire EX_BranchNE_wire;
wire MEM_BranchNE_wire;

wire ID_BranchEQ_wire;
wire EX_BranchEQ_wire;
wire MEM_BranchEQ_wire;

wire RegDst_wire;

wire ID_ALUSrc_wire;
wire EX_ALUSrc_wire;

wire ID_RegWrite_wire;
wire EX_RegWrite_wire;
wire MEM_RegWrite_wire;
wire WB_RegWrite_wire;

wire ID_MemWrite_wire;
wire EX_MemWrite_wire;
wire MEM_MemWrite_wire;

wire ID_MemRead_wire;
wire EX_MemRead_wire;
wire MEM_MemRead_wire;

wire ID_MemtoReg_wire;
wire EX_MemtoReg_wire;
wire MEM_MemtoReg_wire;
wire WB_MemtoReg_wire;

wire ID_ShamtSelector_wire;
wire EX_ShamtSelector_wire;

wire RegisterOrPC_wire;

wire ALUMemOrPC_wire;

wire ID_JumpControl_wire;
wire EX_JumpControl_wire;
wire MEM_JumpControl_wire;

wire [2:0] ALUOp_wire;


wire [31:0] ReadData1_wire;
wire [31:0] ID_ReadData2_wire;
wire [31:0] EX_ReadData2_wire;
wire [31:0] MEM_ReadData2_wire;
wire [4:0] New_WriteRegister_wire;
wire [4:0] WriteRegister_wire;
wire [31:0] InmmediateExtend_wire;
wire [31:0] ShamtExtend_wire;

//Pipeline Resgiter 2
wire [31:0] Instruction_P2;
wire [31:0] PC_4_P2;

//******************************************************************/
//******************************************************************/
// Stage 3

wire [31:0] RegisterOrShamt_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [3:0] ALUOperation_wire;

wire EX_Zero_wire;
wire MEM_Zero_wire;

wire [31:0] EX_ALUResult_wire;
wire [31:0] MEM_ALUResult_wire;

wire [31:0] EX_JumpAddress_wire;
wire [31:0] MEM_JumpAddress_wire;

wire [31:0] EX_BranchAddress_wire;
wire [31:0] MEM_BranchAddress_wire;

//Pipeline Resgiter 3
wire [31:0] PC_4_P3;
wire [31:0] ALUResultOut_P3;

//******************************************************************/
//******************************************************************/
// Stage 4

wire [31:0] MEM_MemoryData_wire;
wire [31:0] WB_MemoryData_wire;

wire [31:0] MEM_PCOrBranch_wire;
wire [31:0] WB_PCOrBranch_wire;

//******************************************************************/
//******************************************************************/
// Stage 5

wire [31:0] MemoryDataOrALU_wire;
wire [31:0] New_ALUMemOrPC_wire;


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

EXBlackBox
#(
	.NBits(32)
)
exStage
(
	.clk(clk),
	.reset(reset),

	.ShamtSelector(EX_ShamtSelector_wire),
	.ReadData1(EX_ReadData1_wire),
	.ShamtExtend(EX_ShamtExtend_wire),
	.ALUSrc(EX_ALUSrc_wire),
	.ReadData2(EX_ReadData2_wire),
	.InmmediateExtend(EX_InmmediateExtend_wire),
	.ALUOp(EX_ALUOp_wire),
	.ALUFunction(EX_Instruction_wire[5:0]),
	.JumpNoShifted(EX_Instruction_wire[25:0]),
	.PC_4(EX_PC_4_wire),

	.BranchAddress(EX_BranchAddress_wire),
	.JumpAddress(EX_JumpAddress_wire),
	.ALUResult(EX_ALUResult_wire),
	.Zero(EX_Zero_wire)
);

EX_MEM_PipelineRegister
ex_mem_pipelineRegister
(
	// General signals
	.clk(clk),
	.reset(reset),

	// Input signals
	.in_Zero(MEM_Zero_wire),
    .in_ALUResult(EX_ALUResult_wire),
    .in_ReadData2(EX_ReadData2_wire),
	.in_JumpAddress(EX_JumpAddress_wire),
	.in_BranchAddress(EX_BranchAddress_wire),
    .in_PC_4(EX_PC_4_wire),
	.in_CtrlJump(EX_JumpControl_wire),
    .in_CtrlMemRead(EX_MemRead_wire),
    .in_CtrlMemWrite(EX_MemWrite_wire),
    .in_CtrlALUOrMem(EX_MemtoReg_wire),
	.in_CtrlBranchEquals(EX_BranchEQ_wire),
	.in_CtrlBranchNotEquals(EX_BranchNE_wire),

	// Output signals
    .out_Zero(MEM_Zero_wire),
    .out_ALUResult(MEM_ALUResult_wire),
    .out_ReadData2(MEM_ReadData2_wire),
    .out_JumpAddress(MEM_JumpAddress_wire),
	.out_BranchAddress(MEM_BranchAddress_wire),
	.out_PC_4(MEM_PC_4_wire),
	.out_CtrlJump(MEM_JumpControl_wire),
    .out_CtrlMemRead(MEM_MemRead_wire),
    .out_CtrlMemWrite(MEM_MemWrite_wire),
    .out_CtrlALUOrMem(MEM_MemtoReg_wire),
	.out_CtrlBranchEquals(MEM_BranchEQ_wire),
	.out_CtrlBranchNotEquals(MEM_BranchNE_wire)
);

//******************************************************************/
//******************************************************************/
//*****************************STAGE 4******************************/
//******************************************************************/
//******************************************************************/

MEMBlackBox
#(
	.NBits(32)
)
memStage
(
	.clk(clk),
	.reset(reset),
	.MemWrite(MEM_MemWrite_wire),
	.MemRead(MEM_MemRead_wire),
	.Zero(MEM_Zero_wire),
	.BranchEquals(MEM_BranchEQ_wire),
    .BranchNotEquals(MEM_BranchNE_wire),
	.ALUResult(MEM_ALUResult_wire),
	.ReadData2(MEM_ReadData2_wire),
	.PC_4(MEM_PC_4_wire),
	.BranchAddress(MEM_BranchAddress_wire),

	.MemoryData(MEM_MemoryData_wire),
	.PCOrBranch(MEM_PCOrBranch_wire)
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

