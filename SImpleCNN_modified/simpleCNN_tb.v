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
	wire fc_done;

	integer i;
	integer j;
	integer f0;

	simpleCNN DUT(
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.result(result),
		.count(count),
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
/*
	initial begin
		f0 = $fopen("test.txt","w");
	end
*/
	initial begin
		clk = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		repeat (1000) @(negedge clk);
		/*
		repeat (1000) begin
			@(negedge clk);
			$fwrite(f0, "%d		", count);
			$fwrite(f0, "%d		", result);
			$fwrite(f0, "%d		", prob_0);
			$fwrite(f0, "%d		", prob_1);
			$fwrite(f0, "%d		", prob_2);
			$fwrite(f0, "%d		", prob_3);
			$fwrite(f0, "%d		", prob_4);
			$fwrite(f0, "%d		", prob_5);
			$fwrite(f0, "%d		", prob_6);
			$fwrite(f0, "%d		", prob_7);
			$fwrite(f0, "%d		", prob_8);
			$fwrite(f0, "%d		", prob_9);
			$fwrite(f0, "\n");
		end
		@(negedge clk);
		$fclose(f0);
		*/
		//$finish;

	end

endmodule
