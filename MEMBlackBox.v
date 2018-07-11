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
    input [NBits-1:0] ALUResult,
    input [NBits-1:0] WriteData,

    output [NBits-1:0] MemoryData,
    output [NBits-1:0] DataAddress
);

    wire [NBits-1:0] Real_Data_Address_wire;
    wire [NBits-1:0] PCOrBranch_wire;
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
        .WriteData(WriteData),
        .Address(Real_Data_Address_wire),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(MemoryData),
        .clk(clk)
    );

    assign DataAddress = Real_Data_Address_wire;
	 
endmodule // MEMBlackBox

    