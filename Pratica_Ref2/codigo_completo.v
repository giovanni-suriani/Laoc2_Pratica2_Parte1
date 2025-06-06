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
endmodule/*
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


module controlador(input [9:0] in, input run, input resetn,
                     input [2:0] cont, input [15:0] G_out, output clear,
                     output reg done, output reg [3:0] mux_selector,
                     output reg [12:0] regs_in, output reg [2:0] ula_op, o
                     utput reg incr_pc, output reg W_D);
  wire [2:0] Rx, Ry;
  wire [3:0] opcode;
  assign opcode = in[9:6];
  assign Rx = in[5:3];
  assign Ry = in[2:0];

  assign clear = resetn || done;

  always @(in, cont, run)
    begin
      if(run == 1'b1)
        begin
          case(cont)
            3'b000:
              begin
                incr_pc <= 1'b1;
                done <= 1'b0;
                mux_selector <= 4'b0111; // R7_out (PC) habilitado
                regs_in <= 13'b0010000000000; // ADDR_in habilitado
                ula_op <= 3'b111;
                W_D <= 1'b0;
              end
            3'b001:
              begin
                incr_pc <= 1'b0;
                done <= 1'b0;
                mux_selector <= 4'b1111;
                regs_in <= 13'b1000000000000; // IR_in habilitado
                ula_op <= 3'b111;
                W_D <= 1'b0;
              end
            3'b010:
              begin
                case(opcode)
                  4'b0000:
                    begin // mv
                      incr_pc <= 1'b0;
                      done <= 1'b1;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0000000000000;
                      regs_in[Rx] <= 1'b1; // RX_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0001:
                    begin // mvi
                      incr_pc <= 1'b1;
                      done <= 1'b0;
                      mux_selector <= 4'b0111; // R7_out (PC) habilitado
                      regs_in <= 13'b0010000000000; // ADDR_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0010:
                    begin // add
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
                      regs_in <= 13'b0000100000000; // A_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0011:
                    begin // sub
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
                      regs_in <= 13'b0000100000000; // A_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0100:
                    begin // ld
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0010000000000; // ADDR_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0101:
                    begin // sd
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0010000000000; // ADDR_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0110:
                    begin // mvnz
                      incr_pc <= 1'b0;
                      done <= 1'b1;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0000000000000;

                      if(G_out != 16'b0000000000000000)
                        regs_in[Rx] <= 1'b1; // RX_in habilitado

                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0111:
                    begin // or
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
                      regs_in <= 13'b0000100000000; // A_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b1000:
                    begin // slt
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
                      regs_in <= 13'b0000100000000; // A_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b1001:
                    begin // sll
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
                      regs_in <= 13'b0000100000000; // A_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b1010:
                    begin // srl
                      incr_pc <= 1'b0;
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
                      regs_in <= 13'b0000100000000; // A_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                endcase
              end
            3'b011:
              begin
                incr_pc <= 1'b0;
                case(opcode)
                  4'b0001:
                    begin // mvi
                      done <= 1'b1;
                      mux_selector <= 4'b1000; // DIN_out habilitado
                      regs_in <= 13'b0000000000000;
                      regs_in[Rx] <= 1'b1; // Rx_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0010:
                    begin // add
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0001000000000; // G_in habilitado
                      ula_op <= 3'b000;
                      W_D <= 1'b0;
                    end
                  4'b0011:
                    begin // sub
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0001000000000; // G_in habilitado'
                      ula_op <= 3'b001;
                      W_D <= 1'b0;
                    end
                  4'b0100:
                    begin // ld
                      done <= 1'b1;
                      mux_selector <= 4'b1000; // DIN_out habilitado
                      regs_in <= 13'b0000000000000;
                      regs_in[Rx] <= 1'b1; // Rx_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0101:
                    begin // sd
                      done <= 1'b1;
                      mux_selector <= { 1'b0, Rx }; // Rx_out habilitado
                      regs_in <= 13'b0100000000000; // DOUT_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b1;
                    end
                  4'b0111:
                    begin // or
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0001000000000; // G_in habilitado
                      ula_op <= 3'b010;
                      W_D <= 1'b0;
                    end
                  4'b1000:
                    begin // slt
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0001000000000; // G_in habilitado
                      ula_op <= 3'b001;
                      W_D <= 1'b0;
                    end
                  4'b1001:
                    begin // sll
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0001000000000; // G_in habilitado
                      ula_op <= 3'b011;
                      W_D <= 1'b0;
                    end
                  4'b1010:
                    begin // srl
                      done <= 1'b0;
                      mux_selector <= { 1'b0, Ry }; // Ry_out habilitado
                      regs_in <= 13'b0001000000000; // G_in habilitado
                      ula_op <= 3'b100;
                      W_D <= 1'b0;
                    end
                endcase
              end
            3'b100:
              begin
                incr_pc <= 1'b0;
                case(opcode)
                  4'b0010:
                    begin // add
                      done <= 1;
                      mux_selector <= 4'b1001; // G_out habilitado
                      regs_in <= 13'b0000000000000;
                      regs_in[Rx] <= 1'b1; // RX_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0011:
                    begin // sub
                      done <= 1;
                      mux_selector <= 4'b1001; // G_out habilitado
                      regs_in <= 13'b0000000000000;
                      regs_in[Rx] <= 1'b1; // RX_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b0111:
                    begin // or
                      done <= 1;
                      mux_selector <= 4'b1001; // G_out habilitado
                      regs_in <= 13'b0000000000000;
                      regs_in[Rx] <= 1'b1; // RX_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b1000:
                    begin // slt
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
                  4'b1001:
                    begin // sll
                      done <= 1;
                      mux_selector <= 4'b1001; // G_out habilitado
                      regs_in <= 13'b0000000000000;
                      regs_in[Rx] <= 1'b1; // RX_in habilitado
                      ula_op <= 3'b111;
                      W_D <= 1'b0;
                    end
                  4'b1010:
                    begin // srl
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
module decodificadorComportamental(SW,HEX0);

	input [3:0]SW;
	output reg [0:6]HEX0;

	always@(*)
	begin

		case(SW)						//  abcdefg 
			4'b0000 : HEX0[0:6] = 7'b0000001; // 0
			4'b0001 : HEX0[0:6] = 7'b1001111; // 1
			4'b0010 : HEX0[0:6] = 7'b0010010; // 2
			4'b0011 : HEX0[0:6] = 7'b0000110; // 3
			4'b0100 : HEX0[0:6] = 7'b1001100; // 4
			4'b0101 : HEX0[0:6] = 7'b0100100; // 5
			4'b0110 : HEX0[0:6] = 7'b0100000; // 6
			4'b0111 : HEX0[0:6] = 7'b0001111; // 7
			4'b1000 : HEX0[0:6] = 7'b0000000; // 8
			4'b1001 : HEX0[0:6] = 7'b0000100; // 9
			default : HEX0[0:6] = 7'b1111111; // 10+
		endcase
	end

endmodule// megafunction wizard: %RAM: 1-PORT%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: memory.v
// Megafunction Name(s):
// 			altsyncram
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
// ************************************************************

//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.

module memory (
	address,
	clock,
	data,
	wren,
	q);

	input	[6:0]  address;
	input	  clock;
	input	[15:0]  data;
	input	  wren;
	output	[15:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
// Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
// Retrieval info: PRIVATE: AclrByte NUMERIC "0"
// Retrieval info: PRIVATE: AclrData NUMERIC "0"
// Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: Clken NUMERIC "0"
// Retrieval info: PRIVATE: DataBusSeparated NUMERIC "1"
// Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
// Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
// Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
// Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING "memory_data.mif"
// Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "128"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "2"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
// Retrieval info: PRIVATE: RegAddr NUMERIC "1"
// Retrieval info: PRIVATE: RegData NUMERIC "1"
// Retrieval info: PRIVATE: RegOutput NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SingleClock NUMERIC "1"
// Retrieval info: PRIVATE: UseDQRAM NUMERIC "1"
// Retrieval info: PRIVATE: WRCONTROL_ACLR_A NUMERIC "0"
// Retrieval info: PRIVATE: WidthAddr NUMERIC "7"
// Retrieval info: PRIVATE: WidthData NUMERIC "16"
// Retrieval info: PRIVATE: rden NUMERIC "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: INIT_FILE STRING "memory_data.mif"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=NO"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "128"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "SINGLE_PORT"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
// Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "M4K"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "7"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "16"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: USED_PORT: address 0 0 7 0 INPUT NODEFVAL "address[6..0]"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
// Retrieval info: USED_PORT: data 0 0 16 0 INPUT NODEFVAL "data[15..0]"
// Retrieval info: USED_PORT: q 0 0 16 0 OUTPUT NODEFVAL "q[15..0]"
// Retrieval info: USED_PORT: wren 0 0 0 0 INPUT NODEFVAL "wren"
// Retrieval info: CONNECT: @address_a 0 0 7 0 address 0 0 7 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @data_a 0 0 16 0 data 0 0 16 0
// Retrieval info: CONNECT: @wren_a 0 0 0 0 wren 0 0 0 0
// Retrieval info: CONNECT: q 0 0 16 0 @q_a 0 0 16 0
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
// megafunction wizard: %RAM: 1-PORT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: memory.v
// Megafunction Name(s):
// 			altsyncram
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module memory (
	address,
	clock,
	data,
	wren,
	q);

	input	[6:0]  address;
	input	  clock;
	input	[15:0]  data;
	input	  wren;
	output	[15:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [15:0] sub_wire0;
	wire [15:0] q = sub_wire0[15:0];

	altsyncram	altsyncram_component (
				.address_a (address),
				.clock0 (clock),
				.data_a (data),
				.wren_a (wren),
				.q_a (sub_wire0),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.address_b (1'b1),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clock1 (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.data_b (1'b1),
				.eccstatus (),
				.q_b (),
				.rden_a (1'b1),
				.rden_b (1'b1),
				.wren_b (1'b0));
	defparam
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.init_file = "memory_data.mif",
		altsyncram_component.intended_device_family = "Cyclone II",
		altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 128,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_reg_a = "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.ram_block_type = "M4K",
		altsyncram_component.widthad_a = 7,
		altsyncram_component.width_a = 16,
		altsyncram_component.width_byteena_a = 1;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
// Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
// Retrieval info: PRIVATE: AclrByte NUMERIC "0"
// Retrieval info: PRIVATE: AclrData NUMERIC "0"
// Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: Clken NUMERIC "0"
// Retrieval info: PRIVATE: DataBusSeparated NUMERIC "1"
// Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
// Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
// Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
// Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING "memory_data.mif"
// Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "128"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "2"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
// Retrieval info: PRIVATE: RegAddr NUMERIC "1"
// Retrieval info: PRIVATE: RegData NUMERIC "1"
// Retrieval info: PRIVATE: RegOutput NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SingleClock NUMERIC "1"
// Retrieval info: PRIVATE: UseDQRAM NUMERIC "1"
// Retrieval info: PRIVATE: WRCONTROL_ACLR_A NUMERIC "0"
// Retrieval info: PRIVATE: WidthAddr NUMERIC "7"
// Retrieval info: PRIVATE: WidthData NUMERIC "16"
// Retrieval info: PRIVATE: rden NUMERIC "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: INIT_FILE STRING "memory_data.mif"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=NO"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "128"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "SINGLE_PORT"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
// Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "M4K"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "7"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "16"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: USED_PORT: address 0 0 7 0 INPUT NODEFVAL "address[6..0]"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
// Retrieval info: USED_PORT: data 0 0 16 0 INPUT NODEFVAL "data[15..0]"
// Retrieval info: USED_PORT: q 0 0 16 0 OUTPUT NODEFVAL "q[15..0]"
// Retrieval info: USED_PORT: wren 0 0 0 0 INPUT NODEFVAL "wren"
// Retrieval info: CONNECT: @address_a 0 0 7 0 address 0 0 7 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @data_a 0 0 16 0 data 0 0 16 0
// Retrieval info: CONNECT: @wren_a 0 0 0 0 wren 0 0 0 0
// Retrieval info: CONNECT: q 0 0 16 0 @q_a 0 0 16 0
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL memory_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
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

endmodulemodule ProcessadorMult(input clock, input resetn, input run, input [15:0] DIN, output done, output [15:0] ADDR_out, output [15:0] DOUT_out, output W_out, output [15:0] R0_out, output [15:0] R1_out, output [15:0] R2_out, output [15:0] R3_out, output [15:0] R4_out, output [15:0] R5_out, output [15:0] R7_out, output [2:0] cont);

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

endmodulemodule registrador1b(input clock, input in, output out);
	reg registrador1b;
	
	always @(posedge clock) begin
		registrador1b <= in;
	end
	
	assign out = registrador1b;
endmodulemodule registradorPC(input clock, input R_in, input incr_pc, input [15:0] in, input resetn, output [15:0] out);
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
endmodulemodule registrador(input clock, input R_in, input [15:0] in, output [15:0] out);
	reg [15:0] registrador;
	
	always @(posedge clock) begin
		if(R_in)
			registrador <= in;
	end
	
	assign out = registrador;
endmodule/*
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