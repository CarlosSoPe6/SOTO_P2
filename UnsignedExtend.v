/******************************************************************
* Description
*	This module performes a extend operation for shamt
* Version:
*	1.0
* Author:
*	Carlos Soto Pérez
* email:
*	carlos348@outlook.com 
* Date:
*	20/06/2018
******************************************************************/
module UnsignedExtend
(   
    input [4:0]  DataInput,
    output[31:0] UnsignedExtendOutput
);

assign  UnsignedExtendOutput = {26'b0,DataInput};

endmodule // UnsignedExtend
