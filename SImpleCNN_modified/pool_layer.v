`timescale 1ns / 1ps
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 69
`define POOL_X 12
`define POOL_Y 12
`define STRIDE 2

module pool_layer(
	input clk,    	// Clock
	input rst,  	// Asynchronous reset active high
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
	output reg signed [68:0] pool_result_1,
	output reg signed [68:0] pool_result_2,
	output reg signed [68:0] pool_result_3,
	output reg signed [68:0] pool_result_4,
	output reg signed [68:0] pool_result_5,
	output reg signed [68:0] pool_result_6,
	output reg signed [68:0] pool_result_7,
	output reg signed [68:0] pool_result_8
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

endmodule
