`timescale 1ns / 1ps
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 45
`define POOL_X 12
`define POOL_Y 12
`define STRIDE 2

module pool_tb; 
	reg	clk;    	// Clock
	reg rst;  	// Asynchronous reset active high
	reg pool_enable;
	reg [`RELU_DATA_WIDTH-1:0] relu_result_1 [`RELU_X-1:0][`RELU_Y-1:0];		// 24*24, 45-bit each
	reg [`RELU_DATA_WIDTH-1:0] relu_result_2 [`RELU_X-1:0][`RELU_Y-1:0];
	reg [`RELU_DATA_WIDTH-1:0] relu_result_3 [`RELU_X-1:0][`RELU_Y-1:0];
	reg [`RELU_DATA_WIDTH-1:0] relu_result_4 [`RELU_X-1:0][`RELU_Y-1:0];
	reg [`RELU_DATA_WIDTH-1:0] relu_result_5 [`RELU_X-1:0][`RELU_Y-1:0];
	reg [`RELU_DATA_WIDTH-1:0] relu_result_6 [`RELU_X-1:0][`RELU_Y-1:0];
	reg [`RELU_DATA_WIDTH-1:0] relu_result_7 [`RELU_X-1:0][`RELU_Y-1:0];
	reg [`RELU_DATA_WIDTH-1:0] relu_result_8 [`RELU_X-1:0][`RELU_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_1 [`POOL_X-1:0][`POOL_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_2 [`POOL_X-1:0][`POOL_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_3 [`POOL_X-1:0][`POOL_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_4 [`POOL_X-1:0][`POOL_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_5 [`POOL_X-1:0][`POOL_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_6 [`POOL_X-1:0][`POOL_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_7 [`POOL_X-1:0][`POOL_Y-1:0];
	wire [`RELU_DATA_WIDTH-1:0] pool_result_8 [`POOL_X-1:0][`POOL_Y-1:0];
	wire pool_done;
	
	integer x;
	integer y;
	integer i;
	integer j;
	
	pool_layer DUT(
	.clk(clk),
	.rst(rst),
	.pool_enable(pool_enable),
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
	.pool_done(pool_done)
	);
	
	always begin
		#5;
		clk = ~clk;
	end
	
	task initial_pool_inputs; // only test 1 depth
		begin
			for (i = 0; i < `RELU_X; i++) begin
				for (j = 0; j < `RELU_Y; j++) begin
					relu_result_1[i][j] = i+j;
				end
			end
			
			for (i = 0; i < `RELU_X; i++) begin
				for (j = 0; j < `RELU_Y; j++) begin
					relu_result_2[i][j] = 45'h0fedcba98764;
					relu_result_3[i][j] = 45'h0fedcba98767;
					relu_result_4[i][j] = 45'h0fedcba98763;
					relu_result_5[i][j] = 45'h0fedcba98762;
					relu_result_6[i][j] = 45'h0fedcba98761;
					relu_result_7[i][j] = 45'h0fedcba98760;
					relu_result_8[i][j] = 45'h0fedcba98765;
				end
			end
		end
	endtask	
	
	task display_pool_inputs;
		begin
			$display("-----------------------------POOL Inputs--------------------------");
			for (i = 0; i < `RELU_X; i++) begin
				$display("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
									relu_result_1[i][23],relu_result_1[i][22],relu_result_1[i][21],relu_result_1[i][20],
									relu_result_1[i][19],relu_result_1[i][18],relu_result_1[i][17],relu_result_1[i][16],
									relu_result_1[i][15],relu_result_1[i][14],relu_result_1[i][13],relu_result_1[i][12],
									relu_result_1[i][11],relu_result_1[i][10],relu_result_1[i][9],relu_result_1[i][8],
									relu_result_1[i][7],relu_result_1[i][6],relu_result_1[i][5],relu_result_1[i][4],
									relu_result_1[i][3],relu_result_1[i][2],relu_result_1[i][1],relu_result_1[i][0]);
			end
		end
	endtask
	
	task display_pool_outputs;
		begin
			$display("-----------------------------POOL Outputs--------------------------");
			for (i = 0; i < `POOL_X; i++) begin
				$display("%d %d %d %d %d %d %d %d %d %d %d %d", 
									pool_result_1[i][11],pool_result_1[i][10],pool_result_1[i][9],pool_result_1[i][8],
									pool_result_1[i][7],pool_result_1[i][6],pool_result_1[i][5],pool_result_1[i][4],
									pool_result_1[i][3],pool_result_1[i][2],pool_result_1[i][1],pool_result_1[i][0]);
			end
			$display("Pool_done: %b", pool_done);
		end
	endtask
	
	initial begin 
		clk = 1'b0;
		pool_enable = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		pool_enable = 1'b1;
		initial_pool_inputs();
		display_pool_inputs();
		$display("Pool_done: %b", pool_done);
		@(negedge clk);
		display_pool_outputs();
		$finish;
	end
	
endmodule
