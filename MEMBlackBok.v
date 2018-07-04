module MEMBlackBox
#(
	parameter NBits=32
)
(
  
);

    Adder32bits
    Data_Memory_Calculator
    (
        .Data0(ALUResultOut_P3),
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
        .WriteData(ReadData2_wire),
        .Address(Real_Data_Address_wire),
        .MemWrite(MemWrite_wire),
        .MemRead(MemRead_wire),
        .ReadData(MemoryData_wire),
        .clk(clk)
    );

    BranchModule
    BranchController
    (
        .Zero(Zero_wire),
        .BNEControl(BranchNE_wire),
        .BEQControl(BranchEQ_wire),
        .BranchControlSignal(BranchControl_wire)
    );

    Multiplexer2to1
    #(
        .NBits(NBits)
    )
    MuxForNextPcOrBranch
    (
        .Selector(BranchControl_wire),
        .MUX_Output(PCOrBranch_wire),
        .MUX_Data0(PC_4_P3),
        .MUX_Data1(MEM_BranchAddress_wire)
    );

endmodule // MEMBlackBox

    