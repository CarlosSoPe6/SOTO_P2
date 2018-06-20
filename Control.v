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
localparam I_Type_J			= 6'h02;
localparam I_Type_JAL		= 6'h03;
localparam I_Type_BEQ		= 6'h04;
localparam I_Type_BNE		= 6'h05;
localparam I_Type_ADDI		= 6'h08;
localparam I_Type_ORI		= 6'h0d;
localparam I_Type_LUI		= 6'h0f;

localparam Func_Shift_Left	= 6'b00_0000;
localparam Func_Shift_Right	= 6'b00_0010;

reg [11:0] ControlValues;

always@(OP or Function) begin
	case(OP)
		R_Type_Default:
			case (Function)
			  	Func_Shift_Left: 
			  		ControlValues= 12'b11_001_00_00_111;
				Func_Shift_Right: 
			  		ControlValues= 12'b11_001_00_00_111;
			  	default: 
			  		ControlValues= 12'b01_001_00_00_111;
			endcase
		I_Type_ADDI:	ControlValues= 12'b00_101_00_00_100;
		I_Type_ORI:		ControlValues= 12'b00_101_00_00_101;
		I_Type_LUI:		ControlValues= 12'b00_101_00_00_110;
		I_Type_J:		ControlValues= 12'bxx_xxx_xx_xx_xxx;
		I_Type_JAL:		ControlValues= 12'bxx_xxx_xx_xx_xxx;
		I_Type_BEQ:		ControlValues= 12'bxx_xxx_xx_xx_xxx;
		I_Type_BNE:		ControlValues= 12'bxx_xxx_xx_xx_xxx;
		default:
			ControlValues= 12'b000000000000;
	endcase
end	


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
