module sub32 (a, b, cin, s, cout);
	input wire signed [31:0] a, b;
	input wire cin;
	output wire signed [31:0] s;
	output wire cout;
	wire [31:0] temp;
	
	neg32 negate(.in(b), .out(temp));
	cla32bit add(.a(a), .b(temp), .cin(cin), .s(s), .cout(cout));
	
endmodule