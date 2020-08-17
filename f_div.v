module f_div(
	input clk,
	input rst,
	input [1:0] button,
	output reg m_f,
	output reg v_f,
	output reg dp_f
);
	reg [15:0]us_counter;
	reg [15:0]ms_counter;
	reg [31:0]vf_counter;
	reg [31:0]dp_counter;
	reg [31:0]v_max;
	reg u_f;
	
	always@(posedge clk)begin
		if(rst)begin
			us_counter<=0;
			u_f<=0;
		end
		else begin
			u_f<=0;
			if(us_counter == 49)begin
				us_counter<=0;
				u_f<=1;
			end
			else begin
				us_counter<=us_counter+1;
			end
		end
	end
	
	always@(posedge clk)begin
		if(rst)begin
			ms_counter<=0;
			m_f<=0;
		end
		else begin
			m_f<=0;
			if(u_f)begin
				if(ms_counter==999)begin
					ms_counter<=0;
					m_f<=1;
				end
				else begin
					ms_counter<=ms_counter+1;
				end
			end
		end
	end
	
	always@(posedge clk)begin
		if(rst)begin
			vf_counter<=0;
			v_f<=0;
		end
		else begin
			v_f<=0;
			if(u_f)begin
				if(vf_counter >= v_max)begin
					vf_counter<=0;
					v_f<=1;
				end
				else begin
					vf_counter<=vf_counter+1;
				end
			end
		end
	end
	
	always@(posedge clk)begin
		if(rst)begin
			dp_counter<=0;
			dp_f<=0;
		end
		else begin
			dp_f<=0;
			if(u_f)begin
				if(dp_counter >= v_max)begin
					dp_counter<=0;
					dp_f<=1;
				end
				else begin
					dp_counter<=dp_counter+2;
				end
			end
		end
	end
	//CHANGE VARI COUNTER TO M_F NOT U_F PLEASE
	
	always@(posedge clk)begin
		if(rst)begin
			v_max<=32'h0008_0000;
		end
		else if(button[1]&~button[0])begin
			if(v_max < 32'h0400_0000)begin
				v_max <= {v_max[30:0],v_max[31]};
			end
		end
		else if(button[0]&~button[1])begin
			if(v_max > 32'h0000_0200)begin
				v_max <= {v_max[0],v_max[31:1]};
			end
		end
	end
endmodule
