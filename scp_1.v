module scp_1(
	input inclk,
	input v_f,
	input ext_reset,
	input [7:0] sw,
	output [31:0] out_zero,
	output [9:0] control_signal,
	output [23:0] instr_lower,
	output [31:24] instr_upper,
	output [31:0] alu,
	output [31:0] program_counter,
	output [31:0] register_1,
	output [31:0] register_2
);
	//Interconnects
	wire clk = inclk;
	wire reset = ext_reset;
	wire [31:0] pc_prime;
	wire [31:0] pc_branch;
	reg [31:0] pc_next;
	reg [31:0] pc_inter;
	wire [31:0] instr;
	wire [31:0] rd1;
	wire [31:0] rd2;
	wire [31:0] sign_imm;
	wire zero;
	wire pc_src;
	wire [31:0] read_data;
	wire [31:0] alu_result;
	
	wire mem_to_reg;
	wire mem_write;
	wire branch;
	wire [2:0] alu_control;
	wire alu_src;
	wire reg_dst;
	wire reg_write;
	wire jump;
	wire reg_src;
	
	reg [4:0] write_reg;
	reg [31:0] src_b;
	reg [31:0] result;
	reg [31:0] reg_data_write;
	
	//Muxes
	always@(*)begin
		case(reg_dst)
			0:write_reg = instr[20:16];
			1:write_reg = instr[15:11];
		endcase
	end
	
	always@(*)begin
		case(alu_src)
			0:src_b = rd2;
			1:src_b = sign_imm;
		endcase
	end
	
	always@(*)begin
		case(mem_to_reg)
			0:result = alu_result;
			1:result = read_data;
		endcase
	end
	
	always@(*)begin
		case(pc_src)
			0:pc_next = pc_prime;
			1:pc_next = pc_branch;
		endcase
	end
	
	always@(*)begin
		case(jump)
			0:pc_inter = pc_next;
			1:pc_inter = instr[25:0];
		endcase
	end
	
	always@(*)begin
		case(reg_src)
			0:reg_data_write = result;
			1:reg_data_write = sw;
		endcase
	end
	
	//Program counter
	reg [31:0] pc;
	always@(posedge clk)begin
		if(reset)begin
			pc<=32'b0;
		end
		else if(v_f) begin
			pc<=pc_inter;
		end
	end
	
	//Next Instruction
	assign pc_prime = pc + 1;
	
	//Branch offset
	assign pc_src = branch&zero;
	assign pc_branch = pc_prime + sign_imm;
	
	//Instruction Memory
	instruction_memory instruction_memory_0
	(
		pc,
		instr
	);
	
	//Control Unit
	control_unit control_unit_0
	(
		instr[31:26],
		instr[5:0],
		mem_to_reg,
		mem_write,
		branch,
		alu_control,
		alu_src,
		reg_dst,
		reg_write,
		jump,
		reg_src
	);
	
	
	//Register File
	register_file register_file_0
	(
		clk,
		reset,
		reg_write,
		v_f,
		instr[25:21],
		instr[20:16],
		write_reg,
		reg_data_write,
		rd1,
		rd2
	);
	
	//Sign Extender
	sign_extend sign_extend_0
	(
		instr[15:0],
		sign_imm
	);
	
	//ALU
	alu alu_0
	(
		alu_control,
		rd1,
		src_b,
		alu_result,
		zero
	);
	
	//Data Memory
	data_memory data_memory_0
	(
	clk,
	mem_write,
	v_f,
	alu_result,
	rd2,
	read_data,
	out_zero
	);
	
	//Outputs
	assign control_signal = {reg_src,jump,reg_write,reg_dst,alu_src,alu_control,branch,mem_write,mem_to_reg};
	assign instr_lower = instr[23:0];
	assign instr_upper = instr[31:24];
	assign alu = alu_result;
	assign program_counter = pc;
	assign register_1 = rd1;
	assign register_2 = rd2;
endmodule
