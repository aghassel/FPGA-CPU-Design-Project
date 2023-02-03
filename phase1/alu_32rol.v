module rol32 (in, num_shifts, out);
	input wire [31:0] in;
	input wire [31:0] num_shifts;
	output reg [31:0] out;
	
    wire temp;
    genvar i;
    integer shifts;
	always @(*) begin
        shifts = num_shifts;
        generate
            for (i=0; i < shifts, i = i + 1) begin : loop
                assign temp = in[31];
                assign in = in<<1;
                assign in[0] = temp;
            end
            assign out = in;
        endgenerate
	end
endmodule