/*
MODULO PARA O MULTIPLEXADOR
*/

//INICIO DO MODULO mux
module mux(DIN,R0Saida,R1Saida,R2Saida,R3Saida,R4Saida,R5Saida,R6Saida,R7Saida,GSaida,
           ROut,GOut,DINOut,MuxSaida);
	input 			[15:0] 	DIN;		//16 bits - Entrada DIN		
	input 			[15:0] 	R0Saida;	//16 bits - Entrada correspondente a saida do registrador R0
	input 			[15:0] 	R1Saida;	//16 bits - Entrada correspondente a saida do registrador R1
	input 			[15:0] 	R2Saida;	//16 bits - Entrada correspondente a saida do registrador R2
	input 			[15:0] 	R3Saida;	//16 bits - Entrada correspondente a saida do registrador R3
	input 			[15:0] 	R4Saida;	//16 bits - Entrada correspondente a saida do registrador R4
	input 			[15:0] 	R5Saida;	//16 bits - Entrada correspondente a saida do registrador R5
	input 			[15:0] 	R6Saida;	//16 bits - Entrada correspondente a saida do registrador R6
	input 			[15:0] 	R7Saida;	//16 bits - Entrada correspondente a saida do registrador R7
	input 			[15:0] 	GSaida;	//16 bits - Entrada correspondente a saida do registrador G
	input 			[7:0]		ROut;		// 8 bits - Sinal de Controle para os registradores R
									// ROut = 00000001 -> R0Out = ativo (1) e Demais R = inativos (0)
									// ROut = 00000010 -> R1Out = ativo (1) e Demais R = inativos (0)
									// ROut = 00000100 -> R2Out = ativo (1) e Demais R = inativos (0)
									// ROut = 00001000 -> R3Out = ativo (1) e Demais R = inativos (0)
									// ROut = 00010000 -> R4Out = ativo (1) e Demais R = inativos (0)
									// ROut = 00100000 -> R5Out = ativo (1) e Demais R = inativos (0)
									// ROut = 01000000 -> R6Out = ativo (1) e Demais R = inativos (0)
									// ROut = 10000000 -> R7Out = ativo (1) e Demais R = inativos (0)											
	input 						GOut;		// 1 bits - Sinal de Controle para o registrador G
	input 						DINOut;	// 1 bits - Sinal de Controle para a entrada DIN
	output	reg	[15:0]	MuxSaida;//16 bits - Saida do Mux
	
	always @(ROut or GOut or DINOut) begin
		if(DINOut) MuxSaida = DIN;
			else if(GOut) MuxSaida = GSaida;
				else begin
					case (ROut) 
						8'b00000001: MuxSaida = R0Saida;
						8'b00000010: MuxSaida = R1Saida;
						8'b00000100: MuxSaida = R2Saida;
						8'b00001000: MuxSaida = R3Saida;
						8'b00010000: MuxSaida = R4Saida;
						8'b00100000: MuxSaida = R5Saida;
						8'b01000000: MuxSaida = R6Saida;
						8'b10000000: MuxSaida = R7Saida;
					endcase
				end
	end
	
//FIM DO MODULO mux		
endmodule