module key_storage
(
	input wire clk,
	input wire [127:0] in,
	output wire [127:0] roundKey,
)

always_ff @ (posedge clk)
begin
	currentData <= in;
end

assign roundKey = currentData;

endmodule