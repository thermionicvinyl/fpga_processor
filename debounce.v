module debounce(
	input clk,
	input rst,
	input m_f,
	input button,
	output reg db_button
);
	reg [1:0] state;
	reg [3:0] counter;
	always@(posedge clk)begin
		if(rst)begin
			state<=0;
			counter<=0;
			db_button<=0;
		end
		else begin
			case(state)
				0:
				begin
					counter<=0;
					db_button<=0;
					if(button)begin
						state<=1;
					end
					else begin
						state<=0;
					end
				end
				1:
				begin
					if(~button)begin
						state<=0;
					end
					else begin
						if(counter == 9)begin
							state<=2;
							counter<=0;
						end
						else if(m_f)begin
							counter<=counter+1;
						end
					end
				end
				2:
				begin
					counter<=0;
					if(~button)begin
						state<=3;
					end
					else begin
						state<=2;
					end
				end
				3:
				begin
					if(button)begin
						state<=2;
					end
					else begin
						if(counter == 9)begin
							state<=0;
							counter<=0;
							db_button<=1;
						end
						else if(m_f)begin
							counter<=counter+1;
						end
					end
				end
			endcase
		end
	end
endmodule
