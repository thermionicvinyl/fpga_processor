module instruction_memory_tb();
	reg[5:0]a;
	wire[31:0]out;
	instruction_memory inst(a,out);
	initial begin
		a = 0;
		#10 a = 1;
		#10 a = 2;
		#10 a = 3;
		#10 a = 4;
		#10 a = 5;
	end
endmodule

