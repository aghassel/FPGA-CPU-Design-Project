module shr32 (in, num_shifts, out);
	input wire [31:0] in;
	input wire [31:0] num_shifts;
	output reg [31:0] out;
	
	always @(*) begin
		assign out[31:0] = in>>num_shifts;
	end
endmodule