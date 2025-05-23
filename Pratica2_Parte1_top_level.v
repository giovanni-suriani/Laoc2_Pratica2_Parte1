module Pratica2_Parte1_top_level (
    input  [17:0] SW,     // SW17 = Run, SW15–0 = DIN
    input  [1:0]  KEY,    // KEY0 = Resetn, KEY1 = Clock
    output [17:0] LEDR    // LEDR15–0 = BusWires, LEDR17 = Done
);

    wire [15:0] BusWires;
    wire Done;

    // Instancia o processador
    proc processor (
        .DIN(SW[15:0]),       // Dados de entrada
        .Resetn(KEY[0]),      // Reset ativo em nível baixo
        .Clock(KEY[1]),       // Clock manual via botão
        .Run(SW[17]),         // Sinal de início via chave
        .Done(Done),          // Indica fim da instrução
        .BusWires(BusWires)   // Saída no barramento
    );

    // Mapeia as saídas para os LEDs
    assign LEDR[15:0] = BusWires;
    assign LEDR[17]   = Done;

endmodule