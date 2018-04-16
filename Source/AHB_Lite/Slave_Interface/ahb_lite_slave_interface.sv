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
wire [127:0] SWDATA;
wire sizeControlError;
wire readWriteError;
wire readWriteReady;

wire enable;
wire error;
wire ready;

reg [31:0] prevAddress;

// Combining Signals
assign enable = HSELx && HREADY;
assign error = sizeControlError || readWriteError; // and future error signals
assign ready = readWriteReady; // and future response signals

// Internal Blocks
transfer_response TR(HCLK, HRESETn, HSELx, ready, error, HREADY, HRESP);
size_control SC(HSLEx, HWDATA, HSIZE, SWDATA, sizeControlError);

always_ff @ (negedge HCLK, negedge HRESETn) begin
	if (HRESETn == 1'b1) begin
		prevAddress <= 32'b0;
	end else begin
		prevAddress <= HADDR;
	end
end

endmodule // ahb_lite_slave_interface
