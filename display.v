module Display(
    input [3:0] result, // Entrada de 4 bits representando o valor a ser exibido
    output reg [6:0] HEX // Saída de 7 bits para controlar os segmentos do display
);
    
    // Bloco sempre sensível a qualquer mudança na entrada 'result'
    always @(*) begin
        case (result)
            4'b0000: HEX = 7'b1000000; // Exibe 0
            4'b0001: HEX = 7'b1111001; // Exibe 1
            4'b0010: HEX = 7'b0100100; // Exibe 2
            4'b0011: HEX = 7'b0110000; // Exibe 3
            4'b0100: HEX = 7'b0011001; // Exibe 4
            4'b0101: HEX = 7'b0010010; // Exibe 5
            4'b0110: HEX = 7'b0000010; // Exibe 6
            4'b0111: HEX = 7'b1111000; // Exibe 7
            4'b1000: HEX = 7'b0000000; // Exibe 8
            4'b1001: HEX = 7'b0010000; // Exibe 9
				4'b1010: HEX = 7'b0001000; // Exibe A
				4'b1011: HEX = 7'b0000011; // Exibe B
				4'b1100: HEX = 7'b1000110; // Exibe C
				4'b1101: HEX = 7'b1000001; // Exibe D
				4'b1110: HEX = 7'b0000110; // Exibe E
				4'b1111: HEX = 7'b0001110; // Exibe F
				
            default: HEX = 7'b1111111; // Display desligado para valores fora do intervalo
        endcase
    end
endmodule
