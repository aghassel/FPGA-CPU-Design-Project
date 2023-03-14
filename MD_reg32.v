module MD_reg32(
    input clr, clk, read, MDRin,
    input [31:0] BusMuxOut, Mdatain,
    output [31:0] Q
);

    wire [31:0] D;
	 
	 mux2to1 MDMux(
        .data_1(BusMuxOut),
        .data_2(Mdatain),
        .select(read),
        .out(D)
	);
	 
	reg32bit MDR(
		.clr(clr),
		.clk(clk),
		.enable(MDRin),
		.D(D),
		.Q(Q)
	);
    
endmodule