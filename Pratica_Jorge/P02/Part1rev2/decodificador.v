/*
MODULO DECODIFICADOR DO DISPLAY DE 7 SEGMENTOS 

0 = ligado / 1 = desligado
			a
		f		b
			g	
		e		c
			d
*/

//INICIO DO MODULO decodificador
module decodificador (Entrada,DISPLAY); 

	input			[3:0]	Entrada;	//Entrada dos dados
	
	output reg 	[0:6]DISPLAY;	
	
	always@(*)
	begin
		case(Entrada)

								// abcdefg
		4'b0000: DISPLAY= 7'b0000001;//0
		4'b0001: DISPLAY= 7'b1001111;//1 
		4'b0010: DISPLAY= 7'b0010010;//2
		4'b0011: DISPLAY= 7'b0000110;//3
		4'b0100: DISPLAY= 7'b1001100;//4
		4'b0101: DISPLAY= 7'b0100100;//5
		4'b0110: DISPLAY= 7'b0100000;//6
		4'b0111: DISPLAY= 7'b0001101;//7
		4'b1000: DISPLAY= 7'b0000000;//8
		4'b1001: DISPLAY= 7'b0000100;//9
		4'b1010: DISPLAY= 7'b0001000;//A
		4'b1011: DISPLAY= 7'b1100000;//B
		4'b1100: DISPLAY= 7'b0110001;//C
		4'b1101: DISPLAY= 7'b1000010;//D
		4'b1110: DISPLAY= 7'b0110000;//E
		4'b1111: DISPLAY= 7'b0111000;//F
		endcase
	end
	
//FIM DO MODULO decodificador		
endmodule