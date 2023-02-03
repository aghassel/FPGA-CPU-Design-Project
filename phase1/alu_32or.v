 module or32 (a,b,c);
	input wire [31:0]a,b;
	output reg [31:0]c;
	genvar i;
	
	always @(*)begin
		generate
			for (i = 0; i < 31; i = i + 1) begin : loop
				assign c[i] = ((a[i])|(b[i]));
			end
		endgenerate
	end
endmodule
		