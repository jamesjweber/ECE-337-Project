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
  
  /*
  input wire HCLK,
  input wire HRESETn,
  input wire HSELx,
  input wire [31:0] HADDR,
	input wire [2:0] HBURST,
	input wire [1:0] HTRANS,
  input wire HREADY,
  input wire fifo_full,
	input wire [31:0] SWDATA,
  output reg [127:0] key,
	output reg [127:0] nonce,
	output reg [31:0] destination,
	output reg [127:0] plain_text,
  output reg write_out,
  output reg write_error,
	output reg write_ready
  */
