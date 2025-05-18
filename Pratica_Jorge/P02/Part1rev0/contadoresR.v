/*
MODULO CONTADORES R - Registradores com comportamento de contador (R7)
*/

//INICIO DO MODULO contadoresR
module contadoresR(R,RIn,Clear,Clock,Prox,Q);
	parameter 		n = 16;
	input 			[n-1:0] R;
	input 			RIn,Clock,Clear,Prox;
	output 	reg	[n-1:0]Q;
	
	initial Q = 16'b0;
	always @(posedge Clock) begin
	   if (RIn)
	      Q <= R;
	   else if(Prox) Q = Q + 1'b1;
	   else if(Clear) Q =  16'b0000000000000000;
	end
	
//FIM DO MODULO contadoresR		
endmodule