module alu_test #(parameter wordSize = 32)(
    input wire clk, clr,
    //32-bit input registers A, B, Y (temp reg)
    input wire [wordSize-1:0] A, B, Y,
    //5-bit opcode
    input wire [4:0] opcode,
    //64-bit output register C
    output reg [(wordSize*2)-1:0] C
);

    parameter   add = 5'b00001, sub = 5'b00010, mul = 5'b00011, div = 5'b00100, shr = 5'b00101, shl = 5'b00110, shra = 5'b00111, 
                ror = 5'b01000, rol = 5'b01001, log_and = 5'b01010, log_or = 5'b01011, log_neg = 5'b01100, log_xor = 5'b01101,
                log_nor = 5'b01110, log_not = 5'b01111; 

   wire [wordSize-1:0] temp, temp32_out, add32_out, sub32_out;
	wire [(wordSize*2)-1:0] temp64_out, mul64_out, div64_out;
	 
	alu_32add myAdd (.a(Y), .b(B), .cin(1'd0), .s(add32_out), .cout(temp));
	
	reg [wordSize-1:0] neg_b;
	alu_32add mySub (.a(Y), .b(neg_b), .cin(1'd0), .s(sub32_out), .cout(temp));
	
	alu_32div myDiv (.dividend(Y), .divisor(B), .out(div64_out));
	alu_32mul myMul (.multiplicand(Y), .multiplier(B), .product(mul64_out));
	
    always @(posedge clk) begin
	 
			neg_b = (~B + 1);
        case(opcode)
            add: begin
                C [31:0] <= add32_out[31:0];
                C [63:32] <= (add32_out[31] == 0) ? 32'd0 : 32'd1;
            end
            sub: begin
                // Calculate two's complement of b
                C [31:0] <= sub32_out[31:0];
                C [63:32] <= 32'd0;
            end
            mul: begin
                C [63:0] <= mul64_out [63:0];
            end
            div: begin
                C [63:0] <= div64_out[63:0];
            end
            shr: begin
                C [31:0] <= Y >> B;
                C [63:32] <= 32'd0;
            end
            shl: begin
                C [31:0] <= Y << B;
                C [63:32] <= 32'd0;
            end
            shra: begin
                C [31:0] <= Y >>> B;
                C [63:32] <= 32'd0;
            end
            ror: begin
                C [31:0] <= (Y >> B) | (Y << ~B);
                C [63:32] <= 32'd0;
            end
            rol: begin
                C [31:0] <= (Y << B) | (Y >> ~B);
                C [63:32] <= 32'd0;
            end
            log_and: begin
                C [31:0] <= Y & B;
                C [63:32] <= 32'd0;
            end
            log_or: begin
                C [31:0] <= Y | B;
                C [63:32] <= 32'd0;
            end
            log_neg: begin
                C [31:0] <= ~Y;
                C [63:32] <= 32'd0;
            end
            log_xor: begin
                C [31:0] <= Y ^ B;
                C [63:32] <= 32'd0;
            end
            log_nor: begin
                C [31:0] <= ~(Y | B);
                C [63:32] <= 32'd0;
            end
            log_not: begin
                C [31:0] <= !Y;
                C [63:32] <= 32'd0;
            end
            default: begin
                C <= 64'd0;
            end
        endcase 
    end
endmodule