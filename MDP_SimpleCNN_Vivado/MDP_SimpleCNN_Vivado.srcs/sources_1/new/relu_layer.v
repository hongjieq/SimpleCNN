`timescale 1ns / 1ps
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 69

module relu_layer(
	input clk,    	// Clock
	input rst,  	// Asynchronous reset active high
	input relu_enable,
	input signed [39743:0] conv_result_1_f,
	input signed [39743:0] conv_result_2_f,
	input signed [39743:0] conv_result_3_f,
	input signed [39743:0] conv_result_4_f,
	input signed [39743:0] conv_result_5_f,
	input signed [39743:0] conv_result_6_f,
	input signed [39743:0] conv_result_7_f,
	input signed [39743:0] conv_result_8_f,
	output reg signed [39743:0] relu_result_1_f,
	output reg signed [39743:0] relu_result_2_f,
	output reg signed [39743:0] relu_result_3_f,
	output reg signed [39743:0] relu_result_4_f,
	output reg signed [39743:0] relu_result_5_f,
	output reg signed [39743:0] relu_result_6_f,
	output reg signed [39743:0] relu_result_7_f,
	output reg signed [39743:0] relu_result_8_f,
	output reg relu_done
);
	
	integer i;
	integer j;
	
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_1 [`RELU_X-1:0][`RELU_Y-1:0];		// 24*24, 45-bit each
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_2 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_3 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_4 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_5 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_6 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_7 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] conv_result_8 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_1 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_2 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_3 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_4 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_5 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_6 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_7 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_8 [`RELU_X-1:0][`RELU_Y-1:0];

	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_1 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_2 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_3 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_4 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_5 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_6 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_7 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_relu_result_8 [`RELU_X-1:0][`RELU_Y-1:0];
	
	always @ (*) begin
		for (i = 0; i < 24; i = i+1) begin
			for (j = 0; j < 24; j = i+1) begin
				conv_result_1[i][j] = conv_result_1_f[1656*i+69*j+:69];
				conv_result_2[i][j] = conv_result_2_f[1656*i+69*j+:69];
				conv_result_3[i][j] = conv_result_3_f[1656*i+69*j+:69];
				conv_result_4[i][j] = conv_result_4_f[1656*i+69*j+:69];
				conv_result_5[i][j] = conv_result_5_f[1656*i+69*j+:69];
				conv_result_6[i][j] = conv_result_6_f[1656*i+69*j+:69];
				conv_result_7[i][j] = conv_result_7_f[1656*i+69*j+:69];
				conv_result_8[i][j] = conv_result_8_f[1656*i+69*j+:69];
			end
		end
		for (i = 0; i < 24; i = i+1) begin
			for (j = 0; j < 24; j = i+1) begin
				relu_result_1_f[1656*i+69*j+:69] = relu_result_1[i][j];
				relu_result_2_f[1656*i+69*j+:69] = relu_result_2[i][j];
				relu_result_3_f[1656*i+69*j+:69] = relu_result_3[i][j];
				relu_result_4_f[1656*i+69*j+:69] = relu_result_4[i][j];
				relu_result_5_f[1656*i+69*j+:69] = relu_result_5[i][j];
				relu_result_6_f[1656*i+69*j+:69] = relu_result_6[i][j];
				relu_result_7_f[1656*i+69*j+:69] = relu_result_7[i][j];
				relu_result_8_f[1656*i+69*j+:69] = relu_result_8[i][j];
			end
		end
	end

	always @ (*) begin
		for (i = 0; i < `RELU_X; i = i+1) begin
			for (j = 0; j < `RELU_Y; j = j+1) begin
				if (conv_result_1[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_1[i][j] = 0;
				else next_relu_result_1[i][j] = conv_result_1[i][j];

				if (conv_result_2[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_2[i][j] = 0;
				else next_relu_result_2[i][j] = conv_result_2[i][j];

				if (conv_result_3[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_3[i][j] = 0;
				else next_relu_result_3[i][j] = conv_result_3[i][j];

				if (conv_result_4[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_4[i][j] = 0;
				else next_relu_result_4[i][j] = conv_result_4[i][j];

				if (conv_result_5[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_5[i][j] = 0;
				else next_relu_result_5[i][j] = conv_result_5[i][j];

				if (conv_result_6[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_6[i][j] = 0;
				else next_relu_result_6[i][j] = conv_result_6[i][j];

				if (conv_result_7[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_7[i][j] = 0;
				else next_relu_result_7[i][j] = conv_result_7[i][j];

				if (conv_result_8[i][j][`RELU_DATA_WIDTH-1] == 1'b1) next_relu_result_8[i][j] = 0;
				else next_relu_result_8[i][j] = conv_result_8[i][j];
			end
		end
	end

	always @ (posedge clk) begin
		if (rst) begin
			for (i = 0; i < `RELU_X; i = i+1) begin
				for (j = 0; j < `RELU_Y; j = j+1) begin
					relu_result_1[i][j] <= 0;
					relu_result_2[i][j] <= 0;
					relu_result_3[i][j] <= 0;
					relu_result_4[i][j] <= 0;
					relu_result_5[i][j] <= 0;
					relu_result_6[i][j] <= 0;
					relu_result_7[i][j] <= 0;
					relu_result_8[i][j] <= 0;
				end
			end
			relu_done <= 0;
		end else if (relu_enable) begin
			for (i = 0; i < `RELU_X; i = i+1) begin
				for (j = 0; j < `RELU_Y; j = j+1) begin
					relu_result_1[i][j] <= next_relu_result_1[i][j];
					relu_result_2[i][j] <= next_relu_result_2[i][j];
					relu_result_3[i][j] <= next_relu_result_3[i][j];
					relu_result_4[i][j] <= next_relu_result_4[i][j];
					relu_result_5[i][j] <= next_relu_result_5[i][j];
					relu_result_6[i][j] <= next_relu_result_6[i][j];
					relu_result_7[i][j] <= next_relu_result_7[i][j];
					relu_result_8[i][j] <= next_relu_result_8[i][j];
				end
			end
			relu_done <= 1'b1;
		end else begin
			for (i = 0; i < `RELU_X; i = i+1) begin
				for (j = 0; j < `RELU_Y; j = j+1) begin
					relu_result_1[i][j] <= 0;
					relu_result_2[i][j] <= 0;
					relu_result_3[i][j] <= 0;
					relu_result_4[i][j] <= 0;
					relu_result_5[i][j] <= 0;
					relu_result_6[i][j] <= 0;
					relu_result_7[i][j] <= 0;
					relu_result_8[i][j] <= 0;
				end
			end
			relu_done <= 0;
		end
	end

endmodule
