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
  if (HRESETn == 1'b0 && HSELx == 1'b1) begin // If selected and not being reset
    key <= next_key;
    nonce <= next_nonce;
    destination <= next_destination;
    plain_text <= next_plain_text;
    write_error <= next_write_error;
    write_ready <= next_write_ready;
    state <= next_state;
    prev_HADDR <= HADDR;
  end else begin // Else if being reset and/or not currently selected
    key <= 128'b0;
    nonce <= 128'b0;
    destination <= 128'b0;
    plain_text <= 128'b0;
    state <= next_state;
    write_error <= 1'b0;
    write_ready <= 1'b1; // AHB Protocol: During reset all slaves must ensure that HREADYOUT is HIGH.
    prev_HADDR <= 32'b0;
  end
end


always_comb begin

  next_key <= key;
  next_nonce <= nonce;
  next_destination <= destination;
  next_plain_text <= plain_text;
  next_state <= state;
  next_write_error <= 1'b0;
  next_write_ready <= 1'b1;

  // See slave_write.md (README) for description of all states

  if (HREADY == 1'b1) begin
    next_state <= {HBURST, HTRANS}; // Set next state
  end else begin
    if (state == {HBURST,HTRANS}) begin
      next_state <= {HBURST,HTRANS};
    end else beign
      next_state <= state;
      next_write_error <= 1'b1;
    end
  end

  case (state)

    S1:
    begin
      // HBURST: SINGLE, HTRANS: IDLE
      // Do not read data in IDLE state
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
          if (fifo_full == 1'b0) begin // if FIFO is full don't wait to write
            next_plain_text <= SWDATA;
          end else begin
            next_write_ready <= 1'b0;
          end
        end else begin
          // Invalid Address
          next_write_error <= 1'b1;
        end
      end

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

      // Not supported
      next_write_error <= 1'b1;
    end

    S6:
    begin
      // HBURST: INCR, HTRANS: BUSY
      // Do not write data in BUSY state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S7:
    begin
      // HBURST: INCR, HTRANS: NONSEQ
      // Beginning of INCR burst.

      // Not supported
      next_write_error <= 1'b1;
    end

    S8:
    begin
      // HBURST: INCR, HTRANS: SEQ
      // Continuation of burst from state S7

      // Not supported
      next_write_error <= 1'b1;
    end

    S9:
    begin
      // HBURST: WRAP4, HTRANS: IDLE
      // Do not write data in IDLE state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S10:
    begin
      // HBURST: WRAP4, HTRANS: BUSY
      // Do not write data in BUSY state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S11:
    begin
      // HBURST: WRAP4, HTRANS: NONSEQ
      // Beginning of WRAP4 burst.

      // Not supported
      next_write_error <= 1'b1;
    end

    S12:
    begin
      // HBURST: WRAP4, HTRANS: SEQ
      // Continuation of burst from state S11.

      // Not supported
      next_write_error <= 1'b1;
    end

    S13:
    begin
      // HBURST: INCR4, HTRANS: IDLE
      // Do not write data in IDLE state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S14:
    begin
      // HBURST: INCR4, HTRANS: BUSY
      // Do not write data in BUSY state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S15:
    begin
      // HBURST: INCR4, HTRANS: NONSEQ
      // Beginning of INCR4 burst.

      // Not supported
      next_write_error <= 1'b1;
    end

    S16:
    begin
      // HBURST: INCR4, HTRANS: SEQ
      // Continuation of burst from state S15.

      // Not supported
      next_write_error <= 1'b1;
    end

    S17:
    begin
      // HBURST: WRAP8, HTRANS: IDLE
      // Do not write data in IDLE state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S18:
    begin
      // HBURST: WRAP8, HTRANS: BUSY
      // Do not write data in BUSY state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S19:
    begin
      // HBURST: WRAP8, HTRANS: NONSEQ
      // Beginning of WRAP8 burst.

      // Not supported
      next_write_error <= 1'b1;
    end

    S20:
    begin
      // HBURST: WRAP8, HTRANS: SEQ
      // Continuation of burst from state S20.

      // Not supported
      next_write_error <= 1'b1;
    end

    S21:
    begin
      // HBURST: INCR8, HTRANS: IDLE
      // Do not write data in IDLE state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S22:
    begin
      // HBURST: INCR8, HTRANS: BUSY
      // Do not write data in BUSY state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S23:
    begin
      // HBURST: INCR8, HTRANS: NONSEQ
      // Beginning of INCR8 burst.

      // Not supported
      next_write_error <= 1'b1;
    end

    S24:
    begin
      // HBURST: INCR8, HTRANS: SEQ
      // Continuation of burst from state S23.

      // Not supported
      next_write_error <= 1'b1;
    end

    S25:
    begin
      // HBURST: WRAP16, HTRANS: IDLE
      // Do not write data in IDLE state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S26:
    begin
      // HBURST: WRAP16, HTRANS: BUSY
      // Do not write data in BUSY state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S27:
    begin
      // HBURST: WRAP16, HTRANS: NONSEQ
      // Beginning of WRAP16 burst.

      // Not supported
      next_write_error <= 1'b1;
    end

    S28:
    begin
      // HBURST: WRAP16, HTRANS: SEQ
      // Continuation of burst from state S26.

      // Not supported
      next_write_error <= 1'b1;
    end

    S29:
    begin
      // HBURST: INCR16, HTRANS: IDLE
      // Do not write data in IDLE state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S30:
    begin
      // HBURST: INCR16, HTRANS: BUSY
      // Do not write data in BUSY state.

      // Not supported
      next_write_error <= 1'b1;
    end

    S31:
    begin
      // HBURST: INCR16, HTRANS: NONSEQ
      // Beginning of WRAP16 burst.

      // Not supported
      next_write_error <= 1'b1;
    end

    S32:
    begin
      // HBURST: INCR16, HTRANS: SEQ
      // Continuation of burst from state 31.

      // Not supported
      next_write_error <= 1'b1;
    end

  endcase

endmodule // slave_write
