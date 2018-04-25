module round_start
(
	input wire clk,
	input wire init,
	input wire [128:0] freshData,
	input wire [128:0] priorRound,
	output wire [128:0] dataOut
);

reg [128:0] currentData;
reg [128:0] dataMinus1;
reg [128:0] dataMinus2;
reg [128:0] dataMinus3;
wire dataSelect;

always_ff @ (posedge clk)
begin
	currentData <= dataMinus1;
	dataMinus1 <= dataMinus2;
	dataMinus2 <= dataMinus3;
	dataMinus3 <= dataSelect;
end

assign dataSelect = init ? freshData: priorRound;
assign dataOut = currentData;

endmodule
