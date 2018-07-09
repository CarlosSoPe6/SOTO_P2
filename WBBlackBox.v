module WBBlackBox
#(
	parameter NBits = 512
)
(
  input clk,
  input reset,

  input in_MemtoReg,
  input in_ALUMemOrPC,
  input in_JumpControl,
  input in_RegisterOrPC,

  input [NBits-1:0] in_ALUResult,
  input [NBits-1:0] in_MemoryData,
  input [NBits-1:0] in_PCOrBranch,
  input [NBits-1:0] in_JumpAddress,
  input [NBits-1:0] in_ReadData1,

  output [NBits-1:0] out_ALUMemOrPCData,
  output [NBits-1:0] out_NewPC
);

    wire [NBits-1:0] MemoryDataOrALU_wire;
    wire [NBits-1:0] PCOrJump_wire;

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MuxForReadMemoryOrALU
    (
        .Selector(in_MemtoReg),
        .MUX_Data0(in_ALUResult),
        .MUX_Data1(in_MemoryData),
        .MUX_Output(MemoryDataOrALU_wire)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MUX_ForALUMemOrPC
    (
        .Selector(in_ALUMemOrPC),
        .MUX_Data0(MemoryDataOrALU_wire),
        .MUX_Data1(in_PCOrBranch),
        
        .MUX_Output(out_ALUMemOrPCData)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MuxForNextPcOrJump
    (
        .Selector(in_JumpControl),
        .MUX_Data0(in_PCOrBranch),
        .MUX_Data1(in_JumpAddress),

        .MUX_Output(PCOrJump_wire)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MUX_ForRegisterOrPC
    (
        .Selector(in_RegisterOrPC),
        .MUX_Data0(PCOrJump_wire),
        .MUX_Data1(in_ReadData1),
        
        .MUX_Output(out_NewPC)
    );

endmodule // WBBlackBox