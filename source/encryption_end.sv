module encryption_end
(
	input wire clk,
	input wire [127:0] pText,
	input wire [127:0] prbs,
	input wire [4:0] count,
	output wire [127:0] dataOut
);

reg [127:0] currentData;
reg [127:0] dataMinus1;
reg [127:0] dataMinus2;
reg [127:0] dataMinus3;
reg [4:0] prevCount;
	always_ff @ (posedge clk) //shift through data every clock
begin
	prevCount <= count;
	currentData <= dataMinus1;
	dataMinus1 <= dataMinus2;
	dataMinus2 <= dataMinus3;
	dataMinus3 <= prbs;
end

assign dataOut = currentData ^ pText;
endmodule
