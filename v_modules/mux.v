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

    
  input [7:0]  Rout;      // campo de seleção para os registradores
  input [15:0] R0out;    // Dados do registrador R0 para colocar no barramento BusWires
  input [15:0] R1out;
  input [15:0] R2out;
  input [15:0] R3out;
  input [15:0] R4out;
  input [15:0] R5out;
  input [15:0] R6out;
  input [15:0] R7out;
  input Gout;                    // Habilita colocar dados do registrador G no barramento BusWires
  input DINout;                  // Habilita a saída do barramento DIN
  input [15:0] Gout_data;        // Dados G para colocar no barramento BusWires DIN
  input [15:0] DINout_data;      // Dados de entrada do barramento BusWires DIN


  output reg [15:0] BusWires;

  always@(Rout)
    begin
      $display("[%0t] mux.v - linha 40 vou mudar hein, Rout =  %8b",$time, Rout);
      if (Rout ==  8'b0100_0000) 
        begin
          $display("[%0t] mux.v - Today is gona be the dayt",$time, Rout);
        end
      case (Rout)
        8'b1000_0000:
        begin
          BusWires = R0out;
          $display("[%0t] fui de mudanca linha 45",$time);
        end
        8'b01000000:
        begin
          BusWires = R1out;
          $display("[%0t] fui de mudanca linha 54",$time);
        end
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
        begin
          // BusWires = 16'bxxxx_xxxx_xxxx_xxxx; // valor indefinido
          $display("[%0t] fui de default linha 63",$time);
        end
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
          // BusWires = 16'bzzzz_zzzz_zzzz_zzzz; // valor padrão
        end
    end

  always@(DINout)
    begin
      if (DINout== 1'b1)
        begin
          $display("[%0t] mux.v linha 92",$time);
          BusWires = DINout_data;
        end
      else if (DINout == 1'b0)
        begin
          // $display("[%0t] To te lascando linha 96",$time);
          
          // BusWires = 16'bxxxx_xxxx_xxxx_xxxx; 
        end
    end

endmodule
