// AHB Lite Master Testbench

`timescale 1ns / 10ps

module tb_ahb_lite_master_interface();

  // Define parameters
  localparam	CLK_PERIOD		= 10.0;
  localparam 	AHB_BUS_SIZE 	= 32;

  // Shared Test Variables
  reg tb_HCLK;
  reg tb_HRESETn;
  reg tb_HREADY;
  reg tb_HRESP;
  reg [AHB_BUS_SIZE - 1:0] tb_HRDATA;
  reg [AHB_BUS_SIZE - 1:0] tb_destination;
  reg tb_dest_updated;
  reg [(4 * AHB_BUS_SIZE) - 1:0] tb_encr_text;
  reg tb_text_rcvd;
  reg [AHB_BUS_SIZE - 1:0] tb_HADDR;
  reg tb_HWRITE;
  reg [2:0] tb_HSIZE;
  reg [2:0] tb_HBURST;
  reg [1:0] tb_HTRANS;
  reg [AHB_BUS_SIZE - 1:0] tb_HWDATA;

  // Test bench signals
  int tb_test_num;
  string tb_test_case;

  // Clock generation block (300 MHz)
  always
  begin
    tb_HCLK = 1'b0;
    #(CLK_PERIOD/2.0);
    tb_HCLK = 1'b1;
    #(CLK_PERIOD/2.0);
  end

  ahb_lite_master_interface DUT(
    .HCLK(tb_HCLK),
    .HRESETn(tb_HRESETn),
    .HREADY(tb_HREADY),
    .HRESP(tb_HRESP),
    .HRDATA(tb_HRDATA),
    .destination(tb_destination),
    .dest_updated(tb_dest_updated),
    .encr_text(tb_encr_text),
    .text_rcvd(tb_text_rcvd),
    .HADDR(tb_HADDR),
    .HWRITE(tb_HWRITE),
    .HSIZE(tb_HSIZE),
    .HBURST(tb_HBURST),
    .HTRANS(tb_HTRANS),
    .HWDATA(tb_HWDATA)
  );

	// Test bench process
  initial
  begin
    // Initialize all of the test inputs
    tb_HRESETn      = 1'b0;		// Initialize to be inactive
    tb_HREADY		    = 1'b1; 	// Initialize to be high (ready)
    tb_HRESP 	      = 1'b0;		// Initialize to be low (no errors)
    tb_HRDATA       = 32'b0;  // No data being read in
    tb_destination  = 32'b0;  // No initial destination
    tb_dest_updated = 1'b0;   // Destination not updated initially
    tb_encr_text    = 128'b0; // Empty text initially
    tb_text_rcvd    = 1'b0;   // No text received initially

    tb_test_num = 0;
    tb_test_case = "Test bench initializaton";
    @(posedge tb_HCLK)
    @(posedge tb_HCLK)

    // Test Case 1 - Initial Reset
    tb_test_num += 1;
    tb_test_case = "Initial Reset";

    tb_HRESETn = 1;	// set reset (active low)
    @(posedge tb_HCLK)

    if (tb_HADDR == '0 && tb_HWRITE == 1'b0) begin
      $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
    end else begin
      $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    end

	// Test Case 2 - Send Destination Address
	tb_test_num += 1;
	tb_test_case = "Send Destination Address";

  tb_destination = 8'h4;
  tb_dest_updated = 1'b1;

	@(posedge tb_HCLK)

  tb_dest_updated = 1'b0;
  
  @(posedge tb_HCLK)

  if (tb_HADDR == 8'h4) begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end
  
	// Test Case 3 - Load and Write Test Data
	tb_test_num += 1;
	tb_test_case = "Load and Write Test Data";
	
	tb_text_rcvd = 1'b1;
	
	@(posedge tb_HCLK)
	
	tb_text_rcvd = 1'b0;
	tb_encr_text = 128'h2A472D4B6150645367566B5970337336; // example encr_text
	
	@(posedge tb_HCLK)
	
	tb_encr_text = 128'h25432A462D4A614E645266556A586E32;
	
	@(posedge tb_HCLK)
	
	tb_encr_text = 128'h7638792F423F4528472B4B6250655368;
	
	@(posedge tb_HCLK)
	
	tb_encr_text = 128'h432646294A404D635166546A576E5A72;
	
	@(posedge tb_HCLK) // 1
	@(posedge tb_HCLK) // 2
	@(posedge tb_HCLK) // 3
	@(posedge tb_HCLK) // 4
	@(posedge tb_HCLK) // 5
	@(posedge tb_HCLK) // 6
	@(posedge tb_HCLK) // 7
	@(posedge tb_HCLK) // 8
	@(posedge tb_HCLK) // 9
	@(posedge tb_HCLK) // 10
	@(posedge tb_HCLK) // 11
	@(posedge tb_HCLK) // 12
	@(posedge tb_HCLK) // 13
	@(posedge tb_HCLK) // 14
	@(posedge tb_HCLK) // 15
	@(posedge tb_HCLK) // 16
  
  @(posedge tb_HCLK)
  
  if (tb_HADDR == 8'h40) begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    $display("HADDR: %h", tb_HADDR);
  end
	
  end
endmodule
