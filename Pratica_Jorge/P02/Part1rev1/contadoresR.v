/*
MODULO CONTADORES R - Registradores com comportamento de contador (R7)
*/

//INICIO DO MODULO contadoresR
module contadoresR(RegEntrada,RIn,Clear,Clock,IncrPc,RegSaida);
	input 		[15:0]	RegEntrada;	//16 bits - Entrada do Registrador - Bus do processador
	input 					RIn;			// 1 bits - Sinal de Controle
	input						Clear;		// 1 bits - Clear
	input 					Clock;		// 1 bits - Clock
	input						IncrPc;		// 1 bits - Incremento de PC
	output reg	[15:0]	RegSaida;	//16 bits - Saida do Registrador
	
	//Valor inicial do registrador igual a zero
	initial RegSaida <= 16'b0000000000000000;
	
	always @(posedge Clock) begin	//Clock:mudanca pela borda de subida
	   if (RIn)							//Se RIn ativa entao
	      RegSaida <= RegEntrada;
	   else if(IncrPc) 				//Se IncrPc ativa entao
			RegSaida = RegSaida + 1'b1;
	   else if(Clear) 				//Se Clear ativa entao
			RegSaida =  16'b0000000000000000;
	end
	
//FIM DO MODULO contadoresR		
endmodule