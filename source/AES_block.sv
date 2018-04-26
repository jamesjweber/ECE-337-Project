module AES_block
(
	input wire HCLK,
	input wire HRESETn,
	input wire slave_HSELx,
	input wire [31:0] slave_HADDR,
	input wire slave_HWRITE,
	input wire [2:0] slave_HSIZE,
	input wire [2:0] slave_HBURST,
	input wire [1:0] slave_HTRANS,
	input wire slave_HREADY,
	input wire [31:0] slave_HWDATA,
  input wire master_HRESP,
  input wire [31:0] master_HRDATA,
	output reg slave_HREADYOUT,
	output reg slave_HRESP,
	output reg [31:0] slave_HRDATA,
	output reg [31:0] master_HADDR,
	output reg master_HWRITE,
	output reg [2:0] master_HSIZE,
	output reg [2:0] master_HBURST,
	output reg [1:0] master_HTRANS,
	output reg [31:0] master_HWDATA
);

wire go;
wire [127:0] key;
wire [127:0] nonce;
wire [127:0] pText;
wire [127:0] encr_text;
wire [127:0] plain_text;
wire [31:0] destination;
wire done;
wire write_out;
wire fifo_full;



controlled_encryption_block ceb(
	.clk(HCLK),
	.go(go), //Signal to tell encryptor that the nonce and key are valid. Requires data either already in the FIFO or prior to encryption end, ~40 clocks.
	.keyIn(key),
	.nonceIn(nonce),
	.pText(pText),
	.encText(encr_text), //output - something something AHB
	.done(done) //output - signal to pull data from the FIFO
);

fifo_buffer fb(
	.clk(HCLK),
	.nRst(HRESETn),
	.read(done),
	.write(write_out),
	.dataIn(plain_text),
	.dataOut(pText),
	.full(fifo_full)
);

ahb_lite_master_interface mi(
	.HCLK(HCLK),
	.HRESETn(HRESETn),
	.HREADY(master_HREADY),
	.HRESP(master_HRESP),
	.HRDATA(master_HRDATA),
	.destination(destination), // Comes from ahb-slave
	.dest_updated(write_out), // Pulse that is sent to notify master of updated dest ^
	.encr_text(encr_text),	// John sends me the encr text
	.text_rcvd(done),  // This is the pulse signal you send before sending the encr text
	.HADDR(master_HADDR),
	.HWRITE(master_HWRITE),
	.HSIZE(master_HSIZE),
	.HBURST(master_HBURST),
	.HTRANS(master_HTRANS),
	.HWDATA(master_HWDATA)
);

ahb_lite_slave_interface si(
	.HCLK(HCLK),
	.HRESETn(HRESETn),
	.HSELx(slave_HSELx),
	.HADDR(slave_HADDR),
	.HWRITE(slave_HWRITE),
	.HBURST(slave_HBURST),
	.HTRANS(slave_HTRANS),
	.HREADY(slave_HREADY),
	.HWDATA(slave_HWDATA),
	.fifo_full(fifo_full),
	.HREADYOUT(slave_HREADYOUT),
	.HRESP(slave_HRESP),
	.HRDATA(slave_HRDATA),
	.key(key),
	.nonce(nonce),
	.destination(destination),
	.plain_text(plain_text),
	.write_out(go)
);

endmodule
