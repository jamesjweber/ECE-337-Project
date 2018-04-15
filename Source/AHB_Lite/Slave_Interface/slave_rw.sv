module slave_rw (
  input wire HCLK,
  input wire HRESETn,
  input wire [31:0] HADDR,
  input wire HWRITE,
	input wire [2:0] HBURST,
	input wire [1:0] HTRANS,
	input wire HREADY,
  input wire fifoFull,
	input wire [128:0] SWDATA,
	output reg [128:0] HRDATA,
  output reg [128:0] key,
	output reg [128:0] nonce,
	output reg [128:0] destination,
	output reg [128:0] plainText,
  output reg readWriteError,
	output reg readWriteReady
);

if (HREADY == 1'b1) begin // must be ready
  if (HWRITE == 1'b1) begin
    // write
  end else begin
    // read
  end
end

endmodule // read_write
