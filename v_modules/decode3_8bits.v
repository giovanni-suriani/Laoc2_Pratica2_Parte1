module decode3_8bits(W, En, Y);

/*
   3bits to 8 bits decoder
   Transforma o campo XXX ou YYY
   da instrução em um sinal que pode ativar diretamente 
   um registrador específico (R0in, R1out, etc.). 
*/

  input [2:0] W;    // Codigo do registrador (campo XXX ou YYY da instrução)
  input En;         // Habilita o decodificador
  output [7:0] Y;  // Sinal de habilitação do registrador (R0in, R1out, etc.)
  reg [7:0] Y;
  always @(W or En)
    begin
      if (En == 1)
        case (W)
          3'b000:
            Y = 8'b1000_0000;
          3'b001:
            Y = 8'b0100_0000;
          3'b010:
            Y = 8'b0010_0000;
          3'b011:
            Y = 8'b0001_0000;
          3'b100:
            Y = 8'b0000_1000;
          3'b101:
            Y = 8'b0000_0100;
          3'b110:
            Y = 8'b0000_0010;
          3'b111:
            Y = 8'b0000_0001;
        endcase
      else
        Y = 8'b00000000;
    end
endmodule
