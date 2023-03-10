module reg32bit(clr, clk, enable, D, Q);
	input wire clr, clk, enable;
	input wire [31:0]D;
	output reg [31:0]Q;

	
	always @(posedge clk) begin
		if (clr) begin
			Q[31:0]  <= 32'b0;
		end
		else if (enable) begin
			Q[31:0] <= D[31:0];
		end
	end
endmodule
	
	