module key_storage
(
	input wire clk,
	input wire keyLock,
	input wire [127:0] in,
	output wire [127:0] roundKey
);
reg [127:0] currentData;
always_ff @ (posedge clk)
begin
	if (keyLock == 1)
	begin
		currentData <= in;
	end
	else
	begin
		currentData <= roundKey;
	end

end

assign roundKey = currentData;

endmodule
