module encryption_block
(
	input wire clk,
	input wire rst,
	input wire keyLock,
	input wire [2:0] keySelect,
	input wire [2:0] encSelect,
	input wire [127:0] keyIn,
	input wire [127:0] nonceIn
);
wire [127:0] nrKey;
wire [127:0] frKey;
wire [127:0] lMixOut;
wire [127:0] sBoxOut;
wire [127:0] nkeyMixOut;
wire [127:0] fkeyMixOut;
wire [127:0] roundStartOut;

round_start rs(
	.clk(clk),
	.rst(rst),
	.freshData(nonceIn),
	.priorRound(lMixOut),
	.dataOut(roundStartOut)
);

key_block kb(
	.clk(clk),
	.rst(rst),
	.keyLock(keyLock),
	.select(keySelect),
	.in(keyIn),
	.roundKey(nrKey),
	.froundKey(frKey)
);

s_box sb(
	.sel(encSelect),
	.inData(nkeyMixOut),
	.outData(sBoxOut)
);

linear_mix lm(
	.A(),
	.B(),
	.C(),
	.D(),
	.newA(),
	.newB(),
	.newC(),
	.newD()
);

key_mix nkm(
	.key(nrKey),
	.data(),
	.modData()
);

key_mix fkm(
	.key(frKey),
	.data(),
	.modData()
);

