
module IF_ID_PipelineRegister
#(
	parameter NBits=32
	
)
(
    input clk,
    input reset,
    input Flush,

    input RegWrite,
    input [NBits-1:0] in_PC_4,
    input [NBits-1:0] in_Instruction,
    
    output [NBits-1:0] out_PC_4,
    output [NBits-1:0] out_Instruction
);

    reg [NBits-1:0] PC_4;
    reg [NBits-1:0] Instruction;
    
    always @(reset or clk) 
    begin
        if(reset==0 || (Flush == 1 && clk == 1))
        begin
            PC_4 <= 0;
            Instruction <= 0;
        end
        else if(RegWrite == 1 && clk == 0)
        begin
            PC_4 <= in_PC_4;
            Instruction <= in_Instruction;
        end
    end

    assign out_PC_4 = PC_4;
    assign out_Instruction = Instruction;
    
endmodule 