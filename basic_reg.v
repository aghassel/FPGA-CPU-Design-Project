module basic_reg(clr, clk, rin, D, Q);
	input wire clr, clk, rin;
	input wire [31:0]D;
	output reg [31:0]Q;

	
	always @(posedge clk) begin
		if (clr)
			Q <= 0;
		else if (rin)
			Q <= D;
	end
endmodule
	
	