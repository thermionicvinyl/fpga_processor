`timescale 1ns/1ns
module display_driver_tb();
	reg clk;
	reg m_f;
	reg rst;
	reg [24:0] hex;
	wire [7:0] digit;
	wire [5:0] select;
	
	display_driver inst
	(
		.clk(clk),
		.m_f(m_f),
		.rst(rst),
		.hex(hex),
		.digit(digit),
		.select(select)
	);
	
	initial begin
		clk = 0;
		m_f = 0;
		rst = 1;
		hex = 24'hfedcba;
		#15 rst = 0;
		#20000 $stop;
	end
	
	always begin
		#10 clk = ~clk;
	end
	
	always begin
		#100 m_f = ~m_f;
	end
endmodule
