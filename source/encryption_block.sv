module encryption_block
(
	input wire clk,
	input wire rst,
	input wire keyLock,
	input wire [2:0] select,
	input wire [127:0] in,
	output wire [127:0] roundKey,
	output wire [127:0] froundKey
);

key_block
(
	.clk(),
	.rst(),
	.keyLock(),
	.select(),
	.in(),
	.roundKey(),
	.froundKey()
);

s_box
(
	.sel(),
	.inData(),
	.outData()
);

linear_mix
(
	.A(),
	.B(),
	.C(),
	.D(),
	.newA(),
	.newB(),
	.newC(),
	.newD()
);

key_mix
(
	.key(),
	.data(),
	.modData()
);