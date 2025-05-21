module contador_2bits(Clear, Clock, Q);

/* 
Usado pela unidade de controle para saber em que etapa da instrução está.

Ao receber Clear, volta para T0.

Caso contrário, incrementa em cada borda de subida do clock.
*/

  input Clear, Clock;
  output [1:0] Q;
  reg [1:0] Q;
  always @(posedge Clock)
    if (Clear)
      Q <= 2'b0;
    else
      Q <= Q + 1'b1;
endmodule 
