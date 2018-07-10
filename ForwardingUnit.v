
module ForwardingUnit(
	input EX_MEM_RegWrite,
	input MEM_WB_RegWrite,
	input [4:0] ID_EX_RegisterRs,
	input [4:0] ID_EX_RegisterRt,
	input [4:0] EX_MEM_RegisterRd,
	input [4:0] MEM_WB_RegisterRd,
	
	
	output reg [1:0] ForwardA,
	output reg [1:0] ForwardB

);

always @*
begin 

	if(EX_MEM_RegWrite 
     && (EX_MEM_RegisterRd != 0)  
	  && (EX_MEM_RegisterRd == ID_EX_RegisterRs)) 
	  ForwardA = 2'b10;
	  
	else if(MEM_WB_RegWrite 
           && (MEM_WB_RegisterRd != 0)  
			  && (EX_MEM_RegisterRd != ID_EX_RegisterRs)
			  && (MEM_WB_RegisterRd == ID_EX_RegisterRs))  
	  ForwardA = 2'b01;
	  
   else 
	  ForwardA = 2'b00;
		
end


always @*
begin 

	if(EX_MEM_RegWrite 
            && (EX_MEM_RegisterRd != 0)  
				&& (EX_MEM_RegisterRd == ID_EX_RegisterRt))
	  ForwardB = 2'b10;
	  
	else if(MEM_WB_RegWrite 
           && (MEM_WB_RegisterRd != 0)  
			  && (EX_MEM_RegisterRd != ID_EX_RegisterRt)
			  && (MEM_WB_RegisterRd == ID_EX_RegisterRt))
	  ForwardB = 2'b01;
	  
   else 
	  ForwardB = 2'b00;
			
end

endmodule 