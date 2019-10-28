`timescale 1ns / 1ps
/*
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 69
`define POOL_X 12
`define POOL_Y 12
`define STRIDE 2
*/
module pool_layer(
	input clk,    	// Clock
	input rst,  	// Asynchronous reset active high
	input [4:0] count_x,
	input [4:0] count_y,
	input signed [68:0] pool_0_00,
	input signed [68:0] pool_0_01,
	input signed [68:0] pool_0_10,
	input signed [68:0] pool_0_11,
	input signed [68:0] pool_1_00,
	input signed [68:0] pool_1_01,
	input signed [68:0] pool_1_10,
	input signed [68:0] pool_1_11,
	input signed [68:0] pool_2_00,
	input signed [68:0] pool_2_01,
	input signed [68:0] pool_2_10,
	input signed [68:0] pool_2_11,
	input signed [68:0] pool_3_00,
	input signed [68:0] pool_3_01,
	input signed [68:0] pool_3_10,
	input signed [68:0] pool_3_11,
	input signed [68:0] pool_4_00,
	input signed [68:0] pool_4_01,
	input signed [68:0] pool_4_10,
	input signed [68:0] pool_4_11,
	input signed [68:0] pool_5_00,
	input signed [68:0] pool_5_01,
	input signed [68:0] pool_5_10,
	input signed [68:0] pool_5_11,
	input signed [68:0] pool_6_00,
	input signed [68:0] pool_6_01,
	input signed [68:0] pool_6_10,
	input signed [68:0] pool_6_11,
	input signed [68:0] pool_7_00,
	input signed [68:0] pool_7_01,
	input signed [68:0] pool_7_10,
	input signed [68:0] pool_7_11,
	/*
	output reg signed [68:0] pool_result_1,
	output reg signed [68:0] pool_result_2,
	output reg signed [68:0] pool_result_3,
	output reg signed [68:0] pool_result_4,
	output reg signed [68:0] pool_result_5,
	output reg signed [68:0] pool_result_6,
	output reg signed [68:0] pool_result_7,
	output reg signed [68:0] pool_result_8
	*/
	output reg signed [112:0] prob_0,
	output reg signed [112:0] prob_1,
	output reg signed [112:0] prob_2,
	output reg signed [112:0] prob_3,
	output reg signed [112:0] prob_4,
	output reg signed [112:0] prob_5,
	output reg signed [112:0] prob_6,
	output reg signed [112:0] prob_7,
	output reg signed [112:0] prob_8,
	output reg signed [112:0] prob_9,
	output reg fc_done
);

	reg signed [68:0] next_pool_result_1;
	reg signed [68:0] next_pool_result_2;
	reg signed [68:0] next_pool_result_3;
	reg signed [68:0] next_pool_result_4;
	reg signed [68:0] next_pool_result_5;
	reg signed [68:0] next_pool_result_6;
	reg signed [68:0] next_pool_result_7;
	reg signed [68:0] next_pool_result_8;
	reg signed [68:0] temp [7:0];
	reg signed [68:0] pool [1151:0];
	reg signed [31:0] fc_weight_read [9:0][1151:0];
	reg signed [112:0] fc_weight [9:0][1151:0];
	reg pool_done;
	integer i,j;
	reg [10:0] count;

	initial begin
		$readmemb("fc_weights_out_2s_comp.txt.txt", fc_weight_read);
	end

	// weight sign extend
	always @(*) begin
		for (i = 0; i < 10; i=i+1) begin
			for (j = 0; j < 1152; j=j+1) begin
				fc_weight[i][j][31:0] = fc_weight_read[i][j];
				fc_weight[i][j][112:32] = {81{fc_weight_read[i][j][31]}};
			end
		end
	end

	always @(*) begin
		temp[0] = pool_0_00;
		if (pool_0_01 > temp[0]) temp[0] = pool_0_01;
		if (pool_0_10 > temp[0]) temp[0] = pool_0_10;
		if (pool_0_11 > temp[0]) temp[0] = pool_0_11;
		next_pool_result_1 = temp[0];
	end

	always @(*) begin
		temp[1] = pool_1_00;
		if (pool_1_01 > temp[1]) temp[1] = pool_1_01;
		if (pool_1_10 > temp[1]) temp[1] = pool_1_10;
		if (pool_1_11 > temp[1]) temp[1] = pool_1_11;
		next_pool_result_2 = temp[1];
	end

	always @(*) begin
		temp[2] = pool_2_00;
		if (pool_2_01 > temp[2]) temp[2] = pool_2_01;
		if (pool_2_10 > temp[2]) temp[2] = pool_2_10;
		if (pool_2_11 > temp[2]) temp[2] = pool_2_11;
		next_pool_result_3 = temp[2];
	end

	always @(*) begin
		temp[3] = pool_3_00;
		if (pool_3_01 > temp[3]) temp[3] = pool_3_01;
		if (pool_3_10 > temp[3]) temp[3] = pool_3_10;
		if (pool_3_11 > temp[3]) temp[3] = pool_3_11;
		next_pool_result_4 = temp[3];
	end

	always @(*) begin
		temp[4] = pool_4_00;
		if (pool_4_01 > temp[4]) temp[4] = pool_4_01;
		if (pool_4_10 > temp[4]) temp[4] = pool_4_10;
		if (pool_4_11 > temp[4]) temp[4] = pool_4_11;
		next_pool_result_5 = temp[4];
	end

	always @(*) begin
		temp[5] = pool_5_00;
		if (pool_5_01 > temp[5]) temp[5] = pool_5_01;
		if (pool_5_10 > temp[5]) temp[5] = pool_5_10;
		if (pool_5_11 > temp[5]) temp[5] = pool_5_11;
		next_pool_result_6 = temp[5];
	end

	always @(*) begin
		temp[6] = pool_6_00;
		if (pool_6_01 > temp[6]) temp[6] = pool_6_01;
		if (pool_6_10 > temp[6]) temp[6] = pool_6_10;
		if (pool_6_11 > temp[6]) temp[6] = pool_6_11;
		next_pool_result_7 = temp[6];
	end

	always @(*) begin
		temp[7] = pool_7_00;
		if (pool_7_01 > temp[7]) temp[7] = pool_7_01;
		if (pool_7_10 > temp[7]) temp[7] = pool_7_10;
		if (pool_7_11 > temp[7]) temp[7] = pool_7_11;
		next_pool_result_8 = temp[7];
	end

	always @(*) begin
		pool[12*count_x+count_y] = next_pool_result_1;
		pool[144+12*count_x+count_y] = next_pool_result_2;
		pool[288+12*count_x+count_y] = next_pool_result_3;
		pool[432+12*count_x+count_y] = next_pool_result_4;
		pool[576+12*count_x+count_y] = next_pool_result_5;
		pool[720+12*count_x+count_y] = next_pool_result_6;
		pool[864+12*count_x+count_y] = next_pool_result_7;
		pool[1008+12*count_x+count_y] = next_pool_result_8;
	end

	always @ (posedge clk) begin
		if (rst) begin
			prob_0 <= 0;
			prob_1 <= 0;
			prob_2 <= 0;
			prob_3 <= 0;
			prob_4 <= 0;
			prob_5 <= 0;
			prob_6 <= 0;
			prob_7 <= 0;
			prob_8 <= 0;
			prob_9 <= 0;
		end else if (pool_done && count < 1152) begin
			prob_0 <= prob_0 + fc_weight[0][count] * pool[count];
			prob_1 <= prob_1 + fc_weight[1][count] * pool[count];
			prob_2 <= prob_2 + fc_weight[2][count] * pool[count];
			prob_3 <= prob_3 + fc_weight[3][count] * pool[count];
			prob_4 <= prob_4 + fc_weight[4][count] * pool[count];
			prob_5 <= prob_5 + fc_weight[5][count] * pool[count];
			prob_6 <= prob_6 + fc_weight[6][count] * pool[count];
			prob_7 <= prob_7 + fc_weight[7][count] * pool[count];
			prob_8 <= prob_8 + fc_weight[8][count] * pool[count];
			prob_9 <= prob_9 + fc_weight[9][count] * pool[count];
		end
	end

	always @ (posedge clk) begin
		if (rst) begin
			pool_done <= 1'b0;
		end else if (count_x == 5'd11 && count_y == 5'd11) begin
			pool_done <= 1'b1;
		end
	end

	always @ (posedge clk) begin
		if (rst) begin
			count <= 0;
			fc_done <= 0;
		end else if (pool_done) begin
			if (count < 1152) count <= count + 1;
			else if (count == 1152) fc_done <= 1'b1;
		end
	end
	/*
	always @ (posedge clk) begin
		if (rst) begin
			pool_result_1 <= 0;
			pool_result_2 <= 0;
			pool_result_3 <= 0;
			pool_result_4 <= 0;
			pool_result_5 <= 0;
			pool_result_6 <= 0;
			pool_result_7 <= 0;
			pool_result_8 <= 0;
		end else begin
			pool_result_1 <= next_pool_result_1;
			pool_result_2 <= next_pool_result_2;
			pool_result_3 <= next_pool_result_3;
			pool_result_4 <= next_pool_result_4;
			pool_result_5 <= next_pool_result_5;
			pool_result_6 <= next_pool_result_6;
			pool_result_7 <= next_pool_result_7;
			pool_result_8 <= next_pool_result_8;
		end
	end
	*/

endmodule
