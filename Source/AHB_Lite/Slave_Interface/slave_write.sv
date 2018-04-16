module slave_write (
  input wire HCLK,
  input wire HRESETn,
  input wire HSELx,
  input wire [31:0] HADDR,
	input wire [2:0] HBURST,
	input wire [1:0] HTRANS,
  input wire HREADY,
  input wire fifo_full,
	input wire [128:0] SWDATA,
  output reg [128:0] key,
	output reg [128:0] nonce,
	output reg [128:0] destination,
	output reg [128:0] plain_text,
  output reg write_error,
	output reg write_ready
);

// User Defined Types
typedef enum bit [4:0] {S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,S24,S25,S26,S27,S28,S29,S30,S31,S32} stateType;
typedef enum bit [2:0] {SINGLE,INCR,WRAP4,INCR4,WRAP8,INCR8,WRAP16,INCR16} hburstType;
typedef enum bit [1:0] {IDLE,BUSY,NONSEQ,SEQ} htransType;

// Internal Signals
stateType state;
stateType next_state;
reg next_key;
reg next_nonce;
reg next_destination;
reg next_plain_text;
reg next_write_error;
reg next_write_ready;
reg [31:0] prev_HADDR;


always_ff @ (posedge HCLK, negedge HRESETn) begin
  if (HRESETn == 1'b0) begin
    key <= 128'b0;
    nonce <= 128'b0;
    destination <= 128'b0;
    plain_text <= 128'b0;
    write_error <= 1'b0;
    write_ready <= 1'b1; // AHB Protocol: During reset all slaves must ensure that HREADYOUT is HIGH.
    prev_HADDR <= 32'b0;
  end else begin
    // Reset Signals as needed
    key <= next_key;
    nonce <= next_nonce;
    destination <= next_destination;
    plain_text <= next_plain_text;
    write_error <= next_write_error;
    write_ready <= next_write_ready;
    state <= next_state;
    prev_HADDR <= HADDR;
end

always_comb begin

  next_key <= key;
  next_nonce <= nonce;
  next_destination <= destination;
  next_plain_text <= plain_text;
  next_state <= state;
  next_write_error <= 1'b0;

  // See slave_write.md (README) for description of all states

  if (HREADY == 1'b1) begin
    next_state <= {HBURST, HTRANS}; // Set next state
  end else begin
    next_state <= state;
  end

  case (state)

    S1:
    begin
      // HBURST: SINGLE, HTRANS: IDLE
      // Do not write data in IDLE state

      // Check for invalid states
      if (next_state == S2 || next_state == S4 || next_state == S6 || next_state == S8 || next_state == S10 || next_state == S12 || next_state == S14 || next_state == S16 || next_state == S18 || next_state == S20 || next_state == S22 || next_state == S24 || next_state == S26 || next_state == S28 || next_state == S30 || next_state == S32) begin
        next_write_error <= 1'b1;
      end // check for invalid next states
    end

    S2:
    begin
      // HBURST: SINGLE, HTRANS: BUSY
      // Nonsensical state, raise error
      next_write_error <= 1'b1;
    end

    S3:
    begin
      // HBURST: SINGLE, HTRANS: NONSEQ
      // Single burst write
      if (HREADY == 1'b1) begin
        // If ready write to address
        if (prev_HADDR[7:0] = 1'h80) begin
          // Key Address
          next_key <= SWDATA;
        end else if (prev_HADDR[7:0] = 1'h100) begin
          // Nonce Address
          next_nonce <= SWDATA;
        end else if (prev_HADDR[7:0] = 1'h180) begin
          // Destination Address
          next_destination <= SWDATA;
        end else if (prev_HADDR[7:0] = 1'h200) begin
          // Plain Text Address
          next_plain_text <= SWDATA;
        end else begin
          // Invalid Address
          next_write_error <= 1'b1;
        end
      end

      if (next_state == S2 || next_state == S4 || next_state == S6 || next_state == S8 || next_state == S10 || next_state == S12 || next_state == S14 || next_state == S16 || next_state == S18 || next_state == S20 || next_state == S22 || next_state == S24 || next_state == S26 || next_state == S28 || next_state == S30 || next_state == S32) begin
        next_write_error <= 1'b1;
      end // check for invalid next states

    end

    S4:
    begin
      // HBURST: SINGLE, HTRANS: SEQ
      // Nonsensical state, raise error
      next_write_error <= 1'b1;
    end

    S5:
    begin
      // HBURST: INCR, HTRANS: IDLE
      // Do not write data in IDLE state

      // Check for invalid states
      if (next_state == S2 || next_state == S4 || next_state == S6 || next_state == S8 || next_state == S10 || next_state == S12 || next_state == S14 || next_state == S16 || next_state == S18 || next_state == S20 || next_state == S22 || next_state == S24 || next_state == S26 || next_state == S28 || next_state == S30 || next_state == S32) begin
        next_write_error <= 1'b1;
      end // check for invalid next states
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

endmodule // slave_write
