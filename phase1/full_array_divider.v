
	

	
module arraydivider (a,bin,modein,cin,cout,s,modeout,bout);
	input a, bin, modein, cin;
	output cout, bout, s, modeout;
	wire xor1;
	 
	assign modeout = !(modein);
	assign bout = !(bout);
	assign xor1 = (modein^bin);
	fulladder fa (.a(xor1), .b(a), .cin(cin), .cout(cout), .s(s));
endmodule
	
	
	
endmodule
	
module fulladder(a,b,cin,cout,s)
	input wire a, b, cin;
	output wire cout, s;
	
	assign s = (a^b)^cin;
	assign cout = (a&b)|(b&cin)|(ci&a);
endmodule