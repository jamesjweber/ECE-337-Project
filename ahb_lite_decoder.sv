// ahb_lite_decoder

module ahb_lite_decoder(
	input wire clk,
	input wire nRst,
	input wire [1:0] addr,
	input wire [127:0] data,
	output reg [31:0] dest,
	output reg [127:0] key,
	output reg [127:0] nonce,
	output reg [127:0] plaintext
);

always_ff @ (posedge clk, negedge n_rst)
begin
	if(n_rst == 0)
	begin
		dest <= '0;
		key <= '0;
		nonce <= '0;
		plaintext <= '0;
	end
end


always_comb begin

	dest = '0;
	key = '0;
	nonce = '0;
	plaintext = '0;

	if (addr == 1'b00) begin
		dest = data[127:96];
	end 
	else if (addr == 1'b01) begin
		key = data;
	end
	else if (addr == 1'b10) begin
		nonce = data;
	end
	else if (addr == 1'b11) begin
		plaintext = data;
	end
end

