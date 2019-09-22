`timescale 1ns / 1ps
`define DATA_X 28
`define DATA_Y 28
`define DATA_SIZE 32
`define WEIGHT_X 5
`define WEIGHT_Y 5
`define WEIGHT_SIZE 32
`define CONV_X 24
`define CONV_Y 24
`define CONV_SIZE 69

module conv_layer (
	input clk,    // Clock
	input rst,  // Asynchronous reset active high
	input conv_enable,
	input [`DATA_SIZE-1:0] data [`DATA_X-1:0][`DATA_Y-1:0], // 28*28 8-bit data
	input signed [`WEIGHT_SIZE-1:0] weight_1 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_2 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_3 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_4 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_5 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_6 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_7 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_8 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_1 [`CONV_X-1:0][`CONV_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_2 [`CONV_X-1:0][`CONV_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_3 [`CONV_X-1:0][`CONV_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_4 [`CONV_X-1:0][`CONV_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_5 [`CONV_X-1:0][`CONV_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_6 [`CONV_X-1:0][`CONV_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_7 [`CONV_X-1:0][`CONV_Y-1:0],
	output signed reg [`CONV_SIZE-1:0] conv_result_8 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg conv_done
);

	integer x;
	integer y;
	integer i;
	integer j;

	reg signed [`CONV_SIZE-1:0] next_conv_result_1 [`CONV_X-1:0][`CONV_Y-1:0];
	reg signed [`CONV_SIZE-1:0] next_conv_result_2 [`CONV_X-1:0][`CONV_Y-1:0];
	reg signed [`CONV_SIZE-1:0] next_conv_result_3 [`CONV_X-1:0][`CONV_Y-1:0];
	reg signed [`CONV_SIZE-1:0] next_conv_result_4 [`CONV_X-1:0][`CONV_Y-1:0];
	reg signed [`CONV_SIZE-1:0] next_conv_result_5 [`CONV_X-1:0][`CONV_Y-1:0];
	reg signed [`CONV_SIZE-1:0] next_conv_result_6 [`CONV_X-1:0][`CONV_Y-1:0];
	reg signed [`CONV_SIZE-1:0] next_conv_result_7 [`CONV_X-1:0][`CONV_Y-1:0];
	reg signed [`CONV_SIZE-1:0] next_conv_result_8 [`CONV_X-1:0][`CONV_Y-1:0];
	
	always @ (*) begin
		for (x = 0; x < `CONV_X; x++) begin
			for (y = 0; y < `CONV_Y; y++) begin
				next_conv_result_1[x][y] = 0;
				next_conv_result_2[x][y] = 0;
				next_conv_result_3[x][y] = 0;
				next_conv_result_4[x][y] = 0;
				next_conv_result_5[x][y] = 0;
				next_conv_result_6[x][y] = 0;
				next_conv_result_7[x][y] = 0;
				next_conv_result_8[x][y] = 0;
				for (i = 0; i < `WEIGHT_X; i++) begin
					for (j = 0; j < `WEIGHT_Y; j++) begin
						next_conv_result_1[x][y] = next_conv_result_1[x][y] + weight_1[i][j] * data[x+i][y+j];
						next_conv_result_2[x][y] = next_conv_result_2[x][y] + weight_2[i][j] * data[x+i][y+j];
						next_conv_result_3[x][y] = next_conv_result_3[x][y] + weight_3[i][j] * data[x+i][y+j];
						next_conv_result_4[x][y] = next_conv_result_4[x][y] + weight_4[i][j] * data[x+i][y+j];
						next_conv_result_5[x][y] = next_conv_result_5[x][y] + weight_5[i][j] * data[x+i][y+j];
						next_conv_result_6[x][y] = next_conv_result_6[x][y] + weight_6[i][j] * data[x+i][y+j];
						next_conv_result_7[x][y] = next_conv_result_7[x][y] + weight_7[i][j] * data[x+i][y+j];
						next_conv_result_8[x][y] = next_conv_result_8[x][y] + weight_8[i][j] * data[x+i][y+j];
					end
				end
			end
		end
	end

	always @ (posedge clk) begin
		if (rst) begin
			for (x = 0; x < `CONV_X; x++) begin
				for (y = 0; y < `CONV_Y; y++) begin
					conv_result_1[x][y] <= 0;
					conv_result_2[x][y] <= 0;
					conv_result_3[x][y] <= 0;
					conv_result_4[x][y] <= 0;
					conv_result_5[x][y] <= 0;
					conv_result_6[x][y] <= 0;
					conv_result_7[x][y] <= 0;
					conv_result_8[x][y] <= 0;
				end
			end
			conv_done <= 0;
		end if (conv_enable) begin
			for (x = 0; x < `CONV_X; x++) begin
				for (y = 0; y < `CONV_Y; y++) begin
					conv_result_1[x][y] <= next_conv_result_1[x][y];
					conv_result_2[x][y] <= next_conv_result_2[x][y];
					conv_result_3[x][y] <= next_conv_result_3[x][y];
					conv_result_4[x][y] <= next_conv_result_4[x][y];
					conv_result_5[x][y] <= next_conv_result_5[x][y];
					conv_result_6[x][y] <= next_conv_result_6[x][y];
					conv_result_7[x][y] <= next_conv_result_7[x][y];
					conv_result_8[x][y] <= next_conv_result_8[x][y];
				end
			end
			conv_done <= 1'b1;
		end else begin
			for (x = 0; x < `CONV_X; x++) begin
				for (y = 0; y < `CONV_Y; y++) begin
					conv_result_1[x][y] <= 0;
					conv_result_2[x][y] <= 0;
					conv_result_3[x][y] <= 0;
					conv_result_4[x][y] <= 0;
					conv_result_5[x][y] <= 0;
					conv_result_6[x][y] <= 0;
					conv_result_7[x][y] <= 0;
					conv_result_8[x][y] <= 0;
				end
			end
			conv_done <= 0;
		end
	end

endmodule
