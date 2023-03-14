//512 x 32 RAM
module ram(
    input read, write,
    input [8:0] MARout,
    input [31:0] MDRout;
    output reg [31:0] BusMuxIn_MDR;
);
    reg [31:0] mem [512];

    always @(read, write, MDRout) begin
        //If read is high, put mem as input to MDR, else don't assign to MDR wire
        if (read)
            MDRin = mem[MARout];
        else MDRin = 32'hx;

        //If write is high, write in location specified.
        if (write)
            mem[MARout] = MDRout;
    end
endmodule

