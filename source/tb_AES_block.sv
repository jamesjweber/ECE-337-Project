// AHB Lite Slave Testbench

`timescale 1ns / 10ps

module tb_AES_block();

// Define parameters
localparam	CLK_PERIOD		= 2.5;
localparam 	AHB_BUS_SIZE 	= 32;

// Shared Test Variables
reg tb_HCLK;
reg tb_HRESETn;
reg tb_slave_HSELx;
reg [AHB_BUS_SIZE - 1:0] tb_slave_HADDR;
reg tb_slave_HWRITE;
reg [2:0] tb_slave_HSIZE;
reg [2:0] tb_slave_HBURST;
reg [1:0] tb_slave_HTRANS;
reg tb_slave_HREADY;
reg [AHB_BUS_SIZE - 1:0] tb_slave_HWDATA;
reg tb_slave_HREADYOUT;
reg tb_slave_HRESP;
reg [AHB_BUS_SIZE - 1:0] tb_slave_HRDATA;

reg tb_master_HSELx;
reg [AHB_BUS_SIZE - 1:0] tb_master_HADDR;
reg tb_master_HWRITE;
reg [2:0] tb_master_HSIZE;
reg [2:0] tb_master_HBURST;
reg [1:0] tb_master_HTRANS;
reg tb_master_HREADY;
reg [AHB_BUS_SIZE - 1:0] tb_master_HWDATA;
reg tb_master_HREADYOUT;
reg tb_master_HRESP;
reg [AHB_BUS_SIZE - 1:0] tb_master_HRDATA;

reg tb_key;
reg tb_nonce;
reg tb_destination;
reg tb_plain_text;
reg tb_write_out;

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

AES_block DUT(
	.clk(tb_HCLK),
	.HRESETn(tb_HRESETn),
	.slave_HSELx(tb_slave_HSELx),
  .slave_HADDR(tb_slave_HADDR),
  .slave_HWRITE(tb_slave_HWRITE),
	.slave_HSIZE(tb_slave_HSIZE),
  .slave_HBURST(tb_slave_HBURST),
  .slave_HTRANS(tb_slave_HTRANS),
	.slave_HREADY(tb_slave_HREADY),
	.slave_HWDATA(tb_slave_HWDATA),
	.slave_HRESP(tb_slave_HRESP),
  .slave_HRDATA(tb_slave_HRDATA),
	.master_HRESP(tb_master_HRESP),
  .master_HRDATA(tb_master_HRDATA),
  .master_HADDR(tb_master_HADDR),
  .master_HWRITE(tb_master_HWRITE),
  .master_HSIZE(tb_master_HSIZE),
  .master_HBURST(tb_master_HBURST),
  .master_HTRANS(tb_master_HTRANS),
  .master_HWDATA(tb_master_HWDATA)
);

// Test bench process
initial
begin
  // Initialize all of the test inputs
  tb_HRESETn 		= 1'b0;		// Initially set high (reset)
  tb_slave_HSELx = 1'b1; 	// Initially selected
  tb_slave_HADDR = 32'b0; 	// Inital address of 0x0'
  tb_slave_HBURST	= 3'b0;		// Single Burst
  tb_slave_HTRANS			= 2'b0;		// Initially IDLE
  tb_slave_HREADY			= 1'b1;		// Initially Ready

  tb_test_num = 0;
  tb_test_case = "Test bench initializaton";
  $display("%s: Case %1d", tb_test_case, tb_test_num);
  @(posedge tb_HCLK)
  @(posedge tb_HCLK)


  // Test Case 1 - Initial Reset (S1)
  tb_test_num += 1;
  tb_test_case = 	"Initial Reset (S1)";

  tb_HRESETn = 1'b1;

  @(posedge tb_HCLK)

  // Test Case 2 - State S2
  tb_test_num += 1;
  tb_test_case = 	"State S2";

  tb_slave_HTRANS = 2'b1;

  @(posedge tb_HCLK)
  // Set HADDR for next test case
  tb_slave_HADDR = 32'h04;
  tb_slave_HTRANS = 2'b10;

  // Test Case 3 - S3, Key 1/4
  tb_test_num += 1;
  tb_test_case = 	"S3, Key 1/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h11111111;
  // For next test case
  tb_slave_HADDR = 32'h08;

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h22222222;
  // For next (next) test case
  tb_slave_HADDR = 32'h0C;

  // Test Case 4 - S3, Key 2/4
  tb_test_num += 1;
  tb_test_case =	"S3, Key 2/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h33333333;
  // For next (next) test case
  tb_slave_HADDR = 32'h10;

  // Test Case 5 - S3, Key 3/4
  tb_test_num += 1;
  tb_test_case =	"S3, Key 3/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h44444444;
  // For next (next) test case
  tb_slave_HADDR = 32'h14;

  // Test Case 6 - S3, Key 4/4
  tb_test_num += 1;
  tb_test_case =	"S3, Key 4/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h12345678;
  // For next (next) test case
  tb_slave_HADDR = 32'h18;

  // Test Case 7 - S3, Nonce 1/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 1/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h23456789;
  // For next (next) test case
  tb_slave_HADDR = 32'h1C;

  // Test Case 8 - S3, Nonce 2/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 2/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h34567890;
  // For next (next) test case
  tb_slave_HADDR = 32'h20;

  // Test Case 9 - S3, Nonce 3/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 3/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h45678900;
  // For next (next) test case
  tb_slave_HADDR = 32'h24;

  // Test Case 10 - S3, Nonce 4/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 4/4";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h10101010;
  // For next (next) test case
  tb_slave_HADDR = 32'h34;

  // Test Case 11 - S3, Dest. Addr.
  tb_test_num += 1;
  tb_test_case =	"S3, Dest. Addr.";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h1;
  // For next (next) test case
  tb_slave_HADDR = 32'h38;

  // Test Case 12 - S3, Plain Text (1/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (1/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h2;
  // For next (next) test case
  tb_slave_HADDR = 32'h3C;

  // Test Case 13 - S3, Plain Text (2/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (2/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h3;
  // For next (next) test case
  tb_slave_HADDR = 32'h40;

  // Test Case 14- S3, Plain Text (3/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (3/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h4;

  // Test Case 15- S3, Plain Text (4/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (4/4)";

  @(posedge tb_HCLK)
  
  // Test Case 12 - S3, Plain Text (1/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (1/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h2;
  // For next (next) test case
  tb_slave_HADDR = 32'h3C;

  // Test Case 13 - S3, Plain Text (2/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (2/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h3;
  // For next (next) test case
  tb_slave_HADDR = 32'h40;

  // Test Case 14- S3, Plain Text (3/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (3/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h4;

  // Test Case 15- S3, Plain Text (4/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (4/4)";

  @(posedge tb_HCLK)
  
  // Test Case 12 - S3, Plain Text (1/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (1/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h2;
  // For next (next) test case
  tb_slave_HADDR = 32'h3C;

  // Test Case 13 - S3, Plain Text (2/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (2/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h3;
  // For next (next) test case
  tb_slave_HADDR = 32'h40;

  // Test Case 14- S3, Plain Text (3/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (3/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h4;

  // Test Case 15- S3, Plain Text (4/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (4/4)";

  @(posedge tb_HCLK)
  
  // Test Case 12 - S3, Plain Text (1/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (1/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h2;
  // For next (next) test case
  tb_slave_HADDR = 32'h3C;

  // Test Case 13 - S3, Plain Text (2/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (2/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h3;
  // For next (next) test case
  tb_slave_HADDR = 32'h40;

  // Test Case 14- S3, Plain Text (3/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (3/4)";

  @(posedge tb_HCLK)
  tb_slave_HWDATA = 32'h4;

  // Test Case 15- S3, Plain Text (4/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (4/4)";

  @(posedge tb_HCLK)
  
  $display("fin");
  
end

endmodule
