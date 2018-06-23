/******************************************************************
* Description
* This module performes the control for the mux branch 
* Version:
*	1.0
* Author:
*	Carlos Soto Pérez
* email:
*	carlos348@outlook.com
* Date:
*	22/06/2018
******************************************************************/
module BranchModule(
    input BEQControl,
    input BNEControl,
    input Zero,
    
    output BranchControlSignal  
);

assign BranchControlSignal = (BEQControl & Zero) | (BNEControl & ~Zero);  

endmodule // BranchModule
