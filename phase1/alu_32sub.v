module sub32 (a, b, cin, s, cout);
	input wire signed [31:0] a, b;
	input wire cin;
	output wire signed [31:0] sum;
	output wire cout;
	wire [31:0] temp;
	
	alu_32neg negate(.in(b), .out(temp));
	alu_32cla add(.a(a), .b(temp), .cin(cin), .s(s), .cout(cout));
	
endmodule