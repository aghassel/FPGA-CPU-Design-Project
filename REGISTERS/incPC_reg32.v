module incPCreg #(parameter qInitial = 0)(clk, incPC, enable, D, Q);
	input wire clk, enable, incPC;
	input [31:0]D;
	output reg [31:0]Q;
	
	initial Q = qInitial;
		
    //Use posedge clk and check for incPC inside the always block
	always @(posedge clk) begin
		if (enable && incPC) //If clr is high set to 0
			Q <= D + 1;
		else if (enable) //If enable is high, read value from bus to Q
			Q <= D;
	end
endmodule
