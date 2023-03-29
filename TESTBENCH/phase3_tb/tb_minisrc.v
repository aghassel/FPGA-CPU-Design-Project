// Running the simulation outlined in CPU_Phase3

`timescale 1ns/1ps

module tb_minisrc;
    //Inputs
    reg run, clear, clock; 
    reg [31:0] InPortData;
    //Outputs
    reg reset, stop; 


    datapath dp (
        .run(run),
        .clear(clear),
        .clock(clock),
        .reset(reset),
        .stop(stop),
        .InPortData(InPortData)
        );

    initial begin
		clk = 0; reset = 1;
        #2 clk = 1;
        #2 clk = 0; reset = 0;
        #2 clk = 1;
		forever #2 clk = ~clk;
	end


endmodule