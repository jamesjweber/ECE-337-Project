module slave_write (
  input wire HCLK,
  input wire HRESETn,
  input wire [31:0] HADDR,
	input wire [2:0] HBURST,
	input wire [1:0] HTRANS,
  input wire fifoFull,
	input wire [128:0] SWDATA,
  output reg [128:0] key,
	output reg [128:0] nonce,
	output reg [128:0] destination,
	output reg [128:0] plainText,
  output reg readWriteError,
	output reg readWriteReady
);

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*
*   STATES:
*      
*
*
*
*
*
*
*
*
*
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

typedef enum bit [4:0] {} stateType;
  stateType state;
  stateType next_state;



endmodule // slave_write
