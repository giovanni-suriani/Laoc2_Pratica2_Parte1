module registrador1b(input clock, input in, output out);
	reg registrador1b;
	
	always @(posedge clock) begin
		registrador1b <= in;
	end
	
	assign out = registrador1b;
endmodule