module AES_block
(
	//something something AHB input output signals
);

controlled_encryption_block ceb(
	.clk(clk),
	.go(go), //Signal to tell encryptor that the nonce and key are valid. Requires data either already in the FIFO or prior to encryption end, ~40 clocks.
	.keyIn(key),
	.nonceIn(nonce),
	.pText(pText),
	.encText(encText), //output - something something AHB
	.done(done) //output - signal to pull data from the FIFO 
);

fifo_buffer fb(
	.clk(clk),
	.clk (nRst),
	.read(done),
	.write(), //something something AHB
	.dataIn(), //something something AHB
	.dataOut(pText), //something something AHB 
	.empty(), //something something AHB
	.full() //something something AHB
);
