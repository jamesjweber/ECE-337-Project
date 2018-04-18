module ahb_lite_master_interface (
  input wire HCLK,
	input wire HRESETn,
  input wire HREADY,
  input wire HRESP,
  input wire [127:0] HRDATA,
  input wire [127:0] destination,
  input wire [127:0] encr_text,
  output reg [31:0] HADDR,
  output wire HWRITE,
  output wire [2:0] HSIZE,
  output wire [2:0] HBURST,
  output wire [1:0] HTRANS,
  output reg [127:0] HWDATA
);

endmodule // ahb_lite_master_interface
