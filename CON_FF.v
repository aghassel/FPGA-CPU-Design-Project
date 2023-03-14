// The “CON FF” logic is used to determine whether the correct condition
// has been met to cause branching to take place in a Conditional Branch instruction

module CONN_FF (
    input [1:0] IRin, 
    input [31:0] BuxMuxOut,
    input CONN_in,
    output CONN_out;
);
    wire nor_bus, msb_bus, D;

    //Nor gate all bus inputs
    assign nor_bus = BusMuxOut == 0 ? 1'b1 : 1'b0;

    //Get MSB of bus
    assign msb_bus = BuxMuxOut[31];

    //2 to 4 decoder and value a
    always @(*) begin
        case(IRin)
            2'b00: assign D = nor_bus;
            2'b01: assign D = ~nor_bus;
            2'b10: assign D = ~msb_bus;
            2'b11: assign D = msb_bus;
        endcase

        if(CONN_in)
            CONN_out = D;
        else
            CONN_out = 1'b0;
    end
endmodule

