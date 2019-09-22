module simpleCNN_tb ();

	reg clk;
	reg rst;
	wire [7:0] imageArray [0:783];

	simpleCNN DUT(
		.clk(clk),
		.rst(rst),
		.imageArray(imageArray)
	);

	integer i;

	always begin
		#5;
		clk = ~clk;
	end

	task display_data;
		$display("------------display data-------------");
		for (i = 0; i < 28; i++) begin
			$display("%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b", 
					imageArray[0+i], imageArray[1+i], imageArray[2+i],imageArray[3+i], imageArray[4+i], imageArray[5+i],imageArray[6+i],
					imageArray[7+i], imageArray[8+i], imageArray[9+i],imageArray[10+i], imageArray[11+i], imageArray[12+i],imageArray[13+i],
					imageArray[14+i], imageArray[15+i], imageArray[16+i],imageArray[17+i], imageArray[18+i], imageArray[19+i],imageArray[20+i],
					imageArray[21+i], imageArray[22+i], imageArray[23+i],imageArray[24+i], imageArray[25+i], imageArray[26+i],imageArray[27+i]);
		end
	endtask 

	initial begin
		clk = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		@(negedge clk);
		rst = 1'b0;
		@(negedge clk);
		display_data();
		$finish;
	end

endmodule