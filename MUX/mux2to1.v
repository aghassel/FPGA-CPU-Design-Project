module mux2to1(data_1, data_2, out, select);
	input wire [31:0] data_1, data_2;
	input wire select;
	output reg [31:0]out;
	
	always@(*)begin
		if (select)
			out <= data_2;
		else
			out <= data_1;
	end
endmodule
	