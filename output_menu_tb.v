`timescale 1ns/1ns
module output_menu_tb();
	reg clk;
	reg rst;
	reg [1:0] button;
	
	reg [23:0] in0;
	reg [23:0] in1;
	reg [23:0] in2;
	reg [23:0] in3;
	
	reg [23:0] in4;
	reg [23:0] in5;
	reg [23:0] in6;
	reg [23:0] in7;
	
	wire [23:0] out;
	output_menu inst
	(
		.clk(clk),
		.rst(rst),
		.button(button),
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.in4(in4),
		.in5(in5),
		.in6(in6),
		.in7(in7),
		.out(out)
	);
	
	initial begin
		clk = 0;
		rst = 1;
		button = 0;
		
		in0 = 0;
		in1 = 1;
		in2 = 2;
		in3 = 3;
		
		in4 = 4;
		in5 = 5;
		in6 = 6;
		in7 = 7;
		#15 rst = 0;
		$stop; 
	end
	
	always begin
		#10 clk = ~clk;
		#2 button = button + 1;
	end
endmodule

