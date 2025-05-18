module registrador(input clock, input R_in, input [15:0] in, output [15:0] out);
	reg [15:0] registrador;
	
	always @(posedge clock) begin
		if(R_in)
			registrador <= in;
	end
	
	assign out = registrador;
endmodule