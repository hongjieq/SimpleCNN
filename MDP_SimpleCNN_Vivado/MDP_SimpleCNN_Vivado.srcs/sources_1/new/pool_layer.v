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
	input signed [39743:0] relu_result_1_f,
	input signed [39743:0] relu_result_2_f,
	input signed [39743:0] relu_result_3_f,
	input signed [39743:0] relu_result_4_f,
	input signed [39743:0] relu_result_5_f,
	input signed [39743:0] relu_result_6_f,
	input signed [39743:0] relu_result_7_f,
	input signed [39743:0] relu_result_8_f,
	output reg signed [9935:0] pool_result_1_f,
	output reg signed [9935:0] pool_result_2_f,
	output reg signed [9935:0] pool_result_3_f,
	output reg signed [9935:0] pool_result_4_f,
	output reg signed [9935:0] pool_result_5_f,
	output reg signed [9935:0] pool_result_6_f,
	output reg signed [9935:0] pool_result_7_f,
	output reg signed [9935:0] pool_result_8_f,
	output reg pool_done 
);
	
	integer x;
	integer y;
	integer i;
	integer j;
	
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_1 [`RELU_X-1:0][`RELU_Y-1:0];		// 24*24, 45-bit each
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_2 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_3 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_4 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_5 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_6 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_7 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] relu_result_8 [`RELU_X-1:0][`RELU_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_1 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_2 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_3 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_4 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_5 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_6 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_7 [`POOL_X-1:0][`POOL_Y-1:0];
	reg signed [`RELU_DATA_WIDTH-1:0] pool_result_8 [`POOL_X-1:0][`POOL_Y-1:0];

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
		for (i = 0; i < 24; i = i+1) begin
			for (j = 0; j < 24; j = i+1) begin
				relu_result_1[i][j] = relu_result_1_f[1656*i+69*j+:69];
				relu_result_2[i][j] = relu_result_2_f[1656*i+69*j+:69];
				relu_result_3[i][j] = relu_result_3_f[1656*i+69*j+:69];
				relu_result_4[i][j] = relu_result_4_f[1656*i+69*j+:69];
				relu_result_5[i][j] = relu_result_5_f[1656*i+69*j+:69];
				relu_result_6[i][j] = relu_result_6_f[1656*i+69*j+:69];
				relu_result_7[i][j] = relu_result_7_f[1656*i+69*j+:69];
				relu_result_8[i][j] = relu_result_8_f[1656*i+69*j+:69];
			end
		end
		for (i = 0; i < 12; i = i+1) begin
			for (j = 0; j < 12; j = i+1) begin
				pool_result_1_f[828*i+69*j+:69] = pool_result_1[i][j];
				pool_result_2_f[828*i+69*j+:69] = pool_result_2[i][j];
				pool_result_3_f[828*i+69*j+:69] = pool_result_3[i][j];
				pool_result_4_f[828*i+69*j+:69] = pool_result_4[i][j];
				pool_result_5_f[828*i+69*j+:69] = pool_result_5[i][j];
				pool_result_6_f[828*i+69*j+:69] = pool_result_6[i][j];
				pool_result_7_f[828*i+69*j+:69] = pool_result_7[i][j];
				pool_result_8_f[828*i+69*j+:69] = pool_result_8[i][j];
			end
		end
	end

	always @ (*) begin
		for (x = 0; x < `POOL_X; x = x+1) begin
			for (y = 0; y < `POOL_Y; y = y+1) begin
				temp_pool_result_1[x][y] = 0;
				temp_pool_result_2[x][y] = 0;
				temp_pool_result_3[x][y] = 0;
				temp_pool_result_4[x][y] = 0;
				temp_pool_result_5[x][y] = 0;
				temp_pool_result_6[x][y] = 0;
				temp_pool_result_7[x][y] = 0;
				temp_pool_result_8[x][y] = 0;
				for (i = 0; i < `STRIDE; i = i+1) begin
					for (j = 0; j < `STRIDE; j = j+1) begin
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
				for (x = 0; x < `POOL_X; x = x+1) begin
                    for (y = 0; y < `POOL_Y; y = y+1) begin
                        next_pool_result_1[i][j] = temp_pool_result_1[i][j];
                        next_pool_result_2[i][j] = temp_pool_result_2[i][j];
                        next_pool_result_3[i][j] = temp_pool_result_3[i][j];
                        next_pool_result_4[i][j] = temp_pool_result_4[i][j];
                        next_pool_result_5[i][j] = temp_pool_result_5[i][j];
                        next_pool_result_6[i][j] = temp_pool_result_6[i][j];
                        next_pool_result_7[i][j] = temp_pool_result_7[i][j];
                        next_pool_result_8[i][j] = temp_pool_result_8[i][j];
                    end
                end
			end
		end
	end

	always @ (posedge clk) begin
		if (rst) begin
			for (x = 0; x < `POOL_X; x = x+1) begin
				for (y = 0; y < `POOL_Y; y = y+1) begin
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
			for (x = 0; x < `POOL_X; x = x+1) begin
				for (y = 0; y < `POOL_Y; y = y+1) begin
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
			for (x = 0; x < `POOL_X; x = x+1) begin
				for (y = 0; y < `POOL_Y; y = y+1) begin
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
