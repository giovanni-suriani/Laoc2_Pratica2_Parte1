/*
MODULO PARA O MULTIPLEXADOR
*/

//INICIO DO MODULO mux
module mux(DIN,R0,R1,R2,R3,R4,R5,R6,R7,G,ROut,GOut,DINOut,MUXOut);
	input 			[15:0] 	DIN,R0,R1,R2,R3,R4,R5,R6,R7,G;
	input 			[7:0]		ROut;
	input 						GOut;
	input 						DINOut;
	output	reg	[15:0]	MUXOut;
	
	always @(ROut or GOut or DINOut) begin
		if(DINOut) MUXOut = DIN;
			else if(GOut) MUXOut = G;
				else begin
					case (ROut) 
						8'b00000001: MUXOut = R0;
						8'b00000010: MUXOut = R1;
						8'b00000100: MUXOut = R2;
						8'b00001000: MUXOut = R3;
						8'b00010000: MUXOut = R4;
						8'b00100000: MUXOut = R5;
						8'b01000000: MUXOut = R6;
						8'b10000000: MUXOut = R7;
					endcase
				end
	end
	
//FIM DO MODULO mux		
endmodule