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
			wire signed [31:0] weight_1 [4:0][4:0];
			wire signed [31:0] fc_weight_0 [1151:0];
			wire conv_enable;
			wire signed [68:0] conv_result_1 [23:0][23:0];
			wire conv_done;
			wire [68:0] relu_result_1 [23:0][23:0];
			wire relu_done;
			wire [68:0] pool_result_1 [11:0][11:0];
			wire pool_done;
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
			,.fc_weight_0(fc_weight_0)
			,.conv_enable(conv_enable)
			,.conv_result_1(conv_result_1)
			,.conv_done(conv_done)
			,.relu_result_1(relu_result_1)
			,.relu_done(relu_done)
			,.pool_result_1(pool_result_1)
			,.pool_done(pool_done)
		`endif
	);
	
	always begin
		#5;
		clk = ~clk;
	end

	task display_data;
		$display("--------------- Display data---------------");
		for (i = 0; i < 28; i++) begin
			// %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b
			$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",
							data[i][0],data[i][1],data[i][2],data[i][3],data[i][4],data[i][5],data[i][6],data[i][7],
							data[i][8],data[i][9],data[i][10],data[i][11],data[i][12],data[i][13],data[i][14],data[i][15],
							data[i][16],data[i][17],data[i][18],data[i][19],data[i][20],data[i][21],data[i][22],data[i][23],
							data[i][24],data[i][25],data[i][26],data[i][27]);
		end
		$display("--------------Display weight------------");
		for (i = 0; i < 5; i++) begin
			$display("%d %d %d %d %d", weight_1[i][0], weight_1[i][1], weight_1[i][2], weight_1[i][3], weight_1[i][4]);
		end
		
		$display("--------------Display conv result-----------");
			$display("Conv_enable: %d", conv_enable);
			for (i = 0; i < 24; i++) begin
					$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
										conv_result_1[i][0],conv_result_1[i][1],conv_result_1[i][2],conv_result_1[i][3],
										conv_result_1[i][4],conv_result_1[i][5],conv_result_1[i][6],conv_result_1[i][7],
										conv_result_1[i][8],conv_result_1[i][9],conv_result_1[i][10],conv_result_1[i][11],
										conv_result_1[i][12],conv_result_1[i][13],conv_result_1[i][14],conv_result_1[i][15],
										conv_result_1[i][16],conv_result_1[i][17],conv_result_1[i][18],conv_result_1[i][19],
										conv_result_1[i][20],conv_result_1[i][21],conv_result_1[i][22],conv_result_1[i][23]);
			end
			$display("Conv_done: %d", conv_done);
			
		$display("--------------Display relu result-----------");
			for (i = 0; i < 24; i++) begin
					$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
										relu_result_1[i][0],relu_result_1[i][1],relu_result_1[i][2],relu_result_1[i][3],
										relu_result_1[i][4],relu_result_1[i][5],relu_result_1[i][6],relu_result_1[i][7],
										relu_result_1[i][8],relu_result_1[i][9],relu_result_1[i][10],relu_result_1[i][11],
										relu_result_1[i][12],relu_result_1[i][13],relu_result_1[i][14],relu_result_1[i][15],
										relu_result_1[i][16],relu_result_1[i][17],relu_result_1[i][18],relu_result_1[i][19],
										relu_result_1[i][20],relu_result_1[i][21],relu_result_1[i][22],relu_result_1[i][23]);
			end
			$display("Relu_done: %d", relu_done);
			
		$display("--------------Display pool result-----------");
		for (i = 0; i < 12; i++) begin
					$display("%d %d %d %d %d %d %d %d %d %d %d %d", 
										pool_result_1[i][0],pool_result_1[i][1],pool_result_1[i][2],pool_result_1[i][3],
										pool_result_1[i][4],pool_result_1[i][5],pool_result_1[i][6],pool_result_1[i][7],
										pool_result_1[i][8],pool_result_1[i][9],pool_result_1[i][10],pool_result_1[i][11]);
			end
			$display("Pool_done: %d", pool_done);
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
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		display_data();
		for (i = 0; i <= 9; i++) begin
			$display("%d", prob[i]);
		end
		$display("Digital identify: %d", result);
		@(negedge clk);
		$finish;
		
	end
	
endmodule
