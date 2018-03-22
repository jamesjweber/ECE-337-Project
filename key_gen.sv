module key_mix
(
	input wire [127:0] inKey,
	output wire [127:0] rKey,
)
wire [255:0] padKey;
wire [6:0] count;
 
reg [31:0] pKeyMinus1;
reg [31:0] pKeyMinus2;
reg [31:0] pKeyMinus3;
reg [31:0] pKeyMinus4;
reg [31:0] pKeyMinus5;
reg [31:0] pKeyMinus6;
reg [31:0] pKeyMinus7;
reg [31:0] pKeyMinus8;

wire [31:0] nKey;
wire [31:0] hold;

count = 0;
assign padKey = {1'b1, inKey, 127'b0};
always_ff @ (posedge clk, negedge nRst)
begin
	if(nrst == 0)
	begin
		pKey0 = 0
		pKey1 = 0
		pKey2 = 0
		pKey3 = 0
		pKey4 = 0
		pKey5 = 0
		pKey6 = 0
		pKey7 = 0
	end
	else
	begin
		pKeyMinus1 = nKey
		pKeyMinus2 = pKeyMinus1
		pKeyMinus3 = pKeyMinus2
		pKeyMinus4 = pKeyMinus3
		pKeyMinus5 = pKeyMinus4
		pKeyMinus6 = pKeyMinus5
		pKeyMinus7 = pKeyMinus6
		pKeyMinus8 = pKeyMinus7
	end
end

always_comb
begin
	if (count == 0)
	begin
		pKeyMinus8 = padKey[0:31]
		pKeyMinus7 = padKey[32:63]	
		pKeyMinus6 = padKey[64:95]	
		pKeyMinus5 = padKey[96:127]	
		pKeyMinus4 = padKey[128:159]	
		pKeyMinus3 = padKey[160:191]	
		pKeyMInus2 = padKey[192:223]
		pKeyMinus1 = padKey[224:256]	
	end
	else
	begin
		hold =  pKeyMinus8 ^ pKeyMinus5 ^ pKeyMinus3 ^ pKeyMinus1 ^ 32'h9e3779b9 ^ count 
		nKey = {hold[10:0], hold[31:11]}
	end
	count = count + 1;
end
endmodule
