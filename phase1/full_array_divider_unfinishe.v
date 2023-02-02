module div32arr (a,b,q,r);
	input wire [31:0] a,b;
	output wire [31:0] q,r;
	
	
module div1arr (a,bin,modein,cin,cout,s,modeout,bout);
	input a, bin, modein, cin;
	output cout, bout, s, modeout;
	
	assign modeout = !(modein);
	assign bout = !(bout);
	assign 
	
	
endmodule
	
module fulladder(a,b,cout,cin,s)
	input wire a, b, cin;
	output wire cout, s;
	
	assign s = (a^b)^cin;
	assign cout = (a&b)|(b&cin)|(ci&a);
endmodule