module EX_MEM_PipelineRegister(
    input clk,
    input reset,
    input in_Zero,
    input [31:0] in_ALUResult,
    input [31:0] in_ReadData2,
    input [31:0] in_JumpAddress,
    input [31:0] in_BranchAddress,
    input [31:0] in_PC_4,
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
    output [31:0] out_ReadData2,
    output [31:0] out_JumpAddress,
    output [31:0] out_BranchAddress,
    output [31:0] out_PC_4,
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
    reg [31:0] ReadData2;
    reg [31:0] JumpAddress;
    reg [31:0] BranchAddress;
    reg [31:0] PC_4;
    reg CtrlMemRead;
    reg CtrlMemWrite;
    reg CtrlALUOrMem;
    reg CtrlBranchEquals;
    reg CtrlBranchNotEquals;
    reg CtrlRegisterOrPC;
    reg CtrlALUMemOrPC;

    always @(negedge reset or negedge clk) begin
      if(reset==0) 
      begin
        Zero <= 0;
        ALUResult <= 0;
        ReadData2 <= 0;
        JumpAddress <= 0;
        BranchAddress <= 0;
        PC_4 <= 0;
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
        ReadData2 <= in_ReadData2;
        JumpAddress <= in_JumpAddress;
        BranchAddress <= in_BranchAddress;
        PC_4 <= in_PC_4;
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
    assign out_ReadData2 = ReadData2;
    assign out_JumpAddress = JumpAddress;
    assign out_BranchAddress = BranchAddress;
    assign out_PC_4 = PC_4;
    assign out_CtrlMemRead = CtrlMemRead;
    assign out_CtrlMemWrite = CtrlMemWrite;
    assign out_CtrlALUOrMem = CtrlALUOrMem;
    assign out_CtrlBranchEquals = CtrlBranchEquals;
    assign out_CtrlBranchNotEquals = out_CtrlBranchEquals;
    assign out_CtrlRegisterOrPC = CtrlRegisterOrPC;
    assign out_CtrlALUMemOrPC = CtrlALUMemOrPC;

endmodule // EX_MEM_PipelineRegister