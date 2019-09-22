`timescale 1ns / 1ps
`define DATA_X 28
`define DATA_Y 28
`define DATA_SIZE 31
`define WEIGHT_X 5
`define WEIGHT_Y 5
`define WEIGHT_SIZE 32

module top (
	input clk,    // Clock
	input rst,  	// Asynchronous reset active high
	input [`DATA_SIZE-1:0] data [`DATA_X-1:0][`DATA_Y-1:0], // 28*28 32-bit data

	output [3:0] result
);

// read_data
	wire signed [`WEIGHT_SIZE-1:0] weight_1 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire signed [`WEIGHT_SIZE-1:0] weight_2 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire signed [`WEIGHT_SIZE-1:0] weight_3 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire signed [`WEIGHT_SIZE-1:0] weight_4 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire signed [`WEIGHT_SIZE-1:0] weight_5 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire signed [`WEIGHT_SIZE-1:0] weight_6 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire signed [`WEIGHT_SIZE-1:0] weight_7 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire signed [`WEIGHT_SIZE-1:0] weight_8 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];

	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_0 [1151:0]; // 12*12*8 = 1152
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_1 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_2 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_3 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_4 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_5 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_6 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_7 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_8 [1151:0];
	wire signed [`WEIGHT_WIDTH-1:0] fc_weight_9 [1151:0];

// conv_layer
	wire conv_enable;
	wire conv_result_1;
	wire conv_result_2;
	wire conv_result_1;
	wire conv_result_3;
	wire conv_result_4;
	wire conv_result_5;
	wire conv_result_6;
	wire conv_result_7;
	wire conv_result_8;
	wire conv_done;

// relu_layer
	wire relu_result_1;
	wire relu_result_2;
	wire relu_result_3;
	wire relu_result_4;
	wire relu_result_5;
	wire relu_result_6;
	wire relu_result_7;
	wire relu_result_8;
	wire relu_done;

// pool_layer
	wire pool_result_1;
	wire pool_result_2;
	wire pool_result_3;
	wire pool_result_4;
	wire pool_result_5;
	wire pool_result_6;
	wire pool_result_7;
	wire pool_result_8;
	wire pool_done;

// fc_layer
	wire [31:0] prob_0;
	wire [31:0] prob_1;
	wire [31:0] prob_2;
	wire [31:0] prob_3;
	wire [31:0] prob_4;
	wire [31:0] prob_5;
	wire [31:0] prob_6;
	wire [31:0] prob_7;
	wire [31:0] prob_8;
	wire [31:0] prob_9;

// TODO: read_data


// conv_layer
	conv_layer conv_layer(
		// INPUTS
	 	.clk(clk),
	 	.rst(rst),
	 	.conv_enable(conv_enable),
	 	.data(data),
	 	.weight_1(weight_1),
	 	.weight_2(weight_2),
	 	.weight_3(weight_3),
	 	.weight_4(weight_4),
	 	.weight_5(weight_5),
	 	.weight_6(weight_6),
	 	.weight_7(weight_7),
	 	.weight_8(weight_8),

		// OUTPUTS
	 	.conv_result_1(conv_result_1),
	 	.conv_result_2(conv_result_2),
	 	.conv_result_3(conv_result_3),
	 	.conv_result_4(conv_result_4),
	 	.conv_result_5(conv_result_5),
	 	.conv_result_6(conv_result_6),
	 	.conv_result_7(conv_result_7),
	 	.conv_result_8(conv_result_8),
	 	.conv_done(conv_done)
	);

	relu_layer relu_layer(
		// INPUTS
		.clk(clk),
	 	.rst(rst),
		.relu_enable(conv_done),
		.conv_result_1(conv_result_1),
		.conv_result_2(conv_result_2),
		.conv_result_3(conv_result_3),
		.conv_result_4(conv_result_4),
		.conv_result_5(conv_result_5),
		.conv_result_6(conv_result_6),
		.conv_result_7(conv_result_7),
		.conv_result_8(conv_result_8),

		// OUTPUTS
		.relu_result_1(relu_result_1),
		.relu_result_2(relu_result_2),
		.relu_result_3(relu_result_3),
		.relu_result_4(relu_result_4),
		.relu_result_5(relu_result_5),
		.relu_result_6(relu_result_6),
		.relu_result_7(relu_result_7),
		.relu_result_8(relu_result_8),
		.relu_done(relu_done)
	);

// pool_layer
	pool_layer pool_layer(
		// INPUTS
		.clk(clk),
	 	.rst(rst),
		.pool_enable(relu_done),
		.relu_result_1(relu_result_1),
		.relu_result_2(relu_result_2),
		.relu_result_3(relu_result_3),
		.relu_result_4(relu_result_4),
		.relu_result_5(relu_result_5),
		.relu_result_6(relu_result_6),
		.relu_result_7(relu_result_7),
		.relu_result_8(relu_result_8),

		// OUTPUTS
		.pool_result_1(pool_result_1),
		.pool_result_2(pool_result_2),
		.pool_result_3(pool_result_3),
		.pool_result_4(pool_result_4),
		.pool_result_5(pool_result_5),
		.pool_result_6(pool_result_6),
		.pool_result_7(pool_result_7),
		.pool_result_8(pool_result_8),
		.pool_done(pool_done)
	);

	// fc_layer
		fc_layer fc_layer(
			// INPUTS
			.clk(clk),
		 	.rst(rst),
			.fc_enable(pool_done),
			.pool_result_1(pool_result_1),
			.pool_result_2(pool_result_2),
			.pool_result_3(pool_result_3),
			.pool_result_4(pool_result_4),
			.pool_result_5(pool_result_5),
			.pool_result_6(pool_result_6),
			.pool_result_7(pool_result_7),
			.pool_result_8(pool_result_8),
			.fc_weight_0(fc_weight_0),
			.fc_weight_1(fc_weight_1),
			.fc_weight_2(fc_weight_2),
			.fc_weight_3(fc_weight_3),
			.fc_weight_4(fc_weight_4),
			.fc_weight_5(fc_weight_5),
			.fc_weight_6(fc_weight_6),
			.fc_weight_7(fc_weight_7),
			.fc_weight_8(fc_weight_8),

			// OUTPUTS
			.prob_0(prob_0),
			.prob_1(prob_1),
			.prob_2(prob_2),
			.prob_3(prob_3),
			.prob_4(prob_4),
			.prob_5(prob_5),
			.prob_6(prob_6),
			.prob_7(prob_7),
			.prob_8(prob_8),
			.prob_9(prob_9),
			.fc_done(fc_done)
		);

// TODO: compare prob0-prob9 and get result











endmodule
