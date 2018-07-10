module MEM_WB_PipelineRegister(
    input clk,
    input reset,
    input [31:0] in_PC_4,
    input [31:0] in_NewPC,
    input [31:0] in_MemoryData,
    input [31:0] in_ALUResult,
    input [31:0] in_ReadData1,
    input [4:0] in_WriteRegister,
    input in_CtrlBranchControl,
    input in_CtrlRegWrite,
    input in_CtrlALUOrMem,
    input in_CtrlJump,
    input in_CtrlRegisterOrPC,
    input in_CtrlALUMemOrPC,

    output [31:0] out_PC_4,
    output [31:0] out_NewPC,
    output [31:0] out_ALUResult,
    output [31:0] out_MemoryData,
    output [31:0] out_ReadData1,
    output [4:0] out_WriteRegister,
    output out_CtrlBranchControl,
	output out_CtrlRegWrite,
    output out_CtrlALUOrMem,
    output out_CtrlJump,
    output out_CtrlRegisterOrPC,
    output out_CtrlALUMemOrPC
);

    reg [31:0] ALUResult;
    reg [31:0] MemoryData;
    reg [4:0] WriteRegister;
    reg [31:0] PC_4;
    reg [31:0] NewPC;
    reg [31:0] ReadData1;
    reg CtrlBranchControl;
    reg CtrlALUOrMem;
    reg CtrlJump;
    reg CtrlRegisterOrPC;
    reg CtrlALUMemOrPc;
    reg CtrlRegWrite;

    always @(negedge reset or negedge clk) 
    begin
        if(reset==0)
        begin
            PC_4 <= 0;
            NewPC <= 0;
            ReadData1 <= 0;
            MemoryData <= 0;
            WriteRegister <= 0;
            CtrlBranchControl <= 0;
            CtrlRegWrite <= 0;
            CtrlALUOrMem <= 0;
            CtrlJump <= 0;
            CtrlRegisterOrPC <= 0;
            CtrlALUMemOrPc <= 0;
            ALUResult <= 0;
        end
        else
        begin
            PC_4 <= in_PC_4;
            NewPC <= in_NewPC;
            ReadData1 <= in_ReadData1;
            ALUResult <= in_ALUResult;
            MemoryData <= in_MemoryData;
            WriteRegister <= in_WriteRegister;
			CtrlBranchControl <= in_CtrlBranchControl;
            CtrlRegWrite <= in_CtrlRegWrite;
            CtrlALUOrMem <= in_CtrlALUOrMem;
            CtrlJump <= in_CtrlJump;
            CtrlRegisterOrPC <= in_CtrlRegisterOrPC;
            CtrlALUMemOrPc <= in_CtrlALUMemOrPC;
        end
    end

    assign out_ALUResult = ALUResult;
    assign out_PC_4 = PC_4;
    assign out_NewPC = NewPC;
    assign out_ReadData1 = ReadData1;
    assign out_MemoryData = MemoryData;
    assign out_WriteRegister = WriteRegister;
    assign out_CtrlBranchControl = CtrlBranchControl;
    assign out_CtrlRegWrite = CtrlRegWrite;
    assign out_CtrlALUOrMem = CtrlALUOrMem;
    assign out_CtrlJump = CtrlJump;
    assign out_CtrlRegisterOrPC = CtrlRegisterOrPC;
    assign out_CtrlALUMemOrPC = CtrlALUMemOrPc;
    
endmodule // MEM_WB_PipelineRegister