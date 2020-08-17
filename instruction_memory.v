module instruction_memory(
	input[31:0] a,
	output[31:0] rd
);

	reg[31:0] i_mem[31:0];
	
	//Used to load program into instruction memory
	
	initial begin
		$readmemb("program.txt",i_mem);
	end
	
	
	assign rd = i_mem[a];
	
endmodule
