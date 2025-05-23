module registrador(R, Rin, Clock, Q);
  // Modulo que representa um registrador de 16 bits que quando habilitado
  // armazena o valor Rin na entrada R. O valor armazenado é lido na

  // inputs
  input [15:0] R;
  input Rin, Clock;

  // outputs
  output [15:0] Q; // valor armazenado

  reg [15:0] Q;
  always @(posedge Clock)
    if (Rin)
      Q <= R;
endmodule
