module mux(
    input  wire [7:0]  Rout,          // seleção do registrador
    input  wire        Gout,          // habilita leitura de G
    input  wire        DINout,        // habilita leitura de DIN
    input  wire [15:0] R0out,
    input  wire [15:0] R1out,
    input  wire [15:0] R2out,
    input  wire [15:0] R3out,
    input  wire [15:0] R4out,
    input  wire [15:0] R5out,
    input  wire [15:0] R6out,
    input  wire [15:0] R7out,
    input  wire [15:0] Gout_data,
    input  wire [15:0] DINout_data,
    output reg  [15:0] BusWires
  );

  always @(DINout or Gout or Rout)
    begin
      // Prioridade: DINout > Gout > Rout
      if (DINout)
        begin
          BusWires = DINout_data;
        end
      else if (Gout)
        begin
          BusWires = Gout_data;
        end
      else
        begin
          case (Rout)
            8'b1000_0000:
              BusWires = R0out;
            8'b0100_0000:
              BusWires = R1out;
            8'b0010_0000:
              BusWires = R2out;
            8'b0001_0000:
              BusWires = R3out;
            8'b0000_1000:
              BusWires = R4out;
            8'b0000_0100:
              BusWires = R5out;
            8'b0000_0010:
              BusWires = R6out;
            8'b0000_0001:
              BusWires = R7out;
            default:
              BusWires = 16'bx;  // valor indefinido se nada selecionado
          endcase
        end
    end

endmodule
