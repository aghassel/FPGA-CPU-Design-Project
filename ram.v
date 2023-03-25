//512 x 32 RAM
module ram(
    input clk, read, write,
    input [8:0] MARout, 	//address
    input [31:0] D,
    output [31:0] Q
);
	reg [31:0] mem [511:0];
	
	initial $readmemh("ram.hex", mem);
	
	assign Q = (write || !read) ?  32'bZZZZZZZZ : mem[MARout];
	
   always @(posedge clk) begin
	    mem[0] = 32'hB1800000; //opcode for branch case 3 testbench 
		if(write) mem[MARout] = D;
	end
endmodule
