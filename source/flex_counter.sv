// $Id: $
// File name:   flex_counter.sv
// Created:     2/1/2018
// Author:      James Weber
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Flexible Counter

module flex_counter
#(
	parameter NUM_CNT_BITS = 6
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input reg [NUM_CNT_BITS-1:0] rollover_val,
	output reg [NUM_CNT_BITS-1:0] count_out,
	output reg rollover_flag
);
	// Register Declarations
	reg [NUM_CNT_BITS-1:0] next_count_out;
	reg [NUM_CNT_BITS-1:0] r_flag;

	assign count_out = next_count_out;
	assign rollover_flag = r_flag;

	always @ (posedge clk, negedge n_rst) begin
		if (~n_rst) begin
			// if n_rst (active low), then reset registers
			next_count_out <= '0;
			r_flag <= 0;
		end else begin
			if (clear) begin
				// if clear set, then clear count and flag
				next_count_out <= '0;
				r_flag <= 0;
			end else begin
				if (count_enable) begin
					if (rollover_flag) begin
						// if flag is set, reset count and flag
						next_count_out <= 1;
						r_flag <= 0;
					end else begin
						// if flag isn't set increase value of count
						next_count_out <= count_out + 1;
						// if the count hits the rollover value, set flag
						if (next_count_out+1 == rollover_val) begin
							r_flag <= 1;
						end
					end
				end else begin
					r_flag <= rollover_flag; // maintains flag value
				end
			end	
		end
	end

endmodule
