`timescale 1ns / 1ps
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 69
`define POOL_X 12
`define POOL_Y 12
`define STRIDE 2

module pool_layer(
	input clk,    	// Clock
	input rst,  	// Asynchronous reset active high
	input pool_enable,
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_1 [`RELU_X-1:0][`RELU_Y-1:0],		// 24*24, 45-bit each
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_2 [`RELU_X-1:0][`RELU_Y-1:0],
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_3 [`RELU_X-1:0][`RELU_Y-1:0],
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_4 [`RELU_X-1:0][`RELU_Y-1:0],
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_5 [`RELU_X-1:0][`RELU_Y-1:0],
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_6 [`RELU_X-1:0][`RELU_Y-1:0],
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_7 [`RELU_X-1:0][`RELU_Y-1:0],
	input signed [`RELU_DATA_WIDTH-1:0] relu_result_8 [`RELU_X-1:0][`RELU_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_1 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_2 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_3 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_4 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_5 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_6 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_7 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg signed [`RELU_DATA_WIDTH-1:0] pool_result_8 [`POOL_X-1:0][`POOL_Y-1:0],
	output reg pool_done
);
	
	integer x;
	integer y;
	integer i;
	integer j;

	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_1 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_2 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_3 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_4 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_5 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_6 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_7 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] next_pool_result_8 [`POOL_X-1:0][`POOL_Y-1:0];

	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_1 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_2 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_3 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_4 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_5 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_6 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_7 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] temp_pool_result_8 [`POOL_X-1:0][`POOL_Y-1:0];

	always @ (*) begin
		for (x = 0; x < `POOL_X; x++) begin
			for (y = 0; y < `POOL_Y; y++) begin
				temp_pool_result_1[x][y] = 0;
				temp_pool_result_2[x][y] = 0;
				temp_pool_result_3[x][y] = 0;
				temp_pool_result_4[x][y] = 0;
				temp_pool_result_5[x][y] = 0;
				temp_pool_result_6[x][y] = 0;
				temp_pool_result_7[x][y] = 0;
				temp_pool_result_8[x][y] = 0;
				for (i = 0; i < `STRIDE; i++) begin
					for (j = 0; j < `STRIDE; j++) begin
						if (relu_result_1[2*x+i][2*y+j] > temp_pool_result_1[x][y]) temp_pool_result_1[x][y] = relu_result_1[2*x+i][2*y+j];
						if (relu_result_2[2*x+i][2*y+j] > temp_pool_result_2[x][y]) temp_pool_result_2[x][y] = relu_result_2[2*x+i][2*y+j];
						if (relu_result_3[2*x+i][2*y+j] > temp_pool_result_3[x][y]) temp_pool_result_3[x][y] = relu_result_3[2*x+i][2*y+j];
						if (relu_result_4[2*x+i][2*y+j] > temp_pool_result_4[x][y]) temp_pool_result_4[x][y] = relu_result_4[2*x+i][2*y+j];
						if (relu_result_5[2*x+i][2*y+j] > temp_pool_result_5[x][y]) temp_pool_result_5[x][y] = relu_result_5[2*x+i][2*y+j];
						if (relu_result_6[2*x+i][2*y+j] > temp_pool_result_6[x][y]) temp_pool_result_6[x][y] = relu_result_6[2*x+i][2*y+j];
						if (relu_result_7[2*x+i][2*y+j] > temp_pool_result_7[x][y]) temp_pool_result_7[x][y] = relu_result_7[2*x+i][2*y+j];
						if (relu_result_8[2*x+i][2*y+j] > temp_pool_result_8[x][y]) temp_pool_result_8[x][y] = relu_result_8[2*x+i][2*y+j];
					end
				end
				next_pool_result_1 = temp_pool_result_1;
				next_pool_result_2 = temp_pool_result_2;
				next_pool_result_3 = temp_pool_result_3;
				next_pool_result_4 = temp_pool_result_4;
				next_pool_result_5 = temp_pool_result_5;
				next_pool_result_6 = temp_pool_result_6;
				next_pool_result_7 = temp_pool_result_7;
				next_pool_result_8 = temp_pool_result_8;
			end
		end
	end

	always @ (posedge clk) begin
		if (rst) begin
			for (x = 0; x < `POOL_X; x++) begin
				for (y = 0; y < `POOL_Y; y++) begin
					pool_result_1[x][y] <= 0;
					pool_result_2[x][y] <= 0;
					pool_result_3[x][y] <= 0;
					pool_result_4[x][y] <= 0;
					pool_result_5[x][y] <= 0;
					pool_result_6[x][y] <= 0;
					pool_result_7[x][y] <= 0;
					pool_result_8[x][y] <= 0;
				end
			end
			pool_done <= 0;
		end else if (pool_enable) begin
			for (x = 0; x < `POOL_X; x++) begin
				for (y = 0; y < `POOL_Y; y++) begin
					pool_result_1[x][y] <= next_pool_result_1[x][y];
					pool_result_2[x][y] <= next_pool_result_2[x][y];
					pool_result_3[x][y] <= next_pool_result_3[x][y];
					pool_result_4[x][y] <= next_pool_result_4[x][y];
					pool_result_5[x][y] <= next_pool_result_5[x][y];
					pool_result_6[x][y] <= next_pool_result_6[x][y];
					pool_result_7[x][y] <= next_pool_result_7[x][y];
					pool_result_8[x][y] <= next_pool_result_8[x][y];
				end
			end
			pool_done <= 1'b1;
		end else begin
			for (x = 0; x < `POOL_X; x++) begin
				for (y = 0; y < `POOL_Y; y++) begin
					pool_result_1[x][y] <= 0;
					pool_result_2[x][y] <= 0;
					pool_result_3[x][y] <= 0;
					pool_result_4[x][y] <= 0;
					pool_result_5[x][y] <= 0;
					pool_result_6[x][y] <= 0;
					pool_result_7[x][y] <= 0;
					pool_result_8[x][y] <= 0;
				end
			end
			pool_done <= 0;
		end
	end

endmodule
