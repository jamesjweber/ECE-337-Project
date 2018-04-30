// AHB Lite Slave Testbench

`timescale 1ns / 10ps

module tb_ahb_lite_slave_interface();

// Define parameters
localparam	CLK_PERIOD		= 5.0;
localparam 	AHB_BUS_SIZE 	= 32;

// Shared Test Variables
reg tb_HCLK;
reg tb_HRESETn;
reg tb_HSELx;
reg [AHB_BUS_SIZE - 1:0] tb_HADDR;
reg tb_HWRITE;
reg [2:0] tb_HSIZE;
reg [2:0] tb_HBURST;
reg [1:0] tb_HTRANS;
reg tb_HREADY;
reg [AHB_BUS_SIZE - 1:0] tb_HWDATA;
reg tb_fifo_full;
reg tb_HREADYOUT;
reg tb_HRESP;
reg [31:0] tb_HRDATA;
reg [127:0] tb_key;
reg [127:0] tb_nonce;
reg [31:0] tb_destination;
reg [127:0] tb_plain_text;
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

ahb_lite_slave_interface DUT(
	.HCLK(tb_HCLK),
	.HRESETn(tb_HRESETn),
	.HSELx(tb_HSELx),
  .HADDR(tb_HADDR),
  .HWRITE(tb_HWRITE),
	.HSIZE(tb_HSIZE),
  .HBURST(tb_HBURST),
  .HTRANS(tb_HTRANS),
	.HREADY(tb_HREADY),
  .HWDATA(tb_HWDATA),
	.fifo_full(tb_fifo_full),
	.HREADYOUT(tb_HREADYOUT),
	.HRESP(tb_HRESP),
	.HRDATA(tb_HRDATA),
	.key(tb_key),
	.nonce(tb_nonce),
	.destination(tb_destination),
	.plain_text(tb_plain_text),
	.write_out(tb_write_out)
);

// Test bench process
initial
begin
  // Initialize all of the test inputs
  tb_HRESETn 		= 1'b0;		// Initially set high (reset)
  tb_HSELx			= 1'b1; 	// Initially selected
  tb_HADDR			= 32'b0; 	// Inital address of 0x0'
  tb_HBURST			= 3'b0;		// Single Burst
  tb_HTRANS			= 2'b0;		// Initially IDLE
  tb_HREADY			= 1'b1;		// Initially Ready
  tb_fifo_full	= 1'b0;		// FIFO not full
  tb_HWDATA			=	32'b0;	// Empty data initially
  tb_HSIZE			= 3'b10;	// Size is word

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

  if (tb_key == 128'b0 &&
      tb_nonce == 128'b0 &&
      tb_destination == 32'b0 &&
      tb_plain_text == 128'b0)
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

  if (tb_key == 128'b0 &&
      tb_nonce == 128'b0 &&
      tb_destination == 32'b0 &&
      tb_plain_text == 128'b0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
    $display("\ttb_key: %h",tb_key);
    $display("\ttb_nonce: %h",tb_nonce);
    $display("\ttb_destination: %h",tb_destination);
    $display("\ttb_plain_text: %h",tb_plain_text);
  end

  // Test Case 3 - S3, Key 1/4
  tb_test_num += 1;
  tb_test_case = 	"S3, Key 1/4";



  @(posedge tb_HCLK)
  tb_HWDATA = 32'h11111111;
  // For next test case
  tb_HADDR = 32'h08;


  @(posedge tb_HCLK)
  tb_HWDATA = 32'h22222222;
  // For next (next) test case
  tb_HADDR = 32'h0C;

  if (tb_key == 128'h11111111 &&
      tb_nonce == 128'b0 &&
      tb_destination == 32'b0 &&
      tb_plain_text == 128'b0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 4 - S3, Key 2/4
  tb_test_num += 1;
  tb_test_case =	"S3, Key 2/4";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h33333333;
  // For next (next) test case
  tb_HADDR = 32'h10;

  if (tb_key == 128'h2222222211111111 &&
      tb_nonce == 128'b0 &&
      tb_destination == 32'b0 &&
      tb_plain_text == 128'b0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end


  // Test Case 5 - S3, Key 3/4
  tb_test_num += 1;
  tb_test_case =	"S3, Key 3/4";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h44444444;
  // For next (next) test case
  tb_HADDR = 32'h14;

  if (tb_key == 128'h333333332222222211111111 &&
      tb_nonce == 128'b0 &&
      tb_destination == 32'b0 &&
      tb_plain_text == 128'b0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 6 - S3, Key 4/4
  tb_test_num += 1;
  tb_test_case =	"S3, Key 4/4";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h12345678;
  // For next (next) test case
  tb_HADDR = 32'h18;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'b0 &&
      tb_destination == 32'b0 &&
      tb_plain_text == 128'b0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end


  // Test Case 7 - S3, Nonce 1/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 1/4";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h23456789;
  // For next (next) test case
  tb_HADDR = 32'h1C;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h12345678 &&
      tb_destination == 32'h0 &&
      tb_plain_text == 128'h0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end


  // Test Case 8 - S3, Nonce 2/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 2/4";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h34567890;
  // For next (next) test case
  tb_HADDR = 32'h20;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h2345678912345678 &&
      tb_destination == 32'h0 &&
      tb_plain_text == 128'h0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end


  // Test Case 9 - S3, Nonce 3/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 3/4";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h45678900;
  // For next (next) test case
  tb_HADDR = 32'h24;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h345678902345678912345678 &&
      tb_destination == 32'h0 &&
      tb_plain_text == 128'h0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end


  // Test Case 10 - S3, Nonce 4/4
  tb_test_num += 1;
  tb_test_case =	"S3, Nonce 4/4";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h10101010;
  // For next (next) test case
  tb_HADDR = 32'h34;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h45678900345678902345678912345678 &&
      tb_destination == 32'h0 &&
      tb_plain_text == 128'h0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 11 - S3, Dest. Addr.
  tb_test_num += 1;
  tb_test_case =	"S3, Dest. Addr.";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h1;
  // For next (next) test case
  tb_HADDR = 32'h38;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h45678900345678902345678912345678 &&
      tb_destination == 32'h10101010 &&
      tb_plain_text == 128'h0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 12 - S3, Plain Text (1/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (1/4)";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h2;
  // For next (next) test case
  tb_HADDR = 32'h3C;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h45678900345678902345678912345678 &&
      tb_destination == 32'h10101010 &&
      tb_plain_text == 128'h1)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 13 - S3, Plain Text (2/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (2/4)";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h3;
  // For next (next) test case
  tb_HADDR = 32'h40;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h45678900345678902345678912345678 &&
      tb_destination == 32'h10101010 &&
      tb_plain_text == 128'h200000001)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 14- S3, Plain Text (3/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (3/4)";

  @(posedge tb_HCLK)
  tb_HWDATA = 32'h4;

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h45678900345678902345678912345678 &&
      tb_destination == 32'h10101010 &&
      tb_plain_text == 128'h30000000200000001)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 15- S3, Plain Text (4/4)
  tb_test_num += 1;
  tb_test_case =	"Plain Text (4/4)";

  @(posedge tb_HCLK)

  if (tb_key == 128'h44444444333333332222222211111111 &&
      tb_nonce == 128'h45678900345678902345678912345678 &&
      tb_destination == 32'h10101010 &&
      tb_plain_text == 128'h4000000030000000200000001)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end

  // Test Case 16 - Final Reset
  tb_test_num += 1;
  tb_test_case =	"Final Reset";

  tb_HRESETn = 1'b1;
  @(posedge tb_HCLK)
  tb_HRESETn = 1'b0;
  @(posedge tb_HCLK)

  if (tb_key == 128'h0 &&
      tb_nonce == 128'h0 &&
      tb_destination == 32'h0 &&
      tb_plain_text == 128'h0)
  begin
    $display("%s: Case %1d, PASSED!", tb_test_case, tb_test_num);
  end else begin
    $display("%s: Case %1d, FAILED!", tb_test_case, tb_test_num);
  end


end

endmodule
