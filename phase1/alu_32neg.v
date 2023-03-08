module neg32 (in, out);
	input wire signed[31:0] in;
	output wire signed[31:0] out;
	wire [31:0] temp;
	wire cout;
	
	not32 notop (.in(in),.out(temp));
	cla32bit add_op (.a(temp), .b(32'd1), .cin(1'd0), .s(out), .cout(cout));
	
endmodule
