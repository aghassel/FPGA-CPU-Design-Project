module alu_32div(input [31:0] divisor, dividend, output reg [63:0] out);
    integer i; 
    reg [63:0] Q; // Q reg
    reg [31:0] tempDivisor;

    always @(*) begin
        //If negative values, change to positive value, then flip bits at end
        if (divisor[31])
            Q[31:0] = -divisor;
        else    
            Q[31:0] = divisor;  
            
        if (dividend[31])
            tempDivisor = -dividend;
        else    
            tempDivisor = dividend;
                
        for (i = 0; i < 32; i = i + 1) begin // iterate through each bit of quotient

            // Shift divisor and Q left one binary position
            Q = Q << 1;

            // If divisor â‰¥ 0, subtract dividend from divisor; otherwise, add dividend to divisor.

            if (Q[63])
                Q[63:32] = Q[63:32] + tempDivisor;
            else 
                Q[63:32] = Q[63:32] - tempDivisor;

            // Now, If divisor â‰¥ 0, set q0 to 1; otherwise, set q0 to 0
            if (Q[63])
                Q[0] = 0;
            else
                Q[0] = 1;
        end 
    
        //If divisor < 0, add dividend to divisor (this is to make sure that the positive remainder is in divisor at the end of n cycles)
        if (Q[63])
            Q[63:32] = Q[63:32] + tempDivisor;

        //If negative values, change to positive value, then flip bits at end
        if ((divisor[31])||(dividend[31]))
            Q[31:0] = -Q[31:0];

        out = Q;
    end 
endmodule 