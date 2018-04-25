// 337 TA Provided Lab 2 Testbench
// This code serves as a starer test bench for the synchronizer design
// STUDENT: Replace this message and the above header section with an
// appropriate header based on your other code files

// 0.5um D-FlipFlop Timing Data Estimates:
// Data Propagation delay (clk->Q): 670ps
// Setup time for data relative to clock: 190ps
// Hold time for data relative to clock: 10ps

`timescale 1ns / 10ps

module tb_key_block();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 5;
	//localparam	FF_SETUP_TIME	= 0.190;
	//localparam	FF_HOLD_TIME	= 0.100;
	//localparam	CHECK_DELAY 	= (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts
	
	//localparam	RESET_OUTPUT_VALUE	= 1'b1;
	
	// Declare DUT portmap signals
	reg tb_clk;
	reg tb_rst;
	reg [3:0] tb_select;
	reg [127:0] tb_in;
	reg [127:0] tb_roundKey;
	reg [127:0] tb_froundKey;
	
	// Declare test bench signals
	//integer tb_test_num;
	//string tb_test_case;
	//integer tb_stream_test_num;
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/3.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/3.0);
	end
	
	// DUT Port map
	key_block DUT(.clk(tb_clk), .rst(tb_rst), .select(tb_select), .in(tb_in), .roundKey(tb_roundKey), .froundKey(tb_froundKey));
	// Test bench main process
	initial
	begin
		tb_rst = 1'b1;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_in = 127'b0;
		tb_select = 6'b011;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_rst = 1'b0;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1; 	
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;
		@(posedge tb_clk);		
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		tb_select = tb_select + 1;


	end
	



endmodule
