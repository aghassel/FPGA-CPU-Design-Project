module datapath (
input clr, clk, read, write,
input BAout, Rin, Rout, Gra, Grb, Grc, CONN_in, //Added in phase2 for select logic and CONN_FF
input HIin, LOin, Zin, incPC, MARin, MDRin, InPortIn, OutPortIn, Cin, Yin, IRin,
input HIout, LOout, ZLowOut, ZHighOut, MDRout, Cout, InPortout, PCin, PCout, 

input [4:0] opcode,
input [31:0] InData
);

wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
wire Control_unit_in;

wire [31:0] BusMuxIn_R0, 
            BusMuxIn_R1, 
            BusMuxIn_R2, 
            BusMuxIn_R3, 
            BusMuxIn_R4, 
            BusMuxIn_R5, 
            BusMuxIn_R6, 
            BusMuxIn_R7, 
            BusMuxIn_R8, 
            BusMuxIn_R9, 
            BusMuxIn_R10, 
            BusMuxIn_R11, 
            BusMuxIn_R12, 
            BusMuxIn_R13, 
            BusMuxIn_R14, 
            BusMuxIn_R15;

wire [31:0] BusMuxIn_HI, 
            BusMuxIn_LO, 
            BusMuxIn_Zhigh, 
            BusMuxIn_Zlow, 
            BusMuxIn_PC, 
            BusMuxIn_MDR, 
            BusMuxIn_InPort,
            Yout,
            MARout,
            BusMuxOut,
            C_sign_extended, //Csign extended for branching
            IRdata, //Output of IR reg
            OutPortOut; //Wire for outport. Goes no where

wire [63:0] CRegOut; 

regR0 R0 (BAout, clr, clk, R0in, R0wire, BusMuxIn_R0); //input signal is always 0 for R0 (special reg)
reg32bit R1 (clr, clk, R1in, BusMuxOut, BusMuxIn_R1);
reg32bit R2 (clr, clk, R2in, BusMuxOut, BusMuxIn_R2);    
reg32bit R3 (clr, clk, R3in, BusMuxOut, BusMuxIn_R3);  
reg32bit R4 (clr, clk, R4in, BusMuxOut, BusMuxIn_R4);  
reg32bit R5 (clr, clk, R5in, BusMuxOut, BusMuxIn_R5);  
reg32bit R6 (clr, clk, R6in, BusMuxOut, BusMuxIn_R6);  
reg32bit R7 (clr, clk, R7in, BusMuxOut, BusMuxIn_R7);  
reg32bit R8 (clr, clk, R8in, BusMuxOut, BusMuxIn_R8);  
reg32bit R9 (clr, clk, R9in, BusMuxOut, BusMuxIn_R9);  
reg32bit R10 (clr, clk, R10in, BusMuxOut, BusMuxIn_R10);  
reg32bit R11 (clr, clk, R11in, BusMuxOut, BusMuxIn_R11);  
reg32bit R12 (clr, clk, R12in, BusMuxOut, BusMuxIn_R12);  
reg32bit R13 (clr, clk, R13in, BusMuxOut, BusMuxIn_R13);  
reg32bit R14 (clr, clk, R14in, BusMuxOut,  BusMuxIn_R14);  
reg32bit R15 (clr, clk, R15in, BusMuxOut,  BusMuxIn_R15); 

reg32bit HI (clr, clk, HIin, BusMuxOut, BusMuxIn_HI); 
reg32bit LO (clr, clk, LOin, BusMuxOut, BusMuxIn_LO);
reg32bit ZHigh (clr, clk, Zin, CRegOut[63:32], BusMuxIn_Zhigh);
reg32bit ZLow (clr, clk, Zin, CRegOut[31:0], BusMuxIn_Zlow);

//PC reg initialization, using specific incPC input to increment PC by 1 each time set to high
regPC PC (clr, clk, incPC, PCin, BusMuxOut, BusMuxIn_PC); 
 
//Input and output ports added to datapath (p2)
reg32bit InPort (clr, clk, InPortIn, InData, BusMuxIn_InPort); 
reg32bit OutPort (clr, clk, OutPortIn, BusMuxOut, OutPortOut);

//MDR reg initialization
MD_reg32 MDR (.clr(clr), .clk(clk), .read(read), .MDRin(MDRin), .BusMuxOut(BusMuxOut), .Mdatain(Mdatain), .Q(BusMuxIn_MDR)); //special MDR reg

reg32bit MAR (clr, clk, MARin, BusMuxOut, MARout);      
<<<<<<< HEAD
reg32bit Y (clr, clk, Yin, BusMuxOut, Yout);           
=======
reg32bit Y (clr, clk, Yin, BusMuxOut, Yout);          
>>>>>>> 20f34f876dfe55bfddbce60773625f58dfbe9078

//Instruction register. IRdata doesn't go on the bus, but leads to CON
reg32bit IR (clr, clk, IRin, BusMuxOut, IRdata);

//Memory initialization
ram myRam (.clk(clk), .read(read), .write(write), .MARout(MARout[8:0]), .D(MDRout), .Q(BusMuxIn_MDR));

//Control Branch logic
CONN_FF myConn_ff (
    .IRin(IRdata[20:19]),
    .BusMuxOut(BusMuxOut),
    .CONN_in(CONN_in),
    .CONN_out(Control_unit_in)
);

//Select and Encode logic for selecting register functions based on opcode
select_and_encode mySAE (
    .irOut(IRdata),
    .Gra(Gra),
    .Grb(Grb),
    .Grc(Grc),
    .Rin(Rin),
    .Rout(Rout),
    .BAout(BAout),
    .R1in(R1in),
    .R2in(R2in),
    .R3in(R3in), 
    .R4in(R4in), 
    .R5in(R5in), 
    .R6in(R6in), 
    .R7in(R7in), 
    .R8in(R8in), 
    .R9in(R9in), 
    .R10in(R10in), 
    .R11in(R11in), 
    .R12in(R12in), 
    .R13in(R13in), 
    .R14in(R14in), 
    .R15in(R15in), 
    .R1out(R1out), 
    .R2out(R2out), 
    .R3out(R3out), 
    .R4out(R4out), 
    .R5out(R5out), 
    .R6out(R6out), 
    .R7out(R7out), 
    .R8out(R8out), 
    .R9out(R9out), 
    .R10out(R10out),
    .R11out(R11out), 
    .R12out(R12out), 
    .R13out(R13out), 
    .R14out(R14out),
    .R15out(R15out),
    .C_sign_extended(C_sign_extended)
);

//bus
bus myBus (
    //encoder
    .R0out(R0out),
    .R1out(R1out),
    .R2out(R2out),
    .R3out(R3out),
    .R4out(R4out),
    .R5out(R5out),
    .R6out(R6out),
    .R7out(R7out),
    .R8out(R8out),
    .R9out(R9out),
    .R10out(R10out),
    .R11out(R11out),
    .R12out(R12out),
    .R13out(R13out),
    .R14out(R14out),
    .R15out(R15out),
    .HIout(HIout),
    .LOout(LOout),
    .ZHighOut(ZHighOut),
    .ZLowOut(ZLowOut),
    .PCout(PCout),
    .MDRout(MDRout),
    .InPortout(InPortout),
    .Cout(Cout),
    //multiplexer
    .BusMuxIn_R0(BusMuxIn_R0),
    .BusMuxIn_R1(BusMuxIn_R1),
    .BusMuxIn_R2(BusMuxIn_R2),
    .BusMuxIn_R3(BusMuxIn_R3),
    .BusMuxIn_R4(BusMuxIn_R4),
    .BusMuxIn_R5(BusMuxIn_R5),
    .BusMuxIn_R6(BusMuxIn_R6),
    .BusMuxIn_R7(BusMuxIn_R7),
    .BusMuxIn_R8(BusMuxIn_R8),
    .BusMuxIn_R9(BusMuxIn_R9),
    .BusMuxIn_R10(BusMuxIn_R10),
    .BusMuxIn_R11(BusMuxIn_R11),
    .BusMuxIn_R12(BusMuxIn_R12),
    .BusMuxIn_R13(BusMuxIn_R13),
    .BusMuxIn_R14(BusMuxIn_R14),
    .BusMuxIn_R15(BusMuxIn_R15),
    .BusMuxIn_HI(BusMuxIn_HI),
    .BusMuxIn_LO(BusMuxIn_LO),
    .BusMuxIn_Zhigh(BusMuxIn_Zhigh),
    .BusMuxIn_Zlow(BusMuxIn_Zlow),
    .BusMuxIn_PC(BusMuxIn_PC),
    .BusMuxIn_MDR(BusMuxIn_MDR),
    .BusMuxIn_InPort(BusMuxIn_InPort),
    .C_sign_extended(C_sign_extended),
    .BusMuxOut(BusMuxOut)
);

//alu
alu_test myAlu(
	.clk(clk),
	.clr(clr), 
	.B(BusMuxOut),
    .A(Yout),
	.opcode(opcode),
	.C(CRegOut)
	);
endmodule