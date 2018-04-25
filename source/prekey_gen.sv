module prekey_gen
(
	input wire clk,
	input wire rst,
	input wire [127:0] preKeyIn,
	output wire [31:0] prKey
);
	reg [7:0] count;
	wire [31:0] ct;
	wire [31:0] hold;
	wire [31:0] mid1;
	wire [31:0] mid2;

	flex_counter counter (.clk(clk), .n_rst(~rst), .clear(rst), .count_enable(1'b1), .rollover_val(8'd132), .count_out(count));

	assign ct = {24'b0, count};
	assign hold = preKeyIn[31:0] ^ preKeyIn[63:32] ^ preKeyIn[95:64] ^ preKeyIn[127:96] ^ 32'h9e3779b9 ^ ct;
	assign mid1 = hold << 11;
	assign mid2 = hold >> 21;
	assign prKey = mid1 | mid2;

endmodule
