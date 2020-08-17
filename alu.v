module alu(
	input [2:0] alu_control,
	input [31:0] src_a,
	input [31:0] src_b,
	output reg [31:0] alu_result,
	output reg zero
);
	always@(*)begin
		case(alu_control)
			0:alu_result = src_a&src_b;
			1:alu_result = src_a|src_b;
			2:alu_result = src_a+src_b;
			4:alu_result = src_a&~src_b;
			5:alu_result = src_a|~src_b;
			6:alu_result = src_a-src_b;
			7:alu_result = ($signed(src_a)<$signed(src_b)) ? 1:0;
			default:alu_result = 32'b0;
		endcase
		
		if(alu_result == 32'b0)begin
			zero = 1'b1;
		end
		else begin
			zero = 1'b0;
		end
	end
endmodule
