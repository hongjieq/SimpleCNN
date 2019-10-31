`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/29/2019 03:59:02 PM
// Design Name:
// Module Name: simpleCNN_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module simpleCNN_tb();

	reg clk;
	reg rst;
	reg enable;
	wire [3:0] result;
	wire [15:0] count;
	wire signed [112:0] prob_0;
	wire signed [112:0] prob_1;
	wire signed [112:0] prob_2;
	wire signed [112:0] prob_3;
	wire signed [112:0] prob_4;
	wire signed [112:0] prob_5;
	wire signed [112:0] prob_6;
	wire signed [112:0] prob_7;
	wire signed [112:0] prob_8;
	wire signed [112:0] prob_9;
	wire signed [68:0] conv_result_1;
	wire signed [68:0] conv_result_2;
	wire signed [68:0] conv_result_3;
	wire signed [68:0] conv_result_4;
	wire signed [68:0] conv_result_5;
	wire signed [68:0] conv_result_6;
	wire signed [68:0] conv_result_7;
	wire signed [68:0] conv_result_8;
// relu_layer
	wire signed [68:0] relu_result_1;
	wire signed [68:0] relu_result_2;
	wire signed [68:0] relu_result_3;
	wire signed [68:0] relu_result_4;
	wire signed [68:0] relu_result_5;
	wire signed [68:0] relu_result_6;
	wire signed [68:0] relu_result_7;
	wire signed [68:0] relu_result_8;
// pool_layer
	wire signed [68:0] pool_result_1;
	wire signed [68:0] pool_result_2;
	wire signed [68:0] pool_result_3;
	wire signed [68:0] pool_result_4;
	wire signed [68:0] pool_result_5;
	wire signed [68:0] pool_result_6;
	wire signed [68:0] pool_result_7;
	wire signed [68:0] pool_result_8;
	wire fc_done;

	integer i;
	integer j;
	integer f0,f1,f2,f3;

	simpleCNN DUT(
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.result(result),
		.count(count),
		.conv_result_1(conv_result_1),
	 	.conv_result_2(conv_result_2),
	 	.conv_result_3(conv_result_3),
	 	.conv_result_4(conv_result_4),
	 	.conv_result_5(conv_result_5),
	 	.conv_result_6(conv_result_6),
	 	.conv_result_7(conv_result_7),
	 	.conv_result_8(conv_result_8),
	 	.relu_result_1(relu_result_1),
		.relu_result_2(relu_result_2),
		.relu_result_3(relu_result_3),
		.relu_result_4(relu_result_4),
		.relu_result_5(relu_result_5),
		.relu_result_6(relu_result_6),
		.relu_result_7(relu_result_7),
		.relu_result_8(relu_result_8),
		.pool_result_1(pool_result_1),
		.pool_result_2(pool_result_2),
		.pool_result_3(pool_result_3),
		.pool_result_4(pool_result_4),
		.pool_result_5(pool_result_5),
		.pool_result_6(pool_result_6),
		.pool_result_7(pool_result_7),
		.pool_result_8(pool_result_8),
		.prob_0(prob_0),
		.prob_1(prob_1),
		.prob_2(prob_2),
		.prob_3(prob_3),
		.prob_4(prob_4),
		.prob_5(prob_5),
		.prob_6(prob_6),
		.prob_7(prob_7),
		.prob_8(prob_8),
		.prob_9(prob_9),
		.fc_done(fc_done)
	);

	always begin
		#5;
		clk = ~clk;
	end

	initial begin
		f0 = $fopen("prob.txt","w");
		f1 = $fopen("conv.txt","w");
		f2 = $fopen("relu.txt","w");
		f3 = $fopen("pool.txt","w");
	end

	initial begin
		clk = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		
		repeat (1000) begin
			@(negedge clk);
			$fwrite(f0, "%d		", count);
			$fwrite(f0, "%d		", result);
			$fwrite(f0, "%d	%d %d %d %d %d	%d %d %d %d", prob_0, prob_1, prob_2, prob_3, prob_4, prob_5, prob_6, prob_7, prob_8, prob_9);
			$fwrite(f0, "\n");
			
			$fwrite(f1, "%d		", count);
			$fwrite(f1, "%d		", conv_result_1);
			$fwrite(f1, "%d		", conv_result_2);
			$fwrite(f1, "%d		", conv_result_3);
			$fwrite(f1, "%d		", conv_result_4);
			$fwrite(f1, "%d		", conv_result_5);
			$fwrite(f1, "%d		", conv_result_6);
			$fwrite(f1, "%d		", conv_result_7);
			$fwrite(f1, "%d		", conv_result_8);
			$fwrite(f1, "\n");
			
			$fwrite(f2, "%d		", count);
			$fwrite(f2, "%d		", relu_result_1);
			$fwrite(f2, "%d		", relu_result_2);
			$fwrite(f2, "%d		", relu_result_3);
			$fwrite(f2, "%d		", relu_result_4);
			$fwrite(f2, "%d		", relu_result_5);
			$fwrite(f2, "%d		", relu_result_6);
			$fwrite(f2, "%d		", relu_result_7);
			$fwrite(f2, "%d		", relu_result_8);
			$fwrite(f2, "\n");
			
			$fwrite(f3, "%d		", count);
			$fwrite(f3, "%d		", pool_result_1);
			$fwrite(f3, "%d		", pool_result_2);
			$fwrite(f3, "%d		", pool_result_3);
			$fwrite(f3, "%d		", pool_result_4);
			$fwrite(f3, "%d		", pool_result_5);
			$fwrite(f3, "%d		", pool_result_6);
			$fwrite(f3, "%d		", pool_result_7);
			$fwrite(f3, "%d		", pool_result_8);
			$fwrite(f3, "\n");
		end
		@(negedge clk);
		$fclose(f0);
		$fclose(f1);
		$fclose(f2);
		$fclose(f3);
		
		$finish;

	end

endmodule
