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


  input [15:0] DIN;
  input Resetn, Clock, Run;
  output Done;
  output [15:0] BusWires;

  wire [15:0] R6_out, A_out, G_out, IR_out, ula_out, bus;
  wire clear, incr_pc, W_D;
  wire [2:0] ula_op;
  wire [3:0] mux_selector;
  wire [12:0] regs_in;

  upcount Tstep (Clear, Clock, Tstep_Q);

  assign I = IR[1:3];
  dec3to8 decX (IR[4:6], 1'b1, Xreg);
  dec3to8 decY (IR[7:9], 1'b1, Yreg);

  registrador R0 (
    .R    (data_in),   // entrada de dados
    .Rin  (enable),    // habilita escrita
    .Clock(clk),       // sinal de clock
    .Q    (data_out)   // saída registrada
  );
  
endmodule
