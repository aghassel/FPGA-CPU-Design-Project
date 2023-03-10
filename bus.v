module bus  #(parameter wordSize = 32)(
    //encoder signals
    input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    input HIout, LOout, ZHighOut, ZLowOut, PCout, MDRout, InPortout, Cout,
    //multiplexer registers
    input [wordSize-1:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15,
    input [wordSize-1:0] BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_InPort,
    output [wordSize-1:0] BusMuxOut
);

wire [4:0] s;

wire [wordSize-1:0] c_sign_extended;

assign c_sign_extended = (Cout == 0) ? 32'd0 : 32'd1;

encoder32to5 myEncoder (
	.ein({8'b0, Cout, InPortout, MDRout, PCout, ZHighOut, ZLowOut, HIout, LOout, 
        R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out}),
	.eout(s)
);

mux32to1 BusMux(

    .data0(BusMuxIn_R0),
    .data1(BusMuxIn_R1),
    .data2(BusMuxIn_R2),
    .data3(BusMuxIn_R3),
    .data4(BusMuxIn_R4),
    .data5(BusMuxIn_R5),
    .data6(BusMuxIn_R6),
    .data7(BusMuxIn_R7),
    .data8(BusMuxIn_R8),
    .data9(BusMuxIn_R9),
    .data10(BusMuxIn_R10),
    .data11(BusMuxIn_R11),
    .data12(BusMuxIn_R12),
    .data13(BusMuxIn_R13),
    .data14(BusMuxIn_R14),
    .data15(BusMuxIn_R15),
    .data16(BusMuxIn_LO),
    .data17(BusMuxIn_HI),
    .data18(BusMuxIn_Zlow),
    .data19(BusMuxIn_Zhigh),
    .data20(BusMuxIn_PC),
    .data21(BusMuxIn_MDR),
    .data22(BusMuxIn_InPort),
    .data23(c_sign_extended),
    .data24(0),
    .data25(0),
    .data26(0),
    .data27(0),
    .data28(0),
    .data29(0),
    .data30(0),
    .data31(0),
    .s(s),
    .out(BusMuxOut)
    );
    
    endmodule