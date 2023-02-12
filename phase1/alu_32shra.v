module shra32 (in, num_shifts, out);
	input wire [31:0] in;
	input wire [31:0] num_shifts;
	output reg [31:0] out;
	
	always @(*) begin

        shifts = num_shifts;
        generate
            for (i=0; i < shifts, i = i + 1) begin : loop
                if (in[31] = 0)
                    assign in = in>>1;
                else begin
                    assign in = in>>1;
                    assign in[31] = 1;
                end
            end
            assign out = in;
        endgenerate
	end
endmodule

// module ror32 (in, num_shifts, out);
// 	input wire [31:0] in;
// 	input wire [31:0] num_shifts;
// 	output reg [31:0] out;
	
//     wire temp;
//     genvar i;
//     integer shifts;
// 	always @(*) begin
//         shifts = num_shifts;
//         generate
//             for (i=0; i < shifts, i = i + 1) begin : loop
//                 if (in[31] = 0)
//                     assign in = in>>1;
//                 else if (in[31] = 1) begin
//                     assign in = in>>1;
//                     assign in[31] = 1;
//                 end
//             end
//             assign out = in;
//         endgenerate
// 	end
// endmodule