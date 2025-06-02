`timescale 1 ns / 1 ns

module tb_memoram;

  // Entradas
  reg [5:0] address;
  reg clock;
  reg [15:0] data;
  reg wren;

  // Saída
  wire [15:0] q;

  // Instancia o módulo da memória
  memoram dut (
    .address(address),
    .clock(clock),
    .data(data),
    .wren(wren),
    .q(q)
  );

  // Geração de clock (10ns período)
  initial clock = 0;
  always #50 clock = ~clock;

  // Estímulos
  initial begin
    $display("Iniciando Testbench...");
    
    // Inicializações
    address = 0;
    data = 0;
    wren = 0;

    // Aguarda alguns ciclos
    #100;

    // Escreve valor 0xAAAA no endereço 5
    // address = 6'd5;
    // data = 16'hAAAA;
    // wren = 1;
    // #100;

    // // Escreve valor 0x1234 no endereço 10
    // address = 6'd10;
    // data = 16'h1234;
    // #100;

    // // Escreve valor 0xFFFF no endereço 20
    // address = 6'd20;
    // data = 16'hFFFF;
    // #100;

    // // Desabilita escrita
    // wren = 0;

    // // Lê dos mesmos endereços com atraso de clock
    // #100;
    // address = 6'd5;
    // #10;
    // $display("Endereco 5 = %h (esperado: AAAA)", q);

    // address = 6'd10;
    // #10;
    // $display("Endereco 10 = %h (esperado: 1234)", q);

    // address = 6'd20;
    // #10;
    // $display("Endereco 20 = %h (esperado: FFFF)", q);

    // $display("Testbench finalizado.");
    // $stop;
  end

endmodule
