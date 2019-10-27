`timescale 1ns / 1ps
/*
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 69
*/
module relu_layer(
	input clk,    	// Clock
	input rst,  	// Asynchronous reset active high
	input signed [68:0] conv_result_1,
	input signed [68:0] conv_result_2,
	input signed [68:0] conv_result_3,
	input signed [68:0] conv_result_4,
	input signed [68:0] conv_result_5,
	input signed [68:0] conv_result_6,
	input signed [68:0] conv_result_7,
	input signed [68:0] conv_result_8,
	output reg signed [68:0] relu_result_1,
	output reg signed [68:0] relu_result_2,
	output reg signed [68:0] relu_result_3,
	output reg signed [68:0] relu_result_4,
	output reg signed [68:0] relu_result_5,
	output reg signed [68:0] relu_result_6,
	output reg signed [68:0] relu_result_7,
	output reg signed [68:0] relu_result_8
);

	reg signed [68:0] next_relu_result_1;
	reg signed [68:0] next_relu_result_2;
	reg signed [68:0] next_relu_result_3;
	reg signed [68:0] next_relu_result_4;
	reg signed [68:0] next_relu_result_5;
	reg signed [68:0] next_relu_result_6;
	reg signed [68:0] next_relu_result_7;
	reg signed [68:0] next_relu_result_8;

	always @ (*) begin
		if (conv_result_1[68] == 1'b1) next_relu_result_1 = 0;
		else next_relu_result_1 = conv_result_1;

		if (conv_result_2[68] == 1'b1) next_relu_result_2 = 0;
		else next_relu_result_2 = conv_result_2;

		if (conv_result_3[68] == 1'b1) next_relu_result_3 = 0;
		else next_relu_result_3 = conv_result_3;

		if (conv_result_4[68] == 1'b1) next_relu_result_4 = 0;
		else next_relu_result_4 = conv_result_4;

		if (conv_result_5[68] == 1'b1) next_relu_result_5 = 0;
		else next_relu_result_5 = conv_result_5;

		if (conv_result_6[68] == 1'b1) next_relu_result_6 = 0;
		else next_relu_result_6 = conv_result_6;

		if (conv_result_7[68] == 1'b1) next_relu_result_7 = 0;
		else next_relu_result_7 = conv_result_7;

		if (conv_result_8[68] == 1'b1) next_relu_result_8 = 0;
		else next_relu_result_8 = conv_result_8;
	end

	always @ (posedge clk) begin
		if (rst) begin
			relu_result_1 <= 0;
			relu_result_2 <= 0;
			relu_result_3 <= 0;
			relu_result_4 <= 0;
			relu_result_5 <= 0;
			relu_result_6 <= 0;
			relu_result_7 <= 0;
			relu_result_8 <= 0;
		end else begin
			relu_result_1 <= next_relu_result_1;
			relu_result_2 <= next_relu_result_2;
			relu_result_3 <= next_relu_result_3;
			relu_result_4 <= next_relu_result_4;
			relu_result_5 <= next_relu_result_5;
			relu_result_6 <= next_relu_result_6;
			relu_result_7 <= next_relu_result_7;
			relu_result_8 <= next_relu_result_8;
		end
	end

endmodule
