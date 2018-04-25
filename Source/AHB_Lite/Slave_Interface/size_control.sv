module size_control (
	input wire HCLK,
	input wire HRESETn,
	input wire HSELx,
	input wire [127:0] HWDATA,
	input wire [2:0] HSIZE,
	output reg [127:0] SWDATA
	output reg ERROR
);

// Internal Signals
reg next_SWDATA;
reg next_ERROR;

always_ff @ (posedge HCLK, negedge HRESETn) begin
  if (HRESETn == 1'b0 && HSELx == 1'b1) begin // If selected and not being reset
    SWDATA <= next_SWDATA;
		ERROR <= next_ERROR;
  end else begin // Else if being reset and/or not currently selected
		SWDATA <= 128'b0;
		ERROR <= 1'b0;
  end
end

always_comb begin

	next_SWDATA <= SWDATA;
	next_ERROR <= 1'b0;

	if (HSIZE == 3'b000) begin // Byte
		next_SWDATA <= {120'b0,HWDATA[7:0]};
	end else if (HSIZE == 3'b001) begin // Halfword
		next_SWDATA <= {112'b0,HWDATA[15:0]};
	end else if (HSIZE == 3'b010) begin // Word
		next_SWDATA <= {96'b0,HWDATA[31:0]};
	end else if (HSIZE == 3'b011) begin // Doubleword
		next_SWDATA <= {64'b0,HWDATA[63:0]};
	end else if (HSIZE == 3'b100) begin // 4-Word
		next_SWDATA <= HWDATA;
	end else begin // If greater than 4-word, send error signal
		next_SWDATA <= HWDATA;
		next_ERROR <= 1'b1;
	end

end

endmodule // size_control
