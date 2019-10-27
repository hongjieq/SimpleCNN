module bubble_sort#(
	parameter NUM_VALS = 8,
	parameter SIZE = 8
)(
	input wire clk,
	input wire rst,
	input wire [NUM_VALS*SIZE-1:0] data,
	output reg [NUM_VALS*SIZE-1:0] data_o
);

	integer i;
	integer j;
	reg [NUM_VALS*SIZE-1:0] sorted;
	reg [SIZE-1:0] temp;
	reg [SIZE-1:0] array [1:NUM_VALS];
	
	always @(*) begin
		for (i = 0; i < NUM_VALS; i=i+1) begin
			array[i+1] = data[SIZE*i+:SIZE];
		end
	end

	always @(*) begin
		for (i = NUM_VALS; i > 0; i=i-1) begin
			for (j = 1; j < i; j=j+1) begin
					if (array[j] < array[j+1])begin
						temp = array[j];
						array[j] = array[j+1];
						array[j+1] = temp;
					end
			end
		end
		
		for (i = 0; i < NUM_VALS; i=i+1) begin
			sorted[i*SIZE +: SIZE] = array[i+1];
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_o <= 0;
		end else begin
			data_o <= sorted;
		end
	end

	endmodule
