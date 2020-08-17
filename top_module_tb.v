`timescale 1ns/1ns
module top_module_tb();
	reg clk;
	reg rst;
	reg [7:0] sw;
	reg [3:0] button;
	
	wire [7:0] digit;
	wire [5:0] select;
	
	 top_module inst
	 (
		.clk(clk),
		.rst(rst),
		.sw(sw),
		.button(button),
		.digit(digit),
		.select(select)
	);
	
	initial begin
		sw = 8'b0001_1111;
		clk = 0;
		rst = 1;
		button = 0;
		#15 rst = 0;
		#16000 
		button = 4'b0000;
		#1000 button = 4'b0000;
		#64000 $stop;
	end
	always begin
		#10 clk = ~clk;
	end
endmodule
