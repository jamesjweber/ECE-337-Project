module size_control (
	input wire ENABLE,
	input wire [127:0] HWDATA,
	input wire [2:0] HSIZE,
	output wire [127:0] SWDATA
	output wire ERROR
);

if (ENABLE == 1'b1) begin

	ERROR = 1'b0;

	if (HSIZE == 3'b000) begin // Byte
		SWDATA = 120'b0 + HWDATA[7:0];
	end else if (HSIZE == 3'b001) begin // Halfword
		SWDATA = 112'b0 + HWDATA[15:0];
	end else if (HSIZE == 3'b010) begin // Word
		SWDATA = 96'b0 + HWDATA[31:0];
	end else if (HSIZE == 3'b011) begin // Doubleword
		SWDATA = 64'b0 + HWDATA[63:0];
	end else if (HSIZE == 3'b100) // 4-Word
		SWDATA = HWDATA;
	end else // If greater than 4-word, send error signal
		ERROR = 1'b1;
	end

end else begin
	SWDATA = 128'b0;
end

endmodule // size_control
