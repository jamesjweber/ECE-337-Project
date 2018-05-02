module size_control (
	input wire HSELx,
	input wire [31:0] HWDATA,
	input wire [2:0] HSIZE,
	output reg [31:0] SWDATA,
	output reg ERROR
);

// This block simply changes the size of the incoming
// HWDATA depending on HSIZE. It pads with zeros if
// The size is smaller than 32 bits, it raises an error
// if it is larger than 32 bits.
	
always_comb begin

	SWDATA = 32'b0;
	ERROR = 1'b0;
	
	if (HSELx == 1'b1) begin
		if (HSIZE == 3'b000) begin // Byte
			SWDATA = {24'b0,HWDATA[7:0]};
		end else if (HSIZE == 3'b001) begin // Halfword
			SWDATA = {16'b0,HWDATA[15:0]};
		end else if (HSIZE == 3'b010) begin // Word
			SWDATA = HWDATA;
		end else begin // If greater than a Word, send error signal
			SWDATA = HWDATA;
			ERROR = 1'b1;
		end
	end else begin
		SWDATA = 32'b0;
		ERROR = 1'b0;
	end

end

endmodule // size_control
