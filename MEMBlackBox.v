module MEMBlackBox
#(
	parameter NBits=32,
	parameter MEMORY_DEPTH = 512
)
(
    input clk,
    input reset,
    input MemWrite,
    input MemRead,
    input Zero,
    input BranchEquals,
    input BranchNotEquals,
    input [NBits-1:0] ALUResult,
    input [NBits-1:0] ReadData2,
    input [NBits-1:0] PC_4,
    input [NBits-1:0] BranchAddress,

    output [NBits-1:0] MemoryData,
    output [NBits-1:0] PCOrBranch

);

    wire [NBits-1:0] Real_Data_Address_wire;
    wire BranchControl_wire;

    Adder32bits
    Data_Memory_Calculator
    (
        .Data0(ALUResult),
        .Data1(32'hFBFF_C000),
        .Result(Real_Data_Address_wire)
    );

    DataMemory
    #(
        .DATA_WIDTH(NBits),
        .MEMORY_DEPTH(MEMORY_DEPTH)
    )
    RAM_Memory
    (
        .WriteData(ReadData2),
        .Address(Real_Data_Address_wire),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(MemoryData),
        .clk(clk)
    );

    BranchModule
    BranchController
    (
        .Zero(Zero),
        .BNEControl(BranchNotEquals),
        .BEQControl(BranchEquals),
        .BranchControlSignal(BranchControl_wire)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MuxForNextPcOrBranch
    (
        .Selector(BranchControl_wire),
        .MUX_Output(PCOrBranch),
        .MUX_Data0(PC_4),
        .MUX_Data1(BranchAddress)
    );

endmodule // MEMBlackBox

    