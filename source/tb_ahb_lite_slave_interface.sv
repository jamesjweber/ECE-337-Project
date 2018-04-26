// AHB Lite Slave Testbench

`timescale 1ns / 10ps

module tb_ahb_lite_slave_interface();

// Define parameters
localparam	CLK_PERIOD		= 2.5;
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
