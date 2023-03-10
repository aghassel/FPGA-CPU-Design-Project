module div32nr(input [31:0] d, v, output reg [31:0] q);
    integer i; 
    reg [63:0] r; // remainder

    always @(*) begin
        r = d; 
        q = 0; 

        for (i = 0; i < 32; i = i + 1) begin // iterate through each bit of quotient

            r = r - v; // subtract divisor from remainder

            if (r[63])  // if result is negative
                r = r + v; // restore previous value of remainder by adding back divisor
            else  
                q[31-i] = 1'b1; // set current bit of quotient to one if result is positive or zero
            
            r = r << 1; // shift remainder left by one bit for next iteration
        end 
    end 
endmodule 