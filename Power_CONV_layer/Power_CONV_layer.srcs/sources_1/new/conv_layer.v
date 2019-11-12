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
	wire signed [31:0] weight_read [7:0][24:0];
	reg signed [68:0] weight [7:0][24:0];
	reg signed [68:0] next_conv_result_1;
	reg signed [68:0] next_conv_result_2;
	reg signed [68:0] next_conv_result_3;
	reg signed [68:0] next_conv_result_4;
	reg signed [68:0] next_conv_result_5;
	reg signed [68:0] next_conv_result_6;
	reg signed [68:0] next_conv_result_7;
	reg signed [68:0] next_conv_result_8;

assign weight_read[0][0] = 32'b11111111101100111011010101000000;
assign weight_read[0][1] = 32'b00000000000110101010010001101011;
assign weight_read[0][2] = 32'b00000000010110100011000001110000;
assign weight_read[0][3] = 32'b00000000000100100000001000110010;
assign weight_read[0][4] = 32'b11111111100000011101000101001110;
assign weight_read[0][5] = 32'b11111111100101011011001111111110;
assign weight_read[0][6] = 32'b00000000010100001100010100011010;
assign weight_read[0][7] = 32'b00000000100011111011100011010010;
assign weight_read[0][8] = 32'b00000000000001111010000011010100;
assign weight_read[0][9] = 32'b11111111001101111111111010010001;
assign weight_read[0][10] = 32'b11111111111000001101111000011101;
assign weight_read[0][11] = 32'b00000000101011000000110011110011;
assign weight_read[0][12] = 32'b00000000100111001101100000000011;
assign weight_read[0][13] = 32'b11111111101110011010011101000011;
assign weight_read[0][14] = 32'b11111111000101011100000001001110;
assign weight_read[0][15] = 32'b00000000010001010101010010101010;
assign weight_read[0][16] = 32'b00000000101011010100100111001111;
assign weight_read[0][17] = 32'b00000000001101001110011000101111;
assign weight_read[0][18] = 32'b11111111100000110101110000000111;
assign weight_read[0][19] = 32'b11111111010011111111011000000101;
assign weight_read[0][20] = 32'b00000000010100010010111101000110;
assign weight_read[0][21] = 32'b00000000001001101001111011111001;
assign weight_read[0][22] = 32'b11111111101000101010001100001100;
assign weight_read[0][23] = 32'b11111111011101000011001110100011;
assign weight_read[0][24] = 32'b11111111011111010110001011000110;
assign weight_read[1][0] = 32'b11111111001111010001010111001010;
assign weight_read[1][1] = 32'b11111111011111010000101100101101;
assign weight_read[1][2] = 32'b11111111110011000011011000010100;
assign weight_read[1][3] = 32'b00000000001110001101101101111011;
assign weight_read[1][4] = 32'b00000000011010010101011101100000;
assign weight_read[1][5] = 32'b11111111011101111100100101101001;
assign weight_read[1][6] = 32'b11111111101001101100111011100100;
assign weight_read[1][7] = 32'b11111111111111100110000100101010;
assign weight_read[1][8] = 32'b00000000011000010001001100100100;
assign weight_read[1][9] = 32'b00000000010111110111100110010001;
assign weight_read[1][10] = 32'b11111111010111101001011110011110;
assign weight_read[1][11] = 32'b11111111101000001010100001011110;
assign weight_read[1][12] = 32'b00000000001000100000110101110100;
assign weight_read[1][13] = 32'b00000000100101110111110010101010;
assign weight_read[1][14] = 32'b00000000011101001110111101000011;
assign weight_read[1][15] = 32'b11111111010101001011111010100101;
assign weight_read[1][16] = 32'b11111111100110100011100100110110;
assign weight_read[1][17] = 32'b00000000000010110001010111010101;
assign weight_read[1][18] = 32'b00000000011101111100110001010010;
assign weight_read[1][19] = 32'b00000000011111000100100101101010;
assign weight_read[1][20] = 32'b11111111010001000010101000011011;
assign weight_read[1][21] = 32'b11111111011001111011110001010110;
assign weight_read[1][22] = 32'b11111111100101100001101110101110;
assign weight_read[1][23] = 32'b00000000000001101111110011110001;
assign weight_read[1][24] = 32'b00000000010100101001100110000101;
assign weight_read[2][0] = 32'b11111111110101100101101101001001;
assign weight_read[2][1] = 32'b11111111110000111101011001110000;
assign weight_read[2][2] = 32'b11111111101010011000011111001011;
assign weight_read[2][3] = 32'b11111111101100101010111101101000;
assign weight_read[2][4] = 32'b11111111111011110110111111101111;
assign weight_read[2][5] = 32'b00000000010000100000011010000001;
assign weight_read[2][6] = 32'b00000000011110011010111011101011;
assign weight_read[2][7] = 32'b00000000100110000111100100000000;
assign weight_read[2][8] = 32'b00000000101001100000110110110001;
assign weight_read[2][9] = 32'b00000000101011110110001001110111;
assign weight_read[2][10] = 32'b00000000010100001101101110110011;
assign weight_read[2][11] = 32'b00000000101110111100110011000010;
assign weight_read[2][12] = 32'b00000000110001001101100000011011;
assign weight_read[2][13] = 32'b00000000101001000011001011100000;
assign weight_read[2][14] = 32'b00000000001110110111011000011111;
assign weight_read[2][15] = 32'b11111111100010000101101101101010;
assign weight_read[2][16] = 32'b11111111110100001111000111001101;
assign weight_read[2][17] = 32'b11111111110100010110010110000011;
assign weight_read[2][18] = 32'b11111111110001011011111001000100;
assign weight_read[2][19] = 32'b11111111100000100011101110001000;
assign weight_read[2][20] = 32'b11111110110100010100010110000000;
assign weight_read[2][21] = 32'b11111110110010100101000001010110;
assign weight_read[2][22] = 32'b11111110110011100010001000101000;
assign weight_read[2][23] = 32'b11111111000010010101000001000100;
assign weight_read[2][24] = 32'b11111111001001101100110100010101;
assign weight_read[3][0] = 32'b11111111101011011100100110100110;
assign weight_read[3][1] = 32'b11111111101101011000011000010111;
assign weight_read[3][2] = 32'b11111111101110101001001000111001;
assign weight_read[3][3] = 32'b11111111111000000000100001001100;
assign weight_read[3][4] = 32'b11111111111110001101000000010111;
assign weight_read[3][5] = 32'b11111111101100001110110110011000;
assign weight_read[3][6] = 32'b11111111111000000111110000011001;
assign weight_read[3][7] = 32'b00000000000000001000001110101110;
assign weight_read[3][8] = 32'b00000000000110111100111100000011;
assign weight_read[3][9] = 32'b00000000000100101001000010001110;
assign weight_read[3][10] = 32'b00000000000101101000101110110110;
assign weight_read[3][11] = 32'b00000000011000110100111101000000;
assign weight_read[3][12] = 32'b00000000010110000111100000101011;
assign weight_read[3][13] = 32'b00000000001011100000000010111010;
assign weight_read[3][14] = 32'b00000000000011100010010001101011;
assign weight_read[3][15] = 32'b00000000010011100100011111001100;
assign weight_read[3][16] = 32'b00000000010100110001000100101011;
assign weight_read[3][17] = 32'b00000000001001111111011100001110;
assign weight_read[3][18] = 32'b00000000000101101101000101111110;
assign weight_read[3][19] = 32'b00000000001000000001010111011101;
assign weight_read[3][20] = 32'b11111111111011000010110100111000;
assign weight_read[3][21] = 32'b11111111110011011100101011101010;
assign weight_read[3][22] = 32'b11111111110110011010101000111101;
assign weight_read[3][23] = 32'b00000000000000010100100001000101;
assign weight_read[3][24] = 32'b00000000000111101001110111011000;
assign weight_read[4][0] = 32'b11111111100010101100010100001100;
assign weight_read[4][1] = 32'b11111111011110000010000110000001;
assign weight_read[4][2] = 32'b11111111100010001110001010001010;
assign weight_read[4][3] = 32'b11111111111101111111100101010010;
assign weight_read[4][4] = 32'b00000000001001110110010010100100;
assign weight_read[4][5] = 32'b11111111010111000111111101101001;
assign weight_read[4][6] = 32'b11111111101010010000000011110111;
assign weight_read[4][7] = 32'b00000000010000111111000101100000;
assign weight_read[4][8] = 32'b00000000100110011110110111011010;
assign weight_read[4][9] = 32'b00000000001011100110011100111101;
assign weight_read[4][10] = 32'b11111111011111110001111111111111;
assign weight_read[4][11] = 32'b00000000010011001101110110110001;
assign weight_read[4][12] = 32'b00000000110010101001010111000010;
assign weight_read[4][13] = 32'b00000000011100011100001010111011;
assign weight_read[4][14] = 32'b11111111101100110100101110101101;
assign weight_read[4][15] = 32'b11111111111101101011001110100100;
assign weight_read[4][16] = 32'b00000000100100011100011110111101;
assign weight_read[4][17] = 32'b00000000011100000110001101000110;
assign weight_read[4][18] = 32'b11111111110101001001010110001010;
assign weight_read[4][19] = 32'b11111111100011100000111001000010;
assign weight_read[4][20] = 32'b00000000001000010011111101010001;
assign weight_read[4][21] = 32'b00000000001100010001010000110010;
assign weight_read[4][22] = 32'b11111111110100101101101001011111;
assign weight_read[4][23] = 32'b11111111101010010011100001010001;
assign weight_read[4][24] = 32'b11111111110011011010000011101101;
assign weight_read[5][0] = 32'b00000000000001110000110011001101;
assign weight_read[5][1] = 32'b00000000001001010101000010000111;
assign weight_read[5][2] = 32'b00000000001001110110000001100010;
assign weight_read[5][3] = 32'b11111111111010010111011101100000;
assign weight_read[5][4] = 32'b11111111100011100101110011011101;
assign weight_read[5][5] = 32'b11111111111000101110000011000101;
assign weight_read[5][6] = 32'b00000000001111001110001011010000;
assign weight_read[5][7] = 32'b00000000100100101001100101100001;
assign weight_read[5][8] = 32'b00000000010110100011110100010000;
assign weight_read[5][9] = 32'b11111111101000110100010110000110;
assign weight_read[5][10] = 32'b11111111100101010101001010000011;
assign weight_read[5][11] = 32'b00000000000000101011010110001110;
assign weight_read[5][12] = 32'b00000000101001100011011001111000;
assign weight_read[5][13] = 32'b00000000101100110001011110000110;
assign weight_read[5][14] = 32'b11111111111101110101110010111011;
assign weight_read[5][15] = 32'b11111111011011111001111010101010;
assign weight_read[5][16] = 32'b11111111101100010000000111001110;
assign weight_read[5][17] = 32'b00000000001011100011001100100111;
assign weight_read[5][18] = 32'b00000000100011101000001110011001;
assign weight_read[5][19] = 32'b00000000010010100000110110010011;
assign weight_read[5][20] = 32'b11111111010110111101000000111110;
assign weight_read[5][21] = 32'b11111111010110110001101010010110;
assign weight_read[5][22] = 32'b11111111011101010110000110000100;
assign weight_read[5][23] = 32'b11111111110101000000100001010110;
assign weight_read[5][24] = 32'b00000000000010010010001010001110;
assign weight_read[6][0] = 32'b11111111111010101001101110111010;
assign weight_read[6][1] = 32'b11111111110111110101000110101001;
assign weight_read[6][2] = 32'b11111111110010110010010001001010;
assign weight_read[6][3] = 32'b11111111110110101101101001010011;
assign weight_read[6][4] = 32'b11111111111011000111000000101101;
assign weight_read[6][5] = 32'b11111111110000011100011101100111;
assign weight_read[6][6] = 32'b11111111110101111110110100001111;
assign weight_read[6][7] = 32'b00000000000000100100000100000001;
assign weight_read[6][8] = 32'b00000000000110110110001101101010;
assign weight_read[6][9] = 32'b00000000000111010111011101110000;
assign weight_read[6][10] = 32'b00000000000111001111000001100000;
assign weight_read[6][11] = 32'b00000000010111000010001011011110;
assign weight_read[6][12] = 32'b00000000011001011011101100011100;
assign weight_read[6][13] = 32'b00000000001101010111000100011001;
assign weight_read[6][14] = 32'b00000000000100010001011110010010;
assign weight_read[6][15] = 32'b00000000010111110100100000100010;
assign weight_read[6][16] = 32'b00000000010101100110101101001110;
assign weight_read[6][17] = 32'b00000000001001101011001010101010;
assign weight_read[6][18] = 32'b00000000000100001000100111111011;
assign weight_read[6][19] = 32'b00000000000100000100000111110000;
assign weight_read[6][20] = 32'b11111111110101001001111011011010;
assign weight_read[6][21] = 32'b11111111100111000010011010011000;
assign weight_read[6][22] = 32'b11111111101010010011100010100010;
assign weight_read[6][23] = 32'b11111111110110010010010101011100;
assign weight_read[6][24] = 32'b11111111111110100110000001101100;
assign weight_read[7][0] = 32'b11111111111010110010110101100011;
assign weight_read[7][1] = 32'b11111111101011101101101100000100;
assign weight_read[7][2] = 32'b11111111010100101010100011000110;
assign weight_read[7][3] = 32'b11111111001111100011101111101101;
assign weight_read[7][4] = 32'b11111111011001101000110100001110;
assign weight_read[7][5] = 32'b00000000010010000111111100111101;
assign weight_read[7][6] = 32'b00000000011000110010011010000010;
assign weight_read[7][7] = 32'b11111111111100010000000101000101;
assign weight_read[7][8] = 32'b11111111011010101011001101011010;
assign weight_read[7][9] = 32'b11111111001110110010011011111100;
assign weight_read[7][10] = 32'b00000000001011001011101001010000;
assign weight_read[7][11] = 32'b00000000110100010100010101100001;
assign weight_read[7][12] = 32'b00000000111011010001101100000110;
assign weight_read[7][13] = 32'b00000000010100000111100010010000;
assign weight_read[7][14] = 32'b11111111100001101000000100110001;
assign weight_read[7][15] = 32'b11111111110000011011011010011001;
assign weight_read[7][16] = 32'b00000000010011100111001001000101;
assign weight_read[7][17] = 32'b00000000110010000100010001100000;
assign weight_read[7][18] = 32'b00000000100111001100101000100100;
assign weight_read[7][19] = 32'b11111111111100001100111000010111;
assign weight_read[7][20] = 32'b11111111100001101010001000111010;
assign weight_read[7][21] = 32'b11111111100011111101110001101101;
assign weight_read[7][22] = 32'b11111111111010010010111100001010;
assign weight_read[7][23] = 32'b00000000010000001000100011010101;
assign weight_read[7][24] = 32'b00000000000100101100000101111010;


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
