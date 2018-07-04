
module IF_ID_PipelineRegister
#(
	parameter NBits=32
	
)
(
    input clk,
    input reset,
    input [NBits-1:0] in_PC_4,
    input [NBits-1:0] in_Instruction,
    
    output [NBits-1:0] out_PC_4,
    output [NBits-1:0] out_Instruction
);

    reg PC_4;
    reg Instruction;
    

    always @(negedge reset or negedge clk) 
    begin
        if(reset)
        begin
            PC_4 <= 0;
            Instruction <= 0;
        end
        else
        begin
            PC_4 <= in_PC_4;
            Instruction <= in_Instruction;
        end
    end

    assign out_PC_4 = PC_4;
    assign out_Instruction = Instruction;
    
endmodule 