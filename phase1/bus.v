//bussy module

module bus  #(parameter wordSize = 32)(
    input [wordSize-1:0] R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    input [wordSize-1:0] HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
    output reg [wordSize-1:0] BusMuxOut
);

wire [5:0] s;

wire [wordSize-1:0] c_sign_extended;

assign c_sign_extended = (Cout == 0) ? 32'd0 : 32'd1;

encoder32to5 myEncoder(
//input wire [31:0]ein, output reg [4:0] eout
.ein[0](R0out),
.ein[1](R1out),
.ein[2](R2out),
.ein[3](R3out),
.ein[4](R4out),
.ein[5](R5out),
.ein[6](R6out),
.ein[7](R7out),
.ein[8](R8out),
.ein[9](R9out),
.ein[10](R10out),
.ein[11](R11out),
.ein[12](R12out),
.ein[13](R13out),
.ein[14](R14out),
.ein[15](R15out),
.ein[16](HIout),
.ein[17](LOout),
.ein[18](Zhighout),
.ein[19](Zlowout),
.ein[20](PCout),
.ein[21](MDRout),
.ein[22](R2out),
.ein[23](Cout),
.eout(s)
);


mux32to1 BusMux(
    /*
    input wire [31:0] data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20, data21, data22, data23, data24, data25, data26, data27, data28, data29, data30, data31;
	input wire [4:0] s;
	output reg [31:0] out;
    */
    .data0(R0out),
    .data1(R1out),
    .data2(R2out),
    .data3(R3out),
    .data4(R4out),
    .data5(R5out),
    .data6(R6out),
    .data7(R7out),
    .data8(R8out),
    .data9(R9out),
    .data10(R10out),
    .data11(R11out),
    .data12(R12out),
    .data13(R13out),
    .data14(R14out),
    .data15(R15out),
    .data16(HIout),
    .data17(LOout),
    .data18(Zhighout),
    .data19(Zlowout),
    .data20(PCout),
    .data21(MDRout),
    .data22(R2out),
    .data23(c_sign_extended),
    .s(s),
    .out(BusMuxOut)
    );
    endmodule