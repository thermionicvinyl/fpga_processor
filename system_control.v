module system_control(
	input clk,
	output sys_clk,
	output reg sys_rst
);
	wire locked;
	
	PLL1 PLL_inst
	(
		.areset(0),
		.inclk0(clk),
		.c0(sys_clk),
		.locked(locked)
	);
	
	always@(posedge sys_clk)begin
		sys_rst<=~locked;
	end
endmodule
