module ula(A, Buswires, Operacao, Ulaout);
  input [15:0] A, Buswires;
  input [1:0] Operacao; // 2 bits para selecionar a operação da ULA
  output reg [15:0] Ulaout; // Saída da ULA
  always @(A or Buswires)
    begin
      case (Operacao)
        2'b00:
          Ulaout = A + Buswires; // Adição
        2'b01:
          Ulaout = A - Buswires; // Subtração
        2'b10:
          Ulaout = 16'd0;
        2'b11:
          Ulaout = 16'd0;
      endcase
    end
endmodule
