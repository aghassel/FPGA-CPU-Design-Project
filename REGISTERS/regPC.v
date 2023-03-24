module regPC #(parameter qInitial = 0)(clr, clk, incPC, enable, D, Q);
	input wire clr, clk, enable, incPC;
	input wire [31:0]D;
	output reg [31:0]Q;

	initial Q = qInitial;

    //Use posedge clk and check for incPC inside the always block
	always @(posedge clk) begin
        if (incPC)
            Q <= Q + 1;
		else if (clr) //If clr is high set to 0
			Q <= 0;
		else if (enable) //If enable is high, read value from bus to Q
			Q <= D;
	end
endmodule
