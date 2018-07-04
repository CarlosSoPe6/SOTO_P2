module EX_MEM_PipelineRegister(
    input clk,
    input reset,
    input in_Zero,
    input in_ALUResult,
    input in_ReadData2,
    input in_JumpAddress,
    input in_BranchAddress,
    input in_PC_4,

    output out_Zero,
    output out_ALUResult,
    output out_ReadData2,
    output out_JumpAddress,
    output out_BranchAddress,
    output out_PC_4
);
    reg Zero;
    reg ALUResult;
    reg ReadData2;
    reg JumpAddress;
    reg BranchAddress;
    reg PC_4;

    always @(negedge reset or negedge clk) begin
      if(reset) 
      begin
        Zero <= 0;
        ALUResult <= 0;
        ReadData2 <= 0;
        JumpAddress <= 0;
        BranchAddress <= 0;
        PC_4 <= 0;
      end 
      else 
      begin
        Zero <= in_Zero;
        ALUResult <= in_ALUResult;
        ReadData2 <= in_ReadData2;
        JumpAddress <= in_JumpAddress;
        BranchAddress <= in_BranchAddress;
        PC_4 <= in_PC_4;
      end
    end

    assign out_Zero = Zero;
    assign out_ALUResult = ALUResult;
    assign out_ReadData2 = ReadData2;
    assign out_JumpAddress = JumpAddress;
    assign out_BranchAddress = BranchAddress;
    assign out_PC_4 = PC_4;

endmodule // EX_MEM_PipelineRegister