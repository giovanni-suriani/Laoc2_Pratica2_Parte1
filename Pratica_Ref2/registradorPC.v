module registradorPC(input clock, input R_in, input incr_pc, input [15:0] in, input resetn, output [15:0] out);
	reg [15:0] registradorPC;
	
	initial begin
		registradorPC = 16'b0000000000000100;
	end
	
	always @(posedge clock) begin
		if(R_in)
			registradorPC <= in;
		if(incr_pc)
			registradorPC <= registradorPC + 1;
		if(resetn)
			registradorPC <= 16'b0000000000000100;
	end
	
	assign out = registradorPC;
endmodule