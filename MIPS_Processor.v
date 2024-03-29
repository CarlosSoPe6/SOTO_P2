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

wire [1:0] ForwardA_wire;
wire [1:0] ForwardB_wire;

//******************************************************************/
//******************************************************************/
// Stage 1

wire [31:0] IF_Instruction_wire;
wire [31:0] ID_Instruction_wire;
wire [31:0] EX_Instruction_wire;

wire [31:0] PC_wire;
wire [31:0] IF_PC_4_wire;
wire [31:0] ID_PC_4_wire;
wire [31:0] EX_PC_4_wire;
wire [31:0] MEM_PC_4_wire;
wire [31:0] WB_PC_4_wire;

wire [31:0] WB_WriteData_wire;

wire [4:0] ID_WriteRegister_wire;
wire [4:0] EX_WriteRegister_wire;
wire [4:0] MEM_WriteRegister_wire;
wire [4:0] WB_WriteRegister_wire;


//******************************************************************/
//******************************************************************/
// Stage 2
//******************************************************************/
//******************************************************************/

// Control Unit wires
wire ID_BranchNE_wire;
wire EX_BranchNE_wire;

wire ID_BranchEQ_wire;
wire EX_BranchEQ_wire;

wire ID_RegDst_wire;

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

wire ID_RegisterOrPC_wire;
wire EX_RegisterOrPC_wire;

wire ID_ALUMemOrPC_wire;
wire EX_ALUMemOrPC_wire;
wire MEM_ALUMemOrPC_wire;
wire WB_ALUMemOrPC_wire;

wire ID_JumpControl_wire;
wire EX_JumpControl_wire;
wire MEM_JumpControl_wire;
wire WB_JumpControl_wire;

wire ID_ShamtSelector;
wire EX_ShamtSelector;

wire ID_ALUSrc;
wire EX_ALUSrc;

wire [2:0] ID_ALUOp_wire;
wire [2:0] EX_ALUOp_wire;

wire [31:0] ID_InmmediateExtend;
wire [31:0] EX_InmmediateExtend;

wire [31:0] ID_ReadData1_wire;
wire [31:0] EX_ReadData1_wire;
wire [31:0] MEM_ReadData1_wire;
wire [31:0] WB_ReadData1_wire;

wire [31:0] ID_ReadData2_wire;
wire [31:0] EX_ReadData2_wire;

wire [31:0] ID_ShamtExtend_wire;
wire [31:0] EX_ShamtExtend_wire;

wire [31:0] EX_WriteData_wire;
wire [31:0] MEM_WriteData_wire;

//******************************************************************/
//******************************************************************/
// Stage 3

wire [31:0] EX_ALUResult_wire;
wire [31:0] MEM_ALUResult_wire;
wire [31:0] WB_ALUResult_wire;

wire [31:0] EX_NewPC_wire;
wire [31:0] MEM_NewPC_wire;

wire EX_JumpOrBranchControll_wire;
wire MEM_JumpOrBranchControll_wire;
//******************************************************************/
//******************************************************************/
// Stage 4

wire [31:0] MEM_MemoryData_wire;
wire [31:0] WB_MemoryData_wire;

wire [31:0] MEM_PCOrBranch_wire;
wire [31:0] WB_PCOrBranch_wire;

wire [31:0] MEM_DataAddress_wire;

//******************************************************************/
//******************************************************************/
// Stage 5

wire [31:0] WB_MemoryDataOrALU_wire;
wire [31:0] WB_ALUMemOrPCData_wire;

wire Flush_wire;
wire Stall_wire;
wire MEM_BranchControl_wire;
wire WB_BranchControl_wire;
//******************************************************************/
//******************************************************************/
//*****************************STAGE 1******************************/
//******************************************************************/
//******************************************************************/

IFBlackBox
#(
	.NBits(32),
	.MEMORY_DEPTH(512)
)
if_blackBox
(
	.clk(clk),
	.reset(reset),
	.PCSelector(MEM_JumpOrBranchControll_wire),
	.BranchOrJumpAddress(MEM_NewPC_wire),
	.PCWrite(~Stall_wire),

	.Instruction_wire(IF_Instruction_wire),
	.PC_4(IF_PC_4_wire)
);

IF_ID_PipelineRegister
#(
	.NBits(32)
)
if_id_pipelineRegister
(
    .clk(clk),
    .reset(reset ),
	.Flush(Flush_wire),
	.RegWrite(~Stall_wire),
    .in_PC_4(IF_PC_4_wire),
    .in_Instruction(IF_Instruction_wire),
    
    .out_PC_4(ID_PC_4_wire),
    .out_Instruction(ID_Instruction_wire)
);

//******************************************************************/
//******************************************************************/
//*****************************STAGE 2******************************/
//******************************************************************/
//******************************************************************/

IDBlackBox
#(
	.NBits(32),
	.MEMORY_DEPTH(512)
)
id_blackBox
(
	.clk(clk),
	.reset(reset),
	.Stall(Stall_wire),

	.Instruction(ID_Instruction_wire),
	.in_WriteRegister(WB_WriteRegister_wire),
	.WriteData(WB_ALUMemOrPCData_wire),
	.in_ALUMemOrPC(WB_ALUMemOrPC_wire),

	.ShamtSelector(ID_ShamtSelector),
	.ALUSrc(ID_ALUSrc),
	.BranchNE(ID_BranchNE_wire),
	.BranchEQ(ID_BranchEQ_wire),
	.ALUOp(ID_ALUOp_wire),
	.in_RegWrite(WB_RegWrite_wire),
	.MemWrite(ID_MemWrite_wire),
	.MemRead(ID_MemRead_wire),
	.MemtoReg(ID_MemtoReg_wire),
	.RegisterOrPC(ID_RegisterOrPC_wire),
	.JumpControl(ID_JumpControl_wire),
	.out_RegWrite(ID_RegWrite_wire),
	.out_WriteRegister(ID_WriteRegister_wire),
	.out_ALUMemOrPC(ID_ALUMemOrPC_wire),
	.ReadData1(ID_ReadData1_wire),
	.ReadData2(ID_ReadData2_wire),
	.ShamtExtend(ID_ShamtExtend_wire),
	.InmmediateExtend(ID_InmmediateExtend)
);

ID_EX_PipelineRegister
#(
	.NBits(32)
)
id_ex_pipelineRegister
(
    .clk(clk),
    .reset(reset ),
	.Flush(Flush_wire),

	.in_ALUOp(ID_ALUOp_wire),
	.in_PC_4(ID_PC_4_wire),
	.in_Instruction(ID_Instruction_wire),
	.in_ReadData1(ID_ReadData1_wire),
	.in_ReadData2(ID_ReadData2_wire),
	.in_ShamtExtend(ID_ShamtExtend_wire),
	.in_InmmediateExtend(ID_InmmediateExtend),
	.in_CtrlShamtSelector(ID_ShamtSelector),
	.in_CtrlALUSrc(ID_ALUSrc),
	.in_CtrlJump(ID_JumpControl_wire),
    .in_CtrlMemRead(ID_MemRead_wire),
    .in_CtrlMemWrite(ID_MemWrite_wire),
    .in_CtrlALUOrMem(ID_MemtoReg_wire),
    .in_CtrlBranchEquals(ID_BranchEQ_wire),
    .in_CtrlBranchNotEquals(ID_BranchNE_wire),
    .in_CtrlRegisterOrPC(ID_RegisterOrPC_wire),
    .in_CtrlALUMemOrPC(ID_ALUMemOrPC_wire),
	.in_CtrlRegWrite(ID_RegWrite_wire),
	.in_WriteRegister(ID_WriteRegister_wire),

	.out_ALUOp(EX_ALUOp_wire),
	.out_PC_4(EX_PC_4_wire),
    .out_Instruction(EX_Instruction_wire),
    .out_ReadData1(EX_ReadData1_wire),
	.out_ReadData2(EX_ReadData2_wire),
	.out_ShamtExtend(EX_ShamtExtend_wire),
	.out_InmmediateExtend(EX_InmmediateExtend),
	.out_CtrlShamtSelector(EX_ShamtSelector),
	.out_CtrlALUSrc(EX_ALUSrc),
	.out_CtrlJump(EX_JumpControl_wire),
    .out_CtrlMemRead(EX_MemRead_wire),
    .out_CtrlMemWrite(EX_MemWrite_wire),
    .out_CtrlALUOrMem(EX_MemtoReg_wire),
    .out_CtrlBranchEquals(EX_BranchEQ_wire),
    .out_CtrlBranchNotEquals(EX_BranchNE_wire),
    .out_CtrlRegisterOrPC(EX_RegisterOrPC_wire),
    .out_CtrlALUMemOrPC(EX_ALUMemOrPC_wire),
	.out_CtrlRegWrite(EX_RegWrite_wire),
	.out_WriteRegister(EX_WriteRegister_wire)
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
	
	.RegisterOrPC(EX_RegisterOrPC_wire),
	.JumpControll(EX_JumpControl_wire),
	.ShamtSelector(EX_ShamtSelector),
	.ALUSrc(EX_ALUSrc),
	.BranchNotEquals(EX_BranchNE_wire),
	.BranchEquals(EX_BranchEQ_wire),
	.ForwardB(ForwardB_wire),
	.ForwardA(ForwardA_wire),
	.ReadData1(EX_ReadData1_wire),
	.ReadData2(EX_ReadData2_wire),
	.ShamtExtend(EX_ShamtExtend_wire),
	.InmmediateExtend(EX_InmmediateExtend),
	.ALUOp(EX_ALUOp_wire),
	.ALUFunction(EX_Instruction_wire[5:0]),
	.JumpNoShifted(EX_Instruction_wire[25:0]),
	.PC_4(EX_PC_4_wire),
	.ALUMemOrPCData(WB_ALUMemOrPCData_wire),
	.MEM_ALUResult(MEM_ALUResult_wire),

	.JumpOrBranchControll(EX_JumpOrBranchControll_wire),
	.NewPC(EX_NewPC_wire),
	.WriteData(EX_WriteData_wire),
	.ALUResult(EX_ALUResult_wire)
);

EX_MEM_PipelineRegister
ex_mem_pipelineRegister
(
	// General signals
	.clk(clk),
	.reset(reset),

	// Input signals
    .in_ALUResult(EX_ALUResult_wire),
    .in_PC_4(EX_PC_4_wire),
	.in_WriteData(EX_WriteData_wire),
	.in_NewPC(EX_NewPC_wire),
	.in_CtrlJumpOrBranchControll(EX_JumpOrBranchControll_wire),
    .in_CtrlMemRead(EX_MemRead_wire),
    .in_CtrlMemWrite(EX_MemWrite_wire),
    .in_CtrlALUOrMem(EX_MemtoReg_wire),
	.in_CtrlALUMemOrPC(EX_ALUMemOrPC_wire),
	.in_CtrlRegWrite(EX_RegWrite_wire),
	.in_WriteRegister(EX_WriteRegister_wire),


	// Output signals
    .out_ALUResult(MEM_ALUResult_wire),
	.out_PC_4(MEM_PC_4_wire),
	.out_WriteData(MEM_WriteData_wire),
	.out_NewPC(MEM_NewPC_wire),
	.out_CtrlJumpOrBranchControll(MEM_JumpOrBranchControll_wire),
    .out_CtrlMemRead(MEM_MemRead_wire),
    .out_CtrlMemWrite(MEM_MemWrite_wire),
    .out_CtrlALUOrMem(MEM_MemtoReg_wire),
	.out_CtrlALUMemOrPC(MEM_ALUMemOrPC_wire),
	.out_CtrlRegWrite(MEM_RegWrite_wire),
	.out_WriteRegister(MEM_WriteRegister_wire)
);

//******************************************************************/
//******************************************************************/
//*****************************STAGE 4******************************/
//******************************************************************/
//******************************************************************/

MEMBlackBox
#(
	.NBits(32),
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
memStage
(
	.clk(clk),
	.reset(reset),
	.MemWrite(MEM_MemWrite_wire),
	.MemRead(MEM_MemRead_wire),
	.ALUResult(MEM_ALUResult_wire),
	.WriteData(MEM_WriteData_wire),

	.MemoryData(MEM_MemoryData_wire),
	.DataAddress(MEM_DataAddress_wire)
);	

MEM_WB_PipelineRegister
mem_wb_pipelineregister
(
	.clk(clk),
    .reset(reset),

	.in_PC_4(MEM_PC_4_wire),
    .in_MemoryData(MEM_MemoryData_wire),
	.in_ALUResult(MEM_ALUResult_wire),
    .in_CtrlALUOrMem(MEM_MemtoReg_wire),
	.in_CtrlALUMemOrPC(MEM_ALUMemOrPC_wire),
	.in_CtrlRegWrite(MEM_RegWrite_wire),
	.in_WriteRegister(MEM_WriteRegister_wire),

	.out_PC_4(WB_PC_4_wire),
    .out_MemoryData(WB_MemoryData_wire),
	.out_ALUResult(WB_ALUResult_wire),
    .out_CtrlALUOrMem(WB_MemtoReg_wire),
    .out_CtrlALUMemOrPC(WB_ALUMemOrPC_wire),
	.out_CtrlRegWrite(WB_RegWrite_wire),
	.out_WriteRegister(WB_WriteRegister_wire)
);

//******************************************************************/
//******************************************************************/
//*****************************STAGE 5******************************/
//******************************************************************/
//******************************************************************/

WBBlackBox
#(
	.NBits(32)
)
wbStage
(
	.clk(clk),
	.reset(reset),
	.MemtoReg(WB_MemtoReg_wire),
	.ALUMemOrPC(WB_ALUMemOrPC_wire),

	.PC_4(WB_PC_4_wire),
	.ALUResult(WB_ALUResult_wire),
	.MemoryData(WB_MemoryData_wire),

	.ALUMemOrPCData(WB_ALUMemOrPCData_wire)
);

ForwardingUnit
forwardingunit
(
	.EX_MEM_RegWrite(MEM_RegWrite_wire),
	.MEM_WB_RegWrite(WB_RegWrite_wire),
	.ID_EX_RegisterRs(EX_Instruction_wire[25:21]),
	.ID_EX_RegisterRt(EX_Instruction_wire[20:16]),
	.EX_MEM_RegisterRd(MEM_WriteRegister_wire),
	.MEM_WB_RegisterRd(WB_WriteRegister_wire),
	
	.ForwardA(ForwardA_wire),
	.ForwardB(ForwardB_wire)

);

HazardDetectionUnit
hazardDetectionUnit
(
	.ID_EX_MemRead(EX_MemRead_wire),
	.ID_EX_RegisterRt(EX_Instruction_wire[20:16]),
	.IF_ID_RegisterRs(ID_Instruction_wire[25:21]),
	.IF_ID_RegisterRt(ID_Instruction_wire[20:16]),
	.BranchControl(MEM_JumpOrBranchControll_wire),

	.Stall(Stall_wire),
	.Flush(Flush_wire)
);

assign ALUResultOut = WB_ALUResult_wire;

endmodule

