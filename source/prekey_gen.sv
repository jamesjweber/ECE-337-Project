module prekey_gen
{
	input wire clk,
	input wire rst,
	input wire [128:0] preKeyIn,
	output wire [31:0] prKey
);
reg [5:0] count;

wire [31:0] nKey;
wire [31:0] hold;

flex_counter a(.clk(clk), .clear(rst), .count_enable(clk), .rollover_val(6'd32), .count_out(count));

assign hold = preKeyIn[31:0] ^ preKeyIn[63:32] ^ preKeyIn[95:64] ^ preKeyIn[127:96] ^ 32'h9e3779b9 ^ count;
assign prKey = {hold[10:0], hold[31:11]}
endmodule
