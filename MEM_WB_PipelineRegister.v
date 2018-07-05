module MEM_WB_PipelineRegister(
    input clk,
    input reset,
    input [31:0] in_ReadData1,
    input [31:0] in_JumpAddress,
    input [31:0] in_MemoryData,
    input [31:0] in_PCOrBranch,
    input [31:0] in_ALUResult,
    input [4:0] in_WriteRegister,
    input in_CtrlRegWrite,
    input in_CtrlALUOrMem,
    input in_CtrlJump,
    input in_CtrlRegisterOrPC,
    input in_CtrlALUMemOrPC,

    output [31:0] out_ReadData1,
    output [31:0] out_ALUResult,
    output [31:0] out_JumpAddress,
    output [31:0] out_MemoryData,
    output [31:0] out_PCOrBranch,
    output [4:0] out_WriteRegister,
	output out_CtrlRegWrite,
    output out_CtrlALUOrMem,
    output out_CtrlJump,
    output out_CtrlRegisterOrPC,
    output out_CtrlALUMemOrPC
);

    reg [31:0] ReadData1;
    reg [31:0] ALUResult;
    reg [31:0] JumpAddress;
    reg [31:0] MemoryData;
    reg [31:0] PCOrBranch;
    reg [4:0] WriteRegister;
    reg CtrlALUOrMem;
    reg CtrlJump;
    reg CtrlRegisterOrPC;
    reg CtrlALUMemOrPc;
    reg CtrlRegWrite;

    always @(negedge reset or negedge clk) 
    begin
        if(reset==0)
        begin
            ReadData1 <= 0;
            JumpAddress <= 0;
            MemoryData <= 0;
            PCOrBranch <= 0;
            WriteRegister <= 0;
            CtrlRegWrite <= 0;
            CtrlALUOrMem <= 0;
            CtrlJump <= 0;
            CtrlRegisterOrPC <= 0;
            CtrlALUMemOrPc <= 0;
            ALUResult <= 0;
        end
        else
        begin
            ALUResult <= in_ALUResult;
            ReadData1 <= in_ReadData1;
            JumpAddress <= in_JumpAddress;
            MemoryData <= in_MemoryData;
            PCOrBranch <= in_PCOrBranch;
            WriteRegister <= in_WriteRegister;
			CtrlRegWrite <= in_CtrlRegWrite;
            CtrlALUOrMem <= in_CtrlALUOrMem;
            CtrlJump <= in_CtrlJump;
            CtrlRegisterOrPC <= in_CtrlRegisterOrPC;
            CtrlALUMemOrPc <= in_CtrlALUMemOrPC;
        end
    end

    assign out_ALUResult = ALUResult;
    assign out_ReadData1 = ReadData1;
    assign out_JumpAddress = JumpAddress;
    assign out_MemoryData = MemoryData;
    assign out_PCOrBranch = PCOrBranch;
    assign out_WriteRegister = WriteRegister;
    assign out_CtrlRegWrite = CtrlRegWrite;
    assign out_CtrlALUOrMem = CtrlALUOrMem;
    assign out_CtrlJump = CtrlJump;
    assign out_CtrlRegisterOrPC = CtrlRegisterOrPC;
    assign out_CtrlALUMemOrPC = CtrlALUMemOrPc;
    
endmodule // MEM_WB_PipelineRegister