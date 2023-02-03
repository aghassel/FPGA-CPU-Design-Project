module neg32 (in, out);
	input wire [31:0] in;
	output reg[31:0] out;
	wire [31:0] temp;
	wire cout;
	
	always @(*) begin
		alu_32not notop(.in(in),.out(temp));
		alu_32cla add_op(.a(temp), .b(32'd1), .cin(1'd0), .s(out), .cout(cout));
	end
endmodule
