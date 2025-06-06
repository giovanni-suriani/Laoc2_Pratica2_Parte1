// grupo 4
module unidade_controle (
    Instrucao,       // opcode III
    Tstep,   // 00=T0,01=T1,10=T2,11=T3
    Run,     // start instruction
    Clear,   // limpa contador de Tstep
    IncrPc, // incrementa PC
    GRout,   // saída do registrador G
    Memout,  // saída da memória
    IRin,    // carrega IR
    Rin,     // habilita escrita em R0..R7
    Rout,    // habilita leitura de R0..R7
    ADDRin, // habilita escrita no barramento
    DOUTin, // habilita escrita no barramento
    Ain,     // carrega registrador A
    Gin,     // carrega registrador G
    Gout,    // lê registrador G
    W_D, // habilita escrita no barramento
    Resetn,  // recomecar da primeira instrucao
    Ulaop,  // escolhe subtração na ALU
    DINout,  // coloca DIN no barramento
    Clock,
    Done     // instrucao concluída
  );

  parameter mv   = 4'b0000; // mv Rx,Ry
  parameter mvi  = 4'b0001; // mvi Rx,imediato
  parameter mvnz = 4'b0010; // mvnz Rx,Ry

  parameter add  = 4'b0011; // add Rx,Ry
  parameter sub  = 4'b0100; // sub Rx,Ry
  parameter slt  = 4'b0101; // slt Rx,Ry
  parameter cmp  = 4'b0110; // cmp Rx,Ry

  parameter ld   = 4'b0111; // ld Rx,imediato
  parameter st   = 4'b1000; // st Rx,imediato
  parameter push = 4'b1001; // push Rx
  parameter pop  = 4'b1010; // pop Rx

  /*
   contador_2bits u_contador_2bits(
    .Clear (Clear ),
    .Clock (Clock ),
    .Q     (Tstep )
  );
  */

  // inputs
  input  wire       Clock;      // clock do processador
  input  wire [9:0] Instrucao;  // opcode III CONECTA com o memoram
  input  wire [2:0] Tstep;      // 00=T0,01=T1,10=T2,11=T3
  input  wire       Run;        // start instruction
  input  wire       Resetn;     // recomecar da primeira instrucao
  input  wire [15:0] GRout;       // saída do registrador G

  // outputs
  output reg        IncrPc;
  output reg        W_D;
  output reg        Clear;   // limpa contador de Tstep
  output reg        IRin;    // carrega IR
  output reg        ADDRin;                // habilita escrita no barramento
  output reg        DOUTin;                // habilita escrita no barramento
  // output wire [7:0]  Rin;     // habilita escrita em R0..R7
  // output wire [7:0]  Rout;    // habilita leitura de R0..R7
  output reg [7:0]  Rin;     // habilita escrita em R0..R7
  output reg [7:0]  Rout;    // habilita leitura de R0..R7
  output reg        Ain;     // carrega registrador A
  output reg        Gin;     // carrega registrador G
  output reg        Gout;    // lê registrador G
  output reg        Memout;   // le da memoria
  output reg [2:0]  Ulaop;  // escolhe subtração ou adicao na ALU
  output reg        DINout;  // coloca DIN no barramento
  output reg        Done;    // instrucao concluída

  // Variaveis
  reg Run_d = 0;                   // armazena o valor anterior de Run
  reg Resetn_d = 1;                   // armazena o valor anterior de Run
  reg En;                     // habilita o decodificador
  wire [3:0] opcode;           // opcode III
  wire [5:3] Rx;              // campo destino
  wire [8:6] Ry;              // campo fonte
  wire [7:0] Wire_Rin;        // campo de seleção para os registradores
  wire [7:0] Wire_Rout;       // campo de seleção para os registradores


  // Instanciacoes
  assign Ry     = Instrucao[2:0]; // campo fonte   (quem fornece o dado)
  assign Rx     = Instrucao[5:3]; // campo destino (quem fica com o dado fornecido)
  assign opcode = Instrucao[9:6]; // opcode IIII
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

  // always @(Tstep or Run or Resetn) // or Resetn
  always @(Tstep or Resetn) // or Resetn
    begin
      /* Todos os sinais mudados aqui, devem ser alterados com <=, pq se nao fica com 0 pq eh non blocking*/
      if (Resetn && !Run ) // Reset ativo em nível baixo
        begin
          Resetn_d <= 1; // reseta o valor de Resetn_d
          Run_d   <= 0; // reseta Run_d
          Clear   <= 1; // limpa o contador de Tstep
          IncrPc  <= 0; // não incrementa o PC
          W_D     <= 0; // não habilita escrita no barramento
          Clear   <= 1; // limpa o contador de Tstep
          IRin    <= 0; // não carrega IR
          Rin     <= 8'b0; // não habilita escrita em R0..R7
          Rout    <= 8'b0; // não habilita leitura de R0..R7
          ADDRin  <= 1; // habilita escrita no barramento
          DOUTin  <= 0; // não habilita escrita no barramento
          Ain     <= 0; // não carrega registrador A
          Gin     <= 0; // não carrega registrador G
          Gout    <= 0; // não lê registrador G
          Ulaop   <= 0; // não escolhe operação na ULA
          DINout  <= 0; // não coloca DIN no barramento
          Memout  <= 0; // não lê da memória
          Done    <= 0; // não indica que a instrução foi concluída
        end
      else
        begin
          // $display("[%0t] bora pic, Run = %b, Run_d = %b",$time, Run, Run_d);
          Clear   <= 0; // não limpa o contador de Tstep
          IncrPc  <= 0; // não incrementa o PC
          W_D     <= 0; // não habilita escrita na memoria
          IRin    <= 0;
          Rin     <= 8'b0;
          ADDRin  <= 0; // não habilita escrita no barramento
          DOUTin  <= 0; // não habilita escrita no barramento
          Rout    <= 8'b0;
          Ain     <= 0;
          Gin     <= 0;
          Gout    <= 0;
          Ulaop   <= 0;
          DINout  <= 0;
          Memout  <= 0; // não lê da memória
          Done    <= 0;

          case (Tstep)
            3'd0:
              begin
                // T0: carrega PC em Bus para ser escrito em Rin
                // IRin    <= 1;
                // ADDRin  <= 1; // Habilita escrita no registrador ADDR
                // Rout    <= 8'b0000_0001; // Habilita leitura do registrador PC no Bus
                // IncrPc <= 1; // Incrementa o PC se a instrução for mvi para pegar imediato
                // ADDRout
                // if (opcode == 3'b001)
                //   begin
                //   end
              end
            3'd1:
              begin
                // Rout    <= 8'b0000_0001;
                // T1: fetch da instrução na MEMORIA
                // Espera ciclo 1
              end
            3'd2:
              begin
                IRin    <= 1;
                DINout  <= 1; // Coloca DIN no barramento
                IncrPc  <= 1; // Incrementa o PC
                // ADDRin  <= 1; // Habilita escrita no barramento ADDR
              end
            3'd3:
              begin
                case (opcode)
                  mv: // mv Rx Ry
                    begin
                      Rin <= Wire_Rin; // Habilita o registrador Rx
                      Rout <= Wire_Rout; // Habilita o registrador Ry
                      Clear <= 1'b1; // Limpa o contador de Tstep
                      Done <= 1'b1; // Indica que a instrução foi concluída
                    end
                  mvi: // mvi Rx,imediato
                    begin
                      // Espera ciclo 1 para carregar o imediato da memoria
                    end
                  mvnz: // mvnz Rx,Ry
                    begin
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
                  add: // ADD Rx,Ry
                    begin
                      // Coloca Rout no registrador A
                      Ain  <=   1'b1;
                      Rout <=   Wire_Rin;
                    end
                  sub: // SUB Rx,Ry
                    begin
                      // Coloca Rout no registrador A
                      Ain  <=   1'b1;
                      Rout <=   Wire_Rin;
                    end
                  slt: // SLT Rx,Ry
                    begin
                      // Coloca Rout no registrador A
                      Ain  <=   1'b1;
                      Rout <=   Wire_Rin;
                    end
                  cmp: // CMP Rx,Ry
                    begin
                      // Coloca Rout no registrador A
                      Ain  <=   1'b1;
                      Rout <=   Wire_Rin;
                    end
                  ld:  // LD Rx, Ry
                    begin
                      Rout <= Wire_Rout; // Habilita o registrador Ry
                      ADDRin <= 1'b1; // Habilita escrita no barramento ADDR
                    end
                  st:  // ST Rx, Ry
                    begin
                      // Passando o dado de Rx para ser escrito na memoria
                      Rout <= Wire_Rin; // Habilita o registrador Ry
                      DOUTin <= 1'b1;   // Habilita escrita no barramento DOUT
                    end
                  push: // PUSH Rx
                    begin
                      // Fazendo $sp = $sp - 4 $sp = R6
                      Rout <= 8'b0000_0010; // Habilita o registrador R6 (SP)
                      Ulaop <= 3'b101; // Subtrai 4 na ULA
                      Gin <= 1'b1; // Habilita escrita no registrador G
                    end
                  pop: // POP Rx
                    begin
                      // Colocando SP como endereco
                      ADDRin <= 1'b1; // Habilita escrita no barramento ADDR
                      Rout <= 8'b0000_0010; // Habilita o registrador R6 (SP)
                    end
                endcase
              end
            3'd4:
              begin
                case (opcode)
                  mvi: // mvi Rx,imediato
                    begin
                      Rin <= Wire_Rin; // Habilita o registrador Rx
                      DINout <= 1'b1; // Coloca DIN no barramento
                      Done <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep
                      IncrPc <= 1; // Incrementa o PC pois o incremento anterior era para o imediato
                    end
                  add: // ADD Rx,Ry
                    begin
                      Rout  <= Wire_Rout; // Habilita o registrador Ry
                      Ulaop <= 3'b000;    // Subtração na ULA
                      Gin   <= 1'b1;     // Habilita escrita no registrador G
                    end
                  sub: // SUB Rx,Ry
                    begin
                      Rout  <= Wire_Rout; // Habilita o registrador Ry
                      Ulaop <= 3'b001;    // Subtração na ULA
                      Gin   <= 1'b1;     // Habilita escrita no registrador G
                    end
                  slt: // SLT Rx,Ry
                    begin
                      Rout  <= Wire_Rout; // Habilita o registrador Ry
                      Ulaop <= 3'b010;    // Set Less Than na ULA
                      Gin   <= 1'b1;     // Habilita escrita no registrador G
                    end
                  cmp: // CMP Rx,Ry
                    begin
                      Rout  <= Wire_Rout; // Habilita o registrador Ry
                      Ulaop <= 3'b011;    // Compare na ULA
                      Gin   <= 1'b1;     // Habilita escrita no registrador G
                    end
                  ld: // LD Rx,Ry
                    begin
                      // Espera 1 ciclo
                    end
                  st: // ST Rx,Ry
                    begin
                      // Passando o dado de Ry como endereco
                      Rout <= Wire_Rout; // Habilita o registrador Ry
                      ADDRin <= 1'b1; // Habilita escrita no barramento ADDR
                      W_D    <= 1'b1; // Habilita escrita no barramento DOUT
                      Done  <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep
                    end
                  push: // PUSH Rx
                    begin
                      // Fazendo Mem[$sp] = [Rx], $sp = R6
                      Gout   <= 1'b1; // Mandando o dado de G para o barramento
                      ADDRin <= 1'b1; // Habilita escrita no registrador ADDR 
                      Rin    <= 8'b0000_0010;
                    end
                  pop: // POP Rx
                    begin
                      // [Rx] = Mem[$sp]
                      Rin    <= Wire_Rin; // Habilita o registrador Rx
                      Memout <= 1'b1; // Habilita leitura da memória
                    end
                endcase
              end
            3'd5:
              begin
                case (opcode)
                  add: // ADD Rx,Ry
                    begin
                      Rin   <= Wire_Rin; // Habilita o registrador Rx
                      Gout  <= 1'b1; // Habilita leitura do registrador G
                      Done  <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep

                      // ADD Rx,Ry
                      // Coloca Rin no bus
                      // Rout <= Wire_Rin; // Habilita o registrador Ry
                      // Gin  <= 1'b1;     // Habilita escrita no registrador G
                    end
                  sub: // SUB Rx,Ry
                    begin
                      Rin   <= Wire_Rin; // Habilita o registrador Rx
                      Gout  <= 1'b1; // Habilita leitura do registrador G
                      Done  <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep

                      // SUB Rx,Ry
                      // Coloca Rin no bus
                      // Rout <= Wire_Rin; // Habilita o registrador Ry
                      // Gin  <= 1'b1;     // Habilita escrita no registrador G
                    end
                  slt: // SLT Rx,Ry
                    begin
                      Rin   <= Wire_Rin; // Habilita o registrador Rx
                      Gout  <= 1'b1; // Habilita leitura do registrador G
                      Done  <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep
                    end
                  cmp: // CMP Rx,Ry
                    begin
                      Rin   <= Wire_Rin; // Habilita o registrador Rx
                      Gout  <= 1'b1; // Habilita leitura do registrador G
                      Done  <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep
                    end
                  ld: // LD Rx,Ry
                    begin
                      Rin   <= Wire_Rin; // Habilita o registrador Rx
                      Memout <= 1'b1; // Habilita leitura da memória
                      Done  <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep
                      // DINout <= 1'b1;    // Coloca DIN no barramento
                      // Done  <= 1'b1; // Indica que a instrução foi concluída
                      // Clear <= 1'b1; // Limpa o contador de Tstep
                      // IncrPc <= 1; // Incrementa o PC pois o incremento anterior era para o imediato
                    end
                  push: // PUSH Rx
                    begin
                      // Mem[$sp] = [Rx] Mandando o dado de Rx para a memoria
                      Rout   <= Wire_Rin; // Mandando o dado de Rx para o barramento
                      DOUTin <= 1'b1;     // Habilita escrita no registrador DOUT
                      W_D    <= 1'b1;     // Habilita escrita na memoria
                      Done   <= 1'b1;     // Indica que a instrução foi concluída
                      Clear  <= 1'b1;     // Limpa o contador de Tstep
                    end
                  pop: // POP Rx
                    begin
                      // Fazendo $sp = $sp + 4
                      Rout    <= 8'b0000_0010; // Escreve no registrador SP
                      Ulaop  <= 3'b100;       // Adiciona 4 na ULA
                      Gin    <= 1'b1;         // Habilita escrita no registrador G
                    end
                endcase
              end
            3'd6:
              begin
                case (opcode)
                  pop: // POP Rx
                    begin
                      // Colocando o dado de Mem[$sp] no registrador Rx
                      Rin    <= 8'b0000_0010; // Habilita escrita no registrador SP
                      Gout   <= 1'b1; // Coloca o dado de G no barramento
                      Done   <= 1'b1; // Indica que a instrução foi concluída
                      Clear  <= 1'b1; // Limpa o contador de Tstep
                    end
                endcase
              end
            // 2'b10:
            //   begin
            //     case (opcode)
            //       3'b011:
            //         begin
            //           // SUB Rx,Ry
            //           // Coloca Rin no bus
            //           Rout  <= Wire_Rout; // Habilita o registrador Ry
            //           Ulaop <= 2'b01;    // Subtração na ULA
            //           Gin   <= 1'b1;     // Habilita escrita no registrador G
            //         end
            //     endcase
            //   end

            // 2'b11:
            //   begin
            //     case (opcode)
            //       3'b011:
            //         begin
            //           Rin <= Wire_Rin; // Habilita o registrador Rx
            //           Gout <= 1'b1; // Lê o registrador G
            //           Done <= 1'b1; // Indica que a instrução foi concluída
            //           Clear <= 1'b1; // Limpa o contador de Tstep

            //           // SUB Rx,Ry
            //           // Coloca Rin no bus
            //           // Rout <= Wire_Rin; // Habilita o registrador Ry
            //           // Gin  <= 1'b1;     // Habilita escrita no registrador G
            //         end
            //     endcase
            //   end
          endcase
        end
    end


  // simples mapeamento dos campos XXX, YYY
  // supondo que você os extraia previamente em sinais separados
  // por exemplo via IR[4:6] → XXX, IR[7:9] → YYY

endmodule
