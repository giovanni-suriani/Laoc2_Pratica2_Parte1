`timescale 1ps/1ps

module tb_processador;

  reg [15:0] DIN;
  reg [2:0] Opcode;          // Opcode III   
  reg [5:3] Rx;              // Rx (destino/target)
  reg [8:6] Ry;              // Ry (fonte/source)
  wire [8:0] Instrucao; // Instrução completa
  reg Clock, Resetn, Run;
  wire Done;
  wire [15:0] BusWires;
  wire [5:3] Rx_wire;              // campo desti
  wire [8:6] Ry_wire;              // campo fonte

  // Instancia o processador
  processador_multiciclo uut (
                           .DIN(DIN),
                           .Resetn(Resetn),
                           .Clock(Clock),
                           .Run(Run),
                           .Done(Done),
                           .BusWires(BusWires)
                         );

  assign Instrucao = {Opcode, Rx, Ry}; // Instrução completa
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
      // T0 - Instrução mv R0, R1 ,R0 <- R1
      // -----------------------------
      Opcode = 3'b000; // mv
      Rx = 3'b000;     // R0
      Ry = 3'b001;     // R1
      #100 DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
      // Colocando 1 no registrador R1 (Ry)
      uut.R1.Q = 16'd10; // R0 = 1

      cabecalho_teste(1);
      $display("[%0t] instrucao = %3b_%3b_%3b = mv R0 R1 000_000_001", $time, Instrucao[8:6], Instrucao[5:3], Instrucao[2:0]);
      Run = 1;
      meio_teste_1_ciclo;
      #50 Run = 0;
      #600;
      // cabecalho_teste(1);
      // meio_teste;
      $stop;
    end


  task cabecalho_teste(input integer numero_task);
    begin
      $display("--------------------------------------------------");
      $display("[%0t] Teste %0d", $time, numero_task);
      $display("--------------------------------------------------");
    end
  endtask

  integer disp_sinais = 1;
  task meio_teste_1_ciclo;
    begin
      if (disp_sinais)
        $display("[%0t] Clock: %b, Resetn: %b, Run: %b, DIN: %b",$time, Clock, Resetn, Run, DIN);
      $display("[%0t] Barramento: %b, Tempo_Instrucao = %0d",$time, BusWires, uut.Tstep);
      $display("[%0t] Done: %b",$time, Done);
    end
  endtask

endmodule

/* 
clear;vsim -c -do vlog_terminal_tb_proc.do
killmodelsim;vsim -do vlog_wave_tb_proc.do 
alias killmodelsim='ps aux | grep '\''intelFPGA/20.1/'\'' | grep -v grep | awk '\''{print $2}'\'' | xargs kill -9'
*/