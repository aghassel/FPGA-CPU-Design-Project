module bitpair (
    input signed [31:0] multiplicand, multiplier,
    output reg signed [63:0] product
);

wire signed [2:0] bitPattern;

//Initialization
multiplicand = multiplicand <<< 1; //this may not be allowed in verilog since we are changing the input
assign temp = 64'b0;

for (int i = 0; i < 16; i = i + 1) begin

    bitPattern = multiplier[2:0];

    case (bitPattern)
    // +1 x M
    3'b001, 3'b010: temp = temp + multiplicand;
    // +2 x M
    3'b011: temp = temp + (multiplicand + multiplicand);
    // -2 x M
    3'b100: temp = temp - (multiplicand + multiplicand);
    // -1 x M
    3'b101, 3'b110: temp = temp - multiplicand;
    endcase

    multiplicand = multiplicand <<< 2;
    multiplier = multiplier >>> 2;
end

assign product = temp;

endmodule