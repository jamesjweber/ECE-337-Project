// key_storage
// Sources: http://www.asic-world.com/examples/verilog/syn_fifo.html

module key_storage
(

	input wire clk,
	input wire nRst,
	input wire rEnable,
	input wire wEnable,
	input wire [DATA_WIDTH-1:0] wData,
	output wire [DATA_WIDTH-1:0] rData,
	output wire empty,
	output wire full
)

fifo FIFO_BLOCK
(
	.r_clk(clk),
	.w_clk(clk),
	.n_rst(n_rst),
	.r_enable(r_enable),
	.w_enable(w_enable),
	.w_data(w_data),
	.r_data(r_data),
	.empty(empty),
	.full(full)
);

endmodule
