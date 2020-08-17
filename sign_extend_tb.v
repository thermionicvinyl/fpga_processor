module sign_extend_tb();
	reg [15:0] instr;
	wire [31:0] sign_imm;
	sign_extend inst (instr,sign_imm);
	initial  begin
		instr = 0 ;

		repeat (100) begin 
		#10; 
		instr = {$random};
		#10;
		end 	
	end
endmodule
