module not32 (in, out);
	input wire signed[31:0] in;
	output reg signed[31:0] out;
	
	genvar i;
	generate 
		for (i=0; i<32; i = i+1) begin : loop
			assign out[i] = !in[i];
		end
	endgenerate
endmodule
	