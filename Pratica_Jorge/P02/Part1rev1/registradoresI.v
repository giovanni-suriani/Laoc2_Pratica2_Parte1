/*
MODULO REGISTRADORES I - Registradores de Instrucao
*/

//INICIO DO MODULO registradoresI
module registradoresI(InstEntrada,IRIn,Clock,InstSaida);						
	input 		[9:0]	InstEntrada;	//10 bits - Instrucao de Entrada
	input 				IRIn;				//1  bits - Sinal de Controle
	input					Clock;			//1  bits - Clock
	output reg 	[9:0]	InstSaida;		//10 bits - Instrucao de Saida
	
	always @(posedge Clock) begin		//Clock:mudanca pela borda de subida
		if(IRIn)								//Se IRIn ativa entao
			InstSaida <= InstEntrada;
	end
	
//FIM DO MODULO registradoresI		
endmodule