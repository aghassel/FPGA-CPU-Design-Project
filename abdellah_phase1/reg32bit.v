module reg32bit(clr, clk, enable, D, Q);
	input wire clr, clk, enable;
	input wire [31:0]D;
	output reg [31:0]Q;

	
	always @(posedge clk) begin
		if (clr)
			Q <= 0;
		else if (enable)
			Q <= D;
	end
endmodule
	
	