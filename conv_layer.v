`timescale 1ns / 1ps
/*
`define DATA_X 28
`define DATA_Y 28
`define DATA_SIZE 32
`define WEIGHT_X 5
`define WEIGHT_Y 5
`define WEIGHT_SIZE 32
`define CONV_X 24
`define CONV_Y 24
`define CONV_SIZE 69
*/
module conv_layer (
	input clk,    // Clock
	input rst,  // Asynchronous reset active high
	input signed [31:0] data_00,
	input signed [31:0] data_01,
	input signed [31:0] data_02,
	input signed [31:0] data_03,
	input signed [31:0] data_04,
	input signed [31:0] data_10,
	input signed [31:0] data_11,
	input signed [31:0] data_12,
	input signed [31:0] data_13,
	input signed [31:0] data_14,
	input signed [31:0] data_20,
	input signed [31:0] data_21,
	input signed [31:0] data_22,
	input signed [31:0] data_23,
	input signed [31:0] data_24,
	input signed [31:0] data_30,
	input signed [31:0] data_31,
	input signed [31:0] data_32,
	input signed [31:0] data_33,
	input signed [31:0] data_34,
	input signed [31:0] data_40,
	input signed [31:0] data_41,
	input signed [31:0] data_42,
	input signed [31:0] data_43,
	input signed [31:0] data_44,
	output reg signed [68:0] conv_result_1,
	output reg signed [68:0] conv_result_2,
	output reg signed [68:0] conv_result_3,
	output reg signed [68:0] conv_result_4,
	output reg signed [68:0] conv_result_5,
	output reg signed [68:0] conv_result_6,
	output reg signed [68:0] conv_result_7,
	output reg signed [68:0] conv_result_8
);

	integer i,j;
	reg signed [31:0] weight_read [7:0][24:0];
	reg signed [68:0] weight [7:0][24:0];
	reg signed [68:0] next_conv_result_1;
	reg signed [68:0] next_conv_result_2;
	reg signed [68:0] next_conv_result_3;
	reg signed [68:0] next_conv_result_4;
	reg signed [68:0] next_conv_result_5;
	reg signed [68:0] next_conv_result_6;
	reg signed [68:0] next_conv_result_7;
	reg signed [68:0] next_conv_result_8;

	always @(*) begin
		for (i = 0; i < 8; i=i+1) begin
			for (j = 0; j < 25; j=j+1) begin
				weight[i][j][31:0] = 0;
				weight[i][j][68:32] = 0;
			end
		end
	end

	//initial begin
	//$readmemb("conv_weights_out_2s_comp.txt.txt", weight_read);
	///end
	// weight sign extend
	always @(*) begin
		for (i = 0; i < 8; i=i+1) begin
			for (j = 0; j < 25; j=j+1) begin
				weight[i][j][31:0] = weight_read[i][j];
				weight[i][j][68:32] = {37{weight_read[i][j][31]}};
			end
		end
	end

	// calculation
	always @(*) begin
		next_conv_result_1 = data_00*weight[0][0] + data_01*weight[0][1] + data_02*weight[0][2] + data_03*weight[0][3] + data_04*weight[0][4] +
													data_10*weight[0][5] + data_11*weight[0][6] + data_12*weight[0][7] + data_13*weight[0][8] + data_14*weight[0][9] +
													data_20*weight[0][10] + data_21*weight[0][11] + data_22*weight[0][12] + data_23*weight[0][13] + data_24*weight[0][14] +
													data_30*weight[0][15] + data_31*weight[0][16] + data_32*weight[0][17] + data_33*weight[0][18] + data_34*weight[0][19] +
													data_40*weight[0][20] + data_41*weight[0][21] + data_42*weight[0][22] + data_43*weight[0][23] + data_44*weight[0][24];
		next_conv_result_2 = data_00*weight[1][0] + data_01*weight[1][1] + data_02*weight[1][2] + data_03*weight[1][3] + data_04*weight[1][4] +
													data_10*weight[1][5] + data_11*weight[1][6] + data_12*weight[1][7] + data_13*weight[1][8] + data_14*weight[1][9] +
													data_20*weight[1][10] + data_21*weight[1][11] + data_22*weight[1][12] + data_23*weight[1][13] + data_24*weight[1][14] +
													data_30*weight[1][15] + data_31*weight[1][16] + data_32*weight[1][17] + data_33*weight[1][18] + data_34*weight[1][19] +
													data_40*weight[1][20] + data_41*weight[1][21] + data_42*weight[1][22] + data_43*weight[1][23] + data_44*weight[1][24];
		next_conv_result_3 = data_00*weight[2][0] + data_01*weight[2][1] + data_02*weight[2][2] + data_03*weight[2][3] + data_04*weight[2][4] +
													data_10*weight[2][5] + data_11*weight[2][6] + data_12*weight[2][7] + data_13*weight[2][8] + data_14*weight[2][9] +
													data_20*weight[2][10] + data_21*weight[2][11] + data_22*weight[2][12] + data_23*weight[2][13] + data_24*weight[2][14] +
													data_30*weight[2][15] + data_31*weight[2][16] + data_32*weight[2][17] + data_33*weight[2][18] + data_34*weight[2][19] +
													data_40*weight[2][20] + data_41*weight[2][21] + data_42*weight[2][22] + data_43*weight[2][23] + data_44*weight[2][24];
		next_conv_result_4 = data_00*weight[3][0] + data_01*weight[3][1] + data_02*weight[3][2] + data_03*weight[3][3] + data_04*weight[3][4] +
													data_10*weight[3][5] + data_11*weight[3][6] + data_12*weight[3][7] + data_13*weight[3][8] + data_14*weight[3][9] +
													data_20*weight[3][10] + data_21*weight[3][11] + data_22*weight[3][12] + data_23*weight[3][13] + data_24*weight[3][14] +
													data_30*weight[3][15] + data_31*weight[3][16] + data_32*weight[3][17] + data_33*weight[3][18] + data_34*weight[3][19] +
													data_40*weight[3][20] + data_41*weight[3][21] + data_42*weight[3][22] + data_43*weight[3][23] + data_44*weight[3][24];
		next_conv_result_5 = data_00*weight[4][0] + data_01*weight[4][1] + data_02*weight[4][2] + data_03*weight[4][3] + data_04*weight[4][4] +
													data_10*weight[4][5] + data_11*weight[4][6] + data_12*weight[4][7] + data_13*weight[4][8] + data_14*weight[4][9] +
													data_20*weight[4][10] + data_21*weight[4][11] + data_22*weight[4][12] + data_23*weight[4][13] + data_24*weight[4][14] +
													data_30*weight[4][15] + data_31*weight[4][16] + data_32*weight[4][17] + data_33*weight[4][18] + data_34*weight[4][19] +
													data_40*weight[4][20] + data_41*weight[4][21] + data_42*weight[4][22] + data_43*weight[4][23] + data_44*weight[4][24];
		next_conv_result_6 = data_00*weight[5][0] + data_01*weight[5][1] + data_02*weight[5][2] + data_03*weight[5][3] + data_04*weight[5][4] +
													data_10*weight[5][5] + data_11*weight[5][6] + data_12*weight[5][7] + data_13*weight[5][8] + data_14*weight[5][9] +
													data_20*weight[5][10] + data_21*weight[5][11] + data_22*weight[5][12] + data_23*weight[5][13] + data_24*weight[5][14] +
													data_30*weight[5][15] + data_31*weight[5][16] + data_32*weight[5][17] + data_33*weight[5][18] + data_34*weight[5][19] +
													data_40*weight[5][20] + data_41*weight[5][21] + data_42*weight[5][22] + data_43*weight[5][23] + data_44*weight[5][24];
		next_conv_result_7 = data_00*weight[6][6] + data_01*weight[6][1] + data_02*weight[6][2] + data_03*weight[6][3] + data_04*weight[6][4] +
													data_10*weight[6][5] + data_11*weight[6][6] + data_12*weight[6][7] + data_13*weight[6][8] + data_14*weight[6][9] +
													data_20*weight[6][10] + data_21*weight[6][11] + data_22*weight[6][12] + data_23*weight[6][13] + data_24*weight[6][14] +
													data_30*weight[6][15] + data_31*weight[6][16] + data_32*weight[6][17] + data_33*weight[6][18] + data_34*weight[6][19] +
													data_40*weight[6][20] + data_41*weight[6][21] + data_42*weight[6][22] + data_43*weight[6][23] + data_44*weight[6][24];
		next_conv_result_8 = data_00*weight[7][0] + data_01*weight[7][1] + data_02*weight[7][2] + data_03*weight[7][3] + data_04*weight[7][4] +
													data_10*weight[7][5] + data_11*weight[7][6] + data_12*weight[7][7] + data_13*weight[7][8] + data_14*weight[7][9] +
													data_20*weight[7][10] + data_21*weight[7][11] + data_22*weight[7][12] + data_23*weight[7][13] + data_24*weight[7][14] +
													data_30*weight[7][15] + data_31*weight[7][16] + data_32*weight[7][17] + data_33*weight[7][18] + data_34*weight[7][19] +
													data_40*weight[7][20] + data_41*weight[7][21] + data_42*weight[7][22] + data_43*weight[7][23] + data_44*weight[7][24];

	end


	always @ (posedge clk) begin
		if (rst) begin
			conv_result_1 <= 0;
			conv_result_2 <= 0;
			conv_result_3 <= 0;
			conv_result_4 <= 0;
			conv_result_5 <= 0;
			conv_result_6 <= 0;
			conv_result_7 <= 0;
			conv_result_8 <= 0;
		end else begin
			conv_result_1 <= next_conv_result_1;
			conv_result_2 <= next_conv_result_2;
			conv_result_3 <= next_conv_result_3;
			conv_result_4 <= next_conv_result_4;
			conv_result_5 <= next_conv_result_5;
			conv_result_6 <= next_conv_result_6;
			conv_result_7 <= next_conv_result_7;
			conv_result_8 <= next_conv_result_8;
		end
	end

endmodule
