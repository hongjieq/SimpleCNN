`timescale 1ns / 1ps

module read_data_tb ();

	reg clk;
	reg rst;
	wire [31:0] data [27:0][27:0];
	wire signed [31:0] weight_1 [5:0][5:0];
	wire signed [31:0] weight_2 [5:0][5:0];
	wire signed [31:0] weight_3 [5:0][5:0];
	wire signed [31:0] weight_4 [5:0][5:0];
	wire signed [31:0] weight_5 [5:0][5:0];
	wire signed [31:0] weight_6 [5:0][5:0];
	wire signed [31:0] weight_7 [5:0][5:0];
	wire signed [31:0] weight_8 [5:0][5:0];
	wire signed [31:0] fc_weight_0 [1151:0];
	wire signed [31:0] fc_weight_1 [1151:0];
	wire signed [31:0] fc_weight_2 [1151:0];
	wire signed [31:0] fc_weight_3 [1151:0];
	wire signed [31:0] fc_weight_4 [1151:0];
	wire signed [31:0] fc_weight_5 [1151:0];
	wire signed [31:0] fc_weight_6 [1151:0];
	wire signed [31:0] fc_weight_7 [1151:0];
	wire signed [31:0] fc_weight_8 [1151:0];
	wire signed [31:0] fc_weight_9 [1151:0];
	

	read_data DUT(
		.clk(clk),
		.rst(rst),
		.data(data),
		.weight_1(weight_1),
		.weight_2(weight_2),
		.weight_3(weight_3),
		.weight_4(weight_4),
		.weight_5(weight_5),
		.weight_6(weight_6),
		.weight_7(weight_7),
		.weight_8(weight_8),
		.fc_weight_0(fc_weight_0),
		.fc_weight_1(fc_weight_1),
		.fc_weight_2(fc_weight_2),
		.fc_weight_3(fc_weight_3),
		.fc_weight_4(fc_weight_4),
		.fc_weight_5(fc_weight_5),
		.fc_weight_6(fc_weight_6),
		.fc_weight_7(fc_weight_7),
		.fc_weight_8(fc_weight_8),
		.fc_weight_9(fc_weight_9)
	);

	integer i;

	always begin
		#5;
		clk = ~clk;
	end
	
	task display_data;
		$display("------------display data-------------");
		for (i = 0; i < 28; i++) begin
			$display("%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b", 
					data[i][0], data[i][1], data[i][2],data[i][3], data[i][4], data[i][5],data[i][6],
					data[i][7], data[i][8], data[i][9],data[i][10], data[i][11], data[i][12],data[i][13],
					data[i][14], data[i][15], data[i][16],data[i][17], data[i][18], data[i][19],data[i][20],
					data[i][21], data[i][22], data[i][23],data[i][24], data[i][25], data[i][26],data[i][27]);
		end
	endtask

	task display_conv_weight;
		$display("------------display conv weight-------------");
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_1[i][0], weight_1[i][1], weight_1[i][2], weight_1[i][3], weight_1[i][4]);
		/*
			$display("%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b", 
					data[0+i], data[1+i], data[2+i],data[3+i], data[4+i], data[5+i],data[6+i],
					data[7+i], data[8+i], data[9+i],data[10+i], data[11+i], data[12+i],data[13+i],
					data[14+i], data[15+i], data[16+i],data[17+i], data[18+i], data[19+i],data[20+i],
					data[21+i], data[22+i], data[23+i],data[24+i], data[25+i], data[26+i],data[27+i]);
		*/
		end
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_2[i][0], weight_2[i][1], weight_2[i][2], weight_2[i][3], weight_2[i][4]);
		end
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_3[i][0], weight_3[i][1], weight_3[i][2], weight_3[i][3], weight_3[i][4]);
		end
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_4[i][0], weight_4[i][1], weight_4[i][2], weight_4[i][3], weight_4[i][4]);
		end
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_5[i][0], weight_5[i][1], weight_5[i][2], weight_5[i][3], weight_5[i][4]);
		end
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_6[i][0], weight_6[i][1], weight_6[i][2], weight_6[i][3], weight_6[i][4]);
		end
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_7[i][0], weight_7[i][1], weight_7[i][2], weight_7[i][3], weight_7[i][4]);
		end
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b ", weight_8[i][0], weight_8[i][1], weight_8[i][2], weight_8[i][3], weight_8[i][4]);
		end
	endtask 
	
	task display_fc_weight;
		$display("------------display fc weight-------------");
		for (i = 0; i < 1152; i++) begin
			$display("%b", fc_weight_0[i]);
		end
	endtask

	initial begin
		clk = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		display_data();
		display_conv_weight();
		display_fc_weight();
		@(negedge clk);
		//$display("%d",5/3);
		$finish;
	end

endmodule
