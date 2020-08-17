module output_menu(
	input clk,
	input rst,
	input [1:0] button,
	input [23:0] in0,
	input [23:0] in1,
	input [23:0] in2,
	input [23:0] in3,
	input [23:0] in4,
	input [23:0] in5,
	input [23:0] in6,
	input [23:0] in7,
	output reg[23:0] out
);
	reg [2:0] position;
	always@(posedge clk)begin
		if(rst)begin
			position<=3'b0;
		end
		else if(button[0]&~button[1])begin
			position<=position - 1'b1;
		end
		else if(button[1]&~button[0])begin
			position<=position + 1'b1;
		end
	end
	
	always@(*)begin
		case(position)
			0:out = in0;
			1:out = in1;
			2:out = in2;
			3:out = in3;
			4:out = in4;
			5:out = in5;
			6:out = in6;
			7:out = in7;
		endcase
	end
endmodule
  