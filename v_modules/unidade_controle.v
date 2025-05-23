// grupo 4
module control_unit (
    Instrucao,       // opcode III
    Tstep,   // 00=T0,01=T1,10=T2,11=T3
    Run,     // start instruction
    Clear,   // limpa contador de Tstep
    IRin,    // carrega IR
    Rin,     // habilita escrita em R0..R7
    Rout,    // habilita leitura de R0..R7
    Ain,     // carrega registrador A
    Gin,     // carrega registrador G
    Gout,    // lê registrador G
    AddSub,  // escolhe subtração na ALU
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

  // outputs
  output reg        Clear;   // limpa contador de Tstep
  output reg        IRin;    // carrega IR
  output reg [7:0]  Rin;     // habilita escrita em R0..R7
  output reg [7:0]  Rout;    // habilita leitura de R0..R7
  output reg        Ain;     // carrega registrador A
  output reg        Gin;     // carrega registrador G
  output reg        Gout;    // lê registrador G
  output reg        AddSub;  // escolhe subtração ou adicao na ALU
  output reg        DINout;  // coloca DIN no barramento
  output reg        Done;    // instrucao concluída

  // Variaveis
  reg [2:0] opcode;          // opcode III
  wire [5:3] Rx;              // campo destino
  wire [8:6] Ry;              // campo fonte


  // Instanciacoes
  assign opcode = Instrucao[2:0]; // opcode III
  assign Rx     = Instrucao[5:3]; // campo destino
  assign Ry     = Instrucao[8:6]; // campo fonte
  


  always @(*)
    begin
      Clear   = Run;
      IRin    = 0;
      Rin     = 8'b0;
      Rout    = 8'b0;
      Ain     = 0;
      Gin     = 0;
      Gout    = 0;
      AddSub  = 0;
      DINout  = 0;
      Done    = 0;

      case (Tstep)
        2'b00:
          begin
            // T0: fetch da instrução
            IRin = 1;
          end

        2'b01:
          begin
            // T1: primeiro passo de execução
            case (opcode)
              3'b000:
                begin
                  // mv Rx, Ry
                  // Logica do registrador fonte (in)
                  dec3to8 u_dec3to8(
                      .W  (Rx  ), // campo XXX ou YYY da instrução
                      .En (1 ), // Habilita o decodificador
                      .Y  (Rin ) // Sinal de habilitação do registrador (R0in, R1out, etc.)
                  );
                  // Logica do registrador destino (out)
                  dec3to8 u_dec3to8(
                      .W  (Ry  ), 
                      .En (1 ), // Habilita o decodificador
                      .Y  (Rout ) // Sinal de habilitação do registrador (R0in, R1out, etc.)
                  );
                  Done = 1'b1;
                end
              /* 
              3'b001:
                begin
                  // mvi Rx,#D
                  DINout     = 1;
                  Rin [XXX] = 1;
                  Done       = 1;
                end
              3'b010:
                begin
                  // add Rx,Ry
                  Rout[XXX] = 1;
                  Ain       = 1;
                end
              3'b011:
                begin
                  // sub Rx,Ry
                  Rout[XXX] = 1;
                  Ain       = 1;
                end 
                */
            endcase
          end

        2'b10:
          begin
            // T2: segundo passo (só para add/sub)
            case (I)
              3'b010:
                begin
                  Rout[YYY] = 1;
                  Gin       = 1;
                end
              3'b011:
                begin
                  Rout[YYY] = 1;
                  Gin       = 1;
                end
              default:
                ;
            endcase
          end

        2'b11:
          begin
            // T3: terceiro passo (só para add/sub)
            case (I)
              3'b010:
                begin
                  Gout       = 1;
                  Rin [XXX] = 1;
                  Done       = 1;
                end
              3'b011:
                begin
                  Gout       = 1;
                  Rin [XXX] = 1;
                  AddSub     = 1;  // subtrai em vez de somar
                  Done       = 1;
                end
              default:
                ;
            endcase
          end
      
      
      endcase
    end

  // simples mapeamento dos campos XXX, YYY
  // supondo que você os extraia previamente em sinais separados
  // por exemplo via IR[4:6] → XXX, IR[7:9] → YYY

endmodule
