module pcReg #(parameter qInitial = 0)(clr, clk, incPC, enable, D, Q);
	input wire clr, clk, enable incPC;
	input wire [31:0]D;
	output reg [31:0]Q;

	initial Q = qInitial;

    always @(posedge incPC) begin
        if (incPC)
            Q <= Q + 4;
    end

	//At positive clock edge begin, regular register operations  
	always @(posedge clk) begin
		if (clr) //If clr is high set to 0
			Q <= 0;
		else if (enable) //If enable is high, read value from bus to Q
			Q <= D;
	end
endmodule
		