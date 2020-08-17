`timescale 1ns/1ns
module debounce_tb();
	reg clk;
	reg m_f;
	reg rst;
	reg button;
	wire db_button;
	
	debounce inst
	(
		.clk(clk),
		.rst(rst),
		.m_f(m_f),
		.button(button),
		.db_button(db_button)
	);
	
	initial begin
		clk = 0;
		rst = 1;
		m_f = 0;
		button = 0;
		#15 rst = 0;
		#10 button = 1;
		#10 button = 0;
		#40 button = 1;
		#1700 button = 0;
		#10 button = 1;
		#10 button = 0;
		#1700 $stop;
	end
	
	always begin
		#10 clk = ~clk;
	end
	
	always begin
		#40 m_f = ~m_f;
	end
endmodule

