`timescale 1 ps / 1 ps

module tb_memoram;

  // Entradas
  reg [5:0] address;
  reg Clock;
  reg [15:0] data;
  reg wren;

  // Saída
  wire [15:0] q;

  // Instancia o módulo da memória
  memoram uut (
            .address(address),
            .clock(Clock),
            .data(data),
            .wren(wren),
            .q(q)
          );

  // Geração de Clock (10ns período)
  always #50 Clock = ~Clock;

  // Estímulos
  initial
    begin
      $display("Iniciando Testbench...");

      // Inicializações
      Clock = 0;
      address = 0;
      data = 0;
      wren = 0;


      // Aguarda alguns ciclos
      #100;

      // Leitura da primeira posicao (endereço 0)
      $display("[%0t] Lendo endereco 0",$time);
      address = 6'd0;
      #100;
      $display("[%0t] Endereco = %0d, Data = %0b",$time, address, q);

      // Escrita no endereco 0
      $display("[%0t] Escrevendo no endereco 0 o valor 1",$time);
      address = 6'd0;
      data = 16'd1;
      wren = 1;
      #100;
      $display("[%0t] Endereco = %0d, Data = %0b",$time, address, q);

      // Leitura do endereco 0
      $display("[%0t] Lendo endereco 0",$time);
      address = 6'd0;
      wren = 0; // Desabilita escrita
      #100;
      $display("[%0t] Endereco = %0d, Data = %0b",$time, address, q);
      
      $stop;

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

      // // Lê dos mesmos endereços com atraso de Clock
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
