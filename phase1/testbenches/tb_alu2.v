`timescale 1ns/10ps

module alu_tb();

    // Inputs
    reg [31:0] A_tb;
    reg [31:0] B_tb;
    reg [4:0] opcode_tb;
    reg clk_tb;
    reg clr_tb;
    reg [31:0] control_tb;
    
    // Outputs
    wire [63:0] C_tb;

    // Instantiate the DUT
    alu alu_inst(
        .A(A_tb),
        .B(B_tb),
        .opcode(opcode_tb),
        .clk(clk_tb),
        .clr(clr_tb),
        .control(control_tb),
        .C(C_tb)
    );

    // Generate a clock signal
    always #5 clk_tb = ~clk_tb;

    // Initialize inputs
    initial begin
        A_tb = 32'd0;
        B_tb = 32'd0;
        opcode_tb = 5'b00000;
        clr_tb = 1'b0;
        control_tb = 32'd0;
    end

    // Testbench stimulus
 initial begin
		// Test 1: Addition
		#10 A_tb = 32'd10;
		B_tb = 32'd20;
		opcode_tb = 5'b00001;
		#10;
		$display("Addition test: C = %d", C_tb);
		assert(C_tb == 32'd30);

		// Test 2: Subtraction
		#10 A_tb = 32'd50;
		B_tb = 32'd20;
		opcode_tb = 5'b00010;
		#10;
		$display("Subtraction test: C = %d", C_tb);
		assert(C_tb == 32'd30);

		// Test 3: Multiplication
		#10 A_tb = 32'd10;
		B_tb = 32'd20;
		opcode_tb = 5'b00011;
		#10;
		$display("Multiplication test: C = %d", C_tb);
		assert(C_tb == 32'd200);

		// Test 4: Division
		#10 A_tb = 32'd100;
		B_tb = 32'd10;
		opcode_tb = 5'b00100;
		#10;
		$display("Division test: C = %d", C_tb);
		assert(C_tb == 32'd10);

		// Test 5: Bitwise right shift
		#10 A_tb = 32'd10;
		B_tb = 32'd4;
		opcode_tb = 5'b00101;
		#10;
		$display("Bitwise right shift test: C = %d", C_tb);
		assert(C_tb == 32'd0);

		// Test 6: Bitwise left shift
		#10 A_tb = 32'd10;
		B_tb = 32'd4;
		opcode_tb = 5'b00110;
		#10;
		$display("Bitwise left shift test: C = %d", C_tb);
		assert(C_tb == 32'd160);

		// Test 7: Arithmetic right shift
		#10 A_tb = 32'd-10;
		B_tb = 32'd2;
		opcode_tb = 5'b00111;
		#10;
		$display("Arithmetic right shift test: C = %d", C_tb);
		assert(C_tb == 32'd-3);

		// Test 8: Rotate right
		#10 A_tb = 32'd0x55555555;
		B_tb = 32'd4;
		opcode_tb = 5'b01000;
		#10;
		$display("Rotate right test: C = %d", C_tb);
	end
endmodule
  
	  
