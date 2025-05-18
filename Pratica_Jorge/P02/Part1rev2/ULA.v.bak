/*
MODULO ULA - Unidade Logica Aritmetica
*/

//INICIO DO MODULO
module ULA(A,B,Opcode,ResultadoULA);
	input 			[15:0]	A;       //Dado A
	input 			[15:0]	B;       //Dado B
	input 			[3:0]		Opcode;	//Opcode da operacao - Vide Opcodes abaixo
			parameter ld   = 4'b0000;	//Operacao de Store
			parameter st   = 4'b0001;	//Operacao de Load
			parameter mvnz = 4'b0010;  //Operacao de "mover" se o registrador for diferente de zero
			parameter mv   = 4'b0011;	//Operacao de "mover" o valor de um registrador para outro
			parameter mvi  = 4'b0100;	//Operacao de "mover" um imediato para um registrador
			parameter add  = 4'b0101;	//Operacao de Soma
			parameter sub  = 4'b0110;	//Operacao de Subtracao
			parameter OR   = 4'b0111;  //Operacao OR - Tirar dúvida com a professora
			parameter slt  = 4'b1000;  //Operacao set less than (menor que)
			parameter sll  = 4'b1001;  //Operacao shift logical left (deslocamento para a esquerda - 11 (3) << 110(6)
			parameter slr  = 4'b1010;	//Operacao shift logical right(deslocamento para a direita  - 110 (6) >> 11(3)
	output 	reg	[15:0]	ResultadoULA;
	
	
	always @(A or B or Opcode) begin
		case (Opcode)
			add : ResultadoULA = A + B;
			sub : ResultadoULA = A - B;
			OR  : ResultadoULA = A + B;
			slt : if(A < B) 
						ResultadoULA =  16'b0000000000000001; 
					else 
						ResultadoULA =  16'b0000000000000000;
			sll : ResultadoULA = A << B;
			slr : ResultadoULA = A >> B;
		endcase
	end
	
//FIM DO MODULO ULA		
endmodule