module ProcessadorMult(input clock, input resetn, input run, input [15:0] DIN, output done, output [15:0] ADDR_out, output [15:0] DOUT_out, output W_out, output [15:0] R0_out, output [15:0] R1_out, output [15:0] R2_out, output [15:0] R3_out, output [15:0] R4_out, output [15:0] R5_out, output [15:0] R7_out, output [2:0] cont);

	wire [15:0] R6_out, A_out, G_out, IR_out, ula_out, bus;
	wire clear, incr_pc, W_D;
	wire [2:0] ula_op;
	wire [3:0] mux_selector;
	wire [12:0] regs_in;

	registrador R0(.clock(clock), .R_in(regs_in[0]), .in(bus), .out(R0_out));
	registrador R1(.clock(clock), .R_in(regs_in[1]), .in(bus), .out(R1_out));
	registrador R2(.clock(clock), .R_in(regs_in[2]), .in(bus), .out(R2_out));
	registrador R3(.clock(clock), .R_in(regs_in[3]), .in(bus), .out(R3_out));
	registrador R4(.clock(clock), .R_in(regs_in[4]), .in(bus), .out(R4_out));
	registrador R5(.clock(clock), .R_in(regs_in[5]), .in(bus), .out(R5_out));
	registrador R6(.clock(clock), .R_in(regs_in[6]), .in(bus), .out(R6_out));
	registradorPC R7(.clock(clock), .R_in(regs_in[7]), .incr_pc(incr_pc && run), .in(bus), .resetn(resetn), .out(R7_out));
	registrador A(.clock(clock), .R_in(regs_in[8]), .in(bus), .out(A_out));
	registrador G(.clock(clock), .R_in(regs_in[9]), .in(ula_out), .out(G_out));
	registrador ADDR(.clock(clock), .R_in(regs_in[10]), .in(bus), .out(ADDR_out));
	registrador DOUT(.clock(clock), .R_in(regs_in[11]), .in(bus), .out(DOUT_out));
	registrador IR(.clock(clock), .R_in(regs_in[12]), .in(DIN), .out(IR_out));
	registrador1b W(.clock(clock), .in(W_D), .out(W_out));

	contador3Bits contador(.clock(clock), .clear(clear), .run(run), .Q(cont));

	controlador control(.in(IR_out[9:0]), .run(run), .resetn(resetn), .cont(cont), .G_out(G_out), .clear(clear), .done(done), .mux_selector(mux_selector), .regs_in(regs_in), .ula_op(ula_op), .incr_pc(incr_pc), .W_D(W_D));

	multiplexador mul(.R0(R0_out), .R1(R1_out), .R2(R2_out), .R3(R3_out), .R4(R4_out), .R5(R5_out), .R6(R6_out), .R7(R7_out), .DIN(DIN), .G(G_out), .selector(mux_selector), .out(bus));

	ula ula_ula(.op(ula_op), .in1(A_out), .in2(bus), .out(ula_out));

endmodule