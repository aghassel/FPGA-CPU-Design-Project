module reg32bit(BAout, clr, clk, enable, D, Q);
	input wire clr, clk, enable;
	input wire [31:0]D;
	output reg [31:0]Q;
	//At positive clock edge begin
	wire regout;
	
	always @(posedge clk) begin
		if (clr) //If clr is high set to 0
			regout <= 0;
		else if (enable) //If enable is high, read value from bus to Q
            regout <= D;
	end
    always @(*) begin
        if (~BAout)
            Q <= 0;
		else
			Q <= regout;
    end

endmodule
	
	