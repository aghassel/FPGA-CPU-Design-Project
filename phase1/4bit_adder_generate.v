module Adder4 (A,B,Ci, S, Co);
input [3:0] A;
input [3:0] B;
input Ci;
output [3:0] S;
output Co;

assing C[0] = Ci;

genvar i;
generate
    
    for (i = 0; i < 4; i = i+1)
        begin: gen_loop
        FullAdder FA (A[i], B[i], C[i], C[i+1], S[i]);
        end
endgenerate
endmodule

assign Co = C[4];

module FullAdder (X, Y, Cin, Cout, Sum);
    input X;
    input Y;
    input Cin;
    output Cout;

    assign #10 Sum = X ^ Y ^ Cin;
    assign #10 Cout = (X & Y) | (X & Cin) | (Y & Cin);
endmodule