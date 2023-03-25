// Branch Case 2: brnz R6, 25
// Opcde: 9B080019
// R6 holds the value one, so it will branch
// It should branch to value 26

`timescale 1ns/1ps

module tb_branch_case2;

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
	

    parameter   nop = 5'b00000,
				add = 5'b00001,
                sub = 5'b00010, 
                mul = 5'b00011, 
                div = 5'b00100,
                shr = 5'b00101,
                shl = 5'b00110,
                shra = 5'b00111, 
                ror = 5'b01000,
                rol = 5'b01001,
                log_and = 5'b01010,
                log_or = 5'b01011,
                log_neg = 5'b01100,
                log_xor = 5'b01101,
                log_nor = 5'b01110,
                log_not = 5'b01111; 
	
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
	
	parameter Default    = 4'b0000, 
			  Reg_load1a = 4'b0001, 
			  Reg_load1b = 4'b0010, 
			  Reg_load2a = 4'b0011, 
			  Reg_load2b = 4'b0100, 
			  Reg_load3a = 4'b0101, 
			  Reg_load3b = 4'b0110, 
			  T0	     = 4'b0111, 
			  T1	     = 4'b1000, 
			  T2	     = 4'b1001,
			  T3	     = 4'b1010, 
			  T4	     = 4'b1011, 
			  T5	     = 4'b1100, 
			  T6	     = 4'b1101, 
			  T7	     = 4'b1110;

	reg [3:0] present_state = Default;
	
	initial begin
		clk = 0;
		forever #2 clk = ~clk;
	end
	
	always @(posedge clk) begin
		case (present_state)
			Default    : #40 present_state = T0;
			T0         : #40 present_state = T1;
			T1         : #40 present_state = T2;
			T2         : #40 present_state = T3;
			T3         : #40 present_state = T4;
			T4         : #40 present_state = T5;
			T5         : #40 present_state = T6;
		endcase
	end
	
	always @(present_state) begin
		case (present_state)
			Default : begin
				CONN_in = 0;
				MDRin = 0;
				MARin = 0;
				read = 0;
				write = 0;
				HIin = 0;
				LOin = 0;
				Yin = 0;
				Zin = 0;
				PCin = 0;
				IRin = 0;
				incPC = 0;
				InPortIn = 0;
				OutPortIn = 0;
				HIout = 0;
				LOout = 0;
				ZHighOut = 0;
				ZLowOut = 0;
				PCout = 0;
				MDRout = 0;
				InPortOut = 0;
				Cout = 0;
				BAout = 0;
				Gra = 0;
				Grb = 0;
				Grc = 0;
				Rin = 0;
				Rout = 0;
				InPortData = 0;
				opcode = 0;
        		clr = 0;
			end

            //Instr fetch & increment PC
			T0: begin
				#10 PCout = 1; MARin = 1; Zin = 1; incPC = 1;
				#15 PCout = 0; MARin = 0; Zin = 0; incPC = 0; 
			end
            // Load instr from mem and place MDR reg, place new PC val in PC reg
			T1: begin
				#10 ZLowOut = 1; PCin = 1; read = 1; MDRin = 1;
				#15 ZLowOut = 0; PCin = 0; read = 0; MDRin = 0;
			end
            // Place instr in IR reg
			T2: begin
				#10 MDRout = 1; IRin = 1;
				#15 MDRout = 0; IRin = 0;
			end
            //Place PC value in ALU
            T3: begin
				#10 Gra = 1; Rout = 1; 
				#15 Gra = 0; Rout = 0; 
            end
			T4: begin
				#10 PCout = 1; Yin = 1;  
				#15 PCout = 0; Yin = 0; 
			end
			T5: begin
				#10 Cout = 1; Zin = 1; CONN_in = 1; opcode = nop;
				#15 Cout = 0; Zin = 0; CONN_in = 0; 
			end
			T6: begin 
				#10 ZLowOut = 1; PCin = 1;
				#15 ZLowOut = 0; PCin = 0;
			end
		endcase

	end
endmodule

