`timescale 1ns / 1ps

module read_data (
	input clk,  // Clock
	input rst,  // Asynchronous reset active high
	output reg signed [25087:0] data_f,
	output reg signed [799:0] weight_1_f,
	output reg signed [799:0] weight_2_f,
	output reg signed [799:0] weight_3_f,
	output reg signed [799:0] weight_4_f,
	output reg signed [799:0] weight_5_f,
	output reg signed [799:0] weight_6_f,
	output reg signed [799:0] weight_7_f,
	output reg signed [799:0] weight_8_f,
	output reg signed [36863:0] fc_weight_0_f,
	output reg signed [36863:0] fc_weight_1_f,
	output reg signed [36863:0] fc_weight_2_f,
	output reg signed [36863:0] fc_weight_3_f,
	output reg signed [36863:0] fc_weight_4_f,
	output reg signed [36863:0] fc_weight_5_f,
	output reg signed [36863:0] fc_weight_6_f,
	output reg signed [36863:0] fc_weight_7_f,
	output reg signed [36863:0] fc_weight_8_f,
	output reg signed [36863:0] fc_weight_9_f
);
	integer i, j;
	/*
	integer j;
	integer m;
	integer file0, file1, file2;
	integer count_data;
	integer count_conv_weight;
	integer count_fc_weight;
	*/
	reg signed [31:0] data [0:27][0:27];
	/*
	reg signed [31:0] weight_1 [4:0][4:0];
	reg signed [31:0] weight_2 [4:0][4:0];
	reg signed [31:0] weight_3 [4:0][4:0];
	reg signed [31:0] weight_4 [4:0][4:0];
	reg signed [31:0] weight_5 [4:0][4:0];
	reg signed [31:0] weight_6 [4:0][4:0];
	reg signed [31:0] weight_7 [4:0][4:0];
	reg signed [31:0] weight_8 [4:0][4:0];
	reg signed [31:0] fc_weight_0 [1151:0];
	reg signed [31:0] fc_weight_1 [1151:0];
	reg signed [31:0] fc_weight_2 [1151:0];
	reg signed [31:0] fc_weight_3 [1151:0];
	reg signed [31:0] fc_weight_4 [1151:0];
	reg signed [31:0] fc_weight_5 [1151:0];
	reg signed [31:0] fc_weight_6 [1151:0];
	reg signed [31:0] fc_weight_7 [1151:0];
	reg signed [31:0] fc_weight_8 [1151:0];
	reg signed [31:0] fc_weight_9 [1151:0];
	*/
	reg signed [799:0] weight [0:7];
	reg signed [36863:0] fc_weight [0:9];
	
    //reg [31:0] test_2s_compliment_test [0:27][0:27];
  always @* begin
    weight[0] = weight_1_f;
	  weight[1] = weight_2_f;
	  weight[2] = weight_3_f;
	  weight[3] = weight_4_f;
	  weight[4] = weight_5_f;
	  weight[5] = weight_6_f;
	  weight[6] = weight_7_f;
	  weight[7] = weight_8_f;
	  fc_weight[0] = fc_weight_0_f;
	  fc_weight[1] = fc_weight_1_f;
	  fc_weight[2] = fc_weight_2_f;
	  fc_weight[3] = fc_weight_3_f;
	  fc_weight[4] = fc_weight_4_f;
	  fc_weight[5] = fc_weight_5_f;
	  fc_weight[6] = fc_weight_6_f;
	  fc_weight[7] = fc_weight_7_f;
	  fc_weight[8] = fc_weight_8_f;
	  fc_weight[9] = fc_weight_9_f;
	end
	
	initial begin
		// read data
		$readmemb("test_2s_compliment.txt.txt", data);
		// read conv weight
		$readmemb("conv_weights_out_2s_comp.txt.txt", weight);
		// read fc weight
		$readmemb("fc_weights_out_2s_comp.txt.txt", fc_weight);

	end
		
	always @(*) begin
		for (i = 0; i < 28; i = i+1) begin
			for (j = 0; j < 28; j = j+1) begin
				data_f[896*i+32*j+:32] = data[i][j];
			end
		end
	end

endmodule
