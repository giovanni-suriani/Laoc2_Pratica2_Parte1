// grupo 4
module unidade_controle (
    Instrucao,       // opcode III
    Tstep,   // 00=T0,01=T1,10=T2,11=T3
    Run,     // start instruction
    Clear,   // limpa contador de Tstep
    IncrPc, // incrementa PC
    GRout,   // saída do registrador G
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

  /*
   contador_2bits u_contador_2bits(
    .Clear (Clear ),
    .Clock (Clock ),
    .Q     (Tstep )
  );
  */

  // inputs
  input  wire       Clock;      // clock do processador
  input  wire [8:0] Instrucao;  // opcode III CONECTA com o memoram
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
  output reg [1:0]  Ulaop;  // escolhe subtração ou adicao na ALU
  output reg        DINout;  // coloca DIN no barramento
  output reg        Done;    // instrucao concluída

  // Variaveis
  reg Run_d = 0;                   // armazena o valor anterior de Run
  reg Resetn_d = 1;                   // armazena o valor anterior de Run
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
          Ulaop   <= 2'b00; // não escolhe operação na ULA
          DINout  <= 0; // não coloca DIN no barramento
          Done    <= 0; // não indica que a instrução foi concluída
        end
      else
        begin
          // $display("[%0t] bora pic, Run = %b, Run_d = %b",$time, Run, Run_d);
          Clear   <= 0; // não limpa o contador de Tstep
          IncrPc  <= 0; // não incrementa o PC
          IRin    <= 0;
          Rin     <= 8'b0;
          ADDRin  <= 0; // não habilita escrita no barramento
          Rout    <= 8'b0;
          Ain     <= 0;
          Gin     <= 0;
          Gout    <= 0;
          Ulaop   <= 2'b00;
          DINout  <= 0;
          Done    <= 0;

          case (Tstep)
            3'b000:
              begin
                // T0: carrega PC em Bus para ser escrito em Rin
                // IRin    <= 1;
                ADDRin  <= 1; // Habilita escrita no registrador ADDR
                Rout    <= 8'b0000_0001; // Habilita leitura do registrador PC no Bus
                // IncrPc <= 1; // Incrementa o PC se a instrução for mvi para pegar imediato
                // ADDRout
                // if (opcode == 3'b001)
                //   begin
                //   end
              end
            3'b001:
              begin
                Rout    <= 8'b0000_0001;
                // T1: fetch da instrução na MEMORIA
                // Espera ciclo 1
                // IRin    <= 1;
                // ADDRin  <= 1; // Habilita escrita no registrador ADDR
                // IncrPc  <= 1; // Incrementa o PC se a instrução for mvi para pegar imediato
                // ADDRout
                // if (opcode == 3'b001)
                //   begin
                //   end
              end
            3'b010:
              begin
                Rout    <= 8'b0000_0001;
                // T2: fetch da instrução na MEMORIA
                // Espera ciclo 2
              end
            3'b011:
              begin
                // T3: Fetch DIN para IRin
                IRin    <= 1;
                DINout  <= 1; // Coloca DIN no barramento
                IncrPc  <= 1; // Incrementa o PC
                ADDRin  <= 1; // Habilita escrita no barramento ADDR
              end
            3'b100:
              begin
                case (opcode)
                  3'b000: // mv Rx Ry
                  begin
                    
                  end
                  3'b001: // mvi Rx,imediato
                    begin
                      // Espera ciclo 1 para carregar o imediato da memoria
                    end
                endcase
              end
            3'b101:
              begin
                case (opcode)
                  3'b000: // mv Rx Ry
                  begin
                    
                  end
                  3'b001: // mvi Rx,imediato
                    begin
                      Rin <= Wire_Rin; // Habilita o registrador Rx
                      DINout <= 1'b1; // Coloca DIN no barramento
                      Done <= 1'b1; // Indica que a instrução foi concluída
                      Clear <= 1'b1; // Limpa o contador de Tstep
                      IncrPc <= 1; // Incrementa o PC se a instrução for mvi para pegar imediato
                    end
                endcase
              end
            3'b110:
              begin
                case (opcode)
                  3'b000: // mv Rx Ry
                  begin
                    
                  end
                  3'b001: // mvi Rx,imediato
                    begin
                      Rin <= Wire_Rin; // Habilita o registrador Rx
                      DINout <= 1'b1; // Coloca DIN no barramento
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
