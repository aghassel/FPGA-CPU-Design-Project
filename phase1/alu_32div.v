module div #(parameter wordSize = 32)(
	input [wordsize-1:0]dividend, divisor,
	output [wordSize*2-1:0] out
	);
	//Z register is 64-bit: remainder in the higher byte, and quotient in the lower byte) operation
	input wire h, l;

	always @(*) begin
		h = dividend % divisor		//remainder
		l = (dividend - h) / divisor //quotient
		out = {h,l} //concatenate high and low in output
	end
endmodule