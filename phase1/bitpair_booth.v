module bitpair (
    input signed [31:0] multiplicand, multiplier,
    output reg signed [63:0] product
);

wire signed [2:0] bitPattern;

//Initialization
multiplicand = multiplicand << 1;
product = 64'b0;

for (int i = 0; i < 16; i = i + 1) begin

    bitPattern = multiplier[2:0];

    case (bitPattern)
    // +1 x M
    3'b001, 3'b010: product = product + multiplicand;
    // +2 x M
    3'b011: product = product + (multiplicand + multiplicand);
    // -2 x M
    3'b100: product = product - (multiplicand + multiplicand);
    // -1 x M
    3'b101, 3'b110: product - multiplicand;
    endcase

    multiplicand = multiplicand << 2;
    multiplier = multiplier >> 2;
end

endmodule