module shra32 (in, num_shifts, out);
	input wire signed [31:0] in;
	input wire [31:0] num_shifts;
	output reg signed [31:0] out;
	
	always @(*) begin
		out[31:0] = in>>>num_shifts;
	end
endmodule

