/*
MODULO COUNTER
*/

//INICIO DO MODULO counter
module counter(Clear,Clock,CounterSaida);
	input						Clear;			// 1 bits - Clear
	input 					Clock;			// 1 bits - Clock
	output	reg	[2:0]	CounterSaida;	// 3 bits - Saida do Contador
	
	//Valor inicial do contador igual a zero
	initial CounterSaida = 3'b000;
	
	always @(posedge Clock) begin	//Clock:mudanca pela borda de subida
		if(Clear)						//Se Clear ativa entao
			CounterSaida <= 3'b000;
		else 								//Se Clear inativo entao
			CounterSaida <= CounterSaida + 1'b1;
	end
	
//FIM DO MODULO counter		
endmodule