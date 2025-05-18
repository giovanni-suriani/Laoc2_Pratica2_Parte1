/*
MODULO REGISTRADORES I - Registradores de Instrucao
*/

//INICIO DO MODULO registradoresI
module registradoresI(R,IRIn,Clock,IR);						
	parameter n = 10;
	input [n-1:0]R;
	input IRIn,Clock;
	output reg [n-1:0]IR;
	
	always @(posedge Clock) begin
		if(IRIn)
			IR <= R;
	end
	
//FIM DO MODULO registradoresI		
endmodule