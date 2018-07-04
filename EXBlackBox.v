module EXBlackBox
#(
	parameter NBits=32
)
(
  input clk,
  input reset,

  input ShamtSelector,
  input [NBits-1:0] ReadData1,
  input [NBits-1:0] ShamtExtend,
  input ALUSrc,
  input [NBits-1:0] ReadData2,
  input [NBits-1:0] InmmediateExtend,
  input [2:0] ALUOp,
  input [5:0] ALUFunction,
  input [25:0] JumpNoShifted,
  input [NBits-1:0] PC_4,

  output [NBits-1:0] BranchAddress,
  output [NBits-1:0] JumpAddress,
  output [NBits-1:0] ALUResult,
  output [NBits-1:0] out_PC_4,
  output Zero
);

    wire [NBits-1:0] RegisterOrShamt_wire;
    wire [NBits-1:0] ReadData2OrInmmediate_wire;
    wire [3:0] ALUOperation_wire;
    wire [NBits-1:0] BranchShifter_wire;

    Multiplexer2to1
    #(
        .NBits(32)
    )
    MUX_ForRegOrShamt
    (
        .Selector(ShamtSelector),
        .MUX_Data0(ReadData1),
        .MUX_Data1(ShamtExtend),
        .MUX_Output(RegisterOrShamt_wire)
    );


    Multiplexer2to1
    #(
        .NBits(32)
    )
    MUX_ForReadDataAndInmediate
    (
        .Selector(ALUSrc),
        .MUX_Data0(ReadData2),
        .MUX_Data1(InmmediateExtend),
        
        .MUX_Output(ReadData2OrInmmediate_wire)

    );

    ALUControl
    ArithmeticLogicUnitControl
    (
        .ALUOp(ALUOp),
        .ALUFunction(ALUFunction),
        .ALUOperation(ALUOperation_wire)
    );

    ALU
    ArithmeticLogicUnit 
    (
        .ALUOperation(ALUOperation_wire),
        .A(RegisterOrShamt_wire),
        .B(ReadData2OrInmmediate_wire),
        .Zero(Zero),
        .ALUResult(ALUResult)
    );

    ShiftLeft2
    JumpShifter
    (
        .DataInput(JumpNoShifted),
        .DataOutput(JumpAddress)
    );

    ShiftLeft2
    BranchShifter
    (
        .DataInput(InmmediateExtend),
        .DataOutput(BranchShifter_wire)
    );

    Adder32bits
    Branch_Address_Calculator
    (
        .Data0(BranchShifter_wire),
        .Data1(PC_4),
        .Result(BranchAddress)
    );

endmodule // EXBlackBox