// Size Control Testbench

`timescale 1ns / 10ps

module tb_size_control();

	// Define parameters
  localparam	CLK_PERIOD		= 5.0;
  localparam 	AHB_BUS_SIZE 	= 32;
  
  reg tb_HCLK;

  reg tb_HSELx;
  reg [AHB_BUS_SIZE - 1:0] tb_HWDATA;
  reg [2:0] tb_HSIZE;
  reg [AHB_BUS_SIZE - 1:0] tb_SWDATA;
  reg tb_ERROR;
  
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
  
  size_control DUT(
    .HSELx(tb_HSELx),
    .HWDATA(tb_HWDATA),
    .HSIZE(tb_HSIZE),
    .SWDATA(tb_SWDATA),
    .ERROR(tb_ERROR)
  );
  
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
    
    // Test Case 1.2 - Sending data [Halfword]
		tb_test_num += 0.1;
		tb_test_case = 		"Sending data [Halfword]";
		
		tb_HSIZE = 3'b001;
		
		@(posedge tb_HCLK)
		
		if (tb_SWDATA == 32'h5678 && tb_ERROR == 1'b0) begin
      $display("%s: Case %1.1f, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1.1f, FAILED!", tb_test_case, tb_test_num);
    end
    
    // Test Case 1.3 - Sending data [Word]
		tb_test_num += 0.1;
		tb_test_case = 		"Sending data [Word]";
		
		tb_HSIZE = 3'b010;
		
		@(posedge tb_HCLK)
		
		if (tb_SWDATA == 32'h12345678 && tb_ERROR == 1'b0) begin
      $display("%s: Case %1.1f, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1.1f, FAILED!", tb_test_case, tb_test_num);
    end
    
    // Test Case 1.4 - Sending data [Doubleword]
		tb_test_num += 0.1;
		tb_test_case = 		"Sending data [Doubleword]";
		
		tb_HSIZE = 3'b011;
		
		@(posedge tb_HCLK)
		
		if (tb_SWDATA == 32'h12345678 && tb_ERROR == 1'b1) begin
      $display("%s: Case %1.1f, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1.1f, FAILED!", tb_test_case, tb_test_num);
    end
    
    // Test Case 2 - Chip Deselect
    tb_test_num = 2;
    tb_test_case = 	"Chip Deselect";
    
    tb_HSELx = 1'b0;
    
    @(posedge tb_HCLK)
		
		if (tb_SWDATA == 32'h0 && tb_ERROR == 1'b0) begin
      $display("%s: Case %1.1f, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1.1f, FAILED!", tb_test_case, tb_test_num);
    end
	
  end
endmodule
