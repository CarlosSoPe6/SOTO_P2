module EX_MEM_PipelineRegister(
    input clk,
    input reset,
    input in_Zero,
    input [31:0] in_ALUResult,
    input [31:0] in_ReadData1,
    input [31:0] in_WriteData,
    input [31:0] in_JumpAddress,
    input [31:0] in_BranchAddress,
    input [31:0] in_PC_4,
    input [4:0] in_WriteRegister,
    input in_CtrlRegWrite,
    input in_CtrlJump,
    input in_CtrlMemRead,
    input in_CtrlMemWrite,
    input in_CtrlALUOrMem,
    input in_CtrlBranchEquals,
    input in_CtrlBranchNotEquals,
    input in_CtrlRegisterOrPC,
    input in_CtrlALUMemOrPC,

    output out_Zero,
    output [31:0] out_ALUResult,
    output [31:0] out_ReadData1,
    output [31:0] out_WriteData,
    output [31:0] out_JumpAddress,
    output [31:0] out_BranchAddress,
    output [31:0] out_PC_4,
    output [4:0] out_WriteRegister,
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
    reg Zero;
    reg [31:0] ALUResult;
    reg [31:0] ReadData1;
    reg [31:0] WriteData;
    reg [31:0] JumpAddress;
    reg [31:0] BranchAddress;
    reg [31:0] PC_4;
    reg [4:0] WriteRegister;
    reg CtrlJump;
    reg CtrlMemRead;
    reg CtrlMemWrite;
    reg CtrlALUOrMem;
    reg CtrlBranchEquals;
    reg CtrlBranchNotEquals;
    reg CtrlRegisterOrPC;
    reg CtrlALUMemOrPC;
    reg CtrlRegWrite;

    always @(negedge reset or negedge clk) begin
      if(reset==0) 
      begin
        Zero <= 0;
        ALUResult <= 0;
        ReadData1 <= 0;
        WriteData <= 0;
        JumpAddress <= 0;
        BranchAddress <= 0;
        PC_4 <= 0;
        WriteRegister <= 0;
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
      else 
      begin
        Zero <= in_Zero;
        ALUResult <= in_ALUResult;
        ReadData1 <= in_ReadData1;
        WriteData <= in_WriteData;
        JumpAddress <= in_JumpAddress;
        BranchAddress <= in_BranchAddress;
        PC_4 <= in_PC_4;
        WriteRegister <= in_WriteRegister;
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

    assign out_Zero = Zero;
    assign out_ALUResult = ALUResult;
    assign out_ReadData1 = ReadData1;
    assign out_WriteData = WriteData;
    assign out_JumpAddress = JumpAddress;
    assign out_BranchAddress = BranchAddress;
    assign out_PC_4 = PC_4;
    assign out_WriteRegister = WriteRegister;
    assign out_CtrlRegWrite = CtrlRegWrite;
    assign out_CtrlJump = CtrlJump;
    assign out_CtrlMemRead = CtrlMemRead;
    assign out_CtrlMemWrite = CtrlMemWrite;
    assign out_CtrlALUOrMem = CtrlALUOrMem;
    assign out_CtrlBranchEquals = CtrlBranchEquals;
    assign out_CtrlBranchNotEquals = out_CtrlBranchNotEquals;
    assign out_CtrlRegisterOrPC = CtrlRegisterOrPC;
    assign out_CtrlALUMemOrPC = CtrlALUMemOrPC;

endmodule // EX_MEM_PipelineRegister