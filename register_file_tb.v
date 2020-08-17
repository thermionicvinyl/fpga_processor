`timescale 1ns/1ns
module register_file_tb();
	reg clk;
	reg we3;
	reg rst;
	reg[5:0]a1;
	reg[5:0]a2;
	reg[5:0]a3;
	reg[31:0]wd3;
	wire[31:0]out1;
	wire[31:0]out2;
	register_file inst(clk,rst,we3,1,a1,a2,a3,wd3,out1,out2);
	initial begin
		clk = 0;
		we3 = 0;
		a1 = 0;
		a2 = 0;
		a3 = 0;
		wd3 = 0;
		rst = 1;
		#10 
		rst = 0;
		we3 = 1;
		a3 = 1;
		wd3 = 23;
		#10
		we3 = 0;	
		a1 = 1;
		#10
		a1 = 0;
		we3 = 1;
		a3 = 2;
		wd3 = 5;
		#10
		we3 = 0;	
		a1 = 1;
		a2 = 2;
	end
	
	always begin
		#10 clk = ~clk;
	end
endmodule

