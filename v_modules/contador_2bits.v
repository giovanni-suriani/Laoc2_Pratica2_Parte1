module contador_2bits(Clear, Clock, Tstep, Run, Resetn);

  /*
  Usado pela unidade de controle para saber em que etapa da instrução está.
   
  Ao receber Clear, volta para T0.
   
  Caso contrário, incrementa em cada borda de subida do clock.
  */

  input Clear, Clock, Run, Resetn;
  output reg [1:0] Tstep;
  reg Resetn_d = 1;                   // armazena o valor anterior de Resetn
  reg Run_d = 0;                   // armazena o valor anterior de Run
  always @(posedge Clock)
    if (Clear && !Resetn) // se Clear for alto e Resetn for baixo, volta para T0
      Tstep <= 2'b0;
    else if (Run && !Run_d) // se Run for alto e Run_d for baixo, incrementa
      begin
        Tstep <= 2'b0;
        Run_d <= Run; // atualiza Run_d para o próximo ciclo
      end
    else if(Run)
      Tstep <= Tstep + 1'b1;
    else if (Resetn)
      begin
        $display("[%0t] linha 20 contador2bit",$time);
        Tstep <= 2'b0; // Avaliar se coloca 11
      end
endmodule
