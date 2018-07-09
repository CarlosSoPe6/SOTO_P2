
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
	  
	else if(EX_MEM_RegWrite 
            && (EX_MEM_RegisterRd != 0)  
				&& (EX_MEM_RegisterRd == ID_EX_RegisterRt))
	  ForwardB = 2'b10;
	else if(MEM_WB_RegWrite 
           && (MEM_WB_RegisterRd != 0)  
			  && (EX_MEM_RegisterRd != ID_EX_RegisterRt)
			  && (MEM_WB_RegisterRd == ID_EX_RegisterRt))
	  ForwardB = 2'b01;
   else 
			begin
			ForwardA = 2'b00;
			ForwardB = 2'b00;
			end
end

/*
assign ForwardA =    (EX_MEM_RegWrite 
                 and (EX_MEM_RegisterRd != 0)  
					  and (EX_MEM_RegisterRd = ID_EX_RegisterRs))? 2'b10:
                     
							(MEM_WB_RegWrite 
                 and (MEM_WB_RegisterRd != 0)  
					  and (EX_MEM_RegisterRd != ID_EX_RegisterRs))
					  and (MEM_WB_RegisterRd = ID_EX_RegisterRs))? 2'b01:
					  
					                                               2'b00;
						
assign ForwardB =    (EX_MEM_RegWrite 
                 and (EX_MEM_RegisterRd != 0)  
					  and (EX_MEM_RegisterRd = ID_EX_RegisterRt))? 2'b10:
                     
							(MEM_WB_RegWrite 
                 and (MEM_WB_RegisterRd != 0)  
					  and (EX_MEM_RegisterRd != ID_EX_RegisterRt))
					  and (MEM_WB_RegisterRd = ID_EX_RegisterRt))? 2'b01:
					  
					                                               2'b00;
*/
endmodule 