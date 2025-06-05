module ula(A, BusWires, Operacao, Q);
  input [15:0] A, BusWires;
  input [1:0] Operacao; // 2 bits para selecionar a operação da ULA
  output reg [15:0] Q; // Saída da ULA
  always @(A or BusWires or Operacao)
    begin
      case (Operacao)
        2'b00: // Adição
          Q <= A + BusWires;
        2'b01: // Subtração
          Q <= A - BusWires;
        2'b10: // SLT
          Q <= (A < BusWires) ? 16'd1 : 16'd0; // Set Less Than
        2'b11: // CMP
          Q <= (A == BusWires) ? 16'd1 : 16'd0; // Compare
      endcase
    end
endmodule
