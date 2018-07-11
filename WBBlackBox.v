module WBBlackBox
#(
	parameter NBits = 32
)
(
  input clk,
  input reset,

    input MemtoReg,
    input ALUMemOrPC,

    input [NBits-1:0] PC_4,
    input [NBits-1:0] ALUResult,
    input [NBits-1:0] MemoryData,

    output [NBits-1:0] ALUMemOrPCData
);

    wire [NBits-1:0] MemoryDataOrALU_wire;

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MuxForReadMemoryOrALU
    (
        .Selector(MemtoReg),
        .MUX_Data0(ALUResult),
        .MUX_Data1(MemoryData),
        
        .MUX_Output(MemoryDataOrALU_wire)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MUX_ForALUMemOrPC
    (
        .Selector(ALUMemOrPC),
        .MUX_Data0(MemoryDataOrALU_wire),
        .MUX_Data1(PC_4),
        
        .MUX_Output(ALUMemOrPCData)
    );

endmodule // WBBlackBox