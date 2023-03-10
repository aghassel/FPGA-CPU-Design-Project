module div32nr(input [31:0] A, M, output reg [63:0] out);
    integer i; 
    reg [63:0] Q; // Q reg
    reg [31:0] divisor;

    always @(*) begin
        //If negative values, change to positive value, then flip bits at end
        if (A[31])
            Q[31:0] = -A;
		else	
			Q[31:0] = A;  
            
        if (M[31])
            divisor = -M;
		else    
			divisor = M;
				
        for (i = 0; i < 32; i = i + 1) begin // iterate through each bit of quotient

            // Shift A and Q left one binary position
            Q = Q << 1;

            // If A ≥ 0, subtract M from A; otherwise, add M to A.

            if (Q[63])
                Q = Q[63:32] + divisor;
            else 
                Q = Q[63:32] - divisor;

            // Now, If A ≥ 0, set q0 to 1; otherwise, set q0 to 0
            if (Q[63])
                Q[0] = 0;
            else
                Q[0] = 1;
        end 
    
        //If A < 0, add M to A (this is to make sure that the positive remainder is in A at the end of n cycles)
        if (Q[63])
            Q[63:32] = Q[63:32] + divisor;

        //If negative values, change to positive value, then flip bits at end
        if ((A[31])||(M[31]))
            Q[31:0] = -Q[31:0];

        out = Q;
    end 
endmodule 