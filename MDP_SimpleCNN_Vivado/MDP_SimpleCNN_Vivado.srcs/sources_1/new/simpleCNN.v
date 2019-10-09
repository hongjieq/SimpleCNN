`timescale 1ns / 1ps
`define DATA_X 28
`define DATA_Y 28
`define DATA_SIZE 32
`define WEIGHT_X 5
`define WEIGHT_Y 5
`define WEIGHT_SIZE 32
`define WEIGHT_WIDTH 32
`define CONV_X 24
`define CONV_Y 24
`define CONV_SIZE 69
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 69
`define POOL_X 12
`define POOL_Y 12
`define STRIDE 2
`define DEBUG

module simpleCNN (
	input wire clk,    // Clock
	input wire rst,  	// Asynchronous reset active high
	input wire enable,
	output reg [3:0] result,
	output reg signed [112:0] prob [9:0]
	/*
	`ifdef DEBUG
		,output reg signed [112:0] prob [9:0]
		,output wire signed [`WEIGHT_SIZE-1:0] weight_1 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0]
		,output wire signed [`DATA_SIZE-1:0] data [`DATA_X-1:0][`DATA_Y-1:0] // 28*28 32-bit data
		,output wire signed [`WEIGHT_WIDTH-1:0] fc_weight_0 [1151:0]	
		,output reg conv_enable
		,output wire signed [`CONV_SIZE-1:0] conv_result_1 [`CONV_X-1:0][`CONV_Y-1:0]
		,output wire conv_done
		,output wire signed [`RELU_DATA_WIDTH-1:0] relu_result_1 [`RELU_X-1:0][`RELU_Y-1:0]
		,output wire relu_done
		,output wire signed [`RELU_DATA_WIDTH-1:0] pool_result_1 [`POOL_X-1:0][`POOL_Y-1:0]
		,output wire pool_done
	`endif
	*/
);

// read_data
  //`ifndef DEBUG	
	wire signed [25087:0] data_f; // 28*28 32-bit data
	wire signed [799:0] weight_1_f;
	//`endif
	wire signed [799:0] weight_2_f;
	wire signed [799:0] weight_3_f;
	wire signed [799:0] weight_4_f;
	wire signed [799:0] weight_5_f;
	wire signed [799:0] weight_6_f;
	wire signed [799:0] weight_7_f;
	wire signed [799:0] weight_8_f;

	//`ifndef DEBUG	
	wire signed [36863:0] fc_weight_0_f; // 12*12*8 = 1152
	//`endif
	wire signed [36863:0] fc_weight_1_f;
	wire signed [36863:0] fc_weight_2_f;
	wire signed [36863:0] fc_weight_3_f;
	wire signed [36863:0] fc_weight_4_f;
	wire signed [36863:0] fc_weight_5_f;
	wire signed [36863:0] fc_weight_6_f;
	wire signed [36863:0] fc_weight_7_f;
	wire signed [36863:0] fc_weight_8_f;
	wire signed [36863:0] fc_weight_9_f;

// conv_layer
	//`ifndef DEBUG
	reg conv_enable;	
	wire signed [39743:0] conv_result_1_f;
	//`endif
	wire signed [39743:0] conv_result_2_f;
	wire signed [39743:0] conv_result_3_f;
	wire signed [39743:0] conv_result_4_f;
	wire signed [39743:0] conv_result_5_f;
	wire signed [39743:0] conv_result_6_f;
	wire signed [39743:0] conv_result_7_f;
	wire signed [39743:0] conv_result_8_f;
	//`ifndef DEBUG
	wire conv_done;
	//`endif

// relu_layer
	//`ifndef DEBUG
	wire signed [39743:0] relu_result_1_f;
	//`endif
	wire signed [39743:0] relu_result_2_f;
	wire signed [39743:0] relu_result_3_f;
	wire signed [39743:0] relu_result_4_f;
	wire signed [39743:0] relu_result_5_f;
	wire signed [39743:0] relu_result_6_f;
	wire signed [39743:0] relu_result_7_f;
	wire signed [39743:0] relu_result_8_f;
	
	//`ifndef DEBUG
	wire relu_done;
	//`endif

// pool_layer
	//`ifndef DEBUG
		wire signed [9935:0] pool_result_1_f;
	//`endif
	wire signed [9935:0] pool_result_2_f;
	wire signed [9935:0] pool_result_3_f;
	wire signed [9935:0] pool_result_4_f;
	wire signed [9935:0] pool_result_5_f;
	wire signed [9935:0] pool_result_6_f;
	wire signed [9935:0] pool_result_7_f;
	wire signed [9935:0] pool_result_8_f;
	//`ifndef DEBUG
	wire pool_done;
	//`endif

// fc_layer
	wire signed [112:0] prob_0;
	wire signed [112:0] prob_1;
	wire signed [112:0] prob_2;
	wire signed [112:0] prob_3;
	wire signed [112:0] prob_4;
	wire signed [112:0] prob_5;
	wire signed [112:0] prob_6;
	wire signed [112:0] prob_7;
	wire signed [112:0] prob_8;
	wire signed [112:0] prob_9;
	wire fc_done;
	
// read_data
	read_data read(
		// INPUTS
		.clk(clk),
	 	.rst(rst),

		// OUTPUTS
		.data_f(data_f),
		.weight_1_f(weight_1_f),
		.weight_2_f(weight_2_f),
		.weight_3_f(weight_3_f),
		.weight_4_f(weight_4_f),
		.weight_5_f(weight_5_f),
		.weight_6_f(weight_6_f),
		.weight_7_f(weight_7_f),
		.weight_8_f(weight_8_f),
		.fc_weight_0_f(fc_weight_0_f),
		.fc_weight_1_f(fc_weight_1_f),
		.fc_weight_2_f(fc_weight_2_f),
		.fc_weight_3_f(fc_weight_3_f),
		.fc_weight_4_f(fc_weight_4_f),
		.fc_weight_5_f(fc_weight_5_f),
		.fc_weight_6_f(fc_weight_6_f),
		.fc_weight_7_f(fc_weight_7_f),
		.fc_weight_8_f(fc_weight_8_f),
		.fc_weight_9_f(fc_weight_9_f)
	);

// TODO: conv_enable control signal

// conv_layer
	conv_layer conv(
		// INPUTS
	 	.clk(clk),
	 	.rst(rst),
	 	.conv_enable(conv_enable),
	 	.data_f(data_f),
	 	.weight_1_f(weight_1_f),
	 	.weight_2_f(weight_2_f),
	 	.weight_3_f(weight_3_f),
	 	.weight_4_f(weight_4_f),
	 	.weight_5_f(weight_5_f),
	 	.weight_6_f(weight_6_f),
	 	.weight_7_f(weight_7_f),
	 	.weight_8_f(weight_8_f),

		// OUTPUTS
	 	.conv_result_1_f(conv_result_1_f),
	 	.conv_result_2_f(conv_result_2_f),
	 	.conv_result_3_f(conv_result_3_f),
	 	.conv_result_4_f(conv_result_4_f),
	 	.conv_result_5_f(conv_result_5_f),
	 	.conv_result_6_f(conv_result_6_f),
	 	.conv_result_7_f(conv_result_7_f),
	 	.conv_result_8_f(conv_result_8_f),
	 	.conv_done(conv_done)
	);

	relu_layer relu(
		// INPUTS
		.clk(clk),
	 	.rst(rst),
		.relu_enable(conv_done),
		.conv_result_1_f(conv_result_1_f),
		.conv_result_2_f(conv_result_2_f),
		.conv_result_3_f(conv_result_3_f),
		.conv_result_4_f(conv_result_4_f),
		.conv_result_5_f(conv_result_5_f),
		.conv_result_6_f(conv_result_6_f),
		.conv_result_7_f(conv_result_7_f),
		.conv_result_8_f(conv_result_8_f),

		// OUTPUTS
		.relu_result_1_f(relu_result_1_f),
		.relu_result_2_f(relu_result_2_f),
		.relu_result_3_f(relu_result_3_f),
		.relu_result_4_f(relu_result_4_f),
		.relu_result_5_f(relu_result_5_f),
		.relu_result_6_f(relu_result_6_f),
		.relu_result_7_f(relu_result_7_f),
		.relu_result_8_f(relu_result_8_f),
		.relu_done(relu_done)
	);

// pool_layer
	pool_layer pool(
		// INPUTS
		.clk(clk),
	 	.rst(rst),
		.pool_enable(relu_done),
		.relu_result_1_f(relu_result_1_f),
		.relu_result_2_f(relu_result_2_f),
		.relu_result_3_f(relu_result_3_f),
		.relu_result_4_f(relu_result_4_f),
		.relu_result_5_f(relu_result_5_f),
		.relu_result_6_f(relu_result_6_f),
		.relu_result_7_f(relu_result_7_f),
		.relu_result_8_f(relu_result_8_f),

		// OUTPUTS
		.pool_result_1_f(pool_result_1_f),
		.pool_result_2_f(pool_result_2_f),
		.pool_result_3_f(pool_result_3_f),
		.pool_result_4_f(pool_result_4_f),
		.pool_result_5_f(pool_result_5_f),
		.pool_result_6_f(pool_result_6_f),
		.pool_result_7_f(pool_result_7_f),
		.pool_result_8_f(pool_result_8_f),
		.pool_done(pool_done)
	);

	// fc_layer
		fc_layer fc(
			// INPUTS
			.clk(clk),
		 	.rst(rst),
			.fc_enable(pool_done),
			.pool_result_1_f(pool_result_1_f),
			.pool_result_2_f(pool_result_2_f),
			.pool_result_3_f(pool_result_3_f),
			.pool_result_4_f(pool_result_4_f),
			.pool_result_5_f(pool_result_5_f),
			.pool_result_6_f(pool_result_6_f),
			.pool_result_7_f(pool_result_7_f),
			.pool_result_8_f(pool_result_8_f),
			.fc_weight_0_f(fc_weight_0_f),
			.fc_weight_1_f(fc_weight_1_f),
			.fc_weight_2_f(fc_weight_2_f),
			.fc_weight_3_f(fc_weight_3_f),
			.fc_weight_4_f(fc_weight_4_f),
			.fc_weight_5_f(fc_weight_5_f),
			.fc_weight_6_f(fc_weight_6_f),
			.fc_weight_7_f(fc_weight_7_f),
			.fc_weight_8_f(fc_weight_8_f),
			.fc_weight_9_f(fc_weight_9_f),

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

	reg signed [112:0] in_prob_0, in_prob_1, in_prob_2, in_prob_3, in_prob_4, in_prob_5, in_prob_6, in_prob_7, in_prob_8, in_prob_9;

	always @ (fc_done) begin
		in_prob_0 = prob_0;
		in_prob_1 = prob_1;
		in_prob_2 = prob_2;
		in_prob_3 = prob_3;
		in_prob_4 = prob_4;
		in_prob_5 = prob_5;
		in_prob_6 = prob_6;
		in_prob_7 = prob_7;
		in_prob_8 = prob_8;
		in_prob_9 = prob_9;
	end

	integer i, j;
	//`ifndef DEBUG
		//reg signed [112:0] prob [9:0];
	//`endif
	reg signed [112:0] tmp_prob;
	reg [3:0] next_result;
	reg signed [112:0] max_prob;

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

		/*
		for (i = 9; i >= 0; i = i-1) begin
			for (j = 0; j < i; j = j+1) begin
				if (prob[j] < prob[j+1]) begin
					tmp_prob = prob[j];
					prob[j] = prob[j+1];
					prob[j+1] = tmp_prob;
				end
			end
		end
		*/
		next_result = 0;
		max_prob = prob[0];
		for (i = 1; i < 10; i=i+1) begin
			if (max_prob < prob[i]) begin
				max_prob = prob[i];
				next_result = i;
			end
		end
		
	end
	/*
	always @ (posedge clk) begin
		if (prob[9] == prob_0)
			result <= 4'd0;
		else if (prob[9] == prob_1)
			result <= 4'd1;
		else if (prob[9] == prob_2)
			result <= 4'd2;
		else if (prob[9] == prob_3)
			result <= 4'd3;
		else if (prob[9] == prob_4)
			result <= 4'd4;
		else if (prob[9] == prob_5)
			result <= 4'd5;
		else if (prob[9] == prob_6)
			result <= 4'd6;
		else if (prob[9] == prob_7)
			result <= 4'd7;
		else if (prob[9] == prob_8)
			result <= 4'd8;
		else if (prob[9] == prob_9)
			result <= 4'd9;
		else
			result <= 4'd15;
	end
	*/
	
	always @ (posedge clk) begin
		if (rst) result <= 0;
		else result <= next_result;
	end

	always @ (posedge clk) begin
		if (rst) conv_enable <= 1'b0;
		//else if (enable) conv_enable <= 1'b1;
		else conv_enable <= 1'b1;
	end

endmodule
