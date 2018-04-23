module ahb_lite_master_interface (
  input wire HCLK,
	input wire HRESETn,
  input wire HREADY,
  input wire HRESP,
  input wire [31:0] HRDATA,
  input wire [31:0] destination,
  input wire dest_updated,
  input wire [127:0] encr_text,
  input wire signal_recieved,
  output reg [31:0] HADDR,
  output reg HWRITE,
  output reg [2:0] HSIZE,
  output reg [2:0] HBURST,
  output reg [1:0] HTRANS,
  output reg [31:0] HWDATA
);

master_write MW(HCLK, HRESETn, HREADY, HRESP, HRDATA, destination, dest_updated, encr_text, signal_recieved, HADDR, HWRITE, HSIZE, HBURST, HTRANS, HWDATA);

endmodule // ahb_lite_master_interface
