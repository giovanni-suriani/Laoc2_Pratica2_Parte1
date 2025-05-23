

module contador3Bits(clear, clock, run, Q);
	input clear, clock, run;
	output [2:0] Q;
	reg [2:0] Q;
	
	initial begin 
		Q <= 3'b0;
	end

	
	always @(posedge clock)
		if (clear)
			Q <= 3'b0;
		else if(run) // colocando o "if(run)" o contador não buga na placa
			Q <= Q + 1'b1;
endmodule