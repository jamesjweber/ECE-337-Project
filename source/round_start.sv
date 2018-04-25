module round_start
(
	input wire clk,
	input wire rst,
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
	if (rst == 1)
	begin
		currentData <= freshData;
		dataMinus1 <= freshData + 1;
		dataMinus2 <= freshData + 2;
		dataMinus3 <= freshData + 3;
	end
	else
	begin
		currentData <= dataMinus1;
		dataMinus1 <= dataMinus2;
		dataMinus2 <= dataMinus3;
		dataMinus3 <= priorRound;
	end
end

assign dataOut = currentData;

endmodule
