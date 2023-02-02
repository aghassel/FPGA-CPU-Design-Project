module encoder_32_to_5 (input wire [31:0]ein, output reg [4:0] eout);
	always @(ein) begin
		if(ein[31]==1) eout=5'b11111;
		else if (ein[30]==1) eout=5'b11110;
		else if (ein[29]==1) eout=5'b11101;
		else if (ein[28]==1) eout=5'b11100;
		else if (ein[27]==1) eout=5'b11011;
		else if (ein[26]==1) eout=5'b11010;
		else if (ein[25]==1) eout=5'b11001;
		else if (ein[24]==1) eout=5'b11000;
		else if (ein[23]==1) eout=5'b10111;
		else if (ein[22]==1) eout=5'b10110;
		else if (ein[21]==1) eout=5'b10101;
		else if (ein[20]==1) eout=5'b10100;
		else if (ein[19]==1) eout=5'b10011;
		else if (ein[18]==1) eout=5'b10010;
		else if (ein[17]==1) eout=5'b10001;
		else if (ein[16]==1) eout=5'b10000;
		else if (ein[15]==1) eout=5'b01111;
		else if (ein[14]==1) eout=5'b01110;
		else if (ein[13]==1) eout=5'b01101;
		else if (ein[12]==1) eout=5'b01100;
		else if (ein[11]==1) eout=5'b01011;
		else if (ein[10]==1) eout=5'b01010;
		else if (ein[9]==1) eout=5'b01001;
		else if (ein[8]==1) eout=5'b01000;
		else if (ein[7]==1) eout=5'b00111;
		else if (ein[6]==1) eout=5'b00110;
		else if (ein[5]==1) eout=5'b00101;
		else if (ein[4]==1) eout=5'b00100;
		else if (ein[3]==1) eout=5'b00011;
		else if (ein[2]==1) eout=5'b00010;
		else if (ein[1]==1) eout=5'b00001;
		else eout=5'b00000;
	end
endmodule
		