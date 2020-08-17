module register_file(
	input clk,
	input reset,
	input we3,
	input v_f,
	input [4:0] a1 ,
	input [4:0] a2 ,
	input [4:0] a3 ,
	input [31:0] wd3 ,
	output [31:0] rd1 ,
	output [31:0] rd2 
);
	reg [31:0] r_mem[31:0];
	assign rd1 = r_mem[a1];
	assign rd2 = r_mem[a2];
	
	always@(posedge clk)begin
		//Creating $0 register
		r_mem[0] <= 32'b0;
		if(we3&v_f)begin
			r_mem[a3]<=wd3;
		end
	end
endmodule

