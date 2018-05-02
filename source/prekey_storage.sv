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
	if(rst == 1) //Pad key out to 256 bits per Serpent spec
	begin
		pKeyMinus8 <= keyIn[31:0];
		pKeyMinus7 <= keyIn[63:32];	
		pKeyMinus6 <= keyIn[95:64];	
		pKeyMinus5 <= keyIn[127:96];	
		pKeyMinus4 <= 32'h1;
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

assign gen_preKeys = {pKeyMinus8, pKeyMinus5, pKeyMinus3, pKeyMinus1}; //prekeys to generate new prekeys
assign pre_froundKeys = {pKeyMinus1, pKeyMinus2, pKeyMinus3, pKeyMinus4}; //prekeys to generate the current round key
assign pre_roundKeys = {pKeyMinus5, pKeyMinus6, pKeyMinus7, pKeyMinus8}; //prekeys to generate the final round key

endmodule
