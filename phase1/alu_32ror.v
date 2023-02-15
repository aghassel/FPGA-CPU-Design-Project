module ror32 (in, num_shifts, out);
	input wire [31:0] in;
	input wire [31:0] num_shifts;
	output reg [31:0] out;
	
    wire temp;
    genvar i;
    integer shifts;
	 always @(*) begin
		shifts <= num_shifts;
	 end
	 generate
		for (i=0; i < shifts; i = i + 1) begin : loop
				assign temp = in[0];
				assign in = in>>1;
				assign in[31] = temp;
		end
		assign out = in;
		endgenerate

endmodule