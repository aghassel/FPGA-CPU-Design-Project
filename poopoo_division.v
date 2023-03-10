module alu_32div(
    input signed [31:0] dividend,
    input signed [31:0] divisor,
    output reg signed [63:0] out
);
    reg signed [63:0] temp;
    reg signed [31:0] D, O;
    integer i;
    
    always @(*) begin
        if (dividend[31])
            D = -dividend;
        else
            D = dividend;

        if (divisor[31])
            O = -divisor
        else
            O = divisor;
        
        // Initialize temp with D and 32 zeros (A/Q reg)
        temp = {32'h0, D};
        // Perform division for 32 iterations     
        for (i = 0; i < 32; i = i + 1) begin
            // Shift temp left by one bit
            temp = temp << 1;
        
            // If the most significant bit of temp is one,
            // add O to upper half of temp.
            if (temp[63] == 1'b1) 
                temp[63:32] = temp[63:32]+ O;
        
            // Otherwise, subtract O from upper half of temp.
            else 
                temp[63:32] = temp[63:32] - O;    
            // If the most significant bit of temp is one,
            // set the least significant bit of quotient to zero.
            if (temp[63] == 1'b1) 
                temp[0] = 1'b0;                  
            // Otherwise, set it to one.
            else 
                temp[0] = 1'b1;
        end
        
     
        if ((dividend[31])||(divisor[31])) begin
            if (!((dividend[31])&&(divisor[31])))
                temp[31:0] = -temp[31:0]
        end



        // If the most significant bit of temp is one,
        // add O to remainder and set out accordingly.

        if (temp[63] == 1'b1) begin
            out = {temp[63:32] + O, temp[31:0]};
            
        // Otherwise, set out accordingly without adding O to remainder.
        end else begin
            out = {temp[63:32],temp[31:0]};
        end 
    end
    
endmodule