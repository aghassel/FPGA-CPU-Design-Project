//bussy module

module bus  #(parameter wordSize = 32)(
    input [wordSize-1:0] R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    input [wordSize-1:0] HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
    output reg [wordSize-1:0] BusMuxOut
);

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
.ein[10](R10oHIut),
.ein[11](R11out),
.ein[12](R12out),
.ein[13](R12out),
.ein[14](R13out),
.ein[15](R14out),
.ein[16](R15out),
.ein[17](HIout),
.ein[18](R2out),
.ein[19](R2out),
.ein[20](R2out),
.ein[21](R2out),
.ein[22](R2out),
.ein[23](R2out),
);

endmodule