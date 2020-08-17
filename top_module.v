module top_module(
	input [7:0] sw,
	input [3:0] button,
	input clk,
	input rst,
	output [7:0] digit,
	output [5:0] select
);
	//CHANGE VARI COUNTER TO M_F NOT U_F PLEASE
	wire sys_clk;
	wire sys_rst;

	wire [23:0] out_zero;
	wire [23:0] control_signal;
	wire [23:0] instr_lower;
	wire [23:0] instr_upper;
	wire [23:0] alu;
	wire [23:0] program_counter;
	wire [23:0] register_1;
	wire [23:0] register_2;
	
	wire [23:0] out;

	wire m_f;
	wire v_f;
	wire dp_f;
	
	wire b_up;
	wire b_down;
	wire b_left;
	wire b_right;
	
	system_control system_control_inst
	(
		.clk(clk),
		.sys_clk(sys_clk),
		.sys_rst(sys_rst)
	);
	
	 scp_1 scp_1_inst
	 (
		.inclk(sys_clk),
		.v_f(v_f),
		.ext_reset(sys_rst),
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
		.clk(sys_clk),
		.rst(sys_rst),
		.button({b_down,b_up}),
		.m_f(m_f),
		.v_f(v_f),
		.dp_f(dp_f)
	);
	
	output_menu output_menu_inst
	(
		.clk(sys_clk),
		.rst(sys_rst),
		.button({b_right,b_left}),
		.in0(out_zero),
		.in1(control_signal),
		.in2(instr_lower),
		.in3(instr_upper),
		.in4(alu),
		.in5(program_counter),
		.in6(register_1),
		.in7(register_2),
		.out(out)
	);
	
	
	display_driver display_driver_inst
	(
		.clk(sys_clk),
		.m_f(m_f),
		.dp_f(dp_f),
		.rst(sys_rst),
		.hex(out),
		.digit(digit),
		.select(select)
	);
	
	
	debounce up
	(
		.clk(sys_clk),
		.rst(sys_rst),
		.m_f(m_f),
		.button(button[0]),
		.db_button(b_up)
	);
	
	debounce down
	(
		.clk(sys_clk),
		.rst(sys_rst),
		.m_f(m_f),
		.button(button[1]),
		.db_button(b_down)
	);
	
	debounce left
	(
		.clk(sys_clk),
		.rst(sys_rst),
		.m_f(m_f),
		.button(button[2]),
		.db_button(b_left)
	);
	
	debounce right
	(
		.clk(sys_clk),
		.rst(sys_rst),
		.m_f(m_f),
		.button(button[3]),
		.db_button(b_right)
	);
endmodule
