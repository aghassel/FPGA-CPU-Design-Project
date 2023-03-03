`timescale 1ns/10ps

module add_tb;
    reg [31:0] A, B, control
    reg [4:0] opcode
    reg clk, clr
    reg [63:0] C
    parameter add_opcode = 5'b00001;

    alu alu_test(.A(A), .B(B), .opcode(opcode), .clk(clk), .clr(clr), .control(control), .C(C));

    initial begin 
        #5 A = 0; B = 0; opcode = add_opcode; clk = 0; clr = 0; control = 0;
        #5 A = 0; B = 0; opcode = add_opcode; clk = 1; clr = 0; control = 0;
        #5 A = 2147483647B; B = 0; opcode = add_opcode; clk = 0; clr = 0; control = 0;
        #5 A = 2147483647B; B = 0; opcode = add_opcode; clk = 1; clr = 0; control = 0;
        #5 A = 2147483647B; B = 2147483647B; opcode = add_opcode; clk = 0; clr = 0; control = 0;
        #5 A = 2147483647B; B = 2147483647B; opcode = add_opcode; clk = 1; clr = 0; control = 0;
        #5 A = -5; B = 5; opcode = add_opcode; clk = 0; clr = 0; control = 0;
        #5 A = -5; B = 5; opcode = add_opcode; clk = 1; clr = 0; control = 0;
        $finish;
    end
endmodule