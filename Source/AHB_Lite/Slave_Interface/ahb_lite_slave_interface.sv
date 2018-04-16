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
	input wire fifoFull,
	output reg HREADYOUT,
	output reg HRESP,
	output reg [128:0] HRDATA
	output reg [128:0] key,
	output reg [128:0] nonce,
	output reg [128:0] destination,
	output reg [128:0] plainText
);

// Internal Signals
output wire [127:0] SWDATA;
output wire sizeControlError;
output wire readWriteError;
output wire readWriteReady;

output wire error;
output wire ready;

// Combining Signals
assign error = sizeControlError || readWriteError; // and future error signals
assign ready = readWriteReady; // and future response signals

// Internal Blocks
transfer_response TR(HCLK, HRESETn, ready, error, HREADY, HRESP);
size_control SC(HWDATA, HSIZE, SWDATA, sizeControlError);

always_ff @ (posedge HCLK, negedge HRESETn) begin
	// Reset stuff
end

endmodule // ahb_lite_slave_interface
