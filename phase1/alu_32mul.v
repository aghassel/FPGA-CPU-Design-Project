//Booths algorithm --unfinished

module multi32 (a,b,p);
	input [31:0] a,b;
	output [63:0] p;
	reg [32:0] mul


	always @(*)begin
		mul[32:1] <= a[31:0];
		mul[0] <= 1'b0;
		p[63:0] <= 64'd0; 
		genvar i;
		reg [63:0] pp;
		integer s;
		s = 0;
		generate
			for (i=0; i < 11, i = i+1) begin : loop
				pp[63:0] = 64'd0
				case (mul[2:0])
					3'b001, 3'b010 : begin // +1 X M
						pp[31:0] = b[31:0];	
						if (pp[31] = 1'b1) pp[63:32] = 32'hFFFFFFFF;
					end 						
					3'b011 : begin // +2 X M
						pp[32:0] = (b[31:0] << 1);	
						if (pp[32] = 1'b1) pp[63:32] = 32'hFFFFFFFF;
					end									
					3'b100 : begin // -2 X M
						pp[32:0] = ((-b[31:0]+1)<<1);	
						if (pp[32] = 1'b1) pp[63:32] = 32'hFFFFFFFF;
					end									
					3'b101, 3'b110 : pp[63:0] = ((-b[31:0]+1)) 						// -1 X M
					default : pp[63:0] = 64'd0							//  0 X M
				endcase
				s = s + 2;
				mul[32:0] = (a[32:0]>>3);
			end

		endgenerate


	end
endmodule

		
		