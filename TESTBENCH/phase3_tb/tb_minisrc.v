// Running the simulation outlined in CPU_Phase3

`timescale 1ns/1ps

module tb_minisrc;
    //Inputs
    reg run, clock; 
    wire [31:0] InPortData;
    //Outputs
    reg reset, stop; 
    //wire clear;

    datapath dp (
    .run(run),
    .clk(clock),
    .reset(reset),
    .stop(stop),
    //.clr(clear),
    .InPortData(InPortData)
);

    initial begin
		#2 clock = 0; reset = 1;
      #2 reset = 0;
      #2 stop = 0;
		  
	end
    always
        #2 clock = ~clock;
endmodule
