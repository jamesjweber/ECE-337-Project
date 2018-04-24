// Slave Write Testbench

`timescale 1ns / 10ps

module tb_slave_write();
	
	// Define parameters
  localparam	CLK_PERIOD		= 5.0;
  localparam 	AHB_BUS_SIZE 	= 32;
  
  // Slave Write Signals
  reg tb_HCLK;
  reg tb_HRESETn;
  reg tb_HSELx;
  reg [AHB_BUS_SIZE - 1:0] tb_HADDR;
  reg [2:0] tb_HBURST;
  reg [1:0] tb_HTRANS;
  reg tb_HREADY;
  reg tb_fifo_full;
  reg [AHB_BUS_SIZE - 1:0] tb_SWDATA;
  reg [(4 * AHB_BUS_SIZE) - 1:0] tb_key;
  reg [(4 * AHB_BUS_SIZE) - 1:0] tb_nonce;
  reg [AHB_BUS_SIZE - 1:0] tb_destination;
  reg [(4 * AHB_BUS_SIZE) - 1:0] tb_plain_text;
  reg tb_write_out;
  reg tb_write_error;
  reg tb_write_ready;
  
  // Test bench signals
  real tb_test_num;
  string tb_test_case;

  // Clock generation block (300 MHz)
  always
  begin
    tb_HCLK = 1'b0;
    #(CLK_PERIOD/3.0);
    tb_HCLK = 1'b1;
    $display("------------- CLOCK HIGH -----------------");
    #(CLK_PERIOD/3.0);
  end
  
  slave_write DUT(
    .HCLK(tb_HCLK),
    .HRESETn(tb_HRESETn),
    .HSELx(tb_HSELx),
    .HADDR(tb_HADDR),
    .HBURST(tb_HBURST),
    .HTRANS(tb_HTRANS),
    .HREADY(tb_HREADY),
    .fifo_full(tb_fifo_full),
    .SWDATA(tb_SWDATA),
    .key(tb_key),
    .nonce(tb_nonce),
    .destination(tb_destination),
    .plain_text(tb_plain_text),
    .write_out(tb_write_out),
    .write_error(tb_write_error),
    .write_ready(tb_write_ready)
  );

	// Test bench process
  initial
  begin
    // Initialize all of the test inputs
    tb_HRESETn 		= 1'b1;		// Initially set high (reset)
    tb_HSELx			= 1'b1; 	// Initially selected
    tb_HADDR			= 32'b0; 	// Inital address of 0x0'
    tb_HBURST			= 3'b0;		// Single Burst
    tb_HTRANS			= 2'b0;		// Initially IDLE
    tb_HREADY			= 1'b1;		// Initially Ready
    tb_fifo_full	= 1'b0;		// FIFO not full
    tb_SWDATA			=	32'b0;	// Empty data initially		
    
    tb_test_num = 0;
    tb_test_case = "Test bench initializaton";
   	$display("%s: Case %1d", tb_test_case, tb_test_num);
    @(posedge tb_HCLK)


		// Test Case 1 - Initial Reset (S1)
		tb_test_num += 1;
		tb_test_case = 	"Initial Reset (S1)";

		tb_HRESETn = 1'b0;

		@(posedge tb_HCLK)
		
		if (tb_key == 128'b0 && 
				tb_nonce == 128'b0 && 
				tb_destination == 32'b0 && 
				tb_plain_text == 128'b0 && 
				tb_write_out == 1'b0 && 
				tb_write_error == 1'b0 &&
				tb_write_ready == 1'b1) 
		begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
	
		// Test Case 2 - State S2
		tb_test_num += 1;
		tb_test_case = 	"State S2";
		
		tb_HTRANS = 2'b1;

		@(posedge tb_HCLK)
		// Set HADDR for next test case
		tb_HADDR = 32'h04;
		tb_HTRANS = 2'b10;
		@(posedge tb_HCLK)
		
		if (tb_key == 128'b0 && 
				tb_nonce == 128'b0 && 
				tb_destination == 32'b0 && 
				tb_plain_text == 128'b0 && 
				tb_write_out == 1'b0 && 
				tb_write_error == 1'b1 &&
				tb_write_ready == 1'b1) 
		begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
      $display("\ttb_key: %h",tb_key);
      $display("\ttb_nonce: %h",tb_nonce);
      $display("\ttb_destination: %h",tb_destination);
      $display("\ttb_plain_text: %h",tb_plain_text);
      $display("\ttb_write_out: %h",tb_write_out);
      $display("\ttb_write_error: %h",tb_write_error);
      $display("\ttb_write_ready: %h",tb_write_ready);
    end
    
    // Test Case 3 - S3, Key Addr 1/4
    tb_test_num += 1;
		tb_test_case = 	"S3, Key Addr 1/4";
		
		tb_SWDATA = 32'h11111111;
		

		@(posedge tb_HCLK)
		
		if (tb_key == 128'b11111111 && 
				tb_nonce == 128'b0 && 
				tb_destination == 32'b0 && 
				tb_plain_text == 128'b0 && 
				tb_write_out == 1'b0 && 
				tb_write_error == 1'b1 &&
				tb_write_ready == 1'b1) 
		begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
    
	
  end
endmodule
