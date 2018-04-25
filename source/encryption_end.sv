module encryption_end
(
	input wire clk,
	input wire [127:0] pText,
	input wire [127:0] prbs,
	input wire [4:0] count,
	output wire [127:0] dataOut,
	output wire done
);

reg [127:0] currentData;
reg [127:0] dataMinus1;
reg [127:0] dataMinus2;
reg [127:0] dataMinus3;
reg [4:0] prevCount;
always_ff @ (posedge clk)
begin
	prevCount <= count;
	currentData <= dataMinus1;
	dataMinus1 <= dataMinus2;
	dataMinus2 <= dataMinus3;
	dataMinus3 <= prbs;
end

assign dataOut = currentData ^ pText;
assign done = count == 0 && prevCount == 31 ? 1:0;
endmodule