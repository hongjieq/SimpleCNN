module simpleCNN (
	input clk,    // Clock
	input rst,  // Asynchronous reset active high
	reg [7:0] imageArray [0:783]
);

	initial $readmemb("test1.txt", imageArray, 0, 783); //reading image

endmodule