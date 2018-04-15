module ahb_lite_slave_interface (
	input wire HCLK,
	input wire HRESETn,
	input wire HSELx,
	input wire [31:0] HADDR,
	input wire HWRITE,
	input wire [2:0] HSIZE,
	input wire [2:0] HBURST,
	input wire [3:0] HPROT,
	input wire [1:0] HTRANS,
	input wire HREADY,
	input wire [128:0] HWDATA,
	output reg HREADYOUT,
	output reg HRESP,
	output reg [31:0] HRDATA
);

// Internal Signals
output wire [127:0] SWDATA;
output wire sizeControlError;

output wire error;
output wire ready;

// Combining Signals
assign error = sizeControlError; // & future error signals
assign ready = 1'b1; // for right now

// Internal Blocks
transfer_response TR(HCLK, HRESETn, ready, error, HREADY, HRESP);
size_control SC(HWDATA, HSIZE, SWDATA, sizeControlError);

always_ff @ (posedge HCLK, negedge HRESETn) begin
	// Reset stuff
end

endmodule // ahb_lite_slave_interface
