// Multiplexador de 16 bits com 12 entradas
// Seleciona uma das entradas para a saída com base no valor do seletor
// Seletor:
// 0 -> R0
// 1 -> R1
// 2 -> R2
// 3 -> R3
// 4 -> R4
// 5 -> R5
// 6 -> R6
// 7 -> R7
// 8 -> DIN
// 9 -> G
// 10 -> 0
// 11 -> 1
module mux(Rout, Gout, DINout, R0out, R1out, R2out, R3out, R4out,
             R5out, R6out, R7out, BusWires,
             Gout_data, DINout_data);

    
  input [0:7] Rout;      // campo de seleção para os registradores
  input [15:0] R0out;   // saída do registrador R0
  input [15:0] R1out;
  input [15:0] R2out;
  input [15:0] R3out;
  input [15:0] R4out;
  input [15:0] R5out;
  input [15:0] R6out;
  input [15:0] R7out;
  input Gout;
  input DINout;                  // Habilita a saída do barramento DIN
  input [15:0] Gout_data;
  input [15:0] DINout_data;      // Dados de entrada do barramento BusWires DIN


  output reg [15:0] BusWires;

  always@(Rout)
    begin
      case (Rout)
        8'b10000000:
          BusWires = R0out;
        8'b01000000:
          BusWires = R1out;
        8'b00100000:
          BusWires = R2out;
        8'b00010000:
          BusWires = R3out;
        8'b00001000:
          BusWires = R4out;
        8'b00000100:
          BusWires = R5out;
        8'b00000010:
          BusWires = R6out;
        8'b00000001:
          BusWires = R7out;
        default:
          BusWires = 16'bxxxx_xxxx_xxxx_xxxx; // valor indefinido
      endcase
    end

  always@(Gout)
    begin
      if (Gout == 1'b1) // Verifica se Gout está ativo
        begin
          BusWires = Gout_data;
        end
      else if (Gout == 1'b0) // Se Gout não está ativo
        begin
          BusWires = 16'bzzzz_zzzz_zzzz_zzzz; // valor padrão
        end
    end

  always@(DINout)
    begin
      if (DINout== 1'b1)
        begin
          BusWires = DINout_data;
        end
      else if (DINout == 1'b0)
        begin
          BusWires = 16'bxxxx_xxxx_xxxx_xxxx; 
        end
    end

endmodule
