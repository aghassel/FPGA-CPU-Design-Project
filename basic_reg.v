module basic_reg(clr, clk, rin, D, Q);
	input clr, clk, rin;
	input [31:0]D;
	output reg [31:0]Q;

	
	always @(posedge clk) begin
		if (clr)
			Q <= 0;
		if (rin)
			Q <= D;
	end
endmodule
	
	