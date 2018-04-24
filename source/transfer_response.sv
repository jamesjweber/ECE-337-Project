module transfer_response (
  input wire HCLK,
  input wire HRESETn,
  input wire enable,
  input wire ready,
  input wire error,
  output reg HREADY,
  output reg HRESP
);

typedef enum bit [1:0] {TL, TH, ERR1, ERR2} stateType;
  stateType state;
  stateType next_state;

always_ff @ (posedge HCLK, posedge enable,negedge HRESETn) begin
  if (enable == 1'b1) begin
    if (HRESETn == 1'b0) begin
    	state <= next_state;
    end else begin
      state <= TL;
    end
  end else begin
    state <= TL; // If disabled, state is transfer low (HREADY and HRESP = 0)
  end
end

always_comb begin

  next_state = state; // gets rid of latches

  case(state)

    TL: // Transfer Pending (Transfer Low)
    begin
      // Set State
      next_state = error ? ERR1 : ready ? TH : TL;
      // Set Output
      HREADY = 1'b0;
      HRESP = 1'b0;
    end

    TH: // Successful Transfer (Transfer High)
    begin
      // Set State
      next_state = error ? ERR1 : ready ? TH : TL;
      // Set Output
      HREADY = 1'b1;
      HRESP = 1'b0;
    end

    ERR1: // Error repsone, cycle 1
    begin
      // Set State
      next_state = ERR2;
      // Set Output
      HREADY = 1'b0;
      HRESP = 1'b1;
    end

    ERR2: // Error repsone, cycle 1
    begin
      // Set State
      next_state = error ? ERR1 : ready ? TH : TL;
      // Set Output
      HREADY = 1'b1;
      HRESP = 1'b1;
    end

  endcase

end

endmodule // error
