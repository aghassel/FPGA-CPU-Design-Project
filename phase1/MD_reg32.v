module MD_reg32 #(parameter wordSize = 32)(
    input clk, clr, read, MDRin,
    input [wordSize-1:0] BusMuxOut, Mdatain,
    output reg [wordSize-1:0] Q
);

    wire [wordSize-1:0] D;

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