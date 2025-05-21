module dec3to8(W, En, Y);

/*
   3bits to 8 bits decoder
   Transforma o campo XXX ou YYY
   da instrução em um sinal que pode ativar diretamente 
   um registrador específico (R0in, R1out, etc.). 
*/

  input [2:0] W;    // Codigo do registrador (campo XXX ou YYY da instrução)
  input En;         // Habilita o decodificador
  output [0:7] Y;  // Sinal de habilitação do registrador (R0in, R1out, etc.)
  reg [0:7] Y;
  always @(W or En)
    begin
      if (En == 1)
        case (W)
          3'b000:
            Y = 8'b10000000;
          3'b001:
            Y = 8'b01000000;
          3'b010:
            Y = 8'b00100000;
          3'b011:
            Y = 8'b00010000;
          3'b100:
            Y = 8'b00001000;
          3'b101:
            Y = 8'b00000100;
          3'b110:
            Y = 8'b00000010;
          3'b111:
            Y = 8'b00000001;
        endcase
      else
        Y = 8'b00000000;
    end
endmodule
