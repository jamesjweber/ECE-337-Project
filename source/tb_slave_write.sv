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
  

	// Test bench process
  initial
  begin
    // Initialize all of the test inputs
    tb_HSELx		= 1'b1;		// Initialize to high (chip selected)
    tb_HWDATA		= 32'b0;	// Set all data to 0 initially
    tb_HSIZE		= 3'b0;		// Set size to halfword initially

    tb_test_num = 0;
    tb_test_case = "Test bench initializaton";
   	$display("%s: Case %1d", tb_test_case, tb_test_num);
    @(posedge tb_HCLK)


		// Test Case 1 - Send Multiple Sizes (No resets/select changes)
		tb_test_num += 1;
		tb_test_case = 	"Send Multiple Sizes (No resets/select changes)";
		$display("%s: Case %1.1f", tb_test_case, tb_test_num);
		
		tb_HWDATA = 32'h12345678;
		@(posedge tb_HCLK)
		
		// Test Case 1.1 - Sending data [Byte]

		tb_test_num += 0.1;
		tb_test_case = 		"Sending data [Byte]";
		
		tb_HSIZE = 3'b000;
		
		@(posedge tb_HCLK)
		
		if (tb_SWDATA == 32'h78 && tb_ERROR == 1'b0) begin
      $display("%s: Case %1.1f, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1.1f, FAILED!", tb_test_case, tb_test_num);
    end
	
  end
endmodule
