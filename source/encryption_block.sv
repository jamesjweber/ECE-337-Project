module encryption_block
(
	input wire clk,
	input wire rst,
	input wire keyLock, //signal to hold keys
	input wire fsmGo, //signal to start encryption from FSM
	input wire [2:0] keySelect, //S-box select for round keys
	input wire [2:0] encSelect, //S-box select for encryption
	input wire [4:0] count,
	input wire [127:0] keyIn,
	input wire [127:0] nonceIn,
	input wire [127:0] pText,
	output wire done, //tells AHB master to prepare for output
	output wire [127:0] encText
);
wire [127:0] nrKey;
wire [127:0] frKey;
wire [127:0] lMixOut;
wire [127:0] sBoxOut;
wire [127:0] nkeyMixOut;
wire [127:0] roundStartOut;
	wire [127:0] prbs; //pseudo-random byte stream

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

enc_sub sb(
	.sel(encSelect),
	.inData(nkeyMixOut),
	.outData(sBoxOut)
);

	linear_mix lm( //A-D corresponded to newA-newD. See serpent linear mixing diagram. 
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
	.dataOut(encText)
);
endmodule
