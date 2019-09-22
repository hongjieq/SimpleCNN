`timescale 1ns / 1ps
`define RELU_DATA_WIDTH 45
`define POOL_X 12
`define POOL_Y 12
`define WEIGHT_WIDTH 32

module fc_layer (
	input clk,    // Clock
	input rst,  // Asynchronous reset active high
	input fc_enable,
	input [`RELU_DATA_WIDTH-1:0] pool_result_1 [`POOL_X-1:0][`POOL_Y-1:0],
	input [`RELU_DATA_WIDTH-1:0] pool_result_2 [`POOL_X-1:0][`POOL_Y-1:0],
	input [`RELU_DATA_WIDTH-1:0] pool_result_3 [`POOL_X-1:0][`POOL_Y-1:0],
	input [`RELU_DATA_WIDTH-1:0] pool_result_4 [`POOL_X-1:0][`POOL_Y-1:0],
	input [`RELU_DATA_WIDTH-1:0] pool_result_5 [`POOL_X-1:0][`POOL_Y-1:0],
	input [`RELU_DATA_WIDTH-1:0] pool_result_6 [`POOL_X-1:0][`POOL_Y-1:0],
	input [`RELU_DATA_WIDTH-1:0] pool_result_7 [`POOL_X-1:0][`POOL_Y-1:0],
	input [`RELU_DATA_WIDTH-1:0] pool_result_8 [`POOL_X-1:0][`POOL_Y-1:0],
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_0 [1151:0], // 12*12*8 = 1152
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_1 [1151:0], // 12*12*8 = 1152
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_2 [1151:0], 
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_3 [1151:0], 
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_4 [1151:0], 
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_5 [1151:0], 
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_6 [1151:0], 
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_7 [1151:0], 
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_8 [1151:0], 
	input signed [`WEIGHT_WIDTH-1:0] fc_weight_9 [1151:0], 
	output reg [31:0] prob_0,
	output reg [31:0] prob_1,
	output reg [31:0] prob_2,
	output reg [31:0] prob_3,
	output reg [31:0] prob_4,
	output reg [31:0] prob_5,
	output reg [31:0] prob_6,
	output reg [31:0] prob_7,
	output reg [31:0] prob_8,
	output reg [31:0] prob_9,
	output reg fc_done
);

	integer i;
	integer j;
	integer m;

	reg [`RELU_DATA_WIDTH-1:0] pool_result [1151:0];
	reg [31:0] next_prob_0;
	reg [31:0] next_prob_1;
	reg [31:0] next_prob_2;
	reg [31:0] next_prob_3;
	reg [31:0] next_prob_4;
	reg [31:0] next_prob_5;
	reg [31:0] next_prob_6;
	reg [31:0] next_prob_7;
	reg [31:0] next_prob_8;
	reg [31:0] next_prob_9;

	always @ (*) begin
		for (i = 0; i < `POOL_X; i++) begin
			for (j = 0; j < `POOL_Y; j++) begin
				pool_result[12*i+j] = pool_result_1[i][j];
				pool_result[12*i+j+144] = pool_result_2[i][j];
				pool_result[12*i+j+288] = pool_result_3[i][j];
				pool_result[12*i+j+432] = pool_result_4[i][j];
				pool_result[12*i+j+576] = pool_result_5[i][j];
				pool_result[12*i+j+720] = pool_result_6[i][j];
				pool_result[12*i+j+864] = pool_result_7[i][j];
				pool_result[12*i+j+1008] = pool_result_8[i][j];
			end
		end
	end

	always @ (*) begin
		next_prob_0 = 0;
		next_prob_1 = 0;
		next_prob_2 = 0;
		next_prob_3 = 0;
		next_prob_4 = 0;
		next_prob_5 = 0;
		next_prob_6 = 0;
		next_prob_7 = 0;
		next_prob_8 = 0;
		next_prob_9 = 0;
		for (m = 0; m < 1152; m++) begin
			next_prob_0 = next_prob_0 + fc_weight_0[m] * pool_result[m];
			next_prob_1 = next_prob_1 + fc_weight_1[m] * pool_result[m];
			next_prob_2 = next_prob_2 + fc_weight_2[m] * pool_result[m];
			next_prob_3 = next_prob_3 + fc_weight_3[m] * pool_result[m];
			next_prob_4 = next_prob_4 + fc_weight_4[m] * pool_result[m];
			next_prob_5 = next_prob_5 + fc_weight_5[m] * pool_result[m];
			next_prob_6 = next_prob_6 + fc_weight_6[m] * pool_result[m];
			next_prob_7 = next_prob_7 + fc_weight_7[m] * pool_result[m];
			next_prob_8 = next_prob_8 + fc_weight_8[m] * pool_result[m];
			next_prob_9 = next_prob_9 + fc_weight_9[m] * pool_result[m];
		end
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
			fc_done <= 0;
		end else if (fc_enable) begin
			prob_0 <= next_prob_0;
			prob_1 <= next_prob_1;
			prob_2 <= next_prob_2;
			prob_3 <= next_prob_3;
			prob_4 <= next_prob_4;
			prob_5 <= next_prob_5;
			prob_6 <= next_prob_6;
			prob_7 <= next_prob_7;
			prob_8 <= next_prob_8;
			prob_9 <= next_prob_9;
			fc_done <= 1'b1;
		end else begin
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
			fc_done <= 0;
		end
	end

endmodule