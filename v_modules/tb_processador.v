`timescale 1ps/1ps

module tb_processador;

  reg [15:0] DIN;
  reg [2:0] opcode;          // opcode III   
  reg [5:3] Rx;              // Rx (destino/target)
  reg [8:6] Rx;              // Ry (fonte/source)
  reg Clock, Resetn, Run;
  wire Done;
  wire [15:0] BusWires;
  reg [2:0] opcode;          // opcode III
  wire [5:3] Rx;              // campo desti
  wire [8:6] Ry;              // campo fonte

  // Instancia o processador
  processador_multiciclo uut (
                           .DIN(DIN),
                           .Resetn(Resetn),
                           .Clock(Clock),
                           .Run(Run),
                           .Done(Done),
                           .BusWires(BusWires)
                         );

  // Clock gerado a cada 50ps
  always #50 Clock = ~Clock;

  initial
    begin
      // Inicialização
      Clock = 0;
      Resetn = 0;
      Run = 0;
      DIN = 16'b0;

      // -----------------------------
      // T0 - Instrução mv R0, R1
      // -----------------------------
      #100 DIN = 9'b001_000_000; // mvi R0, #D
      Run = 1;
      #100 Run = 0;
      $stop
    end


  task cabecalho_teste(input ingeger numero_task);
    begin
      $display("--------------------------------------------------");
      $display("[%0t] Task %d", numero_task,$time);
      $display("--------------------------------------------------");
    end
  endtask

  task meio_teste;
    begin
      $display("[%0t] Clock: %b, Resetn: %b, Run: %b, DIN: %b", Clock, Resetn, Run, DIN);
      $display("[%0t] Barramento: %b", BusWires);
      $display("[%0t] Done: %b", Done);
    end
  endtask

endmodule
