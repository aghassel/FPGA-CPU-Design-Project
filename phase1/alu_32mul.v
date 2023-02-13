//Booths algorithm --unfinished

module multi32 (a,b,p);
	input signed reg [31:0] a,b;
	output signed reg[63:0] p;
	reg [2:0] mul
	reg [31:0] neg_b;
	integer i;
	reg [63:0] pp;
	integer s;

	always @(*)begin
		mul[2:1] = a[2:1];
		mul[0] = 1'b0;
		p[63:0] = 64'd0; 
		
		s = 0;
		neg_b = ((~b[31:0])+1'b1);

		for (i=0; i < 16, i = i+1) begin 
			pp[63:0] = 64'd0
			case (mul[2:0])
				3'b001, 3'b010 : begin // +1 X M
					pp [31:0] = b [31:0];
					if (pp[31] = 1'b1) pp[63:32] = 32'hFFFFFFFF
				end 						
				3'b011 : begin // +2 X M
					pp [31:0] = b [31:0];
					if (pp[31] = 1'b1) pp[63:32] = 32'hFFFFFFFF
					pp = pp << 1;

				end									
				3'b100 : begin // -2 X M
					pp [31:0] = neg_b[31:0];
					if (pp[31] = 1'b1) pp[63:32] = 32'hFFFFFFFF
					pp = pp << 1;
				end									
				3'b101, 3'b110 : begin // -1 X M
					pp [31:0] = neg_b[31:0];
					if (pp[31] = 1'b1) pp[63:32] = 32'hFFFFFFFF
				end			
				default : pp[63:0] = 64'd0							//  0 X M
			endcase

			pp = pp << s;
			s = s + 2;
			a = a >> 2
			mul[2:0] = a[2:0]
			p = p + pp;
		end
	end
endmodule

		
		