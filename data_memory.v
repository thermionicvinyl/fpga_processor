module data_memory(
	input clk,
	input we,
	input v_f,
	input [31:0] a,
	input [31:0] wd,
	output [31:0] rd,
	output [31:0] out_zero
);
	reg [31:0] d_mem[31:0];
	
	assign rd = d_mem[a];
	assign out_zero = d_mem[0];
	
	always@(posedge clk)begin
		if(we&v_f)begin
			d_mem[a]<=wd;
		end
	end
	
	initial begin
		$readmemb("data_memory.txt",d_mem);
	end
endmodule

