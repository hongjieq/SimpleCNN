//#####Bubble sort testbench#####/
//https://github.com/tejas4812/bubble_sort
//data is the unsorted input array
//data_sort_o is the sorted output array

`timescale 1ns/1ps
module bubble_sort_tb();
  reg clk,rst;
  reg [63:0] data;
  wire [63:0] data_o;
  
bubble_sort #(.NUM_VALS(8), .SIZE(8)) DUT(
    .clk(clk),
    .rst(rst),
    .data(data),//64 bit
    .data_o(data_o)//O //64 bits
  );


always #5 clk=~clk;

  initial begin
    clk=0;rst=1;
    #10
    @(posedge clk);
    rst=0;
    @(posedge clk);
    data={8'd25, 8'd10, 8'd40, 8'd45,8'd60,8'd20,8'd3,8'd200};
    @(posedge clk);
    @(posedge clk);
    
    //wait(!done);
    // $display("@@@Time:%4.0f data:%d data sort:%d", $time, data_o, data_sort_o);
   // wait(done);
    
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[7:0]);
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[15:8]);
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[23:16]);
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[31:24]);
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[39:32]);
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[47:40]);
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[55:48]);
		$display("@@@Time:%4.0f data sort:%d", $time, data_o[63:55]);
    $finish;    
  end



endmodule


