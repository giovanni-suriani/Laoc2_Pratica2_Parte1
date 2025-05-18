/*
MODULO REGISTRADORES I - Registradores de Instrucao
*/

//INICIO DO MODULO registradoresI
module registradoresI(InstEntrada,IRIn,Clock,InstSaida);
	parameter 				n = 10;			//parametro de flexibilizacao de bits						
	input 		[n-1:0]	InstEntrada;	//10 bits - Instrucao de Entrada
	input 					IRIn;				//1  bits - Sinal de Controle
	input						Clock;			//1  bits - Clock
	output reg 	[n-1:0]	InstSaida;		//10 bits - Instrucao de Saida
	
	always @(posedge Clock) begin		//Clock:mudanca pela borda de subida
		if(IRIn)								//Se IRIn ativa entao
			InstSaida <= InstEntrada;
	end
	
//FIM DO MODULO registradoresI		
endmodule