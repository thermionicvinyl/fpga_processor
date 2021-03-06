`timescale 1ns/1ns
module scp_1_tb();
	reg clk;
	reg v_f;
	reg rst;
	reg [7:0] sw;
	
	wire [23:0] out_zero;
	wire [23:0] control_signal;
	wire [23:0] instr_lower;
	wire [23:0] instr_upper;
	wire [23:0] alu;
	wire [23:0] program_counter;
	wire [23:0] register_1;
	wire [23:0] register_2;
	
	 scp_1 scp_1_inst
	 (
		.inclk(clk),
		.v_f(v_f),
		.ext_reset(rst),
		.sw(sw),
		.out_zero(out_zero),
		.control_signal(control_signal),
		.instr_lower(instr_lower),
		.instr_upper(instr_upper),
		.alu(alu),
		.program_counter(program_counter),
		.register_1(register_1),
		.register_2(register_2)
	);
	
	f_div f_div_inst
	(
	.clk(clk),
	.rst(rst),
	.button(0),
	.m_f(),
	.v_f(v_f)
	);
	
	initial begin
		sw = 8'b0001_1111;
		clk = 0;
		rst = 1;
		#15 rst = 0;
		#16000 $stop;
	end
	always begin
		#10 clk = ~clk;
	end
endmodule
