`timescale 1ns / 1ps

module read_data (
	input clk,    // Clock
	input rst,  // Asynchronous reset active high
	output reg signed [31:0] data [27:0][27:0],
	output reg signed [31:0] weight_1 [4:0][4:0],
	output reg signed [31:0] weight_2 [4:0][4:0],
	output reg signed [31:0] weight_3 [4:0][4:0],
	output reg signed [31:0] weight_4 [4:0][4:0],
	output reg signed [31:0] weight_5 [4:0][4:0],
	output reg signed [31:0] weight_6 [4:0][4:0],
	output reg signed [31:0] weight_7 [4:0][4:0],
	output reg signed [31:0] weight_8 [4:0][4:0],
	output reg signed [31:0] fc_weight_0 [1151:0],
	output reg signed [31:0] fc_weight_1 [1151:0],
	output reg signed [31:0] fc_weight_2 [1151:0],
	output reg signed [31:0] fc_weight_3 [1151:0],
	output reg signed [31:0] fc_weight_4 [1151:0],
	output reg signed [31:0] fc_weight_5 [1151:0],
	output reg signed [31:0] fc_weight_6 [1151:0],
	output reg signed [31:0] fc_weight_7 [1151:0],
	output reg signed [31:0] fc_weight_8 [1151:0],
	output reg signed [31:0] fc_weight_9 [1151:0]
);
	integer i;
	integer j;
	integer m;
	integer file0, file1, file2;
	integer count_data;
	integer count_conv_weight;
	integer count_fc_weight;
	
	initial begin
		// read data
		file0 = $fopen("test_2s_compliment.txt","r");
		for (i = 0; i < 28; i = i+1) begin
			for (j = 0; j < 28; j = j+1) begin
				count_data = $fscanf(file0, "%b", data[i][j]);
			end
		end
		// read conv weight
		// initial $readmemb("test2.txt", imageArray, 0, 27); //reading image
		file1 = $fopen("conv_weights_out_2s_comp.txt","r");
		//while (! $feof(file1)) begin
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_1[i][j]);
			end
		end
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_2[i][j]);
			end
		end
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_3[i][j]);
			end
		end
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_4[i][j]);
			end
		end
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_5[i][j]);
			end
		end
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_6[i][j]);
			end
		end
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_7[i][j]);
			end
		end
		for (i = 0; i < 5; i = i+1) begin
			for (j = 0; j < 5; j = j+1) begin
				count_conv_weight = $fscanf(file1, "%b", weight_8[i][j]);
			end
		end
		//end
		
		// Read fc weight
		file2 = $fopen("fc_weights_out_2s_comp.txt","r");
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_0[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_1[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_2[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_3[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_4[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_5[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_6[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_7[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_8[m]);
		end
		for (m = 0; m < 1152; m = m+1) begin
			count_fc_weight = $fscanf(file2, "%b", fc_weight_9[m]);
		end
	end

endmodule
