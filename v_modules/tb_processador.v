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

  integer counter_clock_cycle = 0;
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
      // teste_mv_R0_R1;
      Opcode = 3'b001; // mvi R0 5
      Rx = 3'b000;     // R0
      Ry = 3'b001;     // R1
      uut.R0.Q = 16'd11; // R0 = 11
      uut.R1.Q = 16'd10; // R1 = 10
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
      cabecalho_teste(2);
      #10Run = 1; // Agendado ja no inicio do ciclo
      $display("[%0t] instrucao = %3b_%3b_%3b = mv R0 R1 000_000_001", $time, Instrucao[8:6], Instrucao[5:3], Instrucao[2:0]);
      meio_teste_1_ciclo;
      #500;
      // cabecalho_teste(1);
      // meio_teste;
      $stop;
    end

  always @(posedge Clock)
    begin
      counter_clock_cycle = counter_clock_cycle + 1;
      case (counter_clock_cycle)
        1: $display("[%0t] Counter_CLock_Cycle ",$time);
      endcase
      
    end


  task teste_mv_R0_R1;
    begin
      Opcode = 3'b000; // mv
      Rx = 3'b000;     // R0
      Ry = 3'b001;     // R1
      uut.R0.Q = 16'd11; // R0 = 11
      uut.R1.Q = 16'd10; // R1 = 10
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask

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
1 Ciclo em verilog
1. Avaliacao de condicoes, always, if,  e sinais agendados ( PROIBIDO USAR, ex: #2, se nao nao funciona FPGA)...
2. Blocking e Non Blocking, (SO use BLOCKING em logica dentro dos blocos),
3. Atribuicao dos Non Blocking Variaveis externas, sempre usar Non Blocking

clear;vsim -c -do vlog_terminal_tb_proc.do
killmodelsim;vsim -do vlog_wave_tb_proc.do 
alias killmodelsim='ps aux | grep '\''intelFPGA/20.1/'\'' | grep -v grep | awk '\''{print $2}'\'' | xargs kill -9'
*/