module multiplexer_32_to_1(data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20, data21, data22, data23, data24, data25, data26, data27, data28, data29, data30, data31, out, s);
	input wire [31:0] data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20, data21, data22, data23, data24, data25, data26, data27, data28, data29, data30, data31;
	input wire [4:0] s;
	output reg [31:0] out;
	
	always @(*) begin 
		if (s==5'd31) out <= data31;
		else if (s==5'd30) out <= data30;
		else if (s==5'd29) out <= data29;
		else if (s==5'd28) out <= data28;
		else if (s==5'd27) out <= data27;
		else if (s==5'd26) out <= data26;
		else if (s==5'd25) out <= data25;
		else if (s==5'd24) out <= data24;
		else if (s==5'd23) out <= data23;
		else if (s==5'd22) out <= data22;
		else if (s==5'd21) out <= data21;
		else if (s==5'd20) out <= data20;
		else if (s==5'd19) out <= data19;
		else if (s==5'd18) out <= data18;
		else if (s==5'd17) out <= data17;
		else if (s==5'd16) out <= data16;
		else if (s==5'd15) out <= data15;
		else if (s==5'd14) out <= data14;
		else if (s==5'd13) out <= data13;
		else if (s==5'd12) out <= data12;
		else if (s==5'd11) out <= data11;
		else if (s==5'd10) out <= data10;
		else if (s==5'd9) out <= data9;
		else if (s==5'd8) out <= data8;
		else if (s==5'd7) out <= data7;
		else if (s==5'd6) out <= data6;
		else if (s==5'd5) out <= data5;
		else if (s==5'd4) out <= data4;
		else if (s==5'd3) out <= data3;
		else if (s==5'd2) out <= data2;
		else if (s==5'd1) out <= data1;
		else if (s==5'd0) out <= data0;
	end
endmodule
	