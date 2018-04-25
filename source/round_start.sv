module round_start

{
	input wire clk,
	input wire init,
	input wire [128:0] freshData,
	input wire [128:0] priorRound,
	output wire [128:0] dataOut
}

reg [128:0] currentData;
wire dataSelect;

always_ff @ (posedge clk)
begin
	currentData = dataSelect;
end

assign dataSelect = init ? freshData: priorRound;
assign dataOut = currentData;

endmodule
