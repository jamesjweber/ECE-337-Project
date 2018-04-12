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
	input wire HMASTLOCK,
	input wire HREADY,
	input wire [128:0] HWDATA,
	output wire HREADYOUT,
	output wire HRESP,
	output wire [31:0] HRDATA
);

always_ff @ (posedge HCLK, negedge HRESETn) begin
	// Reset stuff
end

endmodule // ahb_lite_slave_interface
