module controlled_encryption_block
(
	input wire clk,
	input wire go,
	input wire [127:0] keyIn,
	input wire [127:0] nonceIn,
	input wire [127:0] pText,
	output wire [127:0] encText,
	output wire done
);

wire rst;
wire keyLock;
wire fsmGo;
logic [2:0] keySelect;
logic [2:0] encSelect;
wire [4:0] round;

serpent_fsm fsm(
	.clk(clk),
	.go(go),
	.sBoxSelect(encSelect),
	.keyBoxSelect(keySelect),
	.done(done),
	.round(round),
	.fsmGo(fsmGo),
	.rst(rst),
	.keyLock(keyLock)
);

encryption_block eb(
	.clk(clk),
	.rst(rst),
	.keyLock(keyLock),
	.fsmGo(fsmGo),
	.count(round),
	.keySelect(keySelect),
	.encSelect(encSelect),
	.keyIn(keyIn),
	.nonceIn(nonceIn),
	.pText(pText), 
	.encText(encText)
);

endmodule
