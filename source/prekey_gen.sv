module key_mix
{
	input wire [128:0] preKeyIn,
	output wire [31:0] prKey
)
reg [5:0] count;

wire [31:0] nKey;
wire [31:0] hold;

always_comb
begin
	//counter thing
end

assign hold = preKeyIn[31:0] ^ preKeyIn[63:32] ^ preKeyIn[95:64] ^ preKeyIn[127:96] ^ 32'h9e3779b9 ^ count;
assign prKey = {hold[10:0], hold[31:11]}
endmodule
