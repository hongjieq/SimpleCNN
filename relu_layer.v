`timescale 1ns / 1ps

module relu_layer #(parameter RELU_X = 24, parameter RELU_Y = 24, parameter RELU_DATA_WIDTH = 45)(
	input clk,    // Clock
	input rst,  // Asynchronous reset active high
	input relu_enable,
	input [RELU_DATA_WIDTH-1:0] conv_result_1 [RELU_X-1:0][RELU_Y-1:0],		// 24*24, 45-bit each
	input [RELU_DATA_WIDTH-1:0] conv_result_2 [RELU_X-1:0][RELU_Y-1:0],
	input [RELU_DATA_WIDTH-1:0] conv_result_4 [RELU_X-1:0][RELU_Y-1:0],
	input [RELU_DATA_WIDTH-1:0] conv_result_5 [RELU_X-1:0][RELU_Y-1:0],
	input [RELU_DATA_WIDTH-1:0] conv_result_6 [RELU_X-1:0][RELU_Y-1:0],
	input [RELU_DATA_WIDTH-1:0] conv_result_7 [RELU_X-1:0][RELU_Y-1:0],
	input [RELU_DATA_WIDTH-1:0] conv_result_8 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_1 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_2 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_3 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_4 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_5 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_6 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_7 [RELU_X-1:0][RELU_Y-1:0],
	output reg [RELU_DATA_WIDTH-1:0] relu_result_8 [RELU_X-1:0][RELU_Y-1:0],
	output reg relu_done
);
	
	integer i;
	integer j;

	wire [RELU_DATA_WIDTH-1:0] next_relu_result_1 [RELU_X-1:0][RELU_Y-1:0];
	wire [RELU_DATA_WIDTH-1:0] next_relu_result_2 [RELU_X-1:0][RELU_Y-1:0];
	wire [RELU_DATA_WIDTH-1:0] next_relu_result_3 [RELU_X-1:0][RELU_Y-1:0];
	wire [RELU_DATA_WIDTH-1:0] next_relu_result_4 [RELU_X-1:0][RELU_Y-1:0];
	wire [RELU_DATA_WIDTH-1:0] next_relu_result_5 [RELU_X-1:0][RELU_Y-1:0];
	wire [RELU_DATA_WIDTH-1:0] next_relu_result_6 [RELU_X-1:0][RELU_Y-1:0];
	wire [RELU_DATA_WIDTH-1:0] next_relu_result_7 [RELU_X-1:0][RELU_Y-1:0];
	wire [RELU_DATA_WIDTH-1:0] next_relu_result_8 [RELU_X-1:0][RELU_Y-1:0];

	always @ (*) begin
		for (int i = 0; i < RELU_X; i++) begin
			for (int j = 0; j < RELU_Y; j++) begin
				if (conv_result_1[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_1[i][j] = 0;
				else next_relu_result_1 = conv_result_1;

				if (conv_result_2[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_2[i][j] = 0;
				else next_relu_result_2 = conv_result_2;

				if (conv_result_3[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_3[i][j] = 0;
				else next_relu_result_3 = conv_result_3;

				if (conv_result_4[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_4[i][j] = 0;
				else next_relu_result_4 = conv_result_4;

				if (conv_result_5[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_5[i][j] = 0;
				else next_relu_result_5 = conv_result_5;

				if (conv_result_6[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_6[i][j] = 0;
				else next_relu_result_6 = conv_result_6;

				if (conv_result_7[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_7[i][j] = 0;
				else next_relu_result_7 = conv_result_7;

				if (conv_result_8[i][j][RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_8[i][j] = 0;
				else next_relu_result_8 = conv_result_8;
			end
		end
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
			relu_done <= 0;
		end else if (relu_enable) begin
			relu_result_1 <= next_relu_result_1;
			relu_result_2 <= next_relu_result_2;
			relu_result_3 <= next_relu_result_3;
			relu_result_4 <= next_relu_result_4;
			relu_result_5 <= next_relu_result_5;
			relu_result_6 <= next_relu_result_6;
			relu_result_7 <= next_relu_result_7;
			relu_result_8 <= next_relu_result_8;
			relu_done <= 1'b1;
		end else begin
			relu_result_1 <= 0;
			relu_result_2 <= 0;
			relu_result_3 <= 0;
			relu_result_4 <= 0;
			relu_result_5 <= 0;
			relu_result_6 <= 0;
			relu_result_7 <= 0;
			relu_result_8 <= 0;
			relu_done <= 0;
		end
	end

endmodule