module round_start
(
	input wire clk,
	input wire rst,
	input wire go,
	input wire [127:0] freshData,
	input wire [127:0] priorRound,
	output wire [127:0] dataOut
);

reg [127:0] currentData;
reg [127:0] dataMinus1;
reg [127:0] dataMinus2;
reg [127:0] dataMinus3;

always_ff @ (posedge clk)
begin
	if (rst == 1)
	begin
		currentData <= freshData;
		dataMinus1 <= freshData + 1;
		dataMinus2 <= freshData + 2;
		dataMinus3 <= freshData + 3;
	end
	else if (go == 1)
	begin
		currentData <= dataMinus1;
		dataMinus1 <= dataMinus2;
		dataMinus2 <= dataMinus3;
		dataMinus3 <= priorRound;
	end
	else
	begin
		currentData <= currentData;
		dataMinus1 <= dataMinus1;
		dataMinus2 <= dataMinus2;
		dataMinus3 <= dataMinus3;
	end
		
end

assign dataOut = currentData;

endmodule
