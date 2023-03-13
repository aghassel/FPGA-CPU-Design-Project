module ror32 (in, num_shifts, out);
    input wire signed [31:0] in;
    input wire signed [31:0] num_shifts;
    output wire signed [31:0] out;
	
	assign out = (in >> num_shifts) | (in << ~num_shifts);

endmodule
