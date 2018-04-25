module linear_mix
(
	input wire [31:0] A,
	input wire [31:0] B,
	input wire [31:0] C,
	input wire [31:0] D,
	output wire [31:0] newA,
	output wire [31:0] newB,
	output wire [31:0] newC,
	output wire [31:0] newD
);

	assign tA1 = {A[17:0], A[31:18]}; // 13-bit left rotation.
	assign tC1 = {C[28:0], C[31:29]}; // 3-bit left rotation.
	assign tB1 = B ^ tA1 ^ tC1; // XOR.
	assign tD1 = D ^ tC1 ^ {tA1[30:0], 1'b0}; // 3-bit left shift and XOR.
	assign newB = {tB1[30:0], tB1[31]}; // 1-bit rotation.
	assign newD = {tD1[24:0], tD1[31:25]}; // 7-bit rotation.
	assign tA2 = tA1 ^ newB ^ newD; // XOR.
	assign newA = {tA2[25:0], tA2[31:26]}; // 5-bit left rotation.
	assign tC2 = tC1 ^ newD ^ {newB[24:0], 7'b0000000}; // 7-bit left shift and XOR.
	assign newC = {tC2[8:0], tC2[31:9]}; // 22-bit left rotation.

endmodule
