module regR0(BAout, clr, clk, enable, D, Q);
	input wire BAout, clr, clk, enable;
	input wire [31:0] D;
	output wire [31:0] Q;

	//At positive clock edge begin
	reg [31:0] regout;
	
	always @(posedge clk) begin
		if (clr) //If clr is high set to 0
			regout <= 0;
		else if (enable) //If enable is high, read value from bus to Q
            regout <= D;
	end
    
	assign Q = BAout ? 32'b0 : regout;

endmodule
	
	