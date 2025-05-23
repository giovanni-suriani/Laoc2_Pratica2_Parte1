module alu(A, B, Sub, Result);
    input [15:0] A, B;
    input Sub;  // 0: add, 1: sub
    output reg [15:0] Result;

    always @(*)
        if (Sub)
            Result = A - B;
        else
            Result = A + B;
endmodule
