// Based on the module programmed in lab.

module flex_counter
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [7:0] rollover_val,
	output wire [7:0] count_out
);

	reg [7:0] cur_count = 0; // Temporary count.
	reg [7:0] nxt_count = 0; // Next count.

	always_ff @ (posedge clk, negedge n_rst)
	begin : FF_LOGIC
		if(n_rst == 1'b0)
			cur_count <= 0;
		else
			cur_count <= nxt_count;
	end

	always_comb
	begin : NXT_LOGIC
		// Default values.
		nxt_count = count_out;
		
		if(clear == 1'b1) // Clear the count.
			nxt_count = 0;
		else if(count_enable == 1'b1) // Increment the count.
			nxt_count = count_out + 1;
	end

	// Assign output.
	assign count_out = cur_count;

endmodule
