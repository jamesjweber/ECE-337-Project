module slave_write (
  input wire HCLK,
  input wire HRESETn,
  input wire [31:0] HADDR,
	input wire [2:0] HBURST,
	input wire [1:0] HTRANS,
  input wire HREADY,
  input wire fifoFull,
	input wire [128:0] SWDATA,
  output reg [128:0] key,
	output reg [128:0] nonce,
	output reg [128:0] destination,
	output reg [128:0] plainText,
  output reg readWriteError,
	output reg readWriteReady
);

typedef enum bit [4:0] {S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,S24,S25,S26,S27,S28,S29,S30,S31,S32} stateType;
  stateType state;
  stateType next_state;



endmodule // slave_write
typedef enum bit [2:0] {SINGLE,INCR,WRAP4,INCR4,WRAP8,INCR8,WRAP16,INCR16} hburstType;
typedef enum bit [1:0] {IDLE,BUSY,NONSEQ,SEQ} htransType;

always_ff @ (posedge HCLK, negedge HRESETn) begin
  if (HRESETn == 1'b0) begin
    readWriteReady = 1'b1; // AHB Protocol: During reset all slaves must ensure that HREADYOUT is HIGH.
    key = 128'b0;
    nonce = 128'b0;
    destination = 128'b0;
    plainText = 128'b0;
  end else begin
    // Reset Signals as needed
    if (readWriteReady == 1'b1) begin
      readWriteReady = 1'b0;
    end
    if (readWriteError == 1'b1) begin
      readWriteError = 1'b0;
    end
    key <= key;
    nonce <= nonce;
    destination <= destination;
    plainText <= plainText;
    state <= next_state;
end

always_comb begin

  // See slave_write.md (README) for description of all states

  next_state <= {HBURST, HTRANS}; // Set next state

  case (state)

    S1:
    begin
      // HBURST: SINGLE, HTRANS: IDLE
      // Do not write data in IDLE state
      if (HTRANS[0] == 1'b1) begin
        // If HTRANS (for the next state) is BUSY or SEQ, raise error as this makes no sense
        readWriteError = 1'b1;
      end
    end

    S2:
    begin
      // HBURST: SINGLE, HTRANS: BUSY
      // Nonsensical state, raise error
      readWriteError = 1'b1;
    end

    S3:
    begin
      // HBURST: SINGLE, HTRANS: NONSEQ
      // Single burst write
      if (HREADY == 1'b1) begin
        // If ready write to address
        if (HADDR[7:0] = 1'h80) begin
          // Key Address
          key = SWDATA;
        end else if (HADDR[7:0] = 1'h100) begin
          // Nonce Address
          nonce = SWDATA;
        end else if (HADDR[7:0] = 1'h180) begin
          // Destination Address
          destination = SWDATA;
        end else if (HADDR[7:0] = 1'h200) begin
          // Plain Text Address
          plainText = SWDATA;
        end else begin
          // Invalid Address
          readWriteError = 1'b1;
        end
      end
      if (HTRANS[0] == 1'b1) begin
        // If HTRANS (for the next state) is BUSY or SEQ, raise error as this makes no sense
        readWriteError = 1'b1;
      end
    end

    S4:
    begin
      // HBURST: SINGLE, HTRANS: SEQ
      // Nonsensical state, raise error
      readWriteError = 1'b1;
    end

    S5:
    begin
      // HBURST: INCR, HTRANS: IDLE
      // Do not write data in IDLE state
    end

    S6:
    begin
      // HBURST: INCR, HTRANS: BUSY
      // Do not write data in IDLE state
    end

    S7:
    begin

    end

    S8:
    begin

    end

    S9:
    begin

    end

    S10:
    begin

    end

    S11:
    begin

    end

    S12:
    begin

    end

    S13:
    begin

    end

    S14:
    begin

    end

    S15:
    begin

    end

    S16:
    begin

    end

    S17:
    begin

    end

    S18:
    begin

    end

    S19:
    begin

    end

    S20:
    begin

    end

    S21:
    begin

    end

    S22:
    begin

    end

    S23:
    begin

    end

    S24:
    begin

    end

    S25:
    begin

    end

    S26:
    begin

    end

    S27:
    begin

    end

    S28:
    begin

    end

    S29:
    begin

    end

    S30:
    begin

    end

    S31:
    begin

    end

    S32:
    begin

    end

  endcase


endmodule
