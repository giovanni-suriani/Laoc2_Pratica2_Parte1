 module computador(input [17:0] SW, input [2:0] KEY, output [2:0] LEDR, output [0:6] HEX0, output [0:6] HEX1, output [0:6] HEX2, output [0:6] HEX3, output [0:6] HEX4, output [0:6] HEX5, output [0:6] HEX6, output [0:6] HEX7);
	wire [15:0] ADDR, DOUT, DIN, R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R7_out;
	wire W, done, resetn, run, clock;
	
	assign run = SW[17];
	assign resetn = SW[1];
	assign clock = KEY[0];
	
	memory memoria(.address(ADDR[6:0]), .clock(~clock), .data(DOUT), .wren(W), .q(DIN));
	ProcessadorMult processador(.clock(clock), .resetn(resetn), .run(run), .DIN(DIN), .done(done), .ADDR_out(ADDR), .DOUT_out(DOUT), .W_out(W), .R0_out(R0_out), .R1_out(R1_out), .R2_out(R2_out), .R3_out(R3_out), .R4_out(R4_out), .R5_out(R5_out), .R7_out(R7_out), .cont(LEDR[2:0]));
	
	decodificadorComportamental d0(R0_out%10 , HEX0);
	decodificadorComportamental d1(R1_out%10 , HEX1);
	decodificadorComportamental d2(R2_out%10 , HEX2);
	decodificadorComportamental d3(R3_out%10 , HEX3);
	decodificadorComportamental d4(R4_out%10 , HEX4);
	decodificadorComportamental d5((R4_out/10)%10 , HEX5);
	decodificadorComportamental d6(R7_out%10 , HEX6);
	decodificadorComportamental d7((R7_out/10)%10 , HEX7);
	
endmodule 