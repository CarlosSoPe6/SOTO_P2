module EXBlackBox
#(
	parameter NBits=32
)
(
    input clk,
    input reset,

    input RegisterOrPC,
    input JumpControll,
    input ShamtSelector,
    input ALUSrc,
    input BranchNotEquals,
    input BranchEquals,
    input [1:0] ForwardB,
    input [1:0] ForwardA,
    input [NBits-1:0] ReadData1,
    input [NBits-1:0] ReadData2,
    input [NBits-1:0] ShamtExtend,
    input [NBits-1:0] InmmediateExtend,
    input [2:0] ALUOp,
    input [5:0] ALUFunction,
    input [25:0] JumpNoShifted,
    input [NBits-1:0] PC_4,
    input [NBits-1:0] ALUMemOrPCData,
    input [NBits-1:0] MEM_ALUResult,

    output JumpOrBranchControll,
    output [NBits-1:0] NewPC,
    output [NBits-1:0] WriteData,
    output [NBits-1:0] ALUResult
);

    wire Zero_wire;
    wire BranchControl_wire;
    wire [3:0] ALUOperation_wire;
    wire [NBits-1:0] ForwardingAData_wire;
    wire [NBits-1:0] ReadDataOrShamt_wire;
    wire [NBits-1:0] ForwardingBData_wire;
    wire [NBits-1:0] BranchAddress_wire;
    wire [NBits-1:0] BranchShifter_wire;
    wire [NBits-1:0] JumpShited_wire;
    wire [NBits-1:0] JumpAddress_wire;
    wire [NBits-1:0] JumpOrBranch_wire;
    wire [NBits-1:0] ReadData2OrInmmediate_wire;
    
    Multiplexer3to1
	#(
		.NBits(32)
	)
	forwardingA
	(
		.Selector(ForwardA),

		.MUX_Data0(ReadData1),
		.MUX_Data1(ALUMemOrPCData),
		.MUX_Data2(MEM_ALUResult),
	
		.MUX_Output(ForwardingAData_wire)

	);

    Multiplexer2to1
    #(
        .NBits(32)
    )
    MUX_ForReadDataOrShamt
    (
        .Selector(ShamtSelector),
        .MUX_Data0(ForwardingAData_wire),
        .MUX_Data1(ShamtExtend),
        .MUX_Output(ReadDataOrShamt_wire)
    );

    Multiplexer3to1
	#(
		.NBits(32)
	)
	forwardingB
	(
		.Selector(ForwardB),

		.MUX_Data0(ReadData2),
		.MUX_Data1(ALUMemOrPCData),
		.MUX_Data2(MEM_ALUResult),
	
		.MUX_Output(ForwardingBData_wire)

	);

    Multiplexer2to1
    #(
        .NBits(32)
    )
    MUX_ForReadDataOrInmediate
    (
        .Selector(ALUSrc),
        .MUX_Data0(ForwardingBData_wire),
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
        .A(ReadDataOrShamt_wire),
        .B(ReadData2OrInmmediate_wire),
        .Zero(Zero_wire),
        .ALUResult(ALUResult)
    );

    /**
     * Address Calculation
     */

    ShiftLeft2
    JumpShifter
    (
        .DataInput(JumpNoShifted),
        .DataOutput(JumpShited_wire)
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
        .Result(BranchAddress_wire)
    );

    BranchModule
    BranchController
    (
        .Zero(Zero_wire),
        .BNEControl(BranchNotEquals),
        .BEQControl(BranchEquals),
        .BranchControlSignal(BranchControl_wire)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MuxForJumpPcOrBranch
    (
        .Selector(BranchControl_wire),
        .MUX_Data0(JumpAddress_wire),
        .MUX_Data1(BranchAddress_wire),

        .MUX_Output(JumpOrBranch_wire)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MUX_ForRegisterOrPC
    (
        .Selector(RegisterOrPC),
        .MUX_Data0(JumpOrBranch_wire),
        .MUX_Data1(ReadData1),
        
        .MUX_Output(NewPC)
    );
	
    assign WriteData = ForwardingBData_wire;
    assign JumpAddress_wire = {PC_4[31:28], JumpShited_wire[27:0]};
    assign JumpOrBranchControll = JumpControll || RegisterOrPC || BranchControl_wire;

endmodule // EXBlackBox