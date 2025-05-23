module proc(DIN, Resetn, Clock, Run, Done, BusWires);
    input [15:0] DIN;
    input Resetn, Clock, Run;
    output reg Done;
    output [15:0] BusWires;

    // Registradores
    reg [15:0] R[0:6];  // R0 a R6
    reg [15:0] A, G, IR;
    reg [15:0] ADDR, DOUT;
    reg [15:0] PC;

    // Fios auxiliares
    wire [1:0] Tstep_Q;
    wire [2:0] I = IR[8:6];
    wire [2:0] X = IR[5:3];
    wire [2:0] Y = IR[2:0];

    // Contador de tempo
    wire Clear = Done | ~Run;
    upcount tstep (Clear, Clock, Tstep_Q);

    // Multiplexador do barramento
    assign BusWires = 
        (Rout == 8'b10000000) ? R[0] :
        (Rout == 8'b01000000) ? R[1] :
        (Rout == 8'b00100000) ? R[2] :
        (Rout == 8'b00010000) ? R[3] :
        (Rout == 8'b00001000) ? R[4] :
        (Rout == 8'b00000100) ? R[5] :
        (Rout == 8'b00000010) ? R[6] :
        (Rout == 8'b00000001) ? PC :
        (Gout) ? G :
        (DINout) ? DIN :
        16'bz;

    // Sinais de controle
    reg Gout, DINout, Ain, Gin, AddSub;
    reg [7:0] Rin, Rout;
    reg IRin, incrPC;

    // Lógica principal de controle
    always @(Tstep_Q or I or Run) begin
        Done = 0;
        IRin = 0; Ain = 0; Gin = 0; Gout = 0; DINout = 0;
        Rin = 0; Rout = 0; incrPC = 0; AddSub = 0;

        case (Tstep_Q)
            2'b00: begin
                IRin = 1; Rout = 8'b00000001; // PC -> IR
                incrPC = 1;
            end
            2'b01: case (I)
                3'b000: begin // MV
                    Rout = 8'b1 << Y;
                    Rin = 8'b1 << X;
                    Done = 1;
                end
                3'b001: begin // MVI
                    DINout = 1;
                    Rin = 8'b1 << X;
                    Done = 1;
                    incrPC = 1;
                end
                3'b010, 3'b011: begin // ADD or SUB
                    Rout = 8'b1 << X;
                    Ain = 1;
                end
                3'b100: begin // LD
                    Rout = 8'b1 << Y;
                    ADDR = BusWires;
                end
                3'b101: begin // ST
                    Rout = 8'b1 << Y;
                    ADDR = BusWires;
                end
                3'b110: begin // MVNZ
                    if (G != 0) begin
                        Rout = 8'b1 << Y;
                        Rin = 8'b1 << X;
                    end
                    Done = 1;
                end
            endcase
            2'b10: case (I)
                3'b010, 3'b011: begin // ADD or SUB
                    Rout = 8'b1 << Y;
                    Gin = 1;
                    AddSub = (I == 3'b011);
                end
                3'b100: begin // LD
                    // Supondo que memória externa já respondeu
                    Rin = 8'b1 << X;
                    Done = 1;
                end
                3'b101: begin // ST
                    Rout = 8'b1 << X;
                    DOUT = BusWires;
                    Done = 1;
                end
            endcase
            2'b11: case (I)
                3'b010, 3'b011: begin
                    Gout = 1;
                    Rin = 8'b1 << X;
                    Done = 1;
                end
            endcase
        endcase
    end

    // Contador de programa
    always @(posedge Clock)
        if (!Resetn)
            PC <= 0;
        else if (incrPC)
            PC <= PC + 1;
        else if (Rin[0]) // R7in
            PC <= BusWires;

    // IR
    always @(posedge Clock)
        if (IRin)
            IR <= DIN;

    // Registrador A
    always @(posedge Clock)
        if (Ain)
            A <= BusWires;

    // Registrador G (resultado da ALU)
    always @(posedge Clock)
        if (Gin) begin
            if (AddSub)
                G <= A - BusWires;
            else
                G <= A + BusWires;
        end

    // Registradores Rx
    integer i;
    always @(posedge Clock)
        for (i = 0; i < 7; i = i + 1)
            if (Rin[i])
                R[i] <= BusWires;

endmodule
