/*
MODULO REGISTRADORES R
*/

//INICIO DO MODULO registradoresR
module registradoresR(RegEntrada,RIn,Clock,RegSaida);
	input 		[15:0]	RegEntrada;	//16 bits - Entrada do Registrador - Bus do processador
	input 					RIn;			// 1 bits - Sinal de Controle
	input						Clock;		// 1 bits - Clock
	output reg	[15:0]	RegSaida;	//16 bits - Saida do Registrador
	
	//Valor inicial do registrador igual a zero
	initial RegSaida <= 16'b0000000000000000;
	
	always @(posedge Clock) begin //Clock:mudanca pela borda de subida
		if(RIn)							//Se RIn ativa entao
			RegSaida <= RegEntrada;
	end
	
//FIM DO MODULO registradoresR		
endmodule