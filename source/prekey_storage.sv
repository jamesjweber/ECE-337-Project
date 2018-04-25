module prekey_storage
(
	input wire clk,
	input wire rst,
	input wire [127:0] keyIn,
	input wire [31:0] in,
	output wire [127:0] gen_preKeys,
	output wire [127:0] pre_roundKeys,
	output wire [127:0] pre_froundKeys
);

reg [31:0] pKeyMinus1;
reg [31:0] pKeyMinus2;
reg [31:0] pKeyMinus3;
reg [31:0] pKeyMinus4;
reg [31:0] pKeyMinus5;
reg [31:0] pKeyMinus6;
reg [31:0] pKeyMinus7;
reg [31:0] pKeyMinus8;

always_ff @ (posedge clk)
begin
	if(rst == 1)
	begin
		pKeyMinus8 <= {1'b1,keyIn[30:0]};
		pKeyMinus7 <= keyIn[62:31];	
		pKeyMinus6 <= keyIn[94:63];	
		pKeyMinus5 <= keyIn[126:95];	
		pKeyMinus4 <= {keyIn[127],31'h0};
		pKeyMinus3 <= 32'h0;
		pKeyMinus2 <= 32'h0;
		pKeyMinus1 <= 32'h0;
	end
	else
	begin
		pKeyMinus1 <= in;
		pKeyMinus2 <= pKeyMinus1;
		pKeyMinus3 <= pKeyMinus2;
		pKeyMinus4 <= pKeyMinus3;
		pKeyMinus5 <= pKeyMinus4;
		pKeyMinus6 <= pKeyMinus5;
		pKeyMinus7 <= pKeyMinus6;
		pKeyMinus8 <= pKeyMinus7;
	end
end

assign gen_preKeys = {pKeyMinus8, pKeyMinus5, pKeyMinus3, pKeyMinus1};
assign pre_froundKeys = {pKeyMinus1, pKeyMinus2, pKeyMinus3, pKeyMinus4};
assign pre_roundKeys = {pKeyMinus5, pKeyMinus6, pKeyMinus7, pKeyMinus8};

endmodule
