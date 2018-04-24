// Transfer Response Testbench

`timescale 1ns / 10ps

module tb_transfer_response();
	
	// Define parameters
  localparam	CLK_PERIOD = 5.0;
  
  // Module Signals
  reg tb_HCLK;
  reg tb_HRESETn;
  reg tb_enable;
  reg tb_ready;
  reg tb_error;
  reg tb_HREADY;
  reg tb_HRESP;

	// Test bench signals
  real tb_test_num;
  string tb_test_case;

  // Clock generation block (300 MHz)
  always
  begin
    tb_HCLK = 1'b0;
    #(CLK_PERIOD/3.0);
    tb_HCLK = 1'b1;
    #(CLK_PERIOD/3.0);
  end
  
  transfer_response DUT(
    .HCLK(tb_HCLK),
    .HRESETn(tb_HRESETn),
    .enable(tb_enable),
    .ready(tb_ready),
    .error(tb_error),
    .HREADY(tb_HREADY),
    .HRESP(tb_HRESP)
  );
  
   // Test bench process
  initial
  begin
    // Initialize all of the test inputs
    tb_HRESETn	= 1'b1;		// Initialize to high (reset)
    tb_enable		= 1'b1;		// Enable initially
    tb_ready		= 1'b0;		// Not ready initially
    tb_error		= 1'b0; 	// No error initially

    tb_test_num = 0;
    tb_test_case = "Test bench initializaton";
   	$display("%s: Case %1d", tb_test_case, tb_test_num);
    @(posedge tb_HCLK)


		// Test Case 1 - Initial Reset
		tb_test_num += 1;
		tb_test_case = 	"Initial Reset";

		tb_HRESETn = 1'b0;

		@(posedge tb_HCLK)
		
		if (tb_HREADY == 1'b0 && tb_HRESP == 1'b0) begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
    
    
    // Test Case 2 - Transfer High
    tb_test_num += 1;
		tb_test_case = 	"Transfer High";

		tb_ready = 1'b1;
		
		@(posedge tb_HCLK)
		@(posedge tb_HCLK)
		
		if (tb_HREADY == 1'b1 && tb_HRESP == 1'b0) begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
    
    
    // Test Case 3 - Error Signal (1/2)
    tb_test_num += 1;
		tb_test_case = 	"Error Signal (1/2)";

		tb_error = 1'b1;
		
		@(posedge tb_HCLK)
		@(posedge tb_HCLK)
		
		if (tb_HREADY == 1'b0 && tb_HRESP == 1'b1) begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
	
		// Test Case 4 - Error Signal (2/2)
    tb_test_num += 1;
		tb_test_case = 	"Error Signal (2/2)";

		@(posedge tb_HCLK)
		
		if (tb_HREADY == 1'b1 && tb_HRESP == 1'b1) begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
    
    // Test Case 5 - Error Signal Persists
    tb_test_num += 1;
		tb_test_case = 	"Error Signal Persists";

		@(posedge tb_HCLK)
		
		if (tb_HREADY == 1'b0 && tb_HRESP == 1'b1) begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
    
    // Test Case 6 - Disable Chip
    tb_test_num += 1;
		tb_test_case = 	"Disable Chip";
		
		tb_enable = 1'b0;

		@(posedge tb_HCLK)
		@(posedge tb_HCLK)
		
		if (tb_HREADY == 1'b0 && tb_HRESP == 1'b0) begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end
    
	
  end
endmodule
