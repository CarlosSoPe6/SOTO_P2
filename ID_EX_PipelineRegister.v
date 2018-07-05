module ID_EX_PipelineRegister
#(
	parameter NBits=32
	
)
(
    input clk,
    input reset,
	 input in_ShamtSelector,
	 input in_ALUSrc,
	 input [2:0] in_ALUOp,
	 input [NBits-1:0] in_PC_4,
    input [NBits-1:0] in_Instruction,
	 input [NBits-1:0] in_ReadData1,
	 input [NBits-1:0] in_ReadData2,
	 input [NBits-1:0] in_ShamtExtend,
	 input [NBits-1:0] in_InmmediateExtend,
    
	 output out_ShamtSelector,
	 output out_ALUSrc,
	 output [2:0] out_ALUOp,
	 output [NBits-1:0] out_PC_4,
    output [NBits-1:0] out_Instruction,
    output [NBits-1:0] out_ReadData1,
	 output [NBits-1:0] out_ReadData2,
	 output [NBits-1:0] out_ShamtExtend,
	 output [NBits-1:0] out_InmmediateExtend
);

    reg ShamtSelector;
	 reg ALUSrc;
	 reg [2:0] ALUOp;
	 reg [NBits-1:0] PC_4;
    reg [NBits-1:0] Instruction;
	 reg [NBits-1:0] ReadData1;
	 reg [NBits-1:0] ReadData2;
	 reg [NBits-1:0] ShamtExtend;
	 reg [NBits-1:0] InmmediateExtend;
    

    always @(negedge reset or negedge clk) 
    begin
        if(reset)
        begin
             ShamtSelector<= 0;
             ALUSrc<= 0;
				 ALUOp<=0;
				 PC_4<=0;
				 Instruction<=0;
				 ReadData1<=0;
				 ReadData2<=0;
				 ShamtExtend<=0;
				 InmmediateExtend<=0;
        end
        else
        begin
             ShamtSelector<= in_ShamtSelector;
             ALUSrc<= in_ALUSrc;
				 ALUOp<=in_ALUOp;
				 PC_4<=in_PC_4;
				 Instruction<=in_Instruction;
				 ReadData1<=in_ReadData1;
				 ReadData2<=in_ReadData2;
				 ShamtExtend<=in_ShamtExtend;
				 InmmediateExtend<=in_InmmediateExtend;
        end
    end

     assign out_ShamtSelector<=ShamtSelector;
	  assign out_ALUSrc<=ALUSrc;
	  assign out_ALUOp<=ALUOp;
	  assign out_PC_4<=PC_4;
	  assign out_Instruction<=Instruction;
	  assign out_ReadData1<=ReadData1;
	  assign out_ReadData2<=ReadData2;
	  assign out_ShamtExtend<=ShamtExtend;
	  assign out_InmmediateExtend<=InmmediateExtend;
	  
endmodule 