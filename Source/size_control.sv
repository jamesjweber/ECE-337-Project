module size_control (
	input wire [127:0] HWDATA,
	input wire [2:0] HSIZE,
	output wire [127:0] SWDATA
);

if (HSIZE == 3'b000) begin // Byte
	assign SWDATA = 120'b0 + HWDATA[7:0];
end else if (HSIZE == 3'b001) begin // Halfword
	assign SWDATA = 112'b0 + HWDATA[15:0];
end else if (HSIZE == 3'b010) begin // Word
	assign SWDATA = 96'b0 + HWDATA[31:0];
end else if (HSIZE == 3'b011) begin // Doubleword
	assign SWDATA = 64'b0 + HWDATA[63:0];
end else begin // 4-Word or more
	assign SWDATA = HWDATA;
end

endmodule // size_control
