module key_block
(
	input wire clk,
	input wire rst,
	input wire keyLock,
	input wire [2:0] select,
	input wire [127:0] in,
	output wire [127:0] roundKey,
	output wire [127:0] froundKey
);

wire [31:0] generatorToStorage_con;
wire [127:0] storageToGenerator_con;
wire [127:0] storageToNS_box;
wire [127:0] storageToFS_box;
wire [127:0] fSboxToStorage;
wire [127:0] nSboxToStorage;
wire [2:0] fselect;

assign fselect = select - 1;

key_storage ksn(.clk(clk),.keyLock(keyLock), .in(nSboxToStorage),.roundKey(roundKey));
key_storage ksf(.clk(clk),.keyLock(keyLock), .in(fSboxToStorage),.roundKey(froundKey));
s_box fsbox(.inData(storageToFS_box),.outData(fSboxToStorage), .sel(fselect));
s_box nsbox(.inData(storageToNS_box),.outData(nSboxToStorage), .sel(select));
prekey_gen pg
(
	.clk(clk),
	.rst(rst),
	.preKeyIn(storageToGenerator_con),
	.prKey(generatorToStorage_con)
);

prekey_storage ps
(
	.clk(clk),
	.rst(rst),
	.keyIn(in),
	.in(generatorToStorage_con),
	.gen_preKeys(storageToGenerator_con),
	.pre_roundKeys(storageToNS_box),
	.pre_froundKeys(storageToFS_box)
);


endmodule
