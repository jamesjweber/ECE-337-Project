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
wire [31:0] tA1;
wire [31:0] tB1;
wire [31:0] tC1;
wire [31:0] tD1;
wire [31:0] tA2;
wire [31:0] tC2;


	assign tA1 = (A << 13) | (A >> 19); // 13-bit left rotation.
	assign tC1 = (C << 3) | (C >> 29); // 3-bit left rotation.
	assign tB1 = B ^ tA1 ^ tC1; // XOR.
	assign tD1 = D ^ tC1 ^ (tA1 << 3); // 3-bit left shift and XOR.
	assign newB = (tB1 << 1) | (tB1 >> 31) ; // 1-bit rotation.
	assign newD = (tD1 << 7) | (tD1 >> 25); // 7-bit rotation.
	assign tA2 = tA1 ^ newB ^ newD; // XOR.
	assign newA = (tA2 << 5) | (tA2 >> 27); // 5-bit left rotation.
	assign tC2 = tC1 ^ newD ^ (newB << 7); // 7-bit left shift and XOR.
	assign newC = (tC2 << 22) | (tC2 >> 10); // 22-bit left rotation.

endmodule
