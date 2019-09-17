`timescale 1ns / 1ps
`define DATA_X 28
`define DATA_Y 28
`define DATA_SIZE 8
`define WEIGHT_X 5
`define WEIGHT_Y 5
`define WEIGHT_SIZE 32
`define CONV_X 24
`define CONV_Y 24
`define CONV_SIZE 45

module conv_tb;
	reg clk;    // Clock
	reg rst;  // Asynchronous reset active high
	reg conv_enable;
	reg [`DATA_SIZE-1:0] data [`DATA_X-1:0][`DATA_Y-1:0]; // 28*28 8-bit data
	reg [`WEIGHT_SIZE-1:0] weight_1 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg [`WEIGHT_SIZE-1:0] weight_2 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg [`WEIGHT_SIZE-1:0] weight_3 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg [`WEIGHT_SIZE-1:0] weight_4 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg [`WEIGHT_SIZE-1:0] weight_5 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg [`WEIGHT_SIZE-1:0] weight_6 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg [`WEIGHT_SIZE-1:0] weight_7 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	reg [`WEIGHT_SIZE-1:0] weight_8 [`WEIGHT_X-1:0][`WEIGHT_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_1 [`CONV_X-1:0][`CONV_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_2 [`CONV_X-1:0][`CONV_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_3 [`CONV_X-1:0][`CONV_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_4 [`CONV_X-1:0][`CONV_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_5 [`CONV_X-1:0][`CONV_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_6 [`CONV_X-1:0][`CONV_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_7 [`CONV_X-1:0][`CONV_Y-1:0];
	wire [`CONV_SIZE-1:0] conv_result_8 [`CONV_X-1:0][`CONV_Y-1:0];
	wire conv_done;
	
	integer i;
	integer j;
	
	conv_layer DUT(
	.clk(clk),
	.rst(rst),
	.conv_enable(conv_enable),
	.data(data),
	.weight_1(weight_1),
	.weight_2(weight_2),
	.weight_3(weight_3),
	.weight_4(weight_4),
	.weight_5(weight_5),
	.weight_6(weight_6),
	.weight_7(weight_7),
	.weight_8(weight_8),
	.conv_result_1(conv_result_1),
	.conv_result_2(conv_result_2),
	.conv_result_3(conv_result_3),
	.conv_result_4(conv_result_4),
	.conv_result_5(conv_result_5),
	.conv_result_6(conv_result_6),
	.conv_result_7(conv_result_7),
	.conv_result_8(conv_result_8),
	.conv_done(conv_done)
	);
	
	always begin
		#5;
		clk = ~clk;
	end
	
	task initial_data; 
		begin
			for (i = 0; i < `DATA_X; i++) begin
				for (j = 0; j < `DATA_Y; j++) begin
					data[i][j] = i+j;
				end
			end
		end
	endtask	
	
	task initial_weights; // only test 1 depth
		begin
			for (i = 0; i < `WEIGHT_X; i++) begin
				for (j = 0; j < `WEIGHT_Y; j++) begin
					weight_1[i][j] = i+j;
				end
			end
			
			for (i = 0; i < `WEIGHT_X; i++) begin
				for (j = 0; j < `WEIGHT_Y; j++) begin
					weight_2[i][j] = 1;
					weight_3[i][j] = 1;
					weight_4[i][j] = 1;
					weight_5[i][j] = 1;
					weight_6[i][j] = 1;
					weight_7[i][j] = 1;
					weight_8[i][j] = 1;
				end
			end
		end
	endtask	
	
	task display_data;
		begin
			$display("-----------------------------28*28 Data--------------------------");
			for (i = 0; i < `DATA_X; i++) begin
				$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
									data[i][27],data[i][26],data[i][25],data[i][24],
									data[i][23],data[i][22],data[i][21],data[i][20],
									data[i][19],data[i][18],data[i][17],data[i][16],
									data[i][15],data[i][14],data[i][13],data[i][12],
									data[i][11],data[i][10],data[i][9],data[i][8],
									data[i][7],data[i][6],data[i][5],data[i][4],
									data[i][3],data[i][2],data[i][1],data[i][0]);
			end
		end
	endtask
	
	task display_weights;
		begin
			$display("-----------------------------5*5 filter, ONLY TEST 1 depth--------------------------");
			for (i = 0; i < `WEIGHT_X; i++) begin
				$display("%d %d %d %d %d", weight_1[i][4],weight_1[i][3],weight_1[i][2],weight_1[i][1],weight_1[i][0]);
			end
		end
	endtask
	
	task display_conv_outputs;
		begin
			$display("-----------------------------Conv Outputs--------------------------");
			for (i = 0; i < `CONV_X; i++) begin
				$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
									conv_result_1[i][23],conv_result_1[i][22],conv_result_1[i][21],conv_result_1[i][20],
									conv_result_1[i][19],conv_result_1[i][18],conv_result_1[i][17],conv_result_1[i][16],
									conv_result_1[i][15],conv_result_1[i][14],conv_result_1[i][13],conv_result_1[i][12],
									conv_result_1[i][11],conv_result_1[i][10],conv_result_1[i][9],conv_result_1[i][8],
									conv_result_1[i][7],conv_result_1[i][6],conv_result_1[i][5],conv_result_1[i][4],
									conv_result_1[i][3],conv_result_1[i][2],conv_result_1[i][1],conv_result_1[i][0]);
			end
			$display("Conv_done: %b", conv_done);
		end
	endtask
	
	initial begin 
		clk = 1'b0;
		conv_enable = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		conv_enable = 1'b1;
		initial_data();
		initial_weights();
		display_data();
		display_weights();
		$display("Conv_done: %b", conv_done);
		@(negedge clk);
		display_conv_outputs();
		$finish;
	end
	
endmodule
	
	
