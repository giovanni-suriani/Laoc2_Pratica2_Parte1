// grupo 4
module unidade_controle (
    Instrucao,       // opcode III
    Tstep,   // 00=T0,01=T1,10=T2,11=T3
    Run,     // start instruction
    Clear,   // limpa contador de Tstep
    GRout,   // saída do registrador G
    IRin,    // carrega IR
    Rin,     // habilita escrita em R0..R7
    Rout,    // habilita leitura de R0..R7
    Ain,     // carrega registrador A
    Gin,     // carrega registrador G
    Gout,    // lê registrador G
    Resetn,  // recomecar da primeira instrucao
    Ulaop,  // escolhe subtração na ALU
    DINout,  // coloca DIN no barramento
    Done     // instrucao concluída
  );

  /*
   contador_2bits u_contador_2bits(
    .Clear (Clear ),
    .Clock (Clock ),
    .Q     (Tstep )
  );
  */

  // inputs
  input  wire [8:0] Instrucao;  // opcode III CONECTA com o memoram
  input  wire [1:0] Tstep;      // 00=T0,01=T1,10=T2,11=T3
  input  wire       Run;        // start instruction
  input  wire       Resetn;     // recomecar da primeira instrucao
  input  wire [15:0] GRout;     // saída do registrador G

  // outputs
  output reg        Clear;   // limpa contador de Tstep
  output reg        IRin;    // carrega IR
  // output wire [7:0]  Rin;     // habilita escrita em R0..R7
  // output wire [7:0]  Rout;    // habilita leitura de R0..R7
  output reg [7:0]  Rin;     // habilita escrita em R0..R7
  output reg [7:0]  Rout;    // habilita leitura de R0..R7
  output reg        Ain;     // carrega registrador A
  output reg        Gin;     // carrega registrador G
  output reg        Gout;    // lê registrador G
  output reg [1:0]  Ulaop;  // escolhe subtração ou adicao na ALU
  output reg        DINout;  // coloca DIN no barramento
  output reg        Done;    // instrucao concluída

  // Variaveis
  reg Run_d = 0;                   // armazena o valor anterior de Run
  reg En;                     // habilita o decodificador
  wire [2:0] opcode;           // opcode III
  wire [5:3] Rx;              // campo destino
  wire [8:6] Ry;              // campo fonte
  wire [7:0] Wire_Rin;        // campo de seleção para os registradores
  wire [7:0] Wire_Rout;       // campo de seleção para os registradores


  // Instanciacoes
  assign Ry     = Instrucao[2:0]; // campo fonte   (quem fornece o dado)
  assign Rx     = Instrucao[5:3]; // campo destino (quem fica com o dado fornecido)
  assign opcode = Instrucao[8:6]; // opcode III
  //Run_d = 0; // inicializa Run_d



  decode3_8bits Rx_decode3_8bits(
                  .W  (Rx  ), // campo XXX ou YYY da instrução
                  .En (1'b1 ), // Habilita o decodificador
                  .Y  (Wire_Rin ) // Sinal de habilitação do registrador (R0in, R1out, etc.)
                );
  // Logica do registrador destino (out)
  decode3_8bits Ry_decode3_8bits(
                  .W  (Ry  ),
                  .En (1'b1 ), // Habilita o decodificador
                  .Y  (Wire_Rout ) // Sinal de habilitação do registrador (R0in, R1out, etc.)
                );

  always @(Tstep or Run) // or Resetn
    begin
      /* Todos os sinais mudados aqui, devem ser alterados com <=, pq se nao fica com 0 pq eh non blocking*/
      if (Run && !Run_d) // Borda de subida de Run
        begin
          Clear <= 1;
          // $display("[%0t] bora pic, Run = %b, Run_d = %b",$time, Run, Run_d);
        end
      else
        begin
          // $display("[%0t] bora bona, Run = %b, Run_d = %b",$time, Run, Run_d);
          Clear <= 0;
        end
      Run_d   <= Run; // salva o valor anterior de Run
      IRin    <= 0;
      Rin     <= 8'b0;
      Rout    <= 8'b0;
      Ain     <= 0;
      Gin     <= 0;
      Gout    <= 0;
      Ulaop   <= 0;
      DINout  <= 0;
      Done    <= 0;
      // En      <= 1; // Habilita o decodificador

      case (Tstep)
        2'b00:
          begin
            // T0: fetch da instrução
            IRin    <= 1;
          end

        2'b01:
          begin
            // T1: primeiro passo de execução
            case (opcode)
              // mv Rx, Ry
              3'b000:
                begin
                  // mv Rx, Ry
                  // Logica do registrador fonte (in)
                  // $display("[%0t] uc.v linha 106 mv",$time);
                  // $display("[%0t] uc.v %b_%b Rout",$time, Rout[7:4], Rout[3:0]);
                  Rin   <= Wire_Rin;  // Habilita o registrador Rx  000 ´1000_0000 (processador)
                  Rout  <= Wire_Rout; // Habilita o registrador Ry  001 ´0100_0000 (mux)
                  Done  <= 1'b1;
                  Clear <= 1'b1; // limpa o contador de Tstep
                end

              // mvi Rx, #D
              3'b001:
                begin
                  // mvi Rx,#D
                  // $display("[%0t] uc.v linha 119 mvi",$time);
                  DINout    <= 1;
                  // $display("[%0t] uc.v fazendo a coisa",$time);
                  Rin       <= Wire_Rin;
                  Done      <= 1;
                  Clear     <= 1'b1; // limpa o contador de Tstep
                end

              // SUB Rx, G
              3'b011:
                begin
                  // SUB Rx,Ry
                  // Coloca Rout no registrador A
                  $display("[%0t] Te executei meu fio",$time);
                  Ain  <= 1'b1;
                  Rout <=   Wire_Rin;
                end

              // mvnz Rx, Ry
              3'b100:
                begin
                  // mvnz Rx, Ry,
                  // $display("[%0t] uc.v linha 119 mvi",$time);
                  // // $display("[%0t] uc.v fazendo a coisa",$time);
                  Rin       <= Wire_Rin;
                  if (GRout != 0) // se G for diferente de zero
                    begin
                      Rout <= Wire_Rout; // Joga Ry em bus
                    end
                  else if (GRout == 0) // se G for igual a zero
                    begin
                      Rout <= Wire_Rin; // Joga Rx em bus (proprio dado)
                    end
                  Done      <= 1;
                  Clear     <= 1'b1; // limpa o contador de Tstep
                end
              /*3'b001:
               begin
                 // add Rx,Ry
                 Rout[XXX] = 1;
                 Ain       = 1;
               end 
               */
            endcase
          end

        2'b10:
          begin
            case (opcode)
              3'b011:
                begin
                  // SUB Rx,Ry
                  // Coloca Rin no bus
                  Rout  <= Wire_Rout; // Habilita o registrador Ry
                  Ulaop <= 2'b1;    // Subtração na ULA
                  Gin   <= 1'b1;     // Habilita escrita no registrador G
                end
            endcase
          end

        2'b11:
          begin
            case (opcode)
              3'b011:
                begin
                  Rin <= Wire_Rin; // Habilita o registrador Rx
                  Gout <= 1'b1; // Lê o registrador G
                  Done <= 1'b1; // Indica que a instrução foi concluída
                  Clear <= 1'b1; // Limpa o contador de Tstep

                  // SUB Rx,Ry
                  // Coloca Rin no bus
                  // Rout <= Wire_Rin; // Habilita o registrador Ry
                  // Gin  <= 1'b1;     // Habilita escrita no registrador G
                end
            endcase
          end
      endcase
    end


  // simples mapeamento dos campos XXX, YYY
  // supondo que você os extraia previamente em sinais separados
  // por exemplo via IR[4:6] → XXX, IR[7:9] → YYY

endmodule
