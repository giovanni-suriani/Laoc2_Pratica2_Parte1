module contador_2bits(Clear, Clock, Tstep);

  /*
  Usado pela unidade de controle para saber em que etapa da instrução está.
   
  Ao receber Clear, volta para T0.
   
  Caso contrário, incrementa em cada borda de subida do clock.
  */

  input Clear, Clock;
  output reg [1:0] Tstep;
  always @(posedge Clock)
    if (Clear)
      Tstep <= 2'b0;
    else
      Tstep <= Tstep + 1'b1;
endmodule
