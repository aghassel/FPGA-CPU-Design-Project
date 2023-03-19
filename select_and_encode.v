module select_and_encode (
    input [31:0] irOut,
    input Gra, Grb, Grc,
    input Rin, Rout, BAout,
    output R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
    output R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, 
    R14out, R15out,
    output C_sign_extended
);
    wire Rout_or;
    wire [3:0] Ra, Rb, Rc, gra_and, grb_and, grc_and, dec_in;
    wire [15:0] dec_out;

    //Decoder initialization
    decoder4to16 myDecoder (.in(dec_in), .out(dec_out));

    //Partition IR reg output
    assign Ra = irOut[26:23];
    assign Rb = irOut[22:19];
    assign Rc = irOut[18:15];

    //If Gr is high, create 4 bit high, else low for anding later
    assign gra_and = Gra == 1 ? 4'b1111 : 4'b0000;
    assign grb_and = Grb == 1 ? 4'b1111 : 4'b0000;
    assign grc_and = Grc == 1 ? 4'b1111 : 4'b0000;
  
    //And Ra, Rb, Rc and w Gr input, then or values and input to decoder
    assign dec_in = (gra_and & Ra) | (grb_and & Rb) | (grc_and & Rc);

    //Or Rout and BAout, then covert to 16 bit for and'ing
    assign Rout_or = Rout | BAout;

    //Select wich output signal to send.
    assign R0in = dec_out[0] & Rin;
    assign R1in = dec_out[1] & Rin;
    assign R2in = dec_out[2] & Rin;
    assign R3in = dec_out[3] & Rin;
    assign R4in = dec_out[4] & Rin;
    assign R5in = dec_out[5] & Rin;
    assign R6in = dec_out[6] & Rin;
    assign R7in = dec_out[7] & Rin;
    assign R8in = dec_out[8] & Rin;
    assign R9in = dec_out[9] & Rin;
    assign R10in = dec_out[10] & Rin;
    assign R11in = dec_out[11] & Rin;
    assign R12in = dec_out[12] & Rin;
    assign R13in = dec_out[13] & Rin;
    assign R14in = dec_out[14] & Rin;
    assign R15in = dec_out[15] & Rin;

    assign R0out = dec_out[0] & Rout_or;
    assign R1out = dec_out[1] & Rout_or;
    assign R2out = dec_out[2] & Rout_or;
    assign R3out = dec_out[3] & Rout_or;
    assign R4out = dec_out[4] & Rout_or;
    assign R5out = dec_out[5] & Rout_or;
    assign R6out = dec_out[6] & Rout_or;
    assign R7out = dec_out[7] & Rout_or;
    assign R8out = dec_out[8] & Rout_or;
    assign R9out = dec_out[9] & Rout_or;
    assign R10out = dec_out[10] & Rout_or;
    assign R11out = dec_out[11] & Rout_or;
    assign R12out = dec_out[12] & Rout_or;
    assign R13out = dec_out[13] & Rout_or;
    assign R14out = dec_out[14] & Rout_or;
    assign R15out = dec_out[15] & Rout_or;

    assign C_sign_extended = irOut[18] == 1 ? {13'b1111111111111, irOut[18:0]} : {13'b0, irOut[18:0]};
endmodule




    
