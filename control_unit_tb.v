`timescale 1ns/1ns
module control_unit_tb();
	reg [5:0] opcode;
	reg [5:0] funct;
	wire mem_to_reg;
	wire mem_write;
	wire branch;
	wire [2:0] alu_control;
	wire alu_src;
	wire reg_dst;
	wire reg_write;
	wire jump;
	wire reg_src;
	control_unit inst(opcode,funct,mem_to_reg,mem_write,branch,alu_control,alu_src,reg_dst,reg_write,jump,reg_src);
	initial begin
		opcode = 6'b0;
		funct = 6'b0;
		#10
		funct = 6'b100000;
		#10
		funct = 6'b100010;
		#10
		funct = 6'b100100;
		#10
		funct = 6'b100101;
		#10
		funct = 6'b101010;
		#10
		funct = 6'b0;
		opcode = 6'b100011;
		#10
		opcode = 6'b101011;
		#10
		opcode = 6'b000100;
		#10
		opcode = 6'b001000;
		#10
		opcode = 6'b000010;
		#10
		opcode = 6'b010000;
		#10
		;
	end
endmodule
