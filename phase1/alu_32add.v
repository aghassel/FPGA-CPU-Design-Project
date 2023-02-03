//Carry look ahead adder
module cla32bit (a,b,cin,s,cout);
	input wire [31:0] a,b;
	input wire cin;
	output wire [31:0] s;
	output wire cout;
	wire c1;
	
	cla16bit cla1 (.a(a[15:0]), .b(b[15:0]), .s(s[15:0]), .cin(cin), .cout(c1));
	cla16bit cla2 (.a(a[31:16]), .b(b[31:16]), .s(s[31:16]), .cin(c1), .cout(cout));

endmodule


module cla16bit (a,b,cin,s,cout);
	input wire [15:0] a,b;
	input wire cin;
	output wire [15:0] s;
	output wire cout;
	wire c1, c2, c3;
	
	cla4bit cla1 (.a(a[3:0]), .b(b[3:0]), .s(s[3:0]), .cin(cin), .cout(c1));
	cla4bit cla2 (.a(a[7:4]), .b(b[7:4]), .s(s[7:4]), .cin(c1), .cout(c2));
	cla4bit cla3 (.a(a[11:8]), .b(b[11:8]), .s(s[11:8]), .cin(c2), .cout(c3));
	cla4bit cla4 (.a(a[15:12]), .b(b[15:12]), .s(s[15:12]), .cin(c3), .cout(cout));
endmodule


module cla4bit (a,b,cin,s,cout);
	input wire [3:0] a,b;
	input wire cin;
	output wire [3:0] s;
	output wire cout;
	wire c1, c2, c3;
	
	cla cla1 (.a(a[0]), .b(b[0]), .s(s[0]), .cin(cin), .cout(c1));
	cla cla2 (.a(a[1]), .b(b[1]), .s(s[1]), .cin(c1), .cout(c2));
	cla cla3 (.a(a[2]), .b(b[2]), .s(s[2]), .cin(c2), .cout(c3));
	cla cla4 (.a(a[3]), .b(b[3]), .s(s[3]), .cin(c3), .cout(cout));
endmodule


module cla (a,b,s,cin,cout);
	input wire a,b,cin;
	output wire s,cout;
	
	wire xor1, and1, and2;
	
	assign xor1 = ((a)^(b));
	assign and1 = ((a)&(b));
	assign and2 = ((xor1)&(cin));
	assign s = ((xor1)^(cin));
	assign cout = ((and1)|(and2));
	
endmodule


	