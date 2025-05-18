/*
MODULO REGISTRADORES R
*/

//INICIO DO MODULO registradoresR
module registradoresR(R,RIn,Clock,Q);
	parameter 				n = 16;
	input 		[n-1:0]	R;
	input 					RIn,Clock;
	output reg	[n-1:0]	Q;
	
	initial Q <= 16'b0000000000000000;
	always @(posedge Clock) begin
		if(RIn)
			Q <= R;
	end
	
//FIM DO MODULO registradoresR		
endmodule