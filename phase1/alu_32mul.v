module mul32 (
    input signed [31:0] multiplicand, 
    input signed [31:0] multiplier,
    output reg signed [63:0] product
);

reg signed [31:0] multiplicand_reg;
reg signed [31:0] multiplier_reg;
reg signed [2:0] bitPattern;
reg signed [31:0] temp;

integer i;

always @(*) begin
    // Initialization
    multiplicand_reg <= (multiplicand <<< 1);
    temp <= 64'b0;

    for (i = 0; i < 16; i = i + 1) begin

        multiplier_reg <= multiplier;

        bitPattern = multiplier_reg[2:0];

        case (bitPattern)
            // +1 x M
            3'b001, 3'b010: temp <= temp + multiplicand_reg;
            // +2 x M
            3'b011: temp <= temp + (multiplicand_reg + multiplicand_reg);
            // -2 x M
            3'b100: temp <= temp - (multiplicand_reg + multiplicand_reg);
            // -1 x M
            3'b101, 3'b110: temp <= temp - multiplicand_reg;
        endcase

        multiplicand_reg <= multiplicand_reg <<< 2;
        multiplier_reg <= multiplier_reg >>> 2;
    end

    product <= temp;
end

endmodule
