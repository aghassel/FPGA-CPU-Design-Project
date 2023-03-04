module datapath (
input clr, clk, enable,
input R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, 
input HIin, LOin, ZHighIn, ZLowIn, incPC, MARin, MDRin, Mdatain, Read, InPortin, Cin, Yin,
input [4:0] opcode
);

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
            BusMuxOut;

wire [63:0] CRegOut;
wire [4:0]  encoderSignal;  


reg32bit R0 (clr, clk, 1'd0, BusMuxOut, BusMuxIn_R0); //input signal is always 0 for R0 (special reg)
reg32bit R2 (clr, clk, R3_in, BusMuxOut, BusMuxIn_R2);  
reg32bit R1 (clr, clk, R2_in, BusMuxOut, BusMuxIn_R1);  
reg32bit R3 (clr, clk, R4_in, BusMuxOut, BusMuxIn_R3);  
reg32bit R4 (clr, clk, R5_in, BusMuxOut, BusMuxIn_R4);  
reg32bit R5 (clr, clk, R6_in, BusMuxOut, BusMuxIn_R5);  
reg32bit R6 (clr, clk, R7_in, BusMuxOut, BusMuxIn_R6);  
reg32bit R7 (clr, clk, R8_in, BusMuxOut, BusMuxIn_R7);  
reg32bit R8 (clr, clk, R9_in, BusMuxOut, BusMuxIn_R8);  
reg32bit R9 (clr, clk, R10_in, BusMuxOut, BusMuxIn_R9);  
reg32bit R10 (clr, clk, R11_in, BusMuxOut, BusMuxIn_R10);  
reg32bit R11 (clr, clk, R12_in, BusMuxOut, BusMuxIn_R11);  
reg32bit R12 (clr, clk, R13_in, BusMuxOut, BusMuxIn_R12);  
reg32bit R13 (clr, clk, R14_in, BusMuxOut, BusMuxIn_R13);  
reg32bit R14 (clr, clk, R15_in, BusMuxOut,  BusMuxIn_R14);  
reg32bit R15 (clr, clk, R16_in, BusMuxOut,  BusMuxIn_R15); 

reg32bit HI (clr, clk, HIin, BusMuxOut, BusMuxIn_HI); 
reg32bit LO (clr, clk, LOin, BusMuxOut, BusMuxIn_LO);
reg32bit ZHigh (clr, clk, ZHighIn, CRegOut[63:32], BusMuxIn_Zhigh);
reg32bit ZLow (clr, clk, ZLowIn, CRegOut[31:0], BusMuxIn_Zlow);
reg32bit PC (clr, clk, incPC, BusMuxOut, BusMuxIn_PC);  
MD_reg32 MDR (clr, clk, Read, MDRin, BusMuxOut, Mdatain, BusMuxIn_MDR); //special MDR reg

reg32bit MAR (clr, clk, MARin, BusMuxOut, MARout);      //do we use this?
reg32bit Y (clr, clk, Yin, BusMuxOut, Yout);           //or this?

//bus
bus myBus (
    //encoder
    .R0out(R0in),
    .R1out(R1in),
    .R2out(R2in),
    .R3out(R3in),
    .R4out(R4in),
    .R5out(R5in),
    .R6out(R6in),
    .R7out(R7in),
    .R8out(R8in),
    .R9out(R9in),
    .R10out(R10in),
    .R11out(R11in),
    .R12out(R12in),
    .R13out(R13in),
    .R14out(R14in),
    .R15out(R15in),
    .HIout(HIin),
    .LOout(LOin),
    .Zhighout(ZHighIn),
    .Zlowout(ZLowIn),
    .PCout(incPC),
    .MDRout(MDRin),
    .InPortout(InPortin),
    .Cout(.Cin),
    .eout(encoderSignal),
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
    .BusMuxOut(BusMuxOut)
);

//alu
alu_test myAlu(
	.clk(clk),
	.clr(clr), 
	.A(BusMuxOut), //A is passed the contents from the bus
	.B(BusMuxOut),
    .Y(Yout),
	.opcode(opcode),
	.C(CRegOut)
	);

endmodule