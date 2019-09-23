`timescale 1ns / 1ps
`define DEBUG

module simpleCNN_tb();

	reg clk;
	reg rst;
	reg enable;
	wire [3:0] result;
	`ifdef DEBUG
			wire [31:0] prob [9:0];
			wire [31:0] data [27:0][27:0];
			wire [31:0] weight_1 [4:0][4:0];
			wire [68:0] pool_result_1 [11:0][11:0];
			wire [68:0] conv_result_1 [23:0][23:0];
			wire conv_done;
	`endif

	integer i;
	integer j;
	
	simpleCNN DUT(
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.result(result)
		`ifdef DEBUG
			,.prob(prob)
			,.weight_1(weight_1)
			,.data(data)
			,.pool_result_1(pool_result_1)
			,.conv_result_1(conv_result_1)
			,.conv_done(conv_done)
		`endif
	);
	
	always begin
		#5;
		clk = ~clk;
	end

	task display_data;
		$display("--------------- Display data---------------");
		for (i = 0; i < 28; i++) begin
			$display("%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b",
							data[i][0],data[i][1],data[i][2],data[i][3],data[i][4],data[i][5],data[i][6],data[i][7],
							data[i][8],data[i][9],data[i][10],data[i][11],data[i][12],data[i][13],data[i][14],data[i][15],
							data[i][16],data[i][17],data[i][18],data[i][19],data[i][20],data[i][21],data[i][22],data[i][23],
							data[i][24],data[i][25],data[i][26],data[i][27]);
		end
		$display("--------------Display weight------------");
		for (i = 0; i < 5; i++) begin
			$display("%b %b %b %b %b", weight_1[i][0], weight_1[i][1], weight_1[i][2], weight_1[i][3], weight_1[i][4]);
		end
		$display("--------------Display conv result-----------");
		for (i = 0; i < 24; i++) begin
			for (j = 0; j < 24; j++) begin
				$display("%b", conv_result_1[i][j]);
			end
		end
		$display("--------------Display pool result-----------");
		for (i = 0; i < 12; i++) begin
			for (j = 0; j < 12; j++) begin
				$display("%b", pool_result_1[i][j]);
			end
		end
	endtask
	
	initial begin
		clk = 1'b0;
		rst = 1'b1;
		enable = 1'b0;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		enable = 1'b1;
		@(negedge clk);
		display_data();
		$display("Conv_done: %b", conv_done);
		for (i = 0; i <= 9; i++) begin
			$display("%d", prob[i]);
		end
		$display("Digital identify: %d", result);
		@(negedge clk);
		$finish;
		
	end
	
endmodule
