/*
MODULO TESTE 
*/

//INICIO DO MODULO
module ProcessadorMulticiclo(SW,KEY,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7);
	input		[17:0]	SW;
								//SW [17]   - Run
								//SW [16]   - ND
								//SW [15:0] - DIN
								       //SW / DIN [2:0]   - Registrador Ry
										 //SW / DIN [5:3]   - Registrador Rx
								       //SW / DIN [9:6]   - Escolha da instrução 
								       //SW / DIN [15:10] - ND
								
	input		[3:0]		KEY;
								//KEY [0] - Resetn
								//KEY [1] - Clock
								//KEY	[2] - ND
								//KEY [3] - ND
				
	output 	[17:0]	LEDR;
								//LEDR [17]   - Done
								//LEDR [15:0] - BusWires[15:0]
								//LEDR [15:0] - AddressOut[15:0]
				
	output	[8:0]		LEDG;
								//LEDG [0] - Write
	
	output	[0:6]		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	
	wire		[15:0]	MemOut;	//Saida da memoria
	wire 					Done;
	wire 		[15:0]	BusWires;
	wire 					Write;
	wire 		[15:0]	AddressOut;	
	wire 		[15:0]	DOUT;							
	wire 		[2:0]		Tstep_Q;
		
	//Instanciando Processador
   //module Processador   (DIN,    Resetn, Clock,  Run,    Done, BusWires, Write, AddressOut, DOUT, Tstep_Q);
	Processador processador(MemOut, KEY[0], KEY[1], SW[17], Done, BusWires, Write, AddressOut, DOUT, Tstep_Q);
	
	//Instanciando Memoria
	//module MemLPM (address,         clock,  data, wren,  q);
	MemLPM memoria  (AddressOut[4:0], KEY[1], DOUT, Write, MemOut);
	
	//Atribuindo os LED's
	assign LEDR[17] 	= Done;
	assign LEDR[15:0] = BusWires[15:0];
	assign LEDG[0] 	= Write;

	//Definindo os Display's
	//           ND     I   Rx  Ry 
	// MemOut = 000000 0000 000 000
	//Mostrando detalhes da instrucao
	decodificador Display3_DIN (MemOut[15:10],HEX3); //Dado de entrada DIN
	decodificador Display2_DIN (MemOut[9:6]  ,HEX2); //Dado de entrada DIN
	decodificador Display1_DIN (MemOut[5:3]  ,HEX1); //Dado de entrada DIN	
	decodificador Display0_DIN (MemOut[2:0]  ,HEX0); //Dado de entrada DIN

	//Mostrando o endereco de memoria
	decodificador Display5_AddressOut (AddressOut[7:4],HEX5); //Endereco da Memoria
	decodificador Display4_AddressOut (AddressOut[3:0],HEX4); //Endereco da Memoria
	
	//Mostrando o ciclo do clock
	decodificador Display6_Tstep_Q ({1'b0,Tstep_Q[2:0]},HEX6);
	
	//Mostrando zero
	decodificador Display7_BusWires (BusWires[15:12],HEX7);

//FIM DO MODULO
endmodule