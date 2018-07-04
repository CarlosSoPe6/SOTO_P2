/******************************************************************
* Description
*	
* Version:
*	1.0
* Author:
*	Carlos Soto Pérez
* email:
*	carlos348@outook.com
* Date:
*	03/07/2018
******************************************************************/
module EX_MEM_PipelineRegister(
    input clk,
    input reset,

    input in_Zero,
    input [31:0] in_ALUResult,
    input [31:0] in_ReadData2,
    input [31:0] in_NewPC,
    input [31:0] in_PC_4,
    input in_CtrlMemRead,
    input in_CtrlMemWrite,
    input in_CtrlALUOrMem,

    output out_Zero,
    output [31:0] out_ALUResult,
    output [31:0] out_ReadData2,
    output [31:0] out_NewPC,
    output out_CtrlMemRead,
    output out_CtrlMemWrite,
    output out_CtrlALUOrMem
);
    reg Zero;
    reg [31:0] ALUResult;
    reg [31:0] ReadData2;
    reg [31:0] NewPC;
    reg CtrlMemRead;
    reg CtrlMemWrite;
    reg CtrlALUOrMem;

    always @(negedge reset or negedge clk) begin
      if(reset) 
      begin
        Zero <= 0;
        ALUResult <= 0;
        ReadData2 <= 0;
        NewPC <= 0;
        CtrlMemRead <= 0;
        CtrlMemWrite <= 0;
        CtrlALUOrMem <= 0;
      end 
      else 
      begin
        Zero <= in_Zero;
        ALUResult <= in_ALUResult;
        ReadData2 <= in_ReadData2;
        NewPC <= in_NewPC;
        CtrlMemRead <= in_CtrlMemRead;
        CtrlMemWrite <= in_CtrlMemWrite;
        CtrlALUOrMem <= in_CtrlALUOrMem;
      end
    end

    assign out_Zero = Zero;
    assign out_ALUResult = ALUResult;
    assign out_ReadData2 = ReadData2;
    assign out_NewPC = NewPC;
    assign out_CtrlMemRead = CtrlMemRead;
    assign out_CtrlMemWrite = CtrlMemWrite;
    assign out_CtrlALUOrMem = CtrlALUOrMem;

endmodule // EX_MEM_PipelineRegister