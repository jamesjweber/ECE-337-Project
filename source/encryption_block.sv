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
	output wire [127:0] outData
);

linear_mix
(
	input wire [31:0] A,
	input wire [31:0] B,
	input wire [31:0] C,
	input wire [31:0] D,
	output wire [31:0] newA,
	output wire [31:0] newB,
	output wire [31:0] newC,
	output wire [31:0] newD
);

key_mix
(
	input wire [127:0] key,
	input wire [127:0] data,
	output wire [127:0] modData
);