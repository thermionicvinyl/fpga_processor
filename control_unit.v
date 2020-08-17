module control_unit(
	input [5:0] opcode,
	input [5:0] funct,
	output reg mem_to_reg,
	output reg mem_write,
	output reg branch,
	output reg [2:0] alu_control,
	output reg alu_src,
	output reg reg_dst,
	output reg reg_write,
	output reg jump,
	output reg reg_src
);
	reg [1:0] alu_op;
	always@(*)begin
		case(opcode)
			6'b000000:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b1100_001000;
			6'b100011:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b1010_010000;
			6'b101011:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b0010_100000;
			6'b000100:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b0001_000100;
			6'b001000:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b1010_000000;
			6'b000010:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b0000_000010;
			6'b010000:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b1000_000001;
			default:{reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,alu_op,jump,reg_src} = 10'b0000_000000;
		endcase
		casex(alu_op)
			2'b00:alu_control = 3'b010;
			2'bx1:alu_control = 3'b110;
			2'b1x:
			begin
				case(funct)
					6'b100000:alu_control = 3'b010;
					6'b100010:alu_control = 3'b110;
					6'b100100:alu_control = 3'b000;
					6'b100101:alu_control = 3'b001;
					6'b101010:alu_control = 3'b111;
					default:alu_control = 3'b000;
				endcase
			end
		endcase
	end
endmodule
