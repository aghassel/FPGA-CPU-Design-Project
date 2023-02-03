//Booths algorithm

module multi32 (a,b,,cout,s);
	input signed [31:0] a, b;
	output signed [63:0] z);
	output wire c;
	reg signed [31:0] z, z_next, z_temp;
	reg next_state, present_state;
	reg [1:0] temp, next_temp;
	reg[1:0] count, next_count; 
	reg valid, next_valid;
	
	parameter IDLE = 1'b0;
	parameter START = 1b'1;

	always @(*) begin
		z<= 64'd0;
		valid <= 1'b0;
		present_state <= 1'b0;
		temp <= 2'd0;
		count <=	2'd0;
		
		
		 
		
		