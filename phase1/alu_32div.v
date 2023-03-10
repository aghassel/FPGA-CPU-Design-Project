module div32(
    input [31:0] dividend,
    input [31:0] divisor,
    output reg [63:0] out,
);

wire reg [31:0] quotient;
wire reg [31:0] remainder;

always @(*) begin
    integer i;
    
    // initialize remainder with dividend
    remainder = dividend;
    
    quotient = 32'd0;
    
    // iterate from MSB to LSB
    for (i = 31; i >= 0; i=i-1) begin
        
        // check if remainder is greater than or equal to divisor shifted left by i bits
        if (remainder >= (divisor << i)) begin
		  // subtract shifted divisor from remainder
            remainder = remainder - (divisor << i);
            
            // set the ith bit of quotient to 1
            quotient[i] = 1'b1;
        end
    end

    out = {remainder, quotient};
end
endmodule