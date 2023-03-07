module divider(
    input [31:0] dividend_input,
    input [31:0] divisor_input,
    output reg [31:0] quotient_output,
    output reg [31:0] remainder_output
);
always @* begin
    integer i;
    
    // initialize remainder with dividend
    remainder_output = dividend_input;
    
    // initialize quotient with 0
    quotient_output = 0;
    
    // iterate from MSB to LSB
    for (i = 31; i >= 0; i=i-1) begin
        
        // check if remainder is greater than or equal to divisor shifted left by i bits
        if (remainder_output >= (divisor_input << i)) begin
		  // subtract shifted divisor from remainder
            remainder_output = remainder_output - (divisor_input << i);
            
            // set the ith bit of quotient to 1
            quotient_output[i] = 1'b1;
        end
    end
end
endmodule