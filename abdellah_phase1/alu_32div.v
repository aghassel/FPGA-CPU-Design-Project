module div #(parameter wordSize = 32)(
	input signed[wordSize-1:0]dividend, divisor,
	output signed[wordSize*2-1:0] out
	);
	//Z register is 64-bit: remainder in the higher byte, and quotient in the lower byte) operation
	wire [wordSize-1:0] h, l;

	assign h = dividend % divisor;		//remainder
	assign l = (dividend - h) / divisor; //quotient
	assign out = {h,l}; //concatenate high and low in output
endmodule