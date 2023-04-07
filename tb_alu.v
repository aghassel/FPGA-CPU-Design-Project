`timescale 1ns/1ns

module tb_alu;

    parameter wordSize = 32;
    
    reg clk = 0;
    reg clr = 0;
    reg [wordSize-1:0] A = -16;
    reg [wordSize-1:0] B = -2;
    reg [4:0] opcode;
    wire [(wordSize)-1:0] Zlow, Zhigh;
    
    alu_test #(.wordSize(wordSize)) dut (
        .clk(clk),
        .clr(clr),
        .A(A),
        .B(B),
        .opcode(opcode),
        .Zlow(Zlow),
        .Zhigh(Zhigh)
    );
    
    initial begin
        $display("Opcode\tOutput");
        for (opcode = 1; opcode < 16; opcode = opcode + 1) begin
            $display("%d\t%d", opcode, Zlow);
            #10;
        end
    end
    
    always #5 clk = ~clk;
    
endmodule