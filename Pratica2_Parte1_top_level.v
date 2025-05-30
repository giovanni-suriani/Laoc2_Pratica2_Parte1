module Pratica2_Parte1_top_level (
    input  [17:0] SW,     // SW17 = Run, SW15–0 = DIN
    input  [3:0]  KEY,    // KEY0 = Resetn, KEY1 = Clock
	 output [7:0] LEDG,     // LEDRG
	 output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, // Saídas para displays de 7 segmentos
    output [17:0] LEDR    // LEDR15–0 = BusWires, LEDR17 = Done
);
	 wire Clock;
    wire [15:0] BusWires;
    wire Done;
	 
	 
	 // Componentes Do processador
	 wire [15:0] Rx_data;
	 wire [15:0] Ry_data;
	 
	 
	 // Mapeia as saídas para os LEDs
    assign LEDR[15:0] = BusWires;
    assign LEDR[17]   = 0;
	 assign Clock      = !KEY[3];
	 assign LEDG[7]    = Clock;
	 // Instancia o processador
	 
		/*processador_multiciclo proc (
        .DIN(SW[15:0]),       // Dados de entrada
        .Resetn(KEY[0]),      // Reset ativo em nível baixo
        .Clock(Clock),       // Clock manual via botão
        .Run(SW[17]),         // Sinal de início via chave
        .Done(Done),          // Indica fim da instrução
        .BusWires(BusWires)   // Saída no barramento
		);*/
		/*
		Display D0(
			 .result(Rx_data), // Sinal mem_write
			 .HEX(HEX0)
		);
		
		Display D1(
			 .result(Ry_data), 
			 .HEX(HEX1)
		);
		*/
		
		Display D_Rx_data(
			 .result(Rx_data[3:0]), 
			 .HEX(HEX2)
		);

		Display D_Opcode(
			 .result({1'b0,SW[8:6]}), 
			 .HEX(HEX3)
		);
		
		Display D_Clock(
			 .result({3'b000,Clock}), 
			 .HEX(HEX7)
		);
		
		
		// Opcode
		// Imediato
		// Rx
		// Ry
   

endmodule