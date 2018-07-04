module MEM_WB_PipelineRegister(
    input clk,
    input reset,
    input in_JumpAddress,
    input in_MemoryData,
    input in_PCOrBranch,
    input in_CtrlALUOrMem,
    input in_CtrlJump,
    input in_CtrlRegisterOrPC,
    input in_CtrlALUMemOrPC,
    output out_JumpAddress,
    output out_MemoryData,
    output out_PCOrBranch,
    output out_CtrlALUOrMem,
    output out_CtrlJump,
    output out_CtrlRegisterOrPC,
    output out_CtrlALUMemOrPC
);

    reg JumpAddress;
    reg MemoryData;
    reg PCOrBranch;
    reg CtrlALUOrMem;
    reg CtrlJump;
    reg CtrlRegisterOrPC;
    reg CtrlALUMemOrPc;

    always @(negedge reset or negedge clk) 
    begin
        if(reset)
        begin
            JumpAddress <= 0;
            MemoryData <= 0;
            PCOrBranch <= 0;
            CtrlALUOrMem <= 0;
            CtrlJump <= 0;
            CtrlRegisterOrPC <= 0;
            CtrlALUMemOrPc <= 0;
        end
        else
        begin
            JumpAddress <= in_JumpAddress;
            MemoryData <= in_MemoryData;
            PCOrBranch <= in_PCOrBranch;
            CtrlALUOrMem <= in_CtrlALUOrMem;
            CtrlJump <= in_CtrlJump;
            CtrlRegisterOrPC <= in_CtrlRegisterOrPC;
            CtrlALUMemOrPc <= in_CtrlALUMemOrPC;
        end
    end

    assign out_JumpAddress = JumpAddress;
    assign out_MemoryData = MemoryData;
    assign out_PCOrBranch = PCOrBranch;
    assign out_CtrlALUOrMem = CtrlALUOrMem;
    assign out_CtrlJump = CtrlJump;
    assign out_CtrlRegisterOrPC = CtrlRegisterOrPC;
    assign out_CtrlALUMemOrPC = CtrlALUMemOrPc;
    
endmodule // MEM_WB_PipelineRegister