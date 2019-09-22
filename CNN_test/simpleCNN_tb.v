`timescale 1ns / 1ps

module simpleCNN_tb();

	reg clk;
	reg rst;
	wire [3:0] result;
	
	simpleCNN DUT(
		.clk(clk),
		.rst(rst),
		.result(result)
	);
	
	always begin
		#5;
		clk = ~clk;
	end
	
	initial begin
		clk = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		$display("Digital identify: %d", result);
		@(negedge clk);
		$finish;
		
	end
