/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add
*		sub
*		or
*		and
*		nor
* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/

module ALU 
(
	input [3:0] ALUOperation,
	input [31:0] A,
	input [31:0] B,
	output reg Zero,
	output reg [31:0]ALUResult
);

localparam AND 	= 4'b0000;
localparam OR  	= 4'b0001;
localparam NOR 	= 4'b0010;
localparam ADD 	= 4'b0011;
localparam SUB 	= 4'b0100;
localparam XOR 	= 4'b0101;
localparam WORD	= 4'b0110;
localparam LUI 	= 4'b0111;
localparam SLL	= 4'b1000;
localparam SRL	= 4'b1001;
   
   always @ (A or B or ALUOperation)
     begin
		case (ALUOperation)
			AND:  							//AND: 4'b0000  
				ALUResult= A & B;
			OR:                        //OR:  4'b0001
				ALUResult= A | B;
			NOR:                       //NOR: 4'b0010
				ALUResult= ~(A|B);
			ADD:                       //ADD: 4'b0011
				ALUResult= A + B;
			SUB:                       //SUB: 4'b0100
				ALUResult= A - B;
			XOR:                       //XOR: 4'b0101
				ALUResult= A ^ B;
			LUI:                       //LUI: 4'b0111
				ALUResult= {B, 16'b0};
			WORD:                      //WORD:4'b0110
				ALUResult= (A + B) >> 2;
			SLL:	                     //SLL: 4'b1000
				ALUResult= B << A;
			SRL:                       //SRL: 4'b1001
				ALUResult= B >> A;
		default:
			ALUResult= 0;
		endcase // case(control)
		Zero = (ALUResult==0) ? 1'b1 : 1'b0;
     end // always @ (A or B or control)
endmodule // ALU