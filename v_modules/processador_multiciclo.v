module processador_multiciclo (Resetn,
                                 Clock, Run, Done, BusWires, Rx_data, Ry_data, Tstep);

  /*
    
    Um processador multiciclo simples, com 8 registradores de 16 bits (R0 a R7), um registrador de 16 bits A, 
  um registrador de 16 bits G e uma ALU de soma/subtracao.
   
  Possui:
      -Um contador (Tstep) controla os ciclos de execucao (T1, T2, T3).
      -Um registrador de instrcao (IR) guarda a instruo atual.
      -Sinais de controle s£o gerados dependendo da etapa (Tstep_Q) e do opcode (I).
      -Registradores (R0 a R7, A, G) e a ALU (soma/subtrao) s£o instanciados.
      -Um multiplexador define o valor presente no BusWires a cada momento.
      -Um case aninhado © usado para acionar os sinais corretos de controle a cada T1/T2/T3.
  */

  /*
  killmodelsim;vlog processador_multiciclo.v registrador.v registrador_IR.v mux.v unidade_controle.v contador_2bits.v;vsim -L altera work.processador_multiciclo
  */


  // input [15:0] DIN; // deve ser 000 000 001 para comecar
  input Resetn, Clock, Run;
  output Done;
  output wire [15:0] BusWires;
  // output reg [15:0] BusWires;


  // Variaveis para controle
  wire [8:0] Instrucao;
  output wire [1:0] Tstep; // 00=T0,01=T1,10=T2,11=T3

  // Para o mux
  wire W_D;
  wire Clear;
  wire IncrPc;
  wire [15:0] DIN;            // barramento de entrada de dados
  wire [7:0]  Rout, Rin;      // campo de seleo para os registradores
  wire [8:0]  IRout;          // Saida do registrador IR
  wire [15:0] R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out; // saida do registrador R0, R1, ..., R7
  wire [15:0] ARout;          // saida do registrador GOUT
  wire [15:0] GRout;          // saida do registrador GOUT
  wire [15:0] ADDRout;        // saida do registrador ADDR
  wire [15:0] DOUTout;        // saida do registrador DOUT
  wire [15:0] Ulaout;         // saida da ULA
  wire [1:0]  Ulaop;           // operacao da Ula
  wire        IRin, Ain, Gin, ADDRin, DOUTin; // habilita escrita no IR, A, G, ADDR e DOUT
  wire        Gout;           // habilita leitura do registrador G
  wire        DINout;         // habilita a saida do barramento DIN
  wire [15:0] BusWires_data;  // dados do barramento BusWires

  assign Instrucao = IRout;

  // Variaveis inuteis
  wire [8:0] UnusedQ9;
  wire [15:0] UnusedQ16;

  // Variaveis da simulacao FPGA
  wire [2:0] Rx = IRout[5:3];
  wire [2:0] Ry = IRout[2:0];
  output [15:0] Rx_data; // Dados do registrador Rx
  output [15:0] Ry_data; // Dados do registrador Ry
  reg [15:0] Rx_data_reg, Ry_data_reg;
  reg [15:0] LazyBusWires;
  reg [7:0] LazyRin;
  assign Rx_data = Rx_data_reg;
  assign Ry_data = Ry_data_reg;
  // assign BusWires = LazyBusWires;
  // assign Rin = LazyRin;


  // wire [8:0] useless_IR_out =

  memoram Memoria_instrucao (
            .address(ADDRout[5:0]), // tem 64 enderecos,
            .clock(Clock),
            .data(DOUTout),
            .wren(W_D),
            .q(DIN)
          );

  registrador_IR IR (
                   .R    (DIN[8:0]),          // entrada de dados (dado a ser escrito)
                   .Rin  (IRin),              // habilita escrita no registrador
                   .Clock(Clock),             // sinal de clock
                   .Q    (IRout)              // saida Inutil
                 );

  registrador ADDR (
                .R    (BusWires),         // entrada de dados (dado a ser escrito)
                .Rin  (ADDRin),           // habilita escrita no registrador
                .Resetn(Resetn),        // sinal de reset
                .Clock(Clock),            // sinal de clock
                .Q    (ADDRout)           // saida Inutil
              );

  registrador DOUT (
                .R    (BusWires),         // entrada de dados (dado a ser escrito)
                .Rin  (DOUTin),            // habilita escrita no registrador
                .Resetn(Resetn),          // sinal de reset
                .Clock(Clock),             // sinal de clock
                .Q    (DOUTout)          // saida Inutil
              );

  registrador R0 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[7]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (R0out)   // saida registrada
              );

  registrador R1 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[6]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (R1out)   // saida registrada
              );

  registrador R2 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[5]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (R2out)   // saida registrada
              );

  registrador R3 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[4]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (R3out)   // saida registrada
              );

  registrador R4 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[3]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (R4out)   // saida registrada
              );

  registrador R5 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[2]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (R5out)   // saida registrada
              );

  registrador R6 (
                .R    (BusWires),   // entrada de dados
                .Rin  (Rin[1]),    // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (R6out)   // saida registrada
              );

  registradorPC R7(
                  .R      (BusWires     ),
                  .Rin    (Rin[0]    ),
                  .Clock  (Clock  ),
                  .Resetn (Resetn ),
                  .IncrPc (IncrPc ),
                  .Q      (R7out     )
                );

  registrador A (
                .R    (BusWires),   // entrada de dados
                .Rin  (Ain),        // habilita escrita
                .Clock(Clock),      // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (ARout)        // saida registrada
              );

  registrador G (
                .R    (Ulaout),   // entrada de dados
                .Rin  (Gin),       // habilita escrita
                .Clock(Clock),       // sinal de clock
                .Resetn(Resetn),     // sinal de reset
                .Q    (GRout)   // saida registrada
              );

  contador_2bits u_contador_2bits(
                   .Clear     (Clear ),
                   .Clock     (Clock ),
                   .Run       (Run   ),
                   .Resetn    (Resetn),
                   .Tstep     (Tstep)
                 );

  unidade_controle u_unidade_controle(
                     .Instrucao (Instrucao ),
                     .Tstep     (Tstep     ),
                     .IncrPc   (IncrPc   ),
                     .W_D      (W_D      ),
                     .ADDRin   (ADDRin   ),
                     .DOUTin   (DOUTin   ),
                     .Run       (Run       ),
                     .Resetn    (Resetn    ),
                     .Clear     (Clear     ),
                     .GRout     (GRout     ),
                     .IRin      (IRin      ),
                     .Rin       (Rin       ),
                     .Rout      (Rout      ),
                     .Ain       (Ain       ),
                     .Gin       (Gin       ),
                     .Gout      (Gout      ),
                     .Ulaop     (Ulaop     ),
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
        .Gout_data   (GRout   ),  // Dados G para colocar no barramento BusWires DIN
        .DINout      (DINout      ),  // Habilita a saida do barramento DIN
        .DINout_data (DIN),           // Dados DIN para colocar no barramento BusWires DIN
        .BusWires    (BusWires)
      );

  ula u_ula(
        .A        (ARout      ), // saida do registrador A
        .BusWires (BusWires   ),
        .Operacao (Ulaop      ),       // operao da ULA (soma ou subtrao)
        .Q        (Ulaout     ) // saida da ULA
      );

  assign Rx_data = Rx_data_reg;
  assign Ry_data = Ry_data_reg;

  always @(Clock)
    begin
      case (Rx)
        3'b000:
          Rx_data_reg = R0out;
        3'b001:
          Rx_data_reg = R1out;
        3'b010:
          Rx_data_reg = R2out;
        3'b011:
          Rx_data_reg = R3out;
        3'b100:
          Rx_data_reg = R4out;
        3'b101:
          Rx_data_reg = R5out;
        3'b110:
          Rx_data_reg = R6out;
        3'b111:
          Rx_data_reg = R7out;
      endcase

      case (Ry)
        3'b000:
          Ry_data_reg = R0out;
        3'b001:
          Ry_data_reg = R1out;
        3'b010:
          Ry_data_reg = R2out;
        3'b011:
          Ry_data_reg = R3out;
        3'b100:
          Ry_data_reg = R4out;
        3'b101:
          Ry_data_reg = R5out;
        3'b110:
          Ry_data_reg = R6out;
        3'b111:
          Ry_data_reg = R7out;
      endcase
    end




  /*
  killmodelsim;
  vlog processador_multiciclo.v registrador.v registrador_IR.v mux.v unidade_controle.v contador_2bits.v;
  vsim -L altera work.processador_multiciclo
  */


endmodule
