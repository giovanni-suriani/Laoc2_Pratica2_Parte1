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
  integer mostra_teste3 = 0;
  integer mostra_teste4 = 0;
  integer mostra_teste5 = 0;
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
      // T1 - Primeira instrucao
      // -----------------------------
      if (mostra_teste1)
      begin
         $display("[%0t] Teste instrucao mvi R2 1, R2 com o valor inicial %0d, Tstep = %0d", $time, uut.R2.Q, uut.Tstep);
        @(posedge Clock);
        #351;
        $display("[%0t] Ciclo 4 NEG_EDGE", $time);
        $display("[%0t]           IR = %10b, R2 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R2.Q, uut.Tstep);
        if (detalhado)
          $display("[%0t] ESPERADO: IR = 001010000, R2 = 1 Tstep = 4",$time);
        $display("[%0t] Teste mvi R2 1 concluido.", $time);
        $display("--------------------------------------------------");
      end

      if (mostra_teste2)
      begin
         $display("[%0t] Teste instrucao mvi R4 10, R4 com o valor inicial %0d, Tstep = %0d", $time, uut.R4.Q, uut.Tstep);
        @(posedge Clock);
        #451;
        $display("[%0t] Ciclo 4 NEG_EDGE", $time);
        $display("[%0t]           IR = %10b, R4 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.Tstep);
        if (detalhado)
          $display("[%0t] ESPERADO: IR = 001100000, R4 = 10 Tstep = 4",$time);
        $display("[%0t] Teste mvi R2 1 concluido.", $time);
        $display("--------------------------------------------------");
      end

      if (mostra_teste3)
      begin
         $display("[%0t] Teste instrucao mv R0, R5 R0 inicial = %0d, R5 inicial = %0d, Tstep = %0d", $time, uut.R0.Q, uut.R5.Q, uut.Tstep);
        @(posedge Clock);
        #451;
        $display("[%0t] Ciclo 4 NEG_EDGE", $time);
        $display("[%0t]           IR = %10b, R0 = %0d, R5 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R5.Q, uut.Tstep);
        if (detalhado)
          $display("[%0t] ESPERADO: IR = 001100000, R0 = 10  R5 = 10 Tstep = 4",$time);
        $display("[%0t] Teste mvi R2 1 concluido.", $time);
        $display("--------------------------------------------------");
      end

       
      // -----------------------------
      // T1 - Instrução mvi R2, #4 ,R0 <- R1
      // -----------------------------
     
      // #100;

      // -----------------------------
      // T2 - Instrução mvi R4, #10 ,R0 <- 5
      // -----------------------------
      /* if (mostra_teste2)
        begin
          @(posedge Clock);
          teste_mvi_R4_10;
          #1;
          $display("[%0t] Teste instrucao mvi R4 10, R4 com o valor inicial %0d, Tstep = %0d", $time, uut.R4.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R4 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 001100000, R4 = 0 Tstep = 0 ",$time); // Esperado
          @(posedge Clock);
          DIN = 16'd10; // Carrega o valor 10 no barramento DIN
          #1;
          $display("[%0t] Ciclo 1: Coloca 10 em R4", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R4 no negedge", $time);
          $display("[%0t]           IR = %9b, R4 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 001100000, R4 = 10 Tstep = 1",$time);
          $display("[%0t] Teste mvi R4 10 concluido.", $time);
          $display("--------------------------------------------------");
        end */

      // -----------------------------
      // T3 - MV R5 R7
      // -----------------------------
     
      // ------------------------------
      // T4 -SUB R4, R2
      // ------------------------------
      if (mostra_teste4)
        begin
          teste_sub_R4_R2;
          @(posedge Clock);
          #1;
          $display("[%0t] Teste instrucao SUB R4 R2, R4 com o valor %0d e R2 com o valor %0d, Tstep = %0d", $time, uut.R4.Q, uut.R2.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R4 = %0d e R2 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.R2.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011100100, R4 = 10 e R2 = 6 Tstep = 0 ",$time); // Esperado

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 1: Coloca R4 em A", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);

          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em A no negedge", $time);
          $display("[%0t]           IR = %9b, R4 = %0d, R2 = %0d, A = %0d  Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.R2.Q, uut.A.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011100010, R4 = 10 e R2 = 6 A = 10 Tstep = 1",$time);

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 2: Faz G = R4 - R2 (A - bus)", $time);
          $display("[%0t] bus = %9b, A = %0d, Tstep = %0d", $time, BusWires, uut.A.Q, uut.Tstep);

          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus - A em G no negedge", $time);
          $display("[%0t]           IR = %9b, R4 = %0d, R2 = %0d, A = %0d, G = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.R2.Q, uut.A.Q, uut.G.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011100010, R4 = 10 e R2 = 6 A = 10 G = 4 Tstep = 2",$time);

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 3: Coloca G em R4", $time);
          $display("[%0t] bus = %9b, G = %0d, Tstep = %0d", $time, BusWires, uut.G.Q, uut.Tstep);

          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R4 no negedge", $time);
          $display("[%0t]           IR = %9b, R4 = %0d, R2 = %0d, A = %0d, G = %0d Tstep = %0d", $time, uut.IR.Q, uut.R4.Q, uut.R2.Q, uut.A.Q, uut.G.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011100010, R4 = 4 e R2 = 6 A = 15 G = 4 Tstep = 3",$time);

          $display("[%0t] Teste SUB R4 R2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T5 - MVNZ R7, R5 Com G = 4
      // -----------------------------
      if (mostra_teste5)
        begin
          teste_mvnz_R7_R5;
          @(posedge Clock);
          #1;
          $display("[%0t] Teste instrucao MVNZ R7 R5, R7 com o valor %0d e R5 com o valor %0d e G com o valor %0d, Tstep = %0d", $time, uut.R7.Q, uut.R5.Q, uut.G.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R7 = %0d e R5 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R7.Q, uut.R5.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 100111101, R7 = 0 e R5 = 0 Tstep = 0 ",$time); // Esperado

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 1: Coloca R5 em R7 se G for diferente de zero", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R7 no negedge", $time);
          $display("[%0t]           IR = %9b, R7 = %0d e R5 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R7.Q, uut.R5.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 100111101, R7 = 0 e R5 = 0 Tstep = 1",$time);
          $display("[%0t] Teste MVNZ R7 R5 concluido.", $time);
          $display("--------------------------------------------------");
        end

      #50;
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
