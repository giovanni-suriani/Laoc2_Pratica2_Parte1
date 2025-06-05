`timescale 1ps/1ps

module tb_processador;

  reg [15:0] DIN;
  reg [2:0] Opcode;          // Opcode III
  reg [5:3] Rx;              // Rx (destino/target)
  reg [8:6] Ry;              // Ry (fonte/source)
  wire [8:0] Instrucao; // Instrução completa
  reg Clock, Resetn, Run;
  wire Done;
  wire [2:0] Tstep; // Sinal de Tstep
  wire [15:0] BusWires;
  wire [15:0] Rx_data, Ry_data; // Dados dos registradores Rx e Ry

  // Instancia o processador

  processador_multiciclo uut (
                           .Resetn   (Resetn   ),
                           .Clock    (Clock    ),
                           .Run      (Run      ),
                           .Done     (Done     ),
                           .BusWires (BusWires ),
                           .Tstep    (Tstep    ),
                           .Rx_data  (Rx_data  ),
                           .Ry_data  (Ry_data  )
                         );



  assign Instrucao = uut.Instrucao; // Instrução completa
  // Clock gerado a cada 50ps


  integer detalhado = 1;
  always #50 Clock = ~Clock;



  integer mostra_teste1 = 1;
  integer mostra_teste2 = 1;
  integer mostra_teste3 = 1;
  integer mostra_teste4 = 1;
  integer mostra_teste5 = 1;
  integer mostra_teste6 = 1;
  integer mostra_teste7 = 1;
  integer mostra_teste8 = 0;
  integer mostra_teste9 = 0;
  integer mostra_teste10 = 1;
  integer mostra_teste11 = 0;

  initial
    begin
      // Inicialização
      Clock = 0;
      Resetn = 1;
      Run = 0;
      DIN = 16'b0;
      // Reset do processador

      // ------------------------------
      // T0 - Resetn dos registradores e sinais
      // ------------------------------
      // @(posedge Clock);
      // #1;
      @(posedge Clock);
      #1;
      $display("[%0t] Teste Resetn (mux, registradores, e outros sinais)",$time);
      $display("[%0t] BusWires = %0d, DIN = %0d, Tstep = %0d",$time, BusWires, uut.DIN, uut.Tstep);
      $display("[%0t] R1 = %0d R2 = %0d, .. R6 = %0d R7 = %0b",$time, uut.R1.Q, uut.R2.Q, uut.R6.Q, uut.R7.Q);
      $display("[%0t] IncrPc=%0d W_D=%0d ADDRin=%0d DOUTin=%0d",
               $time, uut.IncrPc, uut.W_D, uut.ADDRin, uut.DOUTin);
      $display("[%0t] Run=%0d Resetn=%0d Clear=%0d GRout=%0d",
               $time, uut.Run, uut.Resetn, uut.Clear, uut.GRout);
      $display("[%0t] IRin=%0d Rin=%b Rout=%b Ain=%0d",
               $time, uut.IRin, uut.Rin, uut.Rout, uut.Ain);
      $display("[%0t] Gin=%0d Gout=%0d Ulaop=%b DINout=%h",
               $time, uut.Gin, uut.Gout, uut.Ulaop, uut.DINout);
      $display("[%0t] Done=%0d",
               $time, uut.Done);
      $display("[%0t] Teste 0 Finalizado",$time);
      $display("--------------------------------------------------");


      Run = 1; // Ativa o Run
      Resetn = 0; // Desativa o reset

      // -----------------------------
      // T1 - mvi R2 1
      // -----------------------------
      if (mostra_teste1)
        begin
          $display("[%0t] Teste 1 instrucao mvi R2 1, R2 com o valor inicial %0d, Tstep = %0d", $time, uut.R2.Q, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R2 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R2.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0001010000, R2 = 1 Tstep = 4",$time);
          $display("[%0t] Teste mvi R2 1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T2 - mvi R4 10
      // -----------------------------
      if (mostra_teste2)
        begin
          $display("[%0t] Teste 2 instrucao mvi R4 10, R4 com o valor inicial %0d, Tstep = %0d", $time, uut.R4.Q, uut.Tstep);
          @(posedge Clock);
          #451;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R4 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0001100000, R4 = 10 Tstep = 4",$time);
          $display("[%0t] Teste mvi R4 10 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T3 - mvi R0 4
      // -----------------------------
      if (mostra_teste3)
        begin
          $display("[%0t] Teste 3 instrucao mvi R0 4, R4 com o valor inicial %0d, Tstep = %0d", $time, uut.R0.Q, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R0 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0001000000, R0 = 4 Tstep = 4",$time);
          $display("[%0t] Teste mvi R0 4 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T4 - MV R5 R0
      // -----------------------------
      if (mostra_teste4)
        begin
          $display("[%0t] Teste 4 instrucao mv R5, R0 R5 inicial = %0d, R0 inicial = %0d, Tstep = %0d", $time, uut.R5.Q, uut.R0.Q, uut.Tstep);
          @(posedge Clock);
          #451;
          $display("[%0t] Ciclo 4 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R0 = %0d, R5 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R5.Q, uut.R0.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0000101000, R0 = 4  R5 = 4 Tstep = 3",$time);
          $display("[%0t] Teste mv R0 R5 1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T5 - mvnz R3 R2
      // -----------------------------
      if (mostra_teste5)
        begin
          $display("[%0t] Teste 5 instrucao mvnz R3, R3 inicial = %0d, R2 inicial = %0d, Tstep = %0d", $time, uut.R3.Q, uut.R2.Q, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 4 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R3 = %0d, R2 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R3.Q, uut.R2.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0010011010, R3 = 0  R2 = 1 Tstep = 3",$time);
          $display("[%0t] Teste mvnz R3 R2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T6- ADD R4, R2
      // -----------------------------
      if (mostra_teste6)
        begin
          $display("[%0t] Teste 6 instrucao add R4, R2, R4 inicial = %0d, R2 inicial = %0d, Tstep = %0d", $time, uut.R4.Q, uut.R2.Q, uut.Tstep);
          @(posedge Clock);
          #551;
          $display("[%0t] Ciclo 4 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R4 = %0d, R2 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.R2.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0100100010, R4 = 11  R2 = 1 Tstep = 5",$time);
          $display("[%0t] Teste add R4, R2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T7- SUB R4, R2
      // -----------------------------
      if (mostra_teste7)
        begin
          $display("[%0t] Teste 7 instrucao sub R4, R2, R4 inicial = %0d, R2 inicial = %0d, Tstep = %0d", $time, uut.R4.Q, uut.R2.Q, uut.Tstep);
          @(posedge Clock);
          #551;
          $display("[%0t] Ciclo 4 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R4 = %0d, R2 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.R2.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0100100010, R4 = 10  R2 = 1 Tstep = 5",$time);
          $display("[%0t] Teste sub R4, R2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T10 - LD R2, R1
      // -----------------------------
      if (mostra_teste10)
        begin
          $display("[%0t] Teste 10 instrucao LD R2, R1, R2 inicial = %0d, R1 inicial = %0d, Tstep = %0d", $time, uut.R2.Q, uut.R1.Q, uut.Tstep);
          @(posedge Clock);
          #551;
          $display("[%0t] Ciclo 4 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, R2 = %0d, R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R2.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 0100100010, R2 = 9  R1 = 1 Tstep = 5",$time);
          $display("[%0t] Teste LD R2, R1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // ------------------------------
      // T4 -SUB R4, R2
      // ------------------------------
      #300;
      $stop;

    end


  // Testes do AVA
  task teste_mvi_R2_1;
    begin
      Opcode = 3'b001; // mvi
      Rx = 3'b010;     // R2
      Ry = 3'b000;     // R0
      uut.R2.Q = 16'd0; // R0 = 11
      //uut.R1.Q = 16'd10; // R1 = 10
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 010
    end
  endtask

  task teste_mvi_R4_10;
    begin
      Opcode = 3'b001; // mvi
      Rx = 3'b100;     // R0
      Ry = 3'b000;     // zzz
      uut.R4.Q = 16'd0; // R0 = 11
      //uut.R1.Q = 16'd10; // R1 = 10
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask

  task teste_mv_R5_R7;
    begin
      Opcode = 3'b000; // mvi
      Rx = 3'b101;     // R0
      Ry = 3'b111;     // zzz
      uut.R5.Q = 16'd1; // R0 = 11
      uut.R7.Q = 16'd2; // R0 = 11
      //uut.R1.Q = 16'd10; // R1 = 10
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask

  task teste_sub_R4_R2;
    begin
      Opcode = 3'b011; // sub
      Rx = 3'b100;     // R4
      Ry = 3'b010;     // R2
      uut.R4.Q = 16'd10; // R4 = 10
      uut.R2.Q = 16'd6; // R2 = 6
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask

  task teste_mvnz_R7_R5;
    begin
      Opcode = 3'b100; // mvnz
      Rx = 3'b111;     // R7
      Ry = 3'b101;     // R5
      uut.R7.Q = 16'd0; // R7 = 0
      uut.R5.Q = 16'd0; // R5 = 0
      uut.G.Q  = 16'd4; // G = 4
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask


  // Testes Internos

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

  task teste_mvi_R0_5;
    begin
      Opcode = 3'b001; // mv
      Rx = 3'b000;     // R0
      Ry = 3'b001;     // R1
      uut.R0.Q = 16'd11; // R0 = 11
      uut.R1.Q = 16'd10; // R1 = 10
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask

  task teste_sub_R1_R0;
    begin
      Opcode = 3'b011; // sub
      Rx = 3'b001;     // R1
      Ry = 3'b000;     // R0
      uut.R0.Q = 16'd5; // R0 = 11
      uut.R1.Q = 16'd10; // R1 = 10
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask

  task teste1_mvnz_R0_R1;
    begin
      Opcode = 3'b100; // mvnz
      Rx = 3'b000;     // R0
      Ry = 3'b001;     // R1
      uut.R0.Q = 16'd11; // R0 = 11
      uut.R1.Q = 16'd10; // R1 = 10
      uut.G.Q  = 16'd0;  // G = 0
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
    end
  endtask

  task teste2_mvnz_R0_R1;
    begin
      Opcode = 3'b100; // mvnz
      Rx = 3'b000;     // R0
      Ry = 3'b001;     // R1
      uut.R0.Q = 16'd11; // R0 = 11
      uut.R1.Q = 16'd10; // R1 = 10
      uut.G.Q  = 16'd5;  // G = 0
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

  /*
    always @(posedge Clock)
      begin
        counter_clock_cycle = counter_clock_cycle + 1;
        // $display("[%0t] Counter_Clock_Cycle ",$time);
        case (counter_clock_cycle)
          1:
            begin
              // Opcode = 3'b001; // mvi R0 5
              // Rx = 3'b000;     // R0
              // Ry = 3'b001;     // R1
              // uut.R0.Q = 16'd11; // R0 = 11
              // uut.R1.Q = 16'd10; // R1 = 10
              // DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
              // cabecalho_teste(2);
              // Run = 1; // Agendado ja no inicio do ciclo
              // $display("[%0t] instrucao = %3b_%3b_%3b = mv R0 R1 000_000_001", $time, Instrucao[8:6], Instrucao[5:3], Instrucao[2:0]);
            end
   
   
        endcase
   
      end
  */


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
