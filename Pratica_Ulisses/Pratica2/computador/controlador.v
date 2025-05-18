/*
opcode:
0000 -> mv:

0001 -> mvi:

0010 -> add:

0011 -> sub:

0100 -> ld:

0101 -> st:

0110 -> mvnz:

0111 -> or:

1000 -> slt:

1001 -> sll:

1010 -> srl:
*/

/*
regs_in:
0 -> R0_in
1 -> R1_in
2 -> R2_in
3 -> R3_in
4 -> R4_in
5 -> R5_in
6 -> R6_in
7 -> R7_in
8 -> A_in
9 -> G_in
10 -> ADDR_in
11 -> DOUT_in
12 -> IR_in
*/


module controlador(input [9:0] in, input run, input resetn, input [2:0] cont, input [15:0] G_out, output clear, output reg done, output reg [3:0] mux_selector, output reg [12:0] regs_in, output reg [2:0] ula_op, output reg incr_pc, output reg W_D);
	wire [2:0] Rx, Ry;
	wire [3:0] opcode;
	assign opcode = in[9:6];
	assign Rx = in[5:3];
	assign Ry = in[2:0];

	assign clear = resetn || done;

	always @(in, cont, run) begin
		if(run == 1'b1) begin
			case(cont)
				3'b000: begin
					incr_pc <= 1'b1;
					done <= 1'b0;
					mux_selector <= 4'b0111; // R7_out (PC) habilitado
					regs_in <= 13'b0010000000000; // ADDR_in habilitado
					ula_op <= 3'b111;
					W_D <= 1'b0;
				end
				3'b001: begin 
					incr_pc <= 1'b0;
					done <= 1'b0;
					mux_selector <= 4'b1111;
					regs_in <= 13'b1000000000000; // IR_in habilitado
					ula_op <= 3'b111;
					W_D <= 1'b0;
				end
				3'b010: begin
					case(opcode)
						4'b0000: begin // mv
							incr_pc <= 1'b0;
							done <= 1'b1;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // RX_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0001: begin // mvi
							incr_pc <= 1'b1;
							done <= 1'b0;
							mux_selector <= 4'b0111; // R7_out (PC) habilitado
							regs_in <= 13'b0010000000000; // ADDR_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0010: begin // add
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
							regs_in <= 13'b0000100000000; // A_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0011: begin // sub
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
							regs_in <= 13'b0000100000000; // A_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0100: begin // ld
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0010000000000; // ADDR_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0101: begin // sd
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0010000000000; // ADDR_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0110: begin // mvnz
							incr_pc <= 1'b0;
							done <= 1'b1;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0000000000000;
							
							if(G_out != 16'b0000000000000000)
								regs_in[Rx] <= 1'b1; // RX_in habilitado
							
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0111: begin // or
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
							regs_in <= 13'b0000100000000; // A_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b1000: begin // slt
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
							regs_in <= 13'b0000100000000; // A_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b1001: begin // sll
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
							regs_in <= 13'b0000100000000; // A_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b1010: begin // srl
							incr_pc <= 1'b0;
							done <= 1'b0;
							mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
							regs_in <= 13'b0000100000000; // A_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
					endcase
				end
				3'b011: begin
					incr_pc <= 1'b0;
					case(opcode)
						4'b0001: begin // mvi
							done <= 1'b1;
							mux_selector <= 4'b1000; // DIN_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // Rx_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0010: begin // add
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0001000000000; // G_in habilitado
							ula_op <= 3'b000;
							W_D <= 1'b0;
						end
						4'b0011: begin // sub
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0001000000000; // G_in habilitado'
							ula_op <= 3'b001;
							W_D <= 1'b0;
						end
						4'b0100: begin // ld
							done <= 1'b1;
							mux_selector <= 4'b1000; // DIN_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // Rx_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0101: begin // sd
							done <= 1'b1;
							mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
							regs_in <= 13'b0100000000000; // DOUT_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b1;
						end
						4'b0111: begin // or
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0001000000000; // G_in habilitado
							ula_op <= 3'b010;
							W_D <= 1'b0;
						end
						4'b1000: begin // slt
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0001000000000; // G_in habilitado
							ula_op <= 3'b001;
							W_D <= 1'b0;
						end
						4'b1001: begin // sll
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0001000000000; // G_in habilitado
							ula_op <= 3'b011;
							W_D <= 1'b0;
						end
						4'b1010: begin // srl
							done <= 1'b0;
							mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
							regs_in <= 13'b0001000000000; // G_in habilitado
							ula_op <= 3'b100;
							W_D <= 1'b0;
						end
					endcase
				end
				3'b100: begin 
					incr_pc <= 1'b0;
					case(opcode)
						4'b0010: begin // add
							done <= 1;
							mux_selector <= 4'b1001; // G_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // RX_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0011: begin // sub
							done <= 1;
							mux_selector <= 4'b1001; // G_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // RX_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b0111: begin // or
							done <= 1;
							mux_selector <= 4'b1001; // G_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // RX_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b1000: begin // slt
							done <= 1'b1;
							
							if(G_out[15] == 1'b1) // se reg G for negativo, ou seja, Rx < Ry
								mux_selector <= 4'b1011; // mux seleciona valor 1
							else // se reg G for positivo, ou seja, !(Rx < Ry)
								mux_selector <= 4'b1010; // mux seleciona valor 0
								
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // RX_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b1001: begin // sll
							done <= 1;
							mux_selector <= 4'b1001; // G_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // RX_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
						4'b1010: begin // srl
							done <= 1;
							mux_selector <= 4'b1001; // G_out habilitado
							regs_in <= 13'b0000000000000;
							regs_in[Rx] <= 1'b1; // RX_in habilitado
							ula_op <= 3'b111;
							W_D <= 1'b0;
						end
					endcase
				end
			endcase
		end
	end
endmodule