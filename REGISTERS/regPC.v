module regPC #(parameter qInitial = 0)(clr, clk, incPC, enable, D, Q);
	input wire clr, clk, enable, incPC;
	input wire [31:0]D;
	output reg [31:0]Q;
	
	reg [31:0] next_Q;
	
	initial Q = qInitial;
	
	always @(posedge incPC) begin
		next_Q = Q + 1;
	end
	
    //Use posedge clk and check for incPC inside the always block
	always @(posedge clk) begin
		if (clr) //If clr is high set to 0
			Q <= 0;
		else if (enable) //If enable is high, read value from bus to Q
			Q <= D;
		else
			Q <= next_Q;
	end
endmodule
