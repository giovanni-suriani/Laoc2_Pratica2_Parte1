/*
selector: 
0 -> R0
1 -> R1
2 -> R2
3 -> R3
4 -> R4
5 -> R5
6 -> R6
7 -> R7
8 -> DIN
9 -> G
10 -> 0
11 -> 1
*/

module multiplexador(input [15:0] R0, input [15:0] R1, input [15:0] R2, input [15:0] R3, input [15:0] R4, input [15:0] R5, 
							input [15:0] R6, input [15:0] R7, input [15:0] DIN, input [15:0] G, input [3:0] selector, output [15:0] out);

	wire [15:0] valores [11:0];
	assign valores[0] = R0;
	assign valores[1] = R1;
	assign valores[2] = R2;
	assign valores[3] = R3;
	assign valores[4] = R4;
	assign valores[5] = R5;
	assign valores[6] = R6;
	assign valores[7] = R7;
	assign valores[8] = DIN;
	assign valores[9] = G;
	assign valores[10] = 16'b0000000000000000;
	assign valores[11] = 16'b0000000000000001;
	
	assign out = selector <= 4'b1011 ? valores[selector] : 16'bxxxxxxxxxxxxxxxx;

endmodule