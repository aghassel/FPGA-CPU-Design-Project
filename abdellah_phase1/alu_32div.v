// module div #(parameter wordSize = 32)(
// 	input signed[wordSize-1:0]dividend, divisor,
// 	output signed[wordSize*2-1:0] out
// 	);
// 	//Z register is 64-bit: remainder in the higher byte, and quotient in the lower byte) operation
// 	wire [wordSize-1:0] h, l;

// 	assign h = dividend % divisor;		//remainder
// 	assign l = (dividend - h) / divisor; //quotient
// 	assign out = {h,l}; //concatenate high and low in output
// endmodule

// module alu_32div(
//     input [31:0] dividend,
//     input [31:0] divisor,
//     output reg [63:0] out
// );

// reg [31:0] quotient;
// reg [31:0] remainder;
// integer i;

// always @(*) begin
    
//     // initialize remainder with dividend
//     remainder = dividend;
    
//     quotient = 32'd0;
    
//     // iterate from MSB to LSB
//     for (i = 31; i >= 0; i=i-1) begin
        
//         // check if remainder is greater than or equal to divisor shifted left by i bits
//         if (remainder >= (divisor << i)) begin
// 		  // subtract shifted divisor from remainder
//             remainder = remainder - (divisor << i);
            
//             // set the ith bit of quotient to 1
//             quotient[i] = 1'b1;
//         end
//     end

//     out = {remainder, quotient};
// end
// endmodule


//non-restoring
// module alu_32div(input [31:0] divisor, dividend, output reg [63:0] out);
//     integer i; 
//     reg [63:0] Q; // Q reg
//     reg [31:0] tempDivisor;

//     always @(*) begin
//         //If negative values, change to positive value, then flip bits at end
//         if (divisor[31])
//             Q[31:0] = -divisor;
//         else    
//             Q[31:0] = divisor;  
            
//         if (dividend[31])
//             tempDivisor = -dividend;
//         else    
//             tempDivisor = dividend;
                
//         for (i = 0; i < 32; i = i + 1) begin // iterate through each bit of quotient

//             // Shift divisor and Q left one binary position
//             Q = Q << 1;

//             // If A > 0, subtract dividend from divisor; otherwise, add dividend to divisor.

//             if (Q[63])
//                 Q[63:32] = Q[63:32] + tempDivisor;
//             else 
//                 Q[63:32] = Q[63:32] - tempDivisor;

//             // Now, If divisor Q > 0, set q0 to 1; otherwise, set q0 to 0
//             if (Q[63])
//                 Q[0] = 0;
//             else
//                 Q[0] = 1;
//         end 
    
//         //If divisor < 0, add dividend to divisor (this is to make sure that the positive remainder is in divisor at the end of n cycles)
//         if (Q[63])
//             Q[63:32] = Q[63:32] + tempDivisor;

//         //If negative values, change to positive value, then flip bits at end
//         if ((divisor[31])||(dividend[31]))
//             Q[31:0] = -Q[31:0];

//         out = Q;
//     end 
// endmodule 


// module alu_32div(
//     input signed [31:0] dividend,
//     input signed [31:0] divisor,
//     output reg signed [63:0] out
// );
//     reg signed [63:0] temp;
//     integer i;
    
//     always @(*) begin
//         // Initialize temp with dividend and 32 zeros (A/Q reg)
//         temp = {32'h0, dividend};
        
//         // Perform division for 32 iterations     
//           for (i = 0; i < 32; i = i + 1) begin
//             // Shift temp left by one bit
//             temp = temp << 1;
            
//             // If the most significant bit of temp is one,
//             // add divisor to upper half of temp.
//             if (temp[63] == 1'b1) 
//                 temp[63:32] = temp[63:32] + divisor;
          
//             // Otherwise, subtract divisor from upper half of temp.
//              else 
//                 temp[63:32] = temp[63:32] - divisor;
            
            
//             // If the most significant bit of temp is one,
//             // set the least significant bit of quotient to zero.
//             if (temp[63] == 1'b1) 
//                 temp[0] = 1'b0;                  
//             // Otherwise, set it to one.
//             else 
//                 temp[0] = 1'b1;
            
//         end
        
//         // If the most significant bit of temp is one,
//         // add divisor to remainder and set out accordingly.
//         if (temp[63] == 1'b1) begin
//             out = {temp[63:32] + divisor, temp[31:0]};
            
//         // Otherwise, set out accordingly without adding divisor to remainder.
//         end else begin
//             out = {temp[63:32],temp[31:0]};
//         end 
//     end
    
// endmodule

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
            O = -divisor;
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
                temp[31:0] = -temp[31:0];
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