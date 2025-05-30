module ula(A, BusWires, Operacao, Q);
  input [15:0] A, BusWires;
  input [1:0] Operacao; // 2 bits para selecionar a operação da ULA
  output reg [15:0] Q; // Saída da ULA
  always @(A or BusWires or Operacao)
    begin
      case (Operacao)
        2'b00:
          Q <= A + BusWires; // Adição
        2'b01:
          Q <= A - BusWires; // Subtração
        2'b10:
          Q <= 16'd0;
        2'b11:
          Q <= 16'd0;
      endcase
    end
endmodule
