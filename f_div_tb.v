`timescale 1ns/1ns
module f_div_tb();
	reg clk;
	reg rst;
	reg [1:0] button;
	wire m_f;
	wire v_f;
	f_div inst
	(
		.clk(clk),
		.rst(rst),
		.button(button),
		.m_f(m_f),
		.v_f(v_f)
	);
	
	initial begin
		clk = 0;
		rst = 1;
		button = 2'b00;
		#15 rst = 0;
		#10 button = 2'b01;
		#10 button = 2'b00;
		#5000 button = 2'b01;
		#20 button = 2'b00;
		#5000 button = 2'b01;
		#20 button = 2'b00;
		#10 button = 2'b10;
		#10 button = 2'b00;
		#5000 button = 2'b10;
		#20 button = 2'b00;
		#5000 button = 2'b10;
		#20 button = 2'b00;
		#5000 $stop;
	end
	
	always begin
		#10 clk = ~clk;
	end
endmodule

