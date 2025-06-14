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
  wire [15:0] Rx_data, Ry_data; // Dados dos registradores Rx e Ry

  // Instancia o processador
  processador_multiciclo uut (
                           .DIN(DIN),
                           .Resetn(Resetn),
                           .Clock(Clock),
                           .Rx_data(Rx_data),
                           .Ry_data(Ry_data),
                           .Run(Run),
                           .Done(Done),
                           .BusWires(BusWires)
                         );

  assign Instrucao = {Opcode, Rx, Ry}; // Instrução completa
  // Clock gerado a cada 50ps


  integer detalhado = 1;
  integer counter_clock_cycle = 0;
  always #50 Clock = ~Clock;



  integer mostra_teste1 = 1;
  integer mostra_teste2 = 1;
  integer mostra_teste3 = 1;
  integer mostra_teste4 = 1;
  integer mostra_teste5 = 1;
  initial
    begin
      // Inicialização
      Clock = 1;
      Resetn = 1;
      Run = 0;
      DIN = 16'b0;
      // Reset do processador

      @(posedge Clock);
      // So para ajeitar Clear
      Run = 1;
      Resetn = 0;

      @(posedge Clock);
      // Colocando a instrucao de fato
      Opcode = 3'b011; // sub
      Rx = 3'b000;     // R0
      Ry = 3'b001;     // R1
      DIN = {6'b000_000, Opcode, Rx, Ry}; // Formando a instrução: 000 001 000
      @(posedge Clock);
      #1;

      @(posedge Clock);
      $display("[%0t] Que horas sao",$time);

      @(posedge Clock);
      $display("[%0t] Que horas sao2",$time);

      @(posedge Clock);
      $display("[%0t] Que horas sao3",$time);



      // -----------------------------
      // T1 - Instrução mv R0, R1 ,R0 <- R1
      // -----------------------------
      if (mostra_teste1)
        begin
          @(posedge Clock);
          teste_mv_R0_R1;
          #1;
          $display("[%0t] Teste instrucao mv R0 R1, R0 com o valor %0d e R1 com o valor %0d, Tstep = %0d", $time, uut.R0.Q, uut.R1.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);

          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R0 = %0d e R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 00000001, R0 = 11 e R1 = 10 Tstep = 0 ",$time); // Esperado

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 1: Coloca R1 em R0", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);

          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R0 no negedge", $time);
          $display("[%0t]           IR = %9b, R0 = %0d e R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 000000001, R0 = 10 e R1 = 10 Tstep = 1",$time);
          $display("[%0t] Teste mv R0 R1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T2 - Instrução mvi R0, 5 ,R0 <- 5
      // -----------------------------
      if (mostra_teste2)
        begin
          @(posedge Clock);
          teste_mvi_R0_5;
          #1;
          $display("[%0t] Teste instrucao mvi R0 5, R0 com o valor %0d, Tstep = %0d", $time, uut.R0.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);

          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R0 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 001000001, R0 = 11 Tstep = 0 ",$time); // Esperado

          @(posedge Clock);// Tem que dar mais um no Tstep pois o valor dele so e atribuido no fim do ciclo
          DIN = 16'd5; // Carrega o valor 5 no barramento DIN
          #1;
          $display("[%0t] Ciclo 1: Coloca 5 em R0", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);

          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R0 no negedge", $time);
          $display("[%0t]           IR = %9b, R0 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 001000001, R0 = 5 Tstep = 1",$time);
          $display("[%0t] Teste mvi R0 5 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T3 - SUB R1, R0
      // -----------------------------
      if (mostra_teste3)
        begin
          teste_sub_R1_R0;
          @(posedge Clock);
          #1;
          $display("[%0t] Teste instrucao SUB R1 R0, R1 com o valor %0d e R0 com o valor %0d, Tstep = %0d", $time, uut.R1.Q, uut.R0.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R0 = %0d e R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011001000, R0 = 5 e R1 = 10 Tstep = 0 ",$time); // Esperado

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 1: Coloca R1 em A", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em A no negedge", $time);
          $display("[%0t]           IR = %9b, R0 = %0d, R1 = %0d, A = %0d  Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.A.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011001000, R0 = 5 e R1 = 10 A = 10 Tstep = 1",$time);

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 2: Faz G = R1 - R0 (A - bus)", $time);
          $display("[%0t] bus = %9b, A = %0d, Tstep = %0d", $time, BusWires, uut.A.Q, uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus - A em G no negedge", $time);
          $display("[%0t]           IR = %9b, R0 = %0d, R1 = %0d, A = %0d, G = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.A.Q, uut.G.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011001000, R0 = 5 e R1 = 10 A = 10 G = 5 Tstep = 2",$time);
          // $display("[%0t]           IR = %9b, R0 = %0d, R1 = %0d, A = %0d  Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.A.Q, uut.Tstep);

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 3: Coloca G em R1", $time);
          $display("[%0t] bus = %9b, G = %0d, Tstep = %0d", $time, BusWires, uut.G.Q, uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R1 no negedge", $time);
          $display("[%0t]           IR = %9b, R0 = %0d, R1 = %0d, A = %0d, G = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.A.Q, uut.G.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 011001000, R0 = 5 e R1 = 5 A = 10 G = 5 Tstep = 3",$time);
          $display("[%0t] Teste SUB R1 R0 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // T4 - MVNZ R0, R1 Com G = 0
      // ------------------------------
      if (mostra_teste4)
        begin
          teste1_mvnz_R0_R1;
          @(posedge Clock);
          #1;
          $display("[%0t] Teste instrucao MVNZ R0 R1, R0 com o valor %0d e R1 com o valor %0d e G com o valor %0d, Tstep = %0d", $time, uut.R0.Q, uut.R1.Q, uut.G.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R0 = %0d e R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 100000001, R0 = 11 e R1 = 10 Tstep = 0 ",$time); // Esperado

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 1: Coloca R1 em R0 se G for diferente de zero", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R0 no negedge", $time);
          $display("[%0t]           IR = %9b, R0 = %0d e R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 100000001, R0 = 11 e R1 = 10 Tstep = 1",$time);
          $display("[%0t] Teste MVNZ R0 R1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T5 - MVNZ R0, R1 Com G = 5
      // -----------------------------
      if (mostra_teste5)
        begin
          teste2_mvnz_R0_R1;
          @(posedge Clock);
          #1;
          $display("[%0t] Teste instrucao MVNZ R0 R1, R0 com o valor %0d e R1 com o valor %0d e G com o valor %0d, Tstep = %0d", $time, uut.R0.Q, uut.R1.Q, uut.G.Q, uut.Tstep);
          $display("[%0t] Ciclo 0: Fetch IR", $time);
          $display("[%0t] DIN = %9b, Tstep = %0d", $time, uut.DIN[8:0], uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo DIN[8:0] em IR no negedge ", $time);
          $display("[%0t]           IR = %9b, R0 = %0d e R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 100000001, R0 = 11 e R1 = 10 Tstep = 0 ",$time); // Esperado

          @(posedge Clock);
          #1;
          $display("[%0t] Ciclo 1: Coloca R1 em R0 se G for diferente de zero", $time);
          $display("[%0t] bus = %9b, Tstep = %0d", $time, BusWires, uut.Tstep);
          @(negedge Clock);
          #1;
          $display("[%0t] Atribuindo bus em R0 no negedge", $time);
          $display("[%0t]           IR = %9b, R0 = %0d e R1 = %0d Tstep = %0d", $time, uut.IR.Q, uut.R0.Q, uut.R1.Q, uut.Tstep);
          if (detalhado)
            $display("[%0t] ESPERADO: IR = 100000001, R0 = 10 e R1 = 10 Tstep = 1",$time);
          $display("[%0t] Teste MVNZ R0 R1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      $stop;

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
