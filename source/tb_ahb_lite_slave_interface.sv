// AHB Lite Slave Testbench

`timescale 1ns / 10ps

module tb_ahb_lite_slave_interface();

// Define parameters
localparam	CLK_PERIOD		= 2.5;
localparam 	AHB_BUS_SIZE 	= 32;

// Shared Test Variables
reg tb_HCLK;
reg tb_HRESETn;
reg tb_HSELx;
reg [AHB_BUS_SIZE - 1:0] tb_HADDR;
reg tb_HWRITE;
reg [2:0] tb_HSIZE;
reg [2:0] tb_HBURST;
reg 

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
	input wire [2:0] HSIZE,
	input wire [2:0] HBURST,
	input wire [1:0] HTRANS,
	input wire HREADY,
	input wire [31:0] HWDATA,
	input wire fifo_full,
	output reg HREADYOUT,
	output reg HRESP,
	output reg [31:0] HRDATA,
	output reg [127:0] key,
	output reg [127:0] nonce,
	output reg [31:0] destination,
	output reg [127:0] plain_text,
	output reg write_out
);

ahb_lite_slave_interface DUT(
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

endmodule
