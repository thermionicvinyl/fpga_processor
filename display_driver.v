module display_driver(
	input clk,
	input m_f,
	input dp_f,
	input rst,
	input [23:0] hex,
	output reg [7:0] digit,
	output reg [5:0] select
);
	reg [3:0] state;
	reg [3:0] decode;
	always@(posedge clk)begin
		if(rst)begin
			state<=0;
			decode<=0;
			select<=6'b111111;
		end
		else begin
			case(state)
				0:
				begin
					if(m_f)begin
						state<=1;
					end
					decode<=hex[3:0];
					digit <= {dp,num};
					select<=6'b111110;
				end
				1:
				begin
					if(m_f)begin
						state<=2;
					end
					decode<=hex[7:4];
					digit <= {1'b1,num};
					select<=6'b111101;
				end
				2:
				begin
					if(m_f)begin
						state<=3;
					end
					decode<=hex[11:8];
					digit <= {1'b1,num};
					select<=6'b111011;
				end
				3:
				begin
					if(m_f)begin
						state<=4;
					end
					decode<=hex[15:12];
					digit <= {1'b1,num};
					select<=6'b110111;
				end
				4:
				begin
					if(m_f)begin
						state<=5;
					end
					decode<=hex[19:16];
					digit <= {1'b1,num};
					select<=6'b101111;
				end
				5:
				begin
					if(m_f)begin
						state<=0;
					end
					decode<=hex[23:20];
					digit <= {1'b1,num};
					select<=6'b011111;
				end
			endcase
		end
	end
	
	always @ (*)begin
		case (decode)
			0 : num <= 7'b100_0000;
			1 : num <= 7'b111_1001;
			2 : num <= 7'b010_0100;
			3 : num <= 7'b011_0000;
			4 : num <= 7'b001_1001;
			5 : num <= 7'b001_0010;
			6 : num <= 7'b000_0010;
			7 : num <= 7'b111_1000;
			8 : num <= 7'b000_0000;
			9 : num <= 7'b001_0000;
			10 : num <= 7'b000_1000;
			11 : num <= 7'b000_0011;
			12 : num <= 7'b100_0110;
			13 : num <= 7'b010_0001;
			14 : num <= 7'b000_0110;
			15 : num <= 7'b000_1110;
			default : num <= 7'b1000_0000;
		endcase
	end
	
	reg dp;
	reg [6:0] num;
	
	always@(posedge clk)begin
		if(rst)begin
			dp<=1'b0;
		end
		else if(dp_f)begin
			dp<=~dp;
		end
	end
	
endmodule
