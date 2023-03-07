module Adder32 (A, B, Ci, S, Co);
    input [31:0] A;
    input [31:0] B;
    input Ci;
    output [31:0] S;
    output Co;

    wire [31:0] G, P;
    genvar i;
    
    generate
        for (i = 0; i < 32; i = i + 1) begin: gen_loop
            if (i == 0) begin
                assign G[0] = A[0] & B[0];
                assign P[0] = A[0] ^ B[0];
            else
                assign G[i] = (A[i] & B[i]) | (P[i-1] & (A[i] | B[i]));
                assign P[i] = A[i] ^ B[i] ^ P[i-1];
            end
        end
    endgenerate

    assign Co = G[31] | (P[31] & Ci);
    assign S = P;
endmodule
