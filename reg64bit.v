//Inputs 64bit wire into two 32 bit outputs high and low
module reg64bit(clr, clk, enable, D, Qhigh, Qlow);
	input clr, clk, enable;
	input [63:0]D;
	output reg [31:0]Qhigh, Qlow;

	
	always @(posedge clk) begin
		if (clr) begin
			Qlow <= 0;
			Qhigh <= 0;
		end else if (enable) begin
			Qlow <= D[31:0];
			Qhigh <= D[63:32];
		end
	end
endmodule
	
	
