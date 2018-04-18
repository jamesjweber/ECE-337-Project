module prekey_storage
(
	input wire clk,
	input wire rst,
	input wire [127:0] in,
	output wire [255:0] gen_preKeys,
	output wire [255:0] pre_roundKeys,
)

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
	if(rst == 0)
	begin
		pKeyMinus8 = {1b'1,in[0:30]};
		pKeyMinus7 = in[31:62];	
		pKeyMinus6 = in[63:94];	
		pKeyMinus5 = in[95:126];	
		pKeyMinus4 = {in[127],31'h0};
		pKeyMinus3 = 32'h0;
		pKeyMInus2 = 32'h0;
		pKeyMinus1 = 32'h0;
	end
	else
	begin
		pKeyMinus1 <= in[31:0];
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
assign pre_roundKeys = {pKeyMinus1, pKeyMinus2, pKeyMinus3, pKeyMinus4};

endmodule
