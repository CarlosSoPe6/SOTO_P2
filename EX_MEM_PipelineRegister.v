module EX_MEM_PipelineRegister(
    input clk,
    input reset,
    input Flush,

    input [31:0] in_ALUResult,
    input [31:0] in_WriteData,
    input [31:0] in_PC_4,
    input [4:0] in_WriteRegister,
    input [31:0] in_NewPC,
	  input in_CtrlJumpOrBranchControll,
    input in_CtrlRegWrite,
    input in_CtrlMemRead,
    input in_CtrlMemWrite,
    input in_CtrlALUOrMem,
    input in_CtrlALUMemOrPC,

    output [31:0] out_ALUResult,
    output [31:0] out_WriteData,
    output [31:0] out_PC_4,
    output [4:0] out_WriteRegister,
    output [31:0] out_NewPC,
	  output out_CtrlJumpOrBranchControll,
	  output out_CtrlRegWrite,
    output out_CtrlMemRead,
    output out_CtrlMemWrite,
    output out_CtrlALUOrMem,
    output out_CtrlALUMemOrPC
);
    reg [31:0] ALUResult;
    reg [31:0] WriteData;
    reg [31:0] PC_4;
    reg [4:0] WriteRegister;
    reg [31:0] NewPC;
    reg CtrlJumpOrBranchControll;
    reg CtrlMemRead;
    reg CtrlMemWrite;
    reg CtrlALUOrMem;
    reg CtrlALUMemOrPC;
    reg CtrlRegWrite;

    always @(negedge reset or clk) begin
      if(reset==0 || (Flush == 1 && clk == 1)) 
      begin
        ALUResult <= 0;
        WriteData <= 0;
        PC_4 <= 0;
        WriteRegister <= 0;
        NewPC <= 0;
        CtrlJumpOrBranchControll <= 0;
        CtrlRegWrite <= 0;
        CtrlMemRead <= 0;
        CtrlMemWrite <= 0;
        CtrlALUOrMem <= 0;
        CtrlALUMemOrPC <= 0;
      end 
      else if(clk == 0)
      begin
        ALUResult <= in_ALUResult;
        WriteData <= in_WriteData;
        PC_4 <= in_PC_4;
        WriteRegister <= in_WriteRegister;
        NewPC <= in_NewPC;
        CtrlJumpOrBranchControll <= in_CtrlJumpOrBranchControll;
			  CtrlRegWrite <= in_CtrlRegWrite;
        CtrlMemRead <= in_CtrlMemRead;
        CtrlMemWrite <= in_CtrlMemWrite;
        CtrlALUOrMem <= in_CtrlALUOrMem;
        CtrlALUMemOrPC <= in_CtrlALUMemOrPC;
      end
    end

    assign out_ALUResult = ALUResult;
    assign out_WriteData = WriteData;
    assign out_PC_4 = PC_4;
    assign out_WriteRegister = WriteRegister;
    assign out_NewPC = NewPC;
    assign out_CtrlJumpOrBranchControll = CtrlJumpOrBranchControll;
    assign out_CtrlRegWrite = CtrlRegWrite;
    assign out_CtrlMemRead = CtrlMemRead;
    assign out_CtrlMemWrite = CtrlMemWrite;
    assign out_CtrlALUOrMem = CtrlALUOrMem;
    assign out_CtrlALUMemOrPC = CtrlALUMemOrPC;

endmodule // EX_MEM_PipelineRegister