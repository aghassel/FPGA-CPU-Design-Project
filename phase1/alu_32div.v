module div32(
    input [31:0] D,
    input [31:0] V,
    output reg [31:0] Q,
    output reg [31:0] R
);
always @(*) begin
    integer i;
    
    // initialize remainder with dividend
    R = D;
    
    Q = 0;
    
    // iterate from MSB to LSB
    for (i = 31; i >= 0; i=i-1) begin
        
        // check if remainder is greater than or equal to divisor shifted left by i bits
        if (R >= (V << i)) begin
		  // subtract shifted divisor from remainder
            R = R - (V << i);
            
            // set the ith bit of quotient to 1
            Q[i] = 1'b1;
        end
    end
end
endmodule