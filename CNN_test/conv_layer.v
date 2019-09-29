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
	input signed [`DATA_SIZE-1:0] data [`DATA_X-1:0][`DATA_Y-1:0], // 28*28 8-bit data
	input signed [`WEIGHT_SIZE-1:0] weight_1 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_2 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_3 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_4 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_5 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_6 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_7 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	input signed [`WEIGHT_SIZE-1:0] weight_8 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_1 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_2 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_3 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_4 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_5 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_6 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_7 [`CONV_X-1:0][`CONV_Y-1:0],
	output reg signed [`CONV_SIZE-1:0] conv_result_8 [`CONV_X-1:0][`CONV_Y-1:0],
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
	
	reg signed [63:0] temp1;
	reg signed [63:0] temp2;
	reg signed [63:0] temp3;
	reg signed [63:0] temp4;
	reg signed [63:0] temp5;
	reg signed [63:0] temp6;
	reg signed [63:0] temp7;
	reg signed [63:0] temp8;
	
	reg signed [`WEIGHT_SIZE-1:0] temp_1 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg signed [`WEIGHT_SIZE-1:0] temp_2 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg signed [`WEIGHT_SIZE-1:0] temp_3 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg signed [`WEIGHT_SIZE-1:0] temp_4 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg signed [`WEIGHT_SIZE-1:0] temp_5 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg signed [`WEIGHT_SIZE-1:0] temp_6 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg signed [`WEIGHT_SIZE-1:0] temp_7 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg signed [`WEIGHT_SIZE-1:0] temp_8 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	
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
						if (weight_1[i][j] < 0) begin
							temp_1[i][j] = -weight_1[i][j];
							temp1 = - temp_1[i][j] * data[x+i][y+j];
							next_conv_result_1[x][y] = next_conv_result_1[x][y] + temp1;
						end else begin
							temp1 = weight_1[i][j] * data[x+i][y+j];
							next_conv_result_1[x][y] = next_conv_result_1[x][y] + temp1;
						end
						if (weight_2[i][j] < 0) begin
							temp_2[i][j] = -weight_2[i][j];
							temp2 = - temp_2[i][j] * data[x+i][y+j];
							next_conv_result_2[x][y] = next_conv_result_2[x][y] + temp2;
						end else begin
							temp2 = weight_2[i][j] * data[x+i][y+j];
							next_conv_result_2[x][y] = next_conv_result_2[x][y] + temp2;
						end
						if (weight_3[i][j] < 0) begin
							temp_3[i][j] = -weight_3[i][j];
							temp3 = - temp_3[i][j] * data[x+i][y+j];
							next_conv_result_3[x][y] = next_conv_result_3[x][y] + temp3;
						end else begin
							temp3 = weight_3[i][j] * data[x+i][y+j];
							next_conv_result_3[x][y] = next_conv_result_3[x][y] + temp3;
						end
						if (weight_1[i][j] < 0) begin
							temp_4[i][j] = -weight_4[i][j];
							temp4 = - temp_4[i][j] * data[x+i][y+j];
							next_conv_result_4[x][y] = next_conv_result_4[x][y] + temp4;
						end else begin
							temp4 = weight_4[i][j] * data[x+i][y+j];
							next_conv_result_4[x][y] = next_conv_result_4[x][y] + temp4;
						end
						if (weight_5[i][j] < 0) begin
							temp_5[i][j] = -weight_5[i][j];
							temp5 = - temp_5[i][j] * data[x+i][y+j];
							next_conv_result_5[x][y] = next_conv_result_5[x][y] + temp5;
						end else begin
							temp5 = weight_5[i][j] * data[x+i][y+j];
							next_conv_result_5[x][y] = next_conv_result_5[x][y] + temp5;
						end
						if (weight_6[i][j] < 0) begin
							temp_6[i][j] = -weight_6[i][j];
							temp6 = - temp_6[i][j] * data[x+i][y+j];
							next_conv_result_6[x][y] = next_conv_result_6[x][y] + temp6;
						end else begin
							temp6 = weight_6[i][j] * data[x+i][y+j];
							next_conv_result_6[x][y] = next_conv_result_6[x][y] + temp6;
						end
						if (weight_7[i][j] < 0) begin
							temp_7[i][j] = -weight_7[i][j];
							temp7 = - temp_7[i][j] * data[x+i][y+j];
							next_conv_result_7[x][y] = next_conv_result_7[x][y] + temp7;
						end else begin
							temp7 = weight_7[i][j] * data[x+i][y+j];
							next_conv_result_7[x][y] = next_conv_result_7[x][y] + temp7;
						end
						if (weight_8[i][j] < 0) begin
							temp_8[i][j] = -weight_8[i][j];
							temp8 = - temp_8[i][j] * data[x+i][y+j];
							next_conv_result_8[x][y] = next_conv_result_8[x][y] + temp8;
						end else begin
							temp8 = weight_8[i][j] * data[x+i][y+j];
							next_conv_result_8[x][y] = next_conv_result_8[x][y] + temp8;
						end
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
