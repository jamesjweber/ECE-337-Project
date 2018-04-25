module key_mix
(
	input wire [127:0] key,
	input wire [127:0] data,
	output wire [127:0] modData
);
assign modData = key ^ data;
endmodule
