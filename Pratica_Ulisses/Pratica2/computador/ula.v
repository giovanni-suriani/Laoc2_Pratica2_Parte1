/*
op:
000 -> soma
001 -> subtrai
010 -> or 
011 -> sll
100 -> srl
*/

module ula(input [2:0] op, input [15:0] in1, input [15:0] in2, output [15:0] out);
	assign out = op == 3'b000 ? in1 + in2 : 
					 op == 3'b001 ? in1 - in2 :
					 op == 3'b010 ? in1 | in2 : 
					 op == 3'b011 ? in1 << in2 : 
					 op == 3'b100 ? in1 >> in2: 16'bXXXXXXXXXXXXXXXX;
endmodule