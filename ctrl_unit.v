`timescale 1ns/1ps

module ctrl_unit;

    //Control unit registers
    reg clr, clk;
    reg read, write;
    reg BAout, Rin, Rout;
    reg Gra, Grb, Grc;
	reg CONN_in;
	reg MARin, MDRin;
    reg HIin, LOin;
	reg Yin, Zin;
	reg PCin, IRin, incPC;
	reg InPortIn, OutPortIn;
	reg HIout, LOout, ZHighOut, ZLowOut;
    reg MDRout, PCout, InPortOut, Cout;
	reg [31:0] InPortData;
	reg [4:0] opcode;

    //ALU opcodes
    parameter   nop = 5'b00000,
				addop = 5'b00001,
                subop = 5'b00010, 
                mulop = 5'b00011, 
                divop = 5'b00100,
                shrop = 5'b00101,
                shlop = 5'b00110,
                shraop = 5'b00111, 
                rorop = 5'b01000,
                rolop = 5'b01001,
                andop = 5'b01010,
                orop = 5'b01011,
                negop = 5'b01100,
                xorop = 5'b01101,
                norop = 5'b01110,
                notop = 5'b01111; 

    //IR opcodes
    parameter 




    datapath main (
        .clr(clr),
        .clk(clk),
        .read(read),
        .write(write),
        .BAout(BAout),
        .Rin(Rin),
        .Rout(Rout),
        .Gra(Gra),
        .Grb(Grb),
        .Grc(Grc),
        .CONN_in(CONN_in),
        .MARin(MARin),
        .MDRin(MDRin),
        .HIin(HIin),
        .LOin(LOin),
        .Yin(Yin),
        .Zin(Zin),
        .PCin(PCin),
        .IRin(IRin),
        .incPC(incPC),
        .InPortIn(InPortIn),
        .OutPortIn(OutPortIn),
        .HIout(HIout),
        .LOout(LOout),
        .ZLowOut(ZLowOut),
        .ZHighOut(ZHighOut),
        .MDRout(MDRout),
        .Cout(Cout),
        .InPortOut(InPortOut),
        .PCout(PCout), 
        .opcode(opcode),
        .InPortData(InPortData)
    );


endmodule 