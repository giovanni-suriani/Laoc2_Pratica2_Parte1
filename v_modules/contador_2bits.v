module contador_2bits(Clear, Clock, Tstep, Run, Resetn);

  /*
  Usado pela unidade de controle para saber em que etapa da instrução está.
   
  Ao receber Clear, volta para T0.
   
  Caso contrário, incrementa em cada borda de subida do clock.
  */

  input Clear, Clock, Run, Resetn;
  output reg [1:0] Tstep;
  always @(posedge Clock)
    if (Clear && !Resetn) // se Clear for alto e Resetn for baixo, volta para T0
      Tstep <= 2'b0;
    else if(Run)
      Tstep <= Tstep + 1'b1;
    else if (Resetn)
      Tstep <= 2'bxx;
endmodule
