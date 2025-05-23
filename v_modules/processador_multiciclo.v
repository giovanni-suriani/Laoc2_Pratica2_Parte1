module processador_multiciclo (DIN, Resetn, Clock, Run, Done, BusWires);

  /*
    
  Um processador multiciclo simples, com 8 registradores de 16 bits (R0 a R7), um registrador de 16 bits A, 
  um registrador de 16 bits G e uma ALU de soma/subtração.
   
  Possui:
      -Um contador (Tstep) controla os ciclos de execução (T1, T2, T3).
      -Um registrador de instrução (IR) guarda a instrução atual.
      -Sinais de controle são gerados dependendo da etapa (Tstep_Q) e do opcode (I).
      -Registradores (R0 a R7, A, G) e a ALU (soma/subtração) são instanciados.
      -Um multiplexador define o valor presente no BusWires a cada momento.
      -Um case aninhado é usado para acionar os sinais corretos de controle a cada T1/T2/T3.
  */


  input [15:0] DIN; // deve ser 000 000 001 para comecar
  input Resetn, Clock, Run;
  output Done;
  output reg [15:0] BusWires;


  // Variaveis para controle
  wire [8:0] Instrucao;
  wire [1:0] Tstep; // 00=T0,01=T1,10=T2,11=T3
  wire [7:0] Rout, Rin;
  wire       IRin, Ain, Gin;
  wire       Gout;


  assign Instrucao = DIN[8:0];


  contador_2bits u_contador_2bits(
                   .Clear     (Clear ),
                   .Clock     (Clock ),
                   .Tstep     (Tstep)
                 );

  control_unit u_control_unit(
                 .Instrucao (Instrucao ),
                 .Tstep     (Tstep     ),
                 .Run       (Run       ),
                 .Resetn    (Resetn    ),
                 .Clear     (Clear     ),
                 .IRin      (IRin      ),
                 .Rin       (Rin       ),
                 .Rout      (Rout      ),
                 .Ain       (Ain       ),
                 .Gin       (Gin       ),
                 .Gout      (Gout      ),
                 .AddSub    (AddSub    ),
                 .DINout    (DINout    ),
                 .Done      (Done      )
               );

  mux u_mux(
        .Rout     (Rout     ),
        .Gout     (Gout     ),
        .DINout   (DINout   ),
        .BusWires (BusWires )
      );

  registrador IR (
                .R    (BusWires),   // entrada de dados
                .Rin  (IRin),       // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (Instrucao)  // saída registrada
              );

  registrador R0 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[7]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );

  registrador R1 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[6]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador R2 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[5]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador R3 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[4]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador R4 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[3]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador R5 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[2]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador R6 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[1]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador R7 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[0]),    // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador A (
                .R    (BusWires),   // entrada de dados
                .Rin  (Ain),       // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
  registrador G (
                .R    (BusWires),   // entrada de dados
                .Rin  (Gin),       // habilita escrita
                .Clock(clk),       // sinal de clock
                .Q    (data_out)   // saída registrada
              );
 

endmodule
