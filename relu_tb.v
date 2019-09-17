`timescale 1ns / 1ps
`define RELU_X 24
`define RELU_Y 24
`define RELU_DATA_WIDTH 45

module relu_tb;
	reg	clk;    	// Clock
	reg	rst;  	// Asynchronous reset active high
	reg	relu_enable;
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_1 [`RELU_X-1:0][`RELU_Y-1:0];		// 24*24, 45-bit each
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_2 [`RELU_X-1:0][`RELU_Y-1:0];
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_3 [`RELU_X-1:0][`RELU_Y-1:0];
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_4 [`RELU_X-1:0][`RELU_Y-1:0];
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_5 [`RELU_X-1:0][`RELU_Y-1:0];
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_6 [`RELU_X-1:0][`RELU_Y-1:0];
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_7 [`RELU_X-1:0][`RELU_Y-1:0];
	reg 	[`RELU_DATA_WIDTH-1:0] conv_result_8 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	[`RELU_DATA_WIDTH-1:0] relu_result_1 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	[`RELU_DATA_WIDTH-1:0] relu_result_2 [`RELU_X-1:0][`RELU_Y-1:0];
	wire	[`RELU_DATA_WIDTH-1:0] relu_result_3 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	[`RELU_DATA_WIDTH-1:0] relu_result_4 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	[`RELU_DATA_WIDTH-1:0] relu_result_5 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	[`RELU_DATA_WIDTH-1:0] relu_result_6 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	[`RELU_DATA_WIDTH-1:0] relu_result_7 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	[`RELU_DATA_WIDTH-1:0] relu_result_8 [`RELU_X-1:0][`RELU_Y-1:0];
	wire 	relu_done;
	
	integer i;
	integer j;
	
	relu_layer DUT(
	.clk(clk),
	.rst(rst),
	.relu_enable(relu_enable),
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
	.relu_done(relu_done)
	);
	
	always begin
		#5;
		clk = ~clk;
	end
	
	task initial_relu_inputs;
		begin
			for (i = 0; i < `RELU_X; i++) begin
				for (j = 0; j < `RELU_Y; j++) begin
					if (i < 12) begin
						conv_result_1[i][j] = 45'h1fedcba98765;
						conv_result_2[i][j] = 45'h1fedcba98764;
						conv_result_3[i][j] = 45'h1fedcba98767;
						conv_result_4[i][j] = 45'h1fedcba98763;
						conv_result_5[i][j] = 45'h1fedcba98762;
						conv_result_6[i][j] = 45'h1fedcba98761;
						conv_result_7[i][j] = 45'h1fedcba98760;
						conv_result_8[i][j] = 45'h1fedcba98765;
					end else begin
						conv_result_1[i][j] = 45'h0fedcba98765;
						conv_result_2[i][j] = 45'h0fedcba98764;
						conv_result_3[i][j] = 45'h0fedcba98767;
						conv_result_4[i][j] = 45'h0fedcba98763;
						conv_result_5[i][j] = 45'h0fedcba98762;
						conv_result_6[i][j] = 45'h0fedcba98761;
						conv_result_7[i][j] = 45'h0fedcba98760;
						conv_result_8[i][j] = 45'h0fedcba98765;
					end
				end
			end
		end
	endtask
	
	task display_relu_inputs;
		begin
			$display("-----------------------------RELU Inputs--------------------------");
			for (i = 0; i < `RELU_X; i++) begin
				$display("Row = %d", i);
				for (j = 0; j < `RELU_Y; j++) begin
					$display("%h", conv_result_5[i][j]);
				end
			end
		end
	endtask
	
	task display_relu_outputs;
		begin
			$display("-----------------------------RELU Outputs--------------------------");
			for (i = 0; i < `RELU_X; i++) begin
				$display("Row = %d", i);
				for (j = 0; j < `RELU_Y; j++) begin
					$display("%h", relu_result_5[i][j]);
				end
			end
			$display("Relu_done: %b", relu_done);
		end
	endtask
	
	initial begin 
		clk = 1'b0;
		relu_enable = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		relu_enable = 1'b1;
		initial_relu_inputs();
		display_relu_inputs();
		@(negedge clk);
		display_relu_outputs();
		$finish;
	end
	
endmodule
