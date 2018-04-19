module ahb_lite_slave_interface (
	input wire HCLK,
	input wire HRESETn,
	input wire HSELx,
	input wire [31:0] HADDR,
	input wire HWRITE,
	input wire [2:0] HSIZE,
	input wire [2:0] HBURST,
	input wire [1:0] HTRANS,
	input wire HREADY,
	input wire [128:0] HWDATA,
	input wire fifo_full,
	output reg HREADYOUT,
	output reg HRESP,
	output reg [128:0] HRDATA,
	output reg [128:0] key,
	output reg [128:0] nonce,
	output reg [128:0] destination,
	output reg [128:0] plain_text
);

// Internal Signals
wire [127:0] SWDATA;
wire size_control_error;
wire read_error;
wire read_ready;
wire write_error;
wire write_ready;
wire error;
wire ready;

// Combining Signals
assign error = size_control_error || read_error || write_error; // and future error signals
assign ready = read_ready && write_ready; // and future response signals

// Internal Blocks
transfer_response TR(HCLK, HRESETn, HSELx, ready, error, HREADY, HRESP);
size_control SC(HCLK, HRESETn, HSLEx, HWDATA, HSIZE, SWDATA, size_control_error);
slave_read SR(HCLK, HRESETn, HSLEx, HADDR, HBURST, HTRANS, HREADY, fifo_full, SWDATA, key, nonce, destination, plain_text, write_error, write_ready);
slave_write SW(HCLK, HRESETn, HSLEx, HADDR, HBURST, HTRANS, HREADY, fifo_full, SWDATA, key, nonce, destination, plain_text, write_error, write_ready);

endmodule // ahb_lite_slave_interface
