module alu_tb();
	reg [2:0] alu_control;
	reg [31:0] src_a;
	reg [31:0] src_b;
	wire  [31:0] alu_result;
	wire  zero;
	alu inst (alu_control,src_a,src_b,alu_result,zero);
	initial begin
		alu_control = 0;
		repeat (100) begin 
		#10; 
		alu_control = alu_control + 1;
		src_a = {$random};
		src_b = {$random};
		#10;
		end 
	end
endmodule
