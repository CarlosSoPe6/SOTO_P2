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

wire [31:0] IF_Instruction_wire;
wire [31:0] ID_Instruction_wire;
wire [31:0] PC_wire;
wire [31:0] Real_PC_Wire;
wire [31:0] IF_PC_4_wire;
wire [31:0] ID_PC_4_wire;
wire [31:0] EX_PC_4_wire;
wire [31:0] MEM_PC_4_wire;
wire [31:0] PCOrReg_New_Value_wire;
wire [31:0] PC_New_Value_wire; 


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

wire ID_RegDst_wire;

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

wire ID_RegisterOrPC_wire;
wire EX_RegisterOrPC_wire;
wire MEM_RegisterOrPC_wire;
wire WB_RegisterOrPC_wire;

wire ID_ALUMemOrPC_wire;
wire EX_ALUMemOrPC_wire;
wire MEM_ALUMemOrPC_wire;
wire WB_ALUMemOrPC_wire;

wire ID_JumpControl_wire;
wire EX_JumpControl_wire;
wire MEM_JumpControl_wire;
wire WB_JumpControl_wire;

wire [2:0] ID_ALUOp_wire;


wire [31:0] ID_ReadData1_wire;
wire [31:0] ID_ReadData2_wire;
wire [31:0] EX_ReadData2_wire;
wire [31:0] MEM_ReadData2_wire;
wire [4:0] WB_New_WriteRegister_wire;
wire [4:0] WriteRegister_wire;
wire [31:0] ID_InmmediateExtend_wire;
wire [31:0] ID_ShamtExtend_wire;

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
wire [31:0] WB_JumpAddress_wire;

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

IFBlackBox
#(
	.NBits(32),
	.MEMORY_DEPTH(512)
)
(
	.clk(clk),
   .reset(reset),
	.PCOrReg_New_Value_wire(PC_New_Value_wire),


	.Instruction_wire(IF_Instruction_wire),
	.PC_4_wire(IF_PC_4_wire)
);

IF_ID_PipelineRegister
#(
	.NBits(32)
if_id_pipelineRegister
)

(
    .clk(clk),
    .reset(reset),
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
(
	.clk(clk),
	.reset(reset),
	.Instruction_wire(IF_Instruction_wire),
	.New_WriteRegister_wire(WB_New_WriteRegister_wire),
	
	.RegDst_wire(ID_RegDst_wire),
	.BranchNE_wire(ID_BranchNE_wire),
	.BranchEQ_wire(ID_BranchEQ_wire),
	.ALUOp_wire(ID_ALUOp_wire),
	.ALUSrc_wire(ID_ALUSrc_wire),
	.RegWrite_wire(ID_RegWrite_wire),
	.MemWrite_wire(ID_MemWrite_wire),
	.MemRead_wire(ID_MemRead_wire),
	.MemtoReg_wire(ID_MemtoReg_wire),
	.ShamtSelector_wire(ID_ShamtSelector_wire),
	.RegisterOrPC_wire(ID_RegisterOrPC_wire),
	.ALUMemOrPC_wire(ID_ALUMemOrPC_wire),
	.JumpControl_wire(ID_JumpControl_wire),
	
	.ReadData1_wire(ID_ReadData1_wire),
	.ReadData2_wire(ID_ReadData2_wire),
	.InmmediateExtend_wire(ID_InmmediateExtend_wire),
	.ShamtExtend_wire(ID_ShamtExtend_wire)
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
	.in_CtrlRegisterOrPC(EX_RegisterOrPC_wire),
	.in_CtrlALUMemOrPC(EX_ALUMemOrPC_wire),

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
	.out_CtrlBranchNotEquals(MEM_BranchNE_wire),
	.out_CtrlRegisterOrPC(MEM_RegisterOrPC_wire),
	.out_CtrlALUMemOrPC(MEM_ALUMemOrPC_wire)
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

MEM_WB_PipelineRegister
mem_wb_pipelineregister
(
	.clk(clk),
    .reset(reset),
    .in_JumpAddress(MEM_JumpAddress_wire),
    .in_MemoryData(MEM_MemoryData_wire),
    .in_PCOrBranch(MEM_PCOrBranch_wire),
    .in_CtrlALUOrMem(MEM_MemtoReg_wire),
    .in_CtrlJump(MEM_JumpControl_wire),
    .in_CtrlRegisterOrPC(MEM_RegisterOrPC_wire),
    .in_CtrlALUMemOrPC(MEM_ALUMemOrPC_wire),
    
	.out_JumpAddress(WB_JumpAddress_wire),
    .out_MemoryData(WB_MemoryData_wire),
    .out_PCOrBranch(WB_PCOrBranch_wire),
    .out_CtrlALUOrMem(WB_MemtoReg_wire),
    .out_CtrlJump(WB_JumpControl_wire),
    .out_CtrlRegisterOrPC(WB_RegisterOrPC_wire),
    .out_CtrlALUMemOrPC(WB_ALUMemOrPC_wire)
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

Multiplexer2to1
#(
	.NBits(NBits)
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
	.NBits(NBits)
)
MuxForNextPcOrJump
(
	.Selector(JumpControl_wire),
	.MUX_Output(PC_New_Value_wire),
	.MUX_Data0(PCOrBranch_wire),
	.MUX_Data1({PC_4_wire[31:28], JumpAddress_wire[27:0]})
);


assign ALUResultOut = EX_ALUResult_wire;

endmodule

