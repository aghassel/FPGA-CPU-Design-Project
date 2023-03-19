module CONN_FF (
    input [1:0] IRin,
    input [31:0] BusMuxOut,
    input wire CONN_in,
    output reg CONN_out
);
    wire nor_bus, msb_bus;
	 reg D;

    //Nor gate all bus inputs
    assign nor_bus = BusMuxOut == 0 ? 1'b1 : 1'b0;

    //Get MSB of bus
    assign msb_bus = BusMuxOut[31];

    //2 to 4 decoder and value a
    always @(*) begin
        case(IRin)
            2'b00: D = nor_bus;
            2'b01: D = ~nor_bus;
            2'b10: D = ~msb_bus;
            2'b11: D = msb_bus;
        endcase

        if(CONN_in)
            CONN_out = D;
        else
            CONN_out = 1'b0;
    end
endmodule
