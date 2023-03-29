//Control unit for CPU
//Finite state machine logic for control
`timescale 1ns/1ps
module ctrl_unit(
    //Test Bench inputs/outputs but goes through datapath
    input clock, reset, stop,
    output run, clear,
    //Datapath inputs/outputs
    input [31:0] IRdata,
    output reg clr, clk,
    output reg read, write,
    output reg BAout, Rin, Rout,
    output reg Gra, Grb, Grc,
    output reg CONN_in,
    output reg MARin, MDRin,
    output reg HIin, LOin,
    output reg Yin, Zin,
    output reg PCin, IRin, incPC, 
    output reg InPortIn, OutPortIn, 
    output reg HIout, LOout, ZLowOut, ZHighOut,
    output reg MDRout, Cout, InPortOut, PCout, 
    output reg [4:0] alu_opcode,
);

    //Control unit states
    parameter   reset_state = 8'b00000000,
                //Fetch states
                fetch0 = 8'b00000001, fetch1 = 8'b00000010, fetch2= 8'b00000011,
                //Add states
			    add3 = 8'b00000100, add4= 8'b00000101, add5= 8'b00000110, 
                //Sub states
                sub3 = 8'b00000111, sub4 = 8'b00001000, sub5 = 8'b00001001,
                //Multiplication states
			    mul3 = 8'b00001010, mul4 = 8'b00001011, mul5 = 8'b00001100, mul6 = 8'b00001101, 
                //Division states
                div3 = 8'b00001110, div4 = 8'b00001111,div5 = 8'b00010000, div6 = 8'b00010001, 
                //Or states
                or3 = 8'b00010010, or4 = 8'b00010011, or5 = 8'b00010100, 
                //And states
                and3 = 8'b00010101, and4 = 8'b00010110, and5 = 8'b00010111, 
                //Shift left states
                shl3 = 8'b00011000, shl4 = 8'b00011001, shl5 = 8'b00011010, 
                //Shift right states
                shr3 = 8'b00011011, shr4 = 8'b00011100,  shr5 = 8'b00011101, 
                //Shift right arithmatic states
                shra3 = 8'b10011011, shra4 = 8'b10011100,  shra5 = 8'b10011101, 
                //Rotate left states
                rol3 = 8'b00011110, rol4 = 8'b00011111, rol5 = 8'b00100000,
                //Rotate right states 
                ror3 = 8'b00100001, ror4 = 8'b00100010,  ror5 = 8'b00100011,
                //Negate states 
                neg3 = 8'b00100100, neg4 = 8'b00100101, neg5 = 8'b00100110, 
                //Not states
                not3 = 8'b00100111, not4 = 8'b00101000,  not5 = 8'b00101001, 
                //Load states
                ld3 = 8'b00101010, ld4 = 8'b00101011, ld5 = 8'b00101100, ld6 = 8'b00101101, ld7 = 8'b00101110,
                //Load immediate states
                ldi3 = 8'b00101111, ldi4 = 8'b00110000, ldi5 = 8'b00110001,
                //Store States
                st3 = 8'b00110010, st4 = 8'b00110011, st5 = 8'b00110100, st6 = 8'b00110101, st7 = 8'b00110110,
                //Add immediate states
                addi3 = 8'b00110111, addi4 = 8'b00111000, addi5 = 8'b00111001,
                //And immediate states
			    andi3 = 8'b00111010, andi4 = 8'b00111011, andi5 = 8'b00111100, 
                //Or immediate states
                ori3 = 8'b00111101, ori4 = 8'b00111110, ori5 = 8'b00111111,
                //Branch if States
			    br3 = 8'b01000000, br4 = 8'b01000001, br5 = 8'b01000010, br6 = 8'b01000011,
                //Move reg to PC state
                jr3 = 8'b01000100, 
                //Move PC to reg state
                jal3 = 8'b01000101, 
                //Move HI to reg state
			    mfhi3 = 8'b01000111, 
                //Move LO to reg state
                mflo3 = 8'b01001000,
                //Move Inport to reg state
                in3 = 8'b01001001,
                //Move reg to Outport state
                out3 = 8'b01001010,
                //No operation state (go to fetch0)
                nop3 = 8'b01001011, 
                //Halt state
			    halt3 = 8'b01001100;

    //ALU opcodes
    parameter   alu_nop = 5'b00000,
				alu_addop = 5'b00001,
                alu_subop = 5'b00010, 
                alu_mulop = 5'b00011, 
                alu_divop = 5'b00100,
                alu_shrop = 5'b00101,
                alu_shlop = 5'b00110,
                alu_shraop = 5'b00111, 
                alu_rorop = 5'b01000,
                alu_rolop = 5'b01001,
                alu_andop = 5'b01010,
                alu_orop = 5'b01011,
                alu_negop = 5'b01100,
                alu_xorop = 5'b01101,
                alu_norop = 5'b01110,
                alu_notop = 5'b01111; 


    //IR opcodes
    parameter   ir_add  = 5'b00011,
                ir_sub  = 5'b00100,
                ir_mul  = 5'b01111,
                ir_div  = 5'b10000,
                ir_shl  = 5'b01001,
                ir_shr  = 5'b00111,
                ir_shra = 5'b01000,
                ir_rol  = 5'b01011,
                ir_ror  = 5'b01010,
                ir_and  = 5'b00101,
                ir_or   = 5'b00110,
                ir_neg  = 5'b10001,
                ir_not  = 5'b10010,
                ir_ld   = 5'b00000,
                ir_ldi  = 5'b00001,
                ir_st   = 5'b00010,
                ir_addi = 5'b01100,
                ir_andi = 5'b01101,
                ir_ori  = 5'b01110,
                ir_br   = 5'b10011,
                ir_jr   = 5'b10100,
                ir_jal  = 5'b10101,
                ir_mfhi = 5'b11000,
                ir_mflo = 5'b11001,
                ir_in   = 5'b10110,
                ir_out  = 5'b10111;

    reg [7:0] prev_state;
    reg [7:0] present_state = reset_state;
	
	initial begin
		clk = 0;
		forever #2 clk = ~clk;
	end
	
	always @(posedge clk, posedge reset) begin

        if (reset) begin    //reset the processor
            present_state = reset_state;
        end 
        
		case (present_state)
            fetch0 : #40 present_state = fetch1;
            fetch1 : #40 present_state = fetch2;
            fetch2 : begin
                case (IRdata[31:27])
                    ir_add  : #40 present_state = add3;
                    ir_sub  : #40 present_state = sub3;
                    ir_mul  : #40 present_state = mul3;
                    ir_div  : #40 present_state = div3;
                    ir_shl  : #40 present_state = shl3;
                    ir_shr  : #40 present_state = shr3;
                    ir_shra : #40 present_state = shra3;
                    ir_rol  : #40 present_state = rol3;
                    ir_ror  : #40 present_state = ror3;
                    ir_and  : #40 present_state = and3;
                    ir_or   : #40 present_state = or3;
                    ir_neg  : #40 present_state = neg3;
                    ir_not  : #40 present_state = not3;
                    ir_ld   : #40 present_state = ld3;
                    ir_ldi  : #40 present_state = ldi3;
                    ir_st   : #40 present_state = st3;
                    ir_addi : #40 present_state = addi3;
                    ir_andi : #40 present_state = andi3;
                    ir_ori  : #40 present_state = ori3;
                    ir_br   : #40 present_state = br3;
                    ir_jr   : #40 present_state = jr3;
                    ir_jal  : #40 present_state = jal3;
                    ir_mfhi : #40 present_state = mfhi3;
                    ir_mflo : #40 present_state = mflo3;
                    ir_in   : #40 present_state = in3;
                    ir_out  : #40 present_state = out3;
                endcase = add5;
            end
            //Add instruction
            add3    : #40 present_state = add4;
            add4    : #40 present_state = add5;
            add5    : #40 present_state = fetch0;

            //Sub instruction
            sub3    : #40 present_state = sub4;
            sub4    : #40 present_state = sub5;
            sub5    : #40 present_state = fetch0;
            
            //Mul instruction
            mul3    : #40 present_state = mul4;
            mul4    : #40 present_state = mul5;
            mul5    : #40 present_state = mul6;
            mul6    : #40 present_state = fetch0;
            
            //Div instruction
            div3    : #40 present_state = div4;
            div4    : #40 present_state = div5;
            div5    : #40 present_state = div6;
            div6    : #40 present_state = fetch0;

            //Or instruction
            or3     : #40 present_state = or4;
            or4     : #40 present_state = or5;
            or5     : #40 present_state = fetch0;

            //And instruction
            and3    : #40 present_state = and4;
            and4    : #40 present_state = and5;
            and5    : #40 present_state = fetch0;
            
            //Shift left instrcutions
            shl3    : #40 present_state = shl4;
            shl4    : #40 present_state = shl5;
            shl5    : #40 present_state = fetch0;
            
            //Shift right instructions
            shr3    : #40 present_state = shr4;
            shr4    : #40 present_state = shr5;
            shr5    : #40 present_state = fetch0;

            //Shift right arithmatic instructions
            shra3   : #40 present_state = shra4;
            shra4   : #40 present_state = shra5;
            shra5   : #40 present_state = fetch0;
            
            //Rotate left instructions
            rol3    : #40 present_state = rol4;
            rol4    : #40 present_state = rol5;
            rol5    : #40 present_state = fetch0;

            //Rotate right instructions
            ror3    : #40 present_state = ror4;
            ror4    : #40 present_state = ror5;
            ror5    : #40 present_state = fetch0;

            //Negate instructions
            neg3    : #40 present_state = neg4;
            neg4    : #40 present_state = neg5;
            neg5    : #40 present_state = fetch0;

            //Not instructions
            not3    : #40 present_state = not4;
            not4    : #40 present_state = not5;
            not5    : #40 present_state = fetch0;

            //Load instructions
            ld3     : #40 present_state = ld4;
            ld4     : #40 present_state = ld5;
            ld5     : #40 present_state = ld6;
            ld6     : #40 present_state = ld7;
            ld7     : #40 present_state = fetch0;

            //Load immediate instructions
            ldi3    : #40 present_state = ldi4;
            ldi4    : #40 present_state = ldi5;
            ldi5    : #40 present_state = fetch0;

            //Store instructions
            st3     : #40 present_state = st4;
            st4     : #40 present_state = st5;
            st5     : #40 present_state = st6;
            st6     : #40 present_state = st7;
            st7     : #40 present_state = fetch0;

            //Add immediate instructions
            addi3   : #40 present_state = addi4;
            addi4   : #40 present_state = addi5;
            addi5   : #40 present_state = fetch0;

            //And immediate instructions
            andi3   : #40 present_state = andi4;
            andi4   : #40 present_state = andi5;
            andi5   : #40 present_state = fetch0;
            
            //Or immediate instructions
            ori3    : #40 present_state = ori4;
            ori4    : #40 present_state = ori5;
            ori5    : #40 present_state = fetch0;
            
            //Branch instructions
            br3     : #40 present_state = br4;
            br4     : #40 present_state = br5;
            br5     : #40 present_state = br6;
            br6     : #40 present_state = br7;
            br7     : #40 present_state = fetch0;
            
            //Jump register instructions
            jr3     : #40 present_state = fetch0;

            //Jump and link instructions
            jal3    : #40 present_state = fetch0;

            //Move from HI instructions
            mfhi3   : #40 present_state = fetch0;

            //Move from LO instructions
            mflo3   : #40 present_state = fetch0;

            //Input instructions
            in3     : #40 present_state = fetch0;
            
            //Output instructions
            out3    : #40 present_state = fetch0;

            //If restart, go to halt
            restart : begin
                prev_state = fetch0;
                present_state = halt;
            end

            //If halt, wait for 
            halt : begin
                if (~stop) present_state = prev_state;
                else present_state = halt;
            end
		endcase
	end
    
	always @(present_state) begin
		case (present_state)
			reset_state : begin  
                run = 1; clear = 0;
                #5 clr = 1;
                Gra = 0; Grb = 0; Grc = 0; Rin = 0;              
			    BAout = 0; Rin = 0; Rout = 0;
                CONN_in = 0;
                MARin = 0; MDRin = 0;
                HIin = 0; LOin = 0;
                Yin = 0; Zin = 0;
                PCin = 0; IRin = 0; incPC = 0; 
                InPortIn = 0; OutPortIn = 0; 
                HIout = 0; LOout = 0; ZLowOut = 0; ZHighOut = 0;
                MDRout = 0; Cout = 0; InPortOut = 0; PCout = 0; 
                #5 clr = 0;
			end
                      
            fetch0: begin
				#10 PCout = 1; MARin = 1; Zin = 1; incPC = 1;
				#15 PCout = 0; MARin = 0; Zin = 0; incPC = 0; 
			end
            fetch1: begin
				#10 ZLowOut = 1; PCin = 1; Read = 1; MDRin = 1;
				#15 ZLowOut = 0; PCin = 0; Read = 0; MDRin = 0; 
			end
            fetch2: begin
				#10 MDRout = 1; IRin = 1;
				#15 MDRout = 0; IRin = 0; 
			end

            //Alu instruction states
            add3, sub3, and3, or3, shl3, shr3, shra3, ror3, rol3, addi3, andi3, ori3, neg3, not3: begin
                #10 Grb = 1; Yin = 1;
                #15 Grb = 0; Yin = 0;
            end
            mul3, div3: begin
                #10 Gra = 1; Yin = 1; 
                #15 Gra = 0; Yin = 0; 
            end
            add4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_addop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end 
            sub4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_subop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end 
            mul4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_mulop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            div4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_divop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            and4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_andop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            or4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_orop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            shl4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_shlop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            shr4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_shrop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            shra4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_shraop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            ror4  :begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_rorop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            rol4 : begin
                #10 Zin = 1; Grc = 1; Rout = 1; opcode = alu_rolop;
                #15 Zin = 0; Grc = 0; Rout = 0; opcode = alu_nop;
            end
            addi4  :begin 
                #10 Zin = 1; Cout = 1; opcode = alu_addop;
                #15 Zin = 0; Cout = 0; opcode = alu_nop;
            end
            andi4 : begin 
                #10 Zin = 1; Cout = 1; opcode = alu_andop;
                #15 Zin = 0; Cout = 0; opcode = alu_nop;
            end
            ori4 : begin 
                #10 Zin = 1; Cout = 1; opcode = alu_orop;
                #15 Zin = 0; Cout = 0; opcode = alu_nop;
            end
            mul4 : begin
                #10 Zin = 1; Grb = 1; Rout = 1; opcode = alu_mulop;
                #15 Zin = 0; Grb = 0; Rout = 0; opcode = alu_nop;
            end
            div4 : begin
                #10 Zin = 1; Grb = 1; Rout = 1; opcode = alu_divop;
                #15 Zin = 0; Grb = 0; Rout = 0; opcode = alu_nop;
            end        
            neg4 : begin
                #10 Zin = 1; opcode = alu_negop;
                #15 Zin = 0; opcode = alu_nop;
            end
            not4 : begin
                #10 Zin = 1; opcode = alu_notop;
                #15 Zin = 0; opcode = alu_nop;
            end
            add5, sub5, and5, or5, shl5, shr5, shra5, ror5, rol5, andi5, addi5, ori5, not5, neg5 : begin
                #10 ZLowOut = 1; Gra = 1; Rin = 1;
                #15 ZLowOut = 0; Gra = 0; Rin = 0;
            end
            mul5, div5 : begin
                #10 ZLowOut = 1; LOin = 1; Rin = 1;
                #15 ZLowOut = 0; LOin = 0; Rin = 0;
            end
            mul6, div6 : begin
                #10 ZHighOut = 1; HIin = 1; Rin = 1;
                #15 ZHighOut = 0; HIin = 0; Rin = 0;
            end

            //Load instruction states
            ld3, ldi3: begin
                #10 Grb = 1; BAout = 1; Yin = 1;  
                #10 Grb = 0; BAout = 0; Yin = 0;  
            end
            ld4, ldi4 : begin
                #10 Zin = 1; Cout = 1; opcode = alu_addop;
                #15 Zin = 0; Cout = 0; opcode = alu_nop;
            end
            ld5 : begin
                #10 ZLowOut = 1; MARin = 1;
                #15 ZLowOut = 0; MARin = 0;
            end
            ldi5 : begin 
                #10 ZLowOut = 1; Rin = 1; Gra = 1;
                #15 ZLowOut = 0; Rin = 0; Gra = 0;
            end
            ld6 : begin
                #10 read = 1; MDRin = 1;
                #15 read = 0; MDRin = 0;
            end
            ld7 : begin
                #10 MDRout = 1; Rin = 1; Gra = 1;
                #15 MDRout = 0; Rin = 0; Gra = 0;
            end         

            //Store instruction states
            st3 : begin
                #10 Grb = 1; BAout = 1; Yin = 1;  
                #10 Grb = 0; BAout = 0; Yin = 0;  
            end   
            st4: begin 
                #10 Zin = 1; Cout = 1; opcode = alu_addop;
                #15 Zin = 0; Cout = 0; opcode = alu_nop;
            end
            st5 : begin
                #10 ZLowOut = 1; MARin = 1;
                #15 ZLowOut = 0; MARin = 0;
            end
            st6 : begin
                #10 write = 1; MDRin = 1; Rout = 1; Gra = 1;
                #15 write = 0; MDRin = 0; Rout = 0; Gra = 0;
            end

            //Branch instruction states
            br3: begin 
                #10 Gra = 1; Rout = 1;
                #15 Gra = 0; Rout = 0;
            end
            br4: begin
                #10 PCout = 1; Yin = 1;  
				#15 PCout = 0; Yin = 0; 
            end
            br5: begin 
                #10 Cout = 1; Zin = 1; CONN_in = 1; opcode = nop;
				#15 Cout = 0; Zin = 0; CONN_in = 0; 
            end
            br6: begin
                #10 ZLowOut = 1; PCin = 1;
				#15 ZLowOut = 0; PCin = 0;
            end

            //Jump register and Jump and Link Register instructions
            j3 : begin
                #10 Gra = 1; Rout = 1; PCin = 1;  
                #10 Gra = 0; Rout = 0; PCin = 0;  
            end
            jal3 : begin
                #10 Gra = 1; Rin = 1; PCout = 1;  
                #10 Gra = 0; Rin = 0; PCout = 0;  
            end

            //Input Output instruction states
            in3: begin
                #10 InPortIn = 1; Rin = 1; Gra = 1;
                #15 InPortIn = 0; Rin = 0; Gra = 0;
            end
            out3: begin
                #10 OutPortOut = 1; Rout = 1; Gra = 1;
                #15 OutPortOut = 0; Rout = 0; Gra = 0;
            end
            
            //Mfhi and Mflo instruction states
            mfhi3: begin
                #10 HIout = 1; Rin = 1; Gra = 1;
                #15 HIout = 0; Rin = 0; Gra = 0;
            end
            mflo3: begin
                #10 LOout = 1; Rin = 1; Gra = 1;
                #15 LOout = 0; Rin = 0; Gra = 0;
            end

            //No operation instruction states
            nop3: begin
                #10 opcode = alu_nop;
            end

            //If halted, show that not running
            halt: begin
                run = 0;
                clear = 0;
            end

            //If in reset, show not running and set clear high
            reset: begin
                run = 0;
                #5 clear = 1;
            end

    endcase
end

endmodule
