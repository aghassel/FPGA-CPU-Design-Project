module and32 (a,b,c);
	input wire [31:0]a,b;
	output reg [31:0]c;
	integer i;
	always @(*)begin
		for (i = 0; i < 31; i = i + 1) begin 
			assign c[i] = ((a[i])&(b[i]));
		end
	end
endmodule
		