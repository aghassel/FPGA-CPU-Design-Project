module MD_reg32(
    input clr, clk, read, MDRin,
    input [31:0] BusMuxOut, Mdatain,
    output [31:0] Q
);

    wire [31:0] D;
	 // instantiate a 2-to-1 mux with select signal as 'read'
	 mux2to1 MDMux(
        .data_1(BusMuxOut),
        .data_2(Mdatain),
        .select(read),
        .out(D)
	);
	 // instantiate a 32-bit register with enable signal as 'MDRin'
	reg32bit MDR(
		.clr(clr),
		.clk(clk),
		.enable(MDRin),
		.D(D), // connect the output of the mux to the input of the register
		.Q(Q) // connect the output of the register to the output of the module
	);
    
endmodule