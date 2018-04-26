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

// Internal Signals
wire [31:0] SWDATA;
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
transfer_response TR(.HCLK(HCLK), 
										 .HRESETn(HRESETn), 
										 .enable(HSELx), 
										 .ready(ready), 
										 .error(error), 
										 .HREADY(HREADY), 
										 .HRESP(HRESP)
										 );
size_control SC(.HSELx(HSELx), 
								.HWDATA(HWDATA), 
								.HSIZE(HSIZE), 
								.SWDATA(SWDATA), 
								.ERROR(size_control_error)
								);
slave_write SW(.HCLK(HCLK), 
							 .HRESETn(HRESETn), 
							 .HSELx(HSELx), 
							 .HADDR(HADDR), 
							 .HBURST(HBURST), 
							 .HTRANS(HTRANS), 
							 .HREADY(HREADY), 
							 .fifo_full(fifo_full), 
							 .SWDATA(SWDATA), 
							 .key(key), 
							 .nonce(nonce), 
							 .destination(destination), 
							 .plain_text(plain_text), 
							 .write_error(write_error), 
							 .write_ready(write_ready), 
							 .write_out(write_out)
							 );

endmodule // ahb_lite_slave_interface
