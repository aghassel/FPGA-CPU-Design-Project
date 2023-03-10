`timescale 1ns/1ns
//Testbench does the following operation:
// div R1, R2, R3, 
// R2 holds 16, R3 holds -2

module datapath_tb;
    reg clk = 0;
    reg clr = 0;
    reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
    reg HIin, LOin, Zin, incPC, MARin, MDRin, Read, InPortin, Cin, Yin;
    reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
    reg HIout, LOout, ZLowOut, ZHighOut, MARout, MDRout, Cout, Yout, InPortOut;
    reg [4:0] opcode;
    reg [31:0] Mdatain;

    parameter   Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
                Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
                T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101;

    reg [3:0] cur_state = Default;

    datapath DUT(.clr(clr), .clk(clk), .R0in(R0in), .R1in(R1in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), 
                .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in),
                .HIin(HIin), .LOin(LOin), .Zin(Zin) .incPC(incPC), .MARin(MARin), .MDRin(MDRin), .Read(Read),
                .InPortin(InPortin), .Cin(Cin), .Yin(Yin), .opcode(opcode), .Mdatain(Mdatain));

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    always @(posedge clk) begin
        case (cur_state):
            Default     : cur_state = Reg_load1a;
            Reg_load1a  : cur_state = Reg_load1b;
            Reg_load1b  : cur_state = Reg_load2a;
            Reg_load2a  : cur_state = Reg_load2b;
            Reg_load2b  : cur_state = Reg_load3a;
            Reg_load3a  : cur_state = Reg_load3b;
            Reg_load3b  : cur_state = T0;
            T0          : cur_state = T1; 
            T1          : cur_state = T2; 
            T2          : cur_state = T3; 
            T3          : cur_state = T4; 
            T4          : cur_state = T5; 
            T5          : cur_state = T6;
        endcase    
    end

    always @(cur_state) begin 
        case (cur_state):
            Default: begin //Initialize everything to 0
                incPC <= 0;
                Zlowout <= 0;
                MDRout <= 0;
                R2out <= 0;
                R3out <= 0;
                R1out <= 0;
                MARin <= 0;
                Zin <= 0;
                PCin <= 0;
                MDRin <= 0;
                IRin <= 0;
                Yin <= 0;
                Read <= 0;
                R1in <= 0;
                R2in <= 0;
                R3in <= 0;
                R4in <= 0;
                R5in <= 0;
                R6in <= 0;
                R7in <= 0;
                R8in <= 0;
                R9in <= 0;
                R10in <= 0;
                R11in <= 0;
                R12in <= 0;
                R13in <= 0;
                R14in <= 0;
                R15in <= 0;
                Hiin <= 0;
                LOin <= 0;
                Zh
                Mdatain <= 0;
            end

            Reg_load1a: begin
                Mdatain <= 0;
                Read = 0; MDRin = 0;
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRIn <= 0;            
            end

            Reg_load1b: begin
                #10 MDRout <= 1; R1in <= 1;
                #15 MDRout <= 0; R1in <= 0;
            end

            Reg_load2a: begin
                Mdatain <= 16;
                Read = 0; MDRin = 0;
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRIn <= 0;            
            end

            Reg_load2b: begin
                #10 MDRout <= 1; R2in <= 1;
                #15 MDRout <= 0; R2in <= 0;
            end
            Reg_load3a: begin
                Mdatain <= -2;
                Read = 0; MDRin = 0;
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRIn <= 0;            
            end

            Reg_load3b: begin
                #10 MDRout <= 1; R3in <= 1;
                #15 MDRout <= 0; R3in <= 0;
            end

            T0: begin
                IncPC <= 1;
                MARin <= 1;

            end


        endcase

    end

endmodule