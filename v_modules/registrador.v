module regn(R, Rin, Clock, Q);
  input [15:0] R;
  input Rin, Clock;
  output [15:0] Q;
  reg [15:0] Q;
  always @(posedge Clock)
    if (Rin)
      Q <= R;
endmodule
