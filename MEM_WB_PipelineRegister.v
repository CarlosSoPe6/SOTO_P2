module MEM_WB_PipelineRegister(
    input clk,
    input reset,
    input in_MemoryData,
    input in_PCOrBranch,
    input in_CtrlALUOrMem,
    input in_CtrlJump,

    output out_MemoryData,
    output out_PCOrBranch,
    output out_CtrlALUOrMem,
    output out_CtrlJump
);

    reg MemoryData;
    reg PCOrBranch;

    always @(negedge reset or negedge clk) 
    begin
        if(reset)
        begin

        end
        else
        begin
            
        end
    end
endmodule // MEM_WB_PipelineRegister