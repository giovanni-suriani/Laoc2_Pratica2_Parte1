module Pratica2_Parte1_top_level (
    input  [17:0] SW,     // SW17 = Run, SW15–0 = DIN
    input  [3:0]  KEY,    // KEY0 = Resetn, KEY1 = Clock
    output [7:0] LEDG,     // LEDRG
    output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, // Saídas para displays de 7 segmentos
    output [17:0] LEDR    // LEDR15–0 = BusWires, LEDR17 = Done
  );
  wire Clock;
  wire Resetn;
  wire [15:0] BusWires;
  wire Done;
  wire Run;
  wire [2:0] Tstep;


  // Componentes Do processador
  wire [15:0] Rx_data;
  wire [15:0] Ry_data;


  // Mapeia as saídas para os LEDs
  assign LEDR[15:0] = BusWires;
  assign LEDR[17]   = Run;
  assign Run        = SW[17]; // SW17 indica o início da execução
  assign LEDG[2]    = Done;   // LEDG0 indica se a instrução foi concluída
  assign LEDG[1]    = Resetn;  // LEDG0 indica se a instrução foi concluída
  assign Resetn      = SW[16]; // Reset ativo em nível baixo
  // assign Clock      = SW[15]; // Reset ativo em nível baixo
  assign Clock      = !KEY[3];
  assign LEDG[7]    = Clock;
  // Instancia o processador

  processador_multiciclo u_processador_multiciclo(
      .Resetn   (Resetn   ),
      .Clock    (Clock    ),
      .Run      (Run      ),
      .Done     (Done     ),
      .BusWires (BusWires ),
      .Tstep    (Tstep    ),
      .Rx_data  (Rx_data  ),
      .Ry_data  (Ry_data  )
  );
  

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
  Display D_Tstep(
            .result({2'b00,Tstep}),
            .HEX(HEX6)
          );

  Display D_Imm_data(
            .result({11'b0, SW[4:0]}),
            .HEX(HEX0)
          );

  Display D_Ry_data(
            .result(Ry_data[3:0]),
            .HEX(HEX1)
          );

  Display D_Rx_data(
            .result(Rx_data[3:0]),
            .HEX(HEX2)
          );

  Display D_Opcode(
            .result({1'b0,SW[8:6]}),
            .HEX(HEX3)
          );

  Display D_Ry(
            .result({1'b0,SW[2:0]}),
            .HEX(HEX4)
          );

  Display D_Rx(
            .result({1'b0,SW[5:3]}),
            .HEX(HEX5)
          );


  Display D_Clock(
            .result({3'b000,Clock}),
            .HEX(HEX7)
          );


/* 
comandos para o quartus rodar na placa
cd ~/quartus/bin; ./quartus --64bit
lsusb
sudo chmod 666 /dev/bus/usb/001/010
*/


endmodule
