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
	wire [31:0] tA2;
	wire [31:0] tB1;
	wire [31:0] tC1;
	wire [31:0] tC2;
	wire [31:0] tD1;

	always_comb
	begin
		tA1 = {A[17:0]}, A[31:18]}; // 13-bit left rotation.
		tA2 = tA1 ^ newB ^ newD; // XOR.
		newA = {tA2[25:0], tA2[31:26]}; // 5-bit left rotation.

		tB1 = B ^ tA1 ^ tC1; // XOR.
		newB = {tB1[30:0], tB1[31]}; // 1-bit rotation.

		tC1 = {C[28:0], C[31:29]}; // 3-bit left rotation.
		tC2 = tC1 ^ newD ^ {newB[24:0], 7'b0000000}; // 7-bit left shift and XOR.
		newC = {tC2[8:0], tC2[31:9]}; // 22-bit left rotation.

		tD1 = D ^ tC1 ^ {tA1[30:0], 1'b0}; // 3-bit left shift and XOR.
		newD = {tD1[24:0], tD1[31:25]}; // 7-bit rotation.
	end
endmodule