module flex_counter
#(
	parameter NUM_CNT_BITS = 8
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [7:0] rollover_val,
	output wire [7:0] count_out
);

	reg [7:0] cur_count = 0;
	reg [7:0] nxt_count = 0;

	always_ff @ (posedge clk, negedge n_rst)
	begin : FF_LOGIC
		if(n_rst == 1'b0)
			cur_count <= 0;
		else
			cur_count <= nxt_count;
	end

	always_comb
	begin : NXT_LOGIC
		nxt_count = count_out;

		if(clear == 1'b1)
			nxt_count = 0;
		else if(count_enable == 1'b1)
			nxt_count = count_out + 1;
	end

	assign count_out = cur_count;

endmodule
