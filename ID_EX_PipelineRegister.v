module ID_EX_PipelineRegister
#(
	parameter NBits=32
	
)
(
    input clk,
    input reset,
	input Flush,

	input [2:0] in_ALUOp,
	input [NBits-1:0] in_PC_4,
	input [NBits-1:0] in_Instruction,
	input [NBits-1:0] in_ReadData1,
	input [NBits-1:0] in_ReadData2,
	input [NBits-1:0] in_ShamtExtend,
	input [NBits-1:0] in_InmmediateExtend,
	input [4:0] in_WriteRegister,
	input in_CtrlShamtSelector,
	input in_CtrlALUSrc,
	input in_CtrlRegWrite,
	input in_CtrlJump,
    input in_CtrlMemRead,
    input in_CtrlMemWrite,
    input in_CtrlALUOrMem,
    input in_CtrlBranchEquals,
    input in_CtrlBranchNotEquals,
    input in_CtrlRegisterOrPC,
    input in_CtrlALUMemOrPC,
    
	output [2:0] out_ALUOp,
	output [NBits-1:0] out_PC_4,
	output [NBits-1:0] out_Instruction,
	output [NBits-1:0] out_ReadData1,
	output [NBits-1:0] out_ReadData2,
	output [NBits-1:0] out_ShamtExtend,
	output [NBits-1:0] out_ReadData2OrInmmediate,
	output [NBits-1:0] out_InmmediateExtend,
	output [4:0] out_WriteRegister,
	output out_CtrlShamtSelector,
	output out_CtrlALUSrc,
	output out_CtrlRegWrite,
	output out_CtrlJump,
    output out_CtrlMemRead,
    output out_CtrlMemWrite,
    output out_CtrlALUOrMem,
    output out_CtrlBranchEquals,
    output out_CtrlBranchNotEquals,
    output out_CtrlRegisterOrPC,
    output out_CtrlALUMemOrPC
);

	reg [2:0] ALUOp;
	reg [NBits-1:0] PC_4;
    reg [NBits-1:0] Instruction;
	reg [NBits-1:0] ReadData1;
	reg [NBits-1:0] ReadData2;
	reg [NBits-1:0] ShamtExtend;
	reg [NBits-1:0] InmmediateExtend;
	reg [4:0] WriteRegister;

	reg CtrlShamtSelector;
	reg CtrlALUSrc;
	reg CtrlJump;
	reg CtrlMemRead;
    reg CtrlMemWrite;
    reg CtrlALUOrMem;
    reg CtrlBranchEquals;
    reg CtrlBranchNotEquals;
    reg CtrlRegisterOrPC;
    reg CtrlALUMemOrPC;
    reg CtrlRegWrite;

    always @(negedge reset or clk) 
    begin
        if(reset == 0 || (Flush == 1 && clk == 1))
        begin
			ALUOp<=0;
			PC_4<=0;
			Instruction<=0;
			ReadData1<=0;
			ReadData2<=0;
			ShamtExtend<=0;
			InmmediateExtend <= 0;
			WriteRegister <= 0;
			CtrlShamtSelector <= 0;
			CtrlALUSrc <= 0;
            CtrlRegWrite <= 0;
			CtrlJump <= 0;
			CtrlMemRead <= 0;
			CtrlMemWrite <= 0;
			CtrlALUOrMem <= 0;
			CtrlBranchEquals <= 0;
			CtrlBranchNotEquals <= 0;
			CtrlRegisterOrPC <= 0;
			CtrlALUMemOrPC <= 0;
        end
        else if(clk == 0)
        begin
			ALUOp<=in_ALUOp;
			PC_4<=in_PC_4;
			Instruction<=in_Instruction;
			ReadData1<=in_ReadData1;
			ReadData2<=in_ReadData2;
			ShamtExtend<=in_ShamtExtend;
			InmmediateExtend<=in_InmmediateExtend;
			WriteRegister <= in_WriteRegister;
			CtrlShamtSelector <= in_CtrlShamtSelector;
			CtrlALUSrc <= in_CtrlALUSrc;
			CtrlRegWrite <= in_CtrlRegWrite;
			CtrlJump <= in_CtrlJump;
			CtrlMemRead <= in_CtrlMemRead;
			CtrlMemWrite <= in_CtrlMemWrite;
			CtrlALUOrMem <= in_CtrlALUOrMem;
			CtrlBranchEquals <= in_CtrlBranchEquals;
			CtrlBranchNotEquals <= in_CtrlBranchNotEquals;
			CtrlRegisterOrPC <= in_CtrlRegisterOrPC;
			CtrlALUMemOrPC <= in_CtrlALUMemOrPC;
        end
    end

	assign out_ALUOp = ALUOp;
	assign out_PC_4 = PC_4;
	assign out_Instruction = Instruction;
	assign out_ReadData1 = ReadData1;
	assign out_ReadData2 = ReadData2;
	assign out_ShamtExtend = ShamtExtend;
	assign out_InmmediateExtend = InmmediateExtend;
	assign out_WriteRegister = WriteRegister;

	assign out_CtrlShamtSelector = CtrlShamtSelector;
	assign out_CtrlALUSrc = CtrlALUSrc;
    assign out_CtrlRegWrite = CtrlRegWrite;
	assign out_CtrlJump = CtrlJump;
    assign out_CtrlMemRead = CtrlMemRead;
    assign out_CtrlMemWrite = CtrlMemWrite;
    assign out_CtrlALUOrMem = CtrlALUOrMem;
    assign out_CtrlBranchEquals = CtrlBranchEquals;
    assign out_CtrlBranchNotEquals = CtrlBranchNotEquals;
    assign out_CtrlRegisterOrPC = CtrlRegisterOrPC;
    assign out_CtrlALUMemOrPC = CtrlALUMemOrPC;
	  
endmodule 