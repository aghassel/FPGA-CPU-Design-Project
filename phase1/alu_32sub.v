module sub32 (a, b, cin, s, cout);
	input wire [31:0] a, b;
	input wire cin;
	output reg [31:0] sum;
	output reg cout;
	wire [31:0] temp;
	
	always @(*) begin
		alu_32neg negate(.in(b), .out(temp));
		alu_32cla add(.a(a), .b(temp), .cin(cin), .s(s), .cout(cout));
	end
endmodule