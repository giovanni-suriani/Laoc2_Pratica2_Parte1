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

  /*
  killmodelsim;vlog processador_multiciclo.v registrador.v registrador_IR.v mux.v unidade_controle.v contador_2bits.v;vsim -L altera work.processador_multiciclo
  */


  input [15:0] DIN; // deve ser 000 000 001 para comecar
  input Resetn, Clock, Run;
  output Done;
  output reg [15:0] BusWires;


  // Variaveis para controle
  wire [8:0] Instrucao;
  wire [1:0] Tstep; // 00=T0,01=T1,10=T2,11=T3

  // Para o mux
  wire [7:0]  Rout, Rin;      // campo de seleção para os registradores
  wire [15:0] R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out; // saída do registrador R0, R1, ..., R7
  wire [15:0] Gout_data;      // saída do registrador GOUT
  wire        IRin, Ain, Gin; // habilita escrita no IR, A e G
  wire        Gout;           // habilita leitura do registrador G
  wire        DINout;         // habilita a saída do barramento DIN
  wire [15:0] BusWires_data;  // dados do barramento BusWires

  assign Instrucao = DIN[8:0];

  // Variaveis inuteis
  wire [8:0] UnusedQ9;
  wire [15:0] UnusedQ16;


  // wire [8:0] useless_IR_out =

 /*  always @(DIN)
    begin
      Instrucao = DIN[8:0]; // pega os 9 bits de opcode
    end */


  registrador_IR IR (
                   .R    (Instrucao),     // entrada de dados (dado a ser escrito)
                   .Rin  (IRin),          // habilita escrita no registrador
                   .Clock(Clock),         // sinal de clock
                   .Q    (UnusedQ9)       // saída Inutil
                 );

  registrador R0 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[7]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Q    (R0out)   // saída registrada
              );

  registrador R1 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[6]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Q    (R1out)   // saída registrada
              );

  registrador R2 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[5]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Q    (R2out)   // saída registrada
              );

  contador_2bits u_contador_2bits(
                   .Clear     (Clear ),
                   .Clock     (Clock ),
                   .Tstep     (Tstep)
                 );

  unidade_controle u_unidade_controle(
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
        .Rout        (Rout        ),
        .R0out       (R0out       ),
        .R1out       (R1out       ),
        .R2out       (R2out       ),
        .R3out       (R3out       ),
        .R4out       (R4out       ),
        .R5out       (R5out       ),
        .R6out       (R6out       ),
        .R7out       (R7out       ),
        .Gout        (Gout        ),  // Habilita colocar dados do registrador G no barramento BusWires
        .Gout_data   (Gout_data   ),  // Dados G para colocar no barramento BusWires DIN
        .DINout      (DINout      ),  // Habilita a saída do barramento DIN
        .DINout_data (DIN),           // Dados DIN para colocar no barramento BusWires DIN
        .BusWires    (BusWires_data)  
      );



  /*
    
    registrador R3 (
                  .R    (BusWires),   // entrada de dados
                  .Rin  (Rin[4]),    // habilita escrita
                  .Clock(clk),       // sinal de clock
                  .Q    (R3out)   // saída registrada
                );
   
    registrador R4 (
                  .R    (BusWires),   // entrada de dados
                  .Rin  (Rin[3]),    // habilita escrita
                  .Clock(clk),       // sinal de clock
                  .Q    (R4out)   // saída registrada
                );
   
    registrador R5 (
                  .R    (BusWires),   // entrada de dados
                  .Rin  (Rin[2]),    // habilita escrita
                  .Clock(clk),       // sinal de clock
                  .Q    (R5out)   // saída registrada
                );
   
    registrador R6 (
                  .R    (BusWires),   // entrada de dados
                  .Rin  (Rin[1]),    // habilita escrita
                  .Clock(clk),       // sinal de clock
                  .Q    (R6out)   // saída registrada
                );
   
    registrador R7 (
                  .R    (BusWires),   // entrada de dados
                  .Rin  (Rin[0]),    // habilita escrita
                  .Clock(clk),       // sinal de clock
                  .Q    (R7_out)   // saída registrada
                );
   
    Nao funcional ainda
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
                  .Q    (Gout)   // saída registrada
                );
   
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
          .Rout        (Rout        ),
          .R0out       (R0out       ),
          .R1out       (R1out       ),
          .R2out       (R2out       ),
          .R3out       (R3out       ),
          .R4out       (R4out       ),
          .R5out       (R5out       ),
          .R6out       (R6out       ),
          .R7out       (R7out       ),
          .Gout        (Gout        ),
          .Gout_data   (Gout_data   ),
          .DINout      (DINout      ),
          .DINout_data (DINout_data ),
          .BusWires    (BusWires    )
        );
  */

  /*
  killmodelsim;
  vlog processador_multiciclo.v registrador.v registrador_IR.v mux.v unidade_controle.v contador_2bits.v;
  vsim -L altera work.processador_multiciclo
  */


endmodule
