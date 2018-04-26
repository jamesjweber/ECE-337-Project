module encryption_block
(
	input wire clk,
	input wire rst,
	input wire keyLock,
	input wire fsmGo,
	input wire [2:0] keySelect,
	input wire [2:0] encSelect,
	input wire [4:0] count,
	input wire [127:0] keyIn,
	input wire [127:0] nonceIn,
	input wire [127:0] pText,
	output wire done,
	output wire [127:0] encText
);
wire [127:0] nrKey;
wire [127:0] frKey;
wire [127:0] lMixOut;
wire [127:0] sBoxOut;
wire [127:0] nkeyMixOut;
wire [127:0] roundStartOut;
wire [127:0] prbs;

round_start rs(
	.clk(clk),
	.rst(rst),
	.go(fsmGo),
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
	.A(sBoxOut[127:96]),
	.B(sBoxOut[95:64]),
	.C(sBoxOut[63:32]),
	.D(sBoxOut[31:0]),
	.newA(lMixOut[127:96]),
	.newB(lMixOut[95:64]),
	.newC(lMixOut[63:32]),
	.newD(lMixOut[31:0])
);

key_mix nkm(
	.key(nrKey),
	.data(roundStartOut),
	.modData(nkeyMixOut)
);

key_mix fkm(
	.key(frKey),
	.data(sBoxOut),
	.modData(prbs)
);

encryption_end ee(
	.clk(clk),
	.pText(pText),
	.prbs(prbs),
	.count(count),
	.done(done),
	.dataOut(encText)
);
endmodule
