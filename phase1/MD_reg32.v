module MD_reg32 #(parameter wordSize = 32)(
    input clk, clr, read, MDRin,
    input [wordSize-1:0] BusMuxOut, Mdatain,
    output reg [wordSize-1:0] Q
);

    wire [wordSize-1:0] D;

<<<<<<< HEAD
mux2to1 MDMux(
=======
	mux2to1 MDMux(
>>>>>>> f35ae5f22927c41e987fbd236395e4041ec719ba
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

<<<<<<< HEAD
    endmodule
=======
	
endmodule
>>>>>>> f35ae5f22927c41e987fbd236395e4041ec719ba
