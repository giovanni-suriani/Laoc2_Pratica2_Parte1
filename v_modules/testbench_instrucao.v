      // -----------------------------
      // T1 - mvi r0, #2
      // -----------------------------
      if (mostra_teste1)
        begin
          $display("[%0t] Teste 1 instrucao mvi r0, #2, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste mvi r0, #2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T2 - mvi r1, #3
      // -----------------------------
      if (mostra_teste2)
        begin
          $display("[%0t] Teste 2 instrucao mvi r1, #3, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste mvi r1, #3 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T3 - ld r2, r1
      // -----------------------------
      if (mostra_teste3)
        begin
          $display("[%0t] Teste 3 instrucao ld r2, r1, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste ld r2, r1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T4 - add r1, r2
      // -----------------------------
      if (mostra_teste4)
        begin
          $display("[%0t] Teste 4 instrucao add r1, r2, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste add r1, r2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T5 - mv r1, r3
      // -----------------------------
      if (mostra_teste5)
        begin
          $display("[%0t] Teste 5 instrucao mv r1, r3, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste mv r1, r3 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T6 - sub r1, r2
      // -----------------------------
      if (mostra_teste6)
        begin
          $display("[%0t] Teste 6 instrucao sub r1, r2, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste sub r1, r2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T7 - st r1, r0
      // -----------------------------
      if (mostra_teste7)
        begin
          $display("[%0t] Teste 7 instrucao st r1, r0, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste st r1, r0 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T8 - slt r0, r1
      // -----------------------------
      if (mostra_teste8)
        begin
          $display("[%0t] Teste 8 instrucao slt r0, r1, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste slt r0, r1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T9 - push r1
      // -----------------------------
      if (mostra_teste9)
        begin
          $display("[%0t] Teste 9 instrucao push r1, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste push r1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T10 - slt r1, r2
      // -----------------------------
      if (mostra_teste10)
        begin
          $display("[%0t] Teste 10 instrucao slt r1, r2, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste slt r1, r2 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T11 - mvnz r0, r1
      // -----------------------------
      if (mostra_teste11)
        begin
          $display("[%0t] Teste 11 instrucao mvnz r0, r1, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste mvnz r0, r1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T12 - add r0, r0
      // -----------------------------
      if (mostra_teste12)
        begin
          $display("[%0t] Teste 12 instrucao add r0, r0, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste add r0, r0 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T13 - mvnz r0, r1
      // -----------------------------
      if (mostra_teste13)
        begin
          $display("[%0t] Teste 13 instrucao mvnz r0, r1, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste mvnz r0, r1 concluido.", $time);
          $display("--------------------------------------------------");
        end

      // -----------------------------
      // T14 - pop r1
      // -----------------------------
      if (mostra_teste14)
        begin
          $display("[%0t] Teste 14 instrucao pop r1, Tstep = %0d", $time, uut.Tstep);
          @(posedge Clock);
          #351;
          $display("[%0t] Ciclo 5 NEG_EDGE", $time);
          $display("[%0t]           IR = %10b, Tstep = %0d", $time, uut.IR.Q, uut.Tstep);
          $display("[%0t] Teste pop r1 concluido.", $time);
          $display("--------------------------------------------------");
        end
