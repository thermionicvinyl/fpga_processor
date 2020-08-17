module sign_extend(
	input [15:0] instr,
	output [31:0] sign_imm
);
	assign sign_imm = {{16{instr[15]}},instr};
endmodule
