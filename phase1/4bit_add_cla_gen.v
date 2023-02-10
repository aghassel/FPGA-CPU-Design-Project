module Adder4 (A, B, Ci, S, Co);
    input [3:0] A;
    input [3:0] B;
    input Ci;
    output [3:0] S;
    output Co;

    wire [4:0] G, P;
    genvar i;
    
    generate
        for (i = 0; i < 4; i = i + 1) begin: gen_loop
            if (i == 0) begin
                assign G[0] = A[0] & B[0];
                assign P[0] = A[0] ^ B[0];
            else
                assign G[i] = (A[i] & B[i]) | (P[i-1] & (A[i] | B[i]));
                assign P[i] = A[i] ^ B[i] ^ P[i-1];
            end
        end
    endgenerate

    assign Co = G[3] | (P[3] & Ci);
    assign S = P;
endmodule
