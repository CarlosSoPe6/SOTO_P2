module EXBlackBox
#(
	parameter NBits=32
)
(
    input clk,
    input reset,

    input ShamtSelector,
    input [NBits-1:0] ReadData1,
    input [NBits-1:0] RegisterOrShamt,
    input ALUSrc,
    input [NBits-1:0] ReadData2,
    input [NBits-1:0] ReadData2OrInmmediate,
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

    wire [3:0] ALUOperation_wire;
    wire [NBits-1:0] BranchShifter_wire;
    wire [NBits-1:0] JumpAddress_wire;

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
        .A(RegisterOrShamt),
        .B(ReadData2OrInmmediate),
        .Zero(Zero),
        .ALUResult(ALUResult)
    );

    ShiftLeft2
    JumpShifter
    (
        .DataInput(JumpNoShifted),
        .DataOutput(JumpAddress_wire)
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

    assign JumpAddress = {PC_4[31:28], JumpAddress_wire[27:0]};

endmodule // EXBlackBox