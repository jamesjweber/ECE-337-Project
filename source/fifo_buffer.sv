module fifo_buffer
(
	input wire clk,
	input wire nRst,
	input wire read,
	input wire write,
	input wire [127:0] dataIn,
	output wire [127:0] dataOut,
	output wire empty,
	output wire full
);

	reg [127:0] out;
	reg [127:0] buffer [7:0];
	reg [2:0] curr_read, next_read;
	reg [2:0] curr_write, next_write;
	reg curr_empty, next_empty, curr_full, next_full;

	// Control state using flip-flop logic.
	always_ff @(posedge clk, negedge nRst)
	begin : FF_LOGIC
		if(nRst == 1'b1)
		begin
			// Reset pointers and flags.
			curr_read <= 3'b000;
			curr_write <= 3'b000;
			curr_empty <= 1'b1;
			curr_full <= 1'b0;
		end
		else
		begin
			// Get new values.
			curr_read <= next_read;
			curr_write <= next_write;
			curr_empty <= next_empty;
			curr_full <= next_full;

			// Read or write new values.
			out <= (read & ~empty) | (read & write) ? buffer[curr_read] : out;
			buffer[curr_write] <= (write & ~full) | (read & write) ? dataIn : buffer[curr_write];
		end

	end

	always_comb
	begin
		// Initialize new pointers.
		next_read = curr_read;
		next_write = curr_write;

		next_empty = curr_empty;
		next_full = curr_full;

		case({write, read})
			2'b01: // Read from the fifo.
				begin
					if(~empty)
					begin
						next_read = curr_read + 1;
						next_full = 1'b0;
						next_empty = curr_read + 1 == curr_write ? 1'b1 : next_empty;
					end
				end
			2'b10: // Write to the fifo.
				begin
					if(~full)
					begin
						next_write = curr_write + 1;
						next_empty = 1'b0;
						next_full = curr_write + 1 == curr_read ? 1'b1 : next_full;
					end
				end
			2'b11: // Read and write simultaneously.
				begin
					next_read = curr_read + 1;
					next_write = curr_write + 1;
				end
		endcase
	end

	// Assign flags and data.
	assign empty = curr_empty;
	assign full = curr_full;
	assign dataOut = out;

endmodule
