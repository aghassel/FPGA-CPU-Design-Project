`timescale 1ns/10ps

//add R0, R4, R5

module ADDITION_TESTBENCH();

//Yout is the output for Y. Yin is the input for Y.
reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
reg HIin, Loin, ZHIin, ZLOin, PCin, MDRin, MARin, IRin, Yin, Zin;

reg[4:0] testALUSelect = 5'b00001;
reg[31:0] testMdatain;

wire [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI, LO, Y, ZLO, ZHI, IR, BusMuxOut, BUSSIN; 

wire[63:0] testZRegister;

parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;

reg[3:0] Present_state = Default; 

CPU_Datapath MY_DUT_TEST(
	.R0in(R0in),
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
	
     module datapath (
input clr, clk, enable,
input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, 
input HIin, LOin, ZHighIn, ZLowIn, incPC, MARin, MDRin, Mdatain, Read, InPortin, Cin, Yin,
input [4:0] opcode
);

	.HIin(HIin),
	.Loin(Loin),
	.ZHighIn(ZHIin),
	.ZLowIn(ZLOin),
	.PCin(PCin),
	.MDRin(MDRin),
	.MARin(MARin),
	.incPC(IRin),
	.Yin(Yin),
	.Zin(Zin), //nope

	.Read(Read),
	.Cin(Cout),
	.clk(clk),
	.clr(clear),
	.IncPC(IncPC),
	
	.opcode(testALUSelect),
	.Mdatain(testMdatain),
	
	.R0(R0),
	.R1(R1),
	.R2(R2),
	.R3(R3),
	.R4(R4),
	.R5(R5),
	.R6(R6),
	.R7(R7),
	.R8(R8),
	.R9(R9),
	.R10(R10),
	.R11(R11),
	.R12(R12),
	.R13(R13),
	.R14(R14),
	.R15(R15),
	.HI(HI),
	.LO(LO),
	.Y(Y),
	.ZLO(ZLO),
	.ZHI(ZHI),
	
	.Z_register(testZRegister)


);

/*

//enables for the registers
input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, //feeding into registers


//input signals for the encoders
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,

//ins are enables for the registers, outs are input signals for the encoder
input HIin, Loin, PCin, MDRin, MARin, IRin, Yin, ZIn,
HIout, Loout, PCout, MDRout, MDRread, Cout, clk, IncPC, ZLowout, ZHighout,InPortout,

input [4:0] ALUSelection,
input[31:0] Mdatain,

output R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15,

output [63:0] Z_register

);


*/

//testing code below

initial
		begin
				clk = 0;
				forever #10 clk = ~clk;
		end
		

		

always @(posedge clk) //finite state machine, if clock edge rising
	begin
				case (Present_state)
					Default : #40 Present_state = Reg_load1a;
					Reg_load1a : #40 Present_state = Reg_load1b;
					Reg_load1b : #40 Present_state = Reg_load2a;
					Reg_load2a : #40 Present_state = Reg_load2b;
					Reg_load2b : #40 Present_state = Reg_load3a;
					Reg_load3a : #40 Present_state = Reg_load3b;
					Reg_load3b : #40 Present_state = T0;
					T0 : #40 Present_state = T1;
					T1 : #40 Present_state = T2;
					T2 : #40 Present_state = T3;
					T3 : #40 Present_state = T4;
					T4 : #40 Present_state = T5;
				endcase
		end
		
		
always @(Present_state) //do job at each state
	begin
			case(Present_state) //assert the required signals
			
					Default: begin
							PCout <= 0; 
							ZLowSelect <= 0;
							ZHighSelect <= 0;
							MDRout <= 0;
							MARin <= 0;
							PCin <= 0;
							MDRin <= 0;
							IRin <= 0; 
							Yin <= 0;
							Zin<=0;
							IncPC <= 0;
							Read <= 0;
							testALUSelect <= 0;
							
							R1in <= 0;
							R2in <= 0;
							R3in <=0;
							R4in <= 0;
							R1out<=0;
							R2out<=0;
							R3out<=0;
							R4out<=0;
							
							testMdatain <= 32'h00000000;
							R5in <=0;
							R6in <=0;
							R7in <=0;
							
							Loin <=0;
							HIin<=0;
							HIout<=0;
							Loout<=0;
							
							ZHIin<=0;
							ZLOin<=0;
							ZLOout<=0;
							ZHIout<=0;
							
							
							
						end
						
						Reg_load1a : begin
									testMdatain <= 32'h000000A;
									Read = 0;
									MDRin = 0;
									#10 Read <= 1; MDRin <= 1;
									#15 Read <= 0; MDRin <= 0;
									
									end
									
						Reg_load1b: begin
									#10 MDRout <= 1; R4in <= 1;
									#15 MDRout <= 0; R4in <= 0; //initialize R4 with value of 10
									end
									
						Reg_load2a: begin
						            testMdatain<=32'h0000002;
						            #10 Read <= 1; MDRin <= 1;
						            #15 Read <= 0; MDRin <= 0;
						
						end
						
						
						Reg_load2b: begin
						
						#10 MDRout <= 1; R5in <= 1; 
						#15 MDRout <= 0; R5in <= 0; //initialize R5 with value of 2
						
						end
						
						Reg_load3a: begin
                                    testMdatain <= 32'h00000012;
                                    #10 Read <= 1; MDRin <= 1;
                                    #15 Read <= 0; MDRin <= 0;
						end
						
						Reg_load3b: begin
									#10 MDRout <= 1; R1in <= 1;
									#15 MDRout <= 0; R1in <= 0; //initialize r1 with value of 18			
						end
						
						T0: begin //see if you need to de assert signals
						
						//R2out<=1; Yin<=1;
						//#1 Yin <= 0; R2out <=0; //Load R2 into Yin;
						
						PCout<=1; MARin<=1; IncPC<=1; 
						//Zin<=1; ZLOin<=1; 
						
						
						end
						
						
						T1: begin
						
						//Read<=1; PCin<=1; MDRin<=1; testMdatain<=32'h28918000; 

						end
						
						T2: begin
					//MDRout<=1; IRin<=1; 
						end
						
						T3: begin
						    R5out<=1; Yin<=1;
						end
						
						T4: begin
						//R2out <=0; 
                            Yin <= 0; R5out <=0; 
                            Yout <= 1; testALUSelect = 5'b00001; Zin <=1; R4out<=1; 
                            ZLOin<=1;
                            ZLowSelect<=1;
						end
						
						T5: begin
                            ZLOin<=0; 
                            R4out<=0;
                            ZLowSelect<=0;
                            ZLOout<=1; R0in<=1; 
						end
					endcase
				end
		
endmodule