module alu (A, B, opcode, clk, clr, control, C);
    input wire [31:0] A, B, control;
    input wire clk, clr;
    input wire [4:0] opcode;
    output reg [63:0] C;
    

    wire[31:0] neg_reg, nor_reg, or_reg, not_reg, xor_reg, and_reg, shl_reg, shr_reg, shra_reg, ror_reg, rol_reg, add_reg, sub_reg,
    add_cout_reg, sub_cout_reg;
    wire [63:0] mul_reg, div_reg;
    
            
    parameter add = 5'b00001, sub = 5'b00010, mul = 5'b00011, div = 5'b00100, shr = 5'b00101, shl = 5'b00110, shra = 5'b00111, 
                    ror = 5'b01000, rol = 5'b01001, log_and = 5'b01010, log_or = 5'b01011, log_neg = 5'b01100, log_xor = 5'b01101,
                    log_nor = 5'b01110, log_not = 5'b01111; 

    cla32bit addop (.a(A), .b(B), .cin(1'd0), .s(add_reg), .cout(add_cout_reg[0]));
    sub32 subop (.a(A), .b(B), .cin(1'd0), .s(sub_reg), .cout(sub_cout_reg));
    mul32 mulop (.multiplicand(A), .multiplier(B), .product(mul_reg));
    div divop (.dividend(A), .divisor(B), .out(div_reg));
    and32 andop (.a(A), .b(B), .c(and_reg));
    or32 orop (.a(A), .b(B), .c(or_reg));
    xor32 xorop (.a(A), .b(B), .c(xor_reg));
    neg32 negop (.in(B), .out(neg_reg));
    nor32 norop (.a(A), .b(B), .c(nor_reg));
    not32 notop (.in(B), .out(not_reg));
    shl32 shlop (B, A, shl_reg);
    shr32 shrop (B, A, shr_reg); 
    shra32 shraop (B, A, shra_reg);
    ror32 rorop (B, A, ror_reg);
    rol32 rolop (B, A, rol_reg);
    

    always @(posedge clk) begin
        //if (opcode) begin -- don't need this since ur using cases
            case(opcode) 
                add: begin
                    C [31:0] <= add_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                sub: begin
                    C [31:0] <= sub_reg [31:0];
                    C [63:32] <= 32'd0;
                end
                mul: begin
                    C [63:0] <= mul_reg [63:0];
                end
                div: begin
                    C [63:0] <= div_reg[63:0];
                end
                shr: begin
                    C [31:0] <= shr_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                shl: begin
                    C [31:0] <= shl_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                shra: begin
                    C [31:0] <= shra_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                ror: begin
                    C [31:0] <= ror_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                rol: begin
                    C [31:0] <= rol_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                log_and: begin
                    C [31:0] <= and_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                log_or: begin
                    C [31:0] <= or_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                log_neg: begin
                    C [31:0] <= neg_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                log_xor: begin
                    C [31:0] <= xor_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                log_nor: begin
                    C [31:0] <= nor_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                log_not: begin
                    C [31:0] <= not_reg[31:0];
                    C [63:32] <= 32'd0;
                end
                default: begin
                    C <= 64'd0;
                end
            endcase 
        end
    //end
endmodule

