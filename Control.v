/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module Control
(
	input [5:0]OP,
	input [5:0]Function,
	
	output ALUMemOrPC,
	output RegisterOrPC,
	output ShamtSelector,
	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output [2:0]ALUOp
);

localparam R_Type_Default	= 0;
localparam J_Type_J			= 6'h02;
localparam J_Type_JAL		= 6'h03;
localparam I_Type_BEQ		= 6'h04;
localparam I_Type_BNE		= 6'h05;
localparam I_Type_ADDI		= 6'h08;
localparam I_Type_ORI		= 6'h0d;
localparam I_Type_LUI		= 6'h0f;


localparam Func_Shift_Left	= 6'b00_0000;
localparam Func_Shift_Right	= 6'b00_0010;
localparam Func_Jump_Register = 6'b00_1000;

reg [13:0] ControlValues;

always@(OP or Function) begin
	case(OP)
		R_Type_Default:
			case (Function)
			  	Func_Shift_Left: 
			  		ControlValues= 14'b00_11_001_00_00_111;
				Func_Shift_Right: 
			  		ControlValues= 14'b00_11_001_00_00_111;
				Func_Jump_Register:
			      ControlValues= 14'b01_11_001_00_00_111;	
			  	default: 
			  		ControlValues= 14'b00_01_001_00_00_111;
			endcase
		I_Type_ADDI:	ControlValues= 14'b00_00_101_00_00_100;
		I_Type_ORI:		ControlValues= 14'b00_00_101_00_00_101;
		I_Type_LUI:		ControlValues= 14'b00_00_101_00_00_110;
		J_Type_J:		ControlValues= 14'b00_10_000_00_00_000;
		J_Type_JAL:		ControlValues= 14'b10_10_000_00_00_000;
		I_Type_BEQ:		ControlValues= 14'b00_00_000_00_01_000;
		I_Type_BNE:		ControlValues= 14'b00_00_000_00_10_000;
		default:
			ControlValues= 14'b00000000000000;
	endcase
end	


assign ALUMemOrPC = ControlValues[13];	
assign RegisterOrPC = ControlValues[12];	
assign ShamtSelector = ControlValues[11];	
assign RegDst = ControlValues[10];
assign ALUSrc = ControlValues[9];
assign MemtoReg = ControlValues[8];
assign RegWrite = ControlValues[7];
assign MemRead = ControlValues[6];
assign MemWrite = ControlValues[5];
assign BranchNE = ControlValues[4];
assign BranchEQ = ControlValues[3];
assign ALUOp = ControlValues[2:0];	

endmodule
