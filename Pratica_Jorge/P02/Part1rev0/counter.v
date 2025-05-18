/*
MODULO COUNTER
*/

//INICIO DO MODULO counter
module counter(Clear,Clock,Q);
	input 					Clear, Clock;
	output	reg	[2:0]	Q;
	
	initial Q = 3'b000; //Valor Inicial = 0
	
	always @(posedge Clock) begin
		if(Clear)
			Q <= 3'b000;
		else 
			Q <= Q + 1'b1;
	end
	
//FIM DO MODULO counter		
endmodule