`timescale 1ns / 1ps
`define DATA_X 28
`define DATA_Y 28
`define DATA_SIZE 32
`define WEIGHT_X 5
`define WEIGHT_Y 5
`define WEIGHT_SIZE 32

module top (
	input wire clk,    // Clock
	input wire rst,  	// Asynchronous reset active high
	output reg [3:0] result
);

// read_data
	wire [`DATA_SIZE-1:0] data [`DATA_X-1:0][`DATA_Y-1:0]; // 28*28 32-bit data
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
	wire fc_done;

// read_data
	read_data read_data(
		// INPUTS
		.clk(clk),
	 	.rst(rst),

		// OUTPUTS
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

// TODO: conv_enable control signal

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

// Compare prob0-prob9 and get result

	reg [31:0] in_prob_0, in_prob_1, in_prob_2, in_prob_3, in_prob_4, in_prob_5, in_prob_6, in_prob_7, in_prob_8, in_prob_9;

	always @ (fc_done) begin
		in_prob_0 <= prob_0;
		in_prob_1 <= prob_1;
		in_prob_2 <= prob_2;
		in_prob_3 <= prob_3;
		in_prob_4 <= prob_4;
		in_prob_5 <= prob_5;
		in_prob_6 <= prob_6;
		in_prob_7 <= prob_7;
		in_prob_8 <= prob_8;
		in_prob_9 <= prob_9;
	end

	integer i, j;
	reg [31:0] prob [9:0];
	reg [31:0] tmp_prob;

	always @ (*) begin
		prob[0] = in_prob_0;
		prob[1] = in_prob_1;
		prob[2] = in_prob_2;
		prob[3] = in_prob_3;
		prob[4] = in_prob_4;
		prob[5] = in_prob_5;
		prob[6] = in_prob_6;
		prob[7] = in_prob_7;
		prob[8] = in_prob_8;
		prob[9] = in_prob_9;

		for (i = 9; i >= 0; i = i-1) begin
			for (j = 0; j < i; j = j+1) begin
				if (prob[j] < prob[j+1]) begin
					tmp_prob = prob[j];
					prob[j] = prob[j+1];
					prob[j+1] = tmp_prob;
				end
			end
		end
	end

	always @ (posedge clk) begin
		if (prob[9] = prob_0)
			result = 4'd0;
		else if (prob[9] = prob_1)
			result = 4'd1;
		else if (prob[9] = prob_2)
			result = 4'd2;
		else if (prob[9] = prob_3)
			result = 4'd3;
		else if (prob[9] = prob_4)
			result = 4'd4;
		else if (prob[9] = prob_5)
			result = 4'd5;
		else if (prob[9] = prob_6)
			result = 4'd6;
		else if (prob[9] = prob_7)
			result = 4'd7;
		else if (prob[9] = prob_8)
			result = 4'd8;
		else if (prob[9] = prob_9)
			result = 4'd9;
		else
			result = 4'd16;
	end

endmodule
