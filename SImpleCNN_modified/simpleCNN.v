`timescale 1ns / 1ps
/*
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
*/
module simpleCNN (
	input wire clk,    // Clock
	input wire rst,  	// Asynchronous reset active high
	input wire enable,
	output reg [3:0] result,
	output reg [15:0] count,
	output wire signed [112:0] prob_0,
	output wire signed [112:0] prob_1,
	output wire signed [112:0] prob_2,
	output wire signed [112:0] prob_3,
	output wire signed [112:0] prob_4,
	output wire signed [112:0] prob_5,
	output wire signed [112:0] prob_6,
	output wire signed [112:0] prob_7,
	output wire signed [112:0] prob_8,
	output wire signed [112:0] prob_9,
	output wire fc_done
);
	reg signed [112:0] prob [9:0];
	integer i,j;
// conv_layer
	wire signed [68:0] conv_result_1;
	wire signed [68:0] conv_result_2;
	wire signed [68:0] conv_result_3;
	wire signed [68:0] conv_result_4;
	wire signed [68:0] conv_result_5;
	wire signed [68:0] conv_result_6;
	wire signed [68:0] conv_result_7;
	wire signed [68:0] conv_result_8;
// relu_layer
	wire signed [68:0] relu_result_1;
	wire signed [68:0] relu_result_2;
	wire signed [68:0] relu_result_3;
	wire signed [68:0] relu_result_4;
	wire signed [68:0] relu_result_5;
	wire signed [68:0] relu_result_6;
	wire signed [68:0] relu_result_7;
	wire signed [68:0] relu_result_8;
// pool_layer
	wire signed [68:0] pool_result_1;
	wire signed [68:0] pool_result_2;
	wire signed [68:0] pool_result_3;
	wire signed [68:0] pool_result_4;
	wire signed [68:0] pool_result_5;
	wire signed [68:0] pool_result_6;
	wire signed [68:0] pool_result_7;
	wire signed [68:0] pool_result_8;
// fc_layer
/*
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
*/
	reg [4:0] count_x, relu_count_x;
	reg [4:0] count_y, relu_count_y;
	//reg [15:0] count;
	reg signed [31:0] data [0:27][0:27];
	reg data_read_done;
	reg signed [68:0] relu [7:0][575:0];
	reg signed [68:0] relu_1 [23:0][23:0];
	reg signed [68:0] relu_2 [23:0][23:0];
	reg signed [68:0] relu_3 [23:0][23:0];
	reg signed [68:0] relu_4 [23:0][23:0];
	reg signed [68:0] relu_5 [23:0][23:0];
	reg signed [68:0] relu_6 [23:0][23:0];
	reg signed [68:0] relu_7 [23:0][23:0];
	reg signed [68:0] relu_8 [23:0][23:0];
	reg signed [68:0] pool [7:0][143:0];
	reg signed [31:0] data_00;
	reg signed [31:0] data_01;
	reg signed [31:0] data_02;
	reg signed [31:0] data_03;
	reg signed [31:0] data_04;
	reg signed [31:0] data_10;
	reg signed [31:0] data_11;
	reg signed [31:0] data_12;
	reg signed [31:0] data_13;
	reg signed [31:0] data_14;
	reg signed [31:0] data_20;
	reg signed [31:0] data_21;
	reg signed [31:0] data_22;
	reg signed [31:0] data_23;
	reg signed [31:0] data_24;
	reg signed [31:0] data_30;
	reg signed [31:0] data_31;
	reg signed [31:0] data_32;
	reg signed [31:0] data_33;
	reg signed [31:0] data_34;
	reg signed [31:0] data_40;
	reg signed [31:0] data_41;
	reg signed [31:0] data_42;
	reg signed [31:0] data_43;
	reg signed [31:0] data_44;
	reg signed [68:0] pool_0_00;
	reg signed [68:0] pool_0_01;
	reg signed [68:0] pool_0_10;
	reg signed [68:0] pool_0_11;
	reg signed [68:0] pool_1_00;
	reg signed [68:0] pool_1_01;
	reg signed [68:0] pool_1_10;
	reg signed [68:0] pool_1_11;
	reg signed [68:0] pool_2_00;
	reg signed [68:0] pool_2_01;
	reg signed [68:0] pool_2_10;
	reg signed [68:0] pool_2_11;
	reg signed [68:0] pool_3_00;
	reg signed [68:0] pool_3_01;
	reg signed [68:0] pool_3_10;
	reg signed [68:0] pool_3_11;
	reg signed [68:0] pool_4_00;
	reg signed [68:0] pool_4_01;
	reg signed [68:0] pool_4_10;
	reg signed [68:0] pool_4_11;
	reg signed [68:0] pool_5_00;
	reg signed [68:0] pool_5_01;
	reg signed [68:0] pool_5_10;
	reg signed [68:0] pool_5_11;
	reg signed [68:0] pool_6_00;
	reg signed [68:0] pool_6_01;
	reg signed [68:0] pool_6_10;
	reg signed [68:0] pool_6_11;
	reg signed [68:0] pool_7_00;
	reg signed [68:0] pool_7_01;
	reg signed [68:0] pool_7_10;
	reg signed [68:0] pool_7_11;

	initial begin
		$readmemb("test_2s_compliment.txt.txt", data);
	end

	always @(*) begin
		if (data_read_done == 1'b0) begin
			// row 0
			data_00 = data[count_x][count_y];
			data_01 = data[count_x][count_y+1];
			data_02 = data[count_x][count_y+2];
			data_03 = data[count_x][count_y+3];
			data_04 = data[count_x][count_y+4];
			// row 1
			data_10 = data[count_x+1][count_y];
			data_11 = data[count_x+1][count_y+1];
			data_12 = data[count_x+1][count_y+2];
			data_13 = data[count_x+1][count_y+3];
			data_14 = data[count_x+1][count_y+4];
			// row 2
			data_20 = data[count_x+2][count_y];
			data_21 = data[count_x+2][count_y+1];
			data_22 = data[count_x+2][count_y+2];
			data_23 = data[count_x+2][count_y+3];
			data_24 = data[count_x+2][count_y+4];
			// row 3
			data_30 = data[count_x+3][count_y];
			data_31 = data[count_x+3][count_y+1];
			data_32 = data[count_x+3][count_y+2];
			data_33 = data[count_x+3][count_y+3];
			data_34 = data[count_x+3][count_y+4];
			// row 4
			data_40 = data[count_x+4][count_y];
			data_41 = data[count_x+4][count_y+1];
			data_42 = data[count_x+4][count_y+2];
			data_43 = data[count_x+4][count_y+3];
			data_44 = data[count_x+4][count_y+4];
		end
	end

	always @(*) begin
		// depth 0
		pool_0_00 = relu_1[2*relu_count_x][2*relu_count_y];
		pool_0_01 = relu_1[2*relu_count_x][2*relu_count_y+1];
		pool_0_10 = relu_1[2*relu_count_x+1][2*relu_count_y];
		pool_0_11 = relu_1[2*relu_count_x+1][2*relu_count_y+1];
		// depth 1
		pool_1_00 = relu_2[2*relu_count_x][2*relu_count_y];
		pool_1_01 = relu_2[2*relu_count_x][2*relu_count_y+1];
		pool_1_10 = relu_2[2*relu_count_x+1][2*relu_count_y];
		pool_1_11 = relu_2[2*relu_count_x+1][2*relu_count_y+1];
		// depth 2
		pool_2_00 = relu_3[2*relu_count_x][2*relu_count_y];
		pool_2_01 = relu_3[2*relu_count_x][2*relu_count_y+1];
		pool_2_10 = relu_3[2*relu_count_x+1][2*relu_count_y];
		pool_2_11 = relu_3[2*relu_count_x+1][2*relu_count_y+1];
		// depth 3
		pool_3_00 = relu_4[2*relu_count_x][2*relu_count_y];
		pool_3_01 = relu_4[2*relu_count_x][2*relu_count_y+1];
		pool_3_10 = relu_4[2*relu_count_x+1][2*relu_count_y];
		pool_3_11 = relu_4[2*relu_count_x+1][2*relu_count_y+1];
		// depth 4
		pool_4_00 = relu_5[2*relu_count_x][2*relu_count_y];
		pool_4_01 = relu_5[2*relu_count_x][2*relu_count_y+1];
		pool_4_10 = relu_5[2*relu_count_x+1][2*relu_count_y];
		pool_4_11 = relu_5[2*relu_count_x+1][2*relu_count_y+1];
		// depth 5
		pool_5_00 = relu_6[2*relu_count_x][2*relu_count_y];
		pool_5_01 = relu_6[2*relu_count_x][2*relu_count_y+1];
		pool_5_10 = relu_6[2*relu_count_x+1][2*relu_count_y];
		pool_5_11 = relu_6[2*relu_count_x+1][2*relu_count_y+1];
		// depth 6
		pool_6_00 = relu_7[2*relu_count_x][2*relu_count_y];
		pool_6_01 = relu_7[2*relu_count_x][2*relu_count_y+1];
		pool_6_10 = relu_7[2*relu_count_x+1][2*relu_count_y];
		pool_6_11 = relu_7[2*relu_count_x+1][2*relu_count_y+1];
		// depth 7
		pool_7_00 = relu_8[2*relu_count_x][2*relu_count_y];
		pool_7_01 = relu_8[2*relu_count_x][2*relu_count_y+1];
		pool_7_10 = relu_8[2*relu_count_x+1][2*relu_count_y];
		pool_7_11 = relu_8[2*relu_count_x+1][2*relu_count_y+1];
	end

	always @(posedge clk) begin
		if (rst) count <= 0;
		else count = count + 1;
	end

	always @(posedge clk) begin
		if (rst) begin
			count_x <= 0;
			count_y <= 0;
		end else if (count_y < 5'd23) begin
			count_y <= count_y + 1;
		end else if (count_y == 5'd23) begin
			count_x <= count_x + 1;
			count_y <= 0;
		end

		if (rst) begin
			data_read_done <= 1'b0;
		end else if (count_y == 5'd23 && count_x == 5'd23) begin
			data_read_done <= 1'b1;
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			relu_count_x <= 0;
			relu_count_y <= 0;
		end else if (count >=579 && count < 723) begin
			if (relu_count_y < 5'd11) begin
				relu_count_y <= relu_count_y + 1;
			end else if (relu_count_y == 5'd11) begin
				relu_count_x <= relu_count_x + 1;
				relu_count_y <= 0;
			end
		end
	end

	always @(*) begin
		if (count > 1 && count <578) begin
			relu[0][count-2] = relu_result_1;
			relu[1][count-2] = relu_result_2;
			relu[2][count-2] = relu_result_3;
			relu[3][count-2] = relu_result_4;
			relu[4][count-2] = relu_result_5;
			relu[5][count-2] = relu_result_6;
			relu[6][count-2] = relu_result_7;
			relu[7][count-2] = relu_result_8;
		end
	end

	always @(*) begin
		for (i = 0; i < 24; i = i+1) begin
			for (j = 0; j < 24; j = j+1) begin
				relu_1[i][j] = relu[0][24*i + j];
				relu_2[i][j] = relu[1][24*i + j];
				relu_3[i][j] = relu[2][24*i + j];
				relu_4[i][j] = relu[3][24*i + j];
				relu_5[i][j] = relu[4][24*i + j];
				relu_6[i][j] = relu[5][24*i + j];
				relu_7[i][j] = relu[6][24*i + j];
				relu_8[i][j] = relu[7][24*i + j];
			end
		end
	end

	conv_layer conv(
		// INPUTS
	 	.clk(clk),
	 	.rst(rst),
		.data_00(data_00),
		.data_01(data_01),
		.data_02(data_02),
		.data_03(data_03),
		.data_04(data_04),
		.data_10(data_10),
		.data_11(data_11),
		.data_12(data_12),
		.data_13(data_13),
		.data_14(data_14),
		.data_20(data_20),
		.data_21(data_21),
		.data_22(data_22),
		.data_23(data_23),
		.data_24(data_24),
		.data_30(data_30),
		.data_31(data_31),
		.data_32(data_32),
		.data_33(data_33),
		.data_34(data_34),
		.data_40(data_40),
		.data_41(data_41),
		.data_42(data_42),
		.data_43(data_43),
		.data_44(data_44),
		// OUTPUTS
	 	.conv_result_1(conv_result_1),
	 	.conv_result_2(conv_result_2),
	 	.conv_result_3(conv_result_3),
	 	.conv_result_4(conv_result_4),
	 	.conv_result_5(conv_result_5),
	 	.conv_result_6(conv_result_6),
	 	.conv_result_7(conv_result_7),
	 	.conv_result_8(conv_result_8)
	);

	relu_layer relu_l(
		// INPUTS
		.clk(clk),
	 	.rst(rst),
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
		.relu_result_8(relu_result_8)
	);

// pool_layer
	pool_layer pool_l(
		// INPUTS
		.clk(clk),
	 	.rst(rst),
		.count_x(relu_count_x),
		.count_y(relu_count_y),
		.pool_0_00 (pool_0_00),
		.pool_0_01 (pool_0_01),
		.pool_0_10 (pool_0_10),
		.pool_0_11 (pool_0_11),
		.pool_1_00 (pool_1_00),
		.pool_1_01 (pool_1_01),
		.pool_1_10 (pool_1_10),
		.pool_1_11 (pool_1_11),
		.pool_2_00 (pool_2_00),
		.pool_2_01 (pool_2_01),
		.pool_2_10 (pool_2_10),
		.pool_2_11 (pool_2_11),
		.pool_3_00 (pool_3_00),
		.pool_3_01 (pool_3_01),
		.pool_3_10 (pool_3_10),
		.pool_3_11 (pool_3_11),
		.pool_4_00 (pool_4_00),
		.pool_4_01 (pool_4_01),
		.pool_4_10 (pool_4_10),
		.pool_4_11 (pool_4_11),
		.pool_5_00 (pool_5_00),
		.pool_5_01 (pool_5_01),
		.pool_5_10 (pool_5_10),
		.pool_5_11 (pool_5_11),
		.pool_6_00 (pool_6_00),
		.pool_6_01 (pool_6_01),
		.pool_6_10 (pool_6_10),
		.pool_6_11 (pool_6_11),
		.pool_7_00 (pool_7_00),
		.pool_7_01 (pool_7_01),
		.pool_7_10 (pool_7_10),
		.pool_7_11 (pool_7_11),
		// OUTPUTS
		/*
		.pool_result_1(pool_result_1),
		.pool_result_2(pool_result_2),
		.pool_result_3(pool_result_3),
		.pool_result_4(pool_result_4),
		.pool_result_5(pool_result_5),
		.pool_result_6(pool_result_6),
		.pool_result_7(pool_result_7),
		.pool_result_8(pool_result_8)
		*/
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
	/*
	// fc_layer
		fc_layer fc(
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
			.fc_weight_9(fc_weight_9),

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
		*/
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
		next_result = 0;
		max_prob = prob[0];
		for (i = 1; i < 10; i=i+1) begin
			if (max_prob < prob[i]) begin
				max_prob = prob[i];
				next_result = i;
			end
		end
	end

	always @ (posedge clk) begin
		if (rst) result <= 0;
		else result <= next_result;
	end
endmodule
