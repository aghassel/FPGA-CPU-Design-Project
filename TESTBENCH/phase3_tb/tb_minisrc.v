// Running the simulation outlined in CPU_Phase3

`timescale 1ns/1ps

module tb_minisrc;
    reg run, clear, clock, reset, stop;
    reg [31:0] InPortData;

    datapath dp (
        .run(run),
        .clear(clear),
        .clock(clock),
        .reset(reset),
        .stop(stop),
        .InPortData(InPortData)
        );

    


endmodule
