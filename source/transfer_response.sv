module transfer_response (
  input wire HCLK,
  input wire HRESETn,
  input wire enable,
  input wire ready,
  input wire error,
  output reg HREADYOUT,
  output reg HRESP
);

typedef enum bit [1:0] {TL, TH, ERR1, ERR2} stateType;
  stateType state;
  stateType next_state;

wire valid;

assign valid = enable && ~HRESETn;

always_ff @ (posedge HCLK, posedge valid) begin
  if (valid == 1'b1) begin
     state <= next_state;
     $display("clk");
  end else begin
    state <= TL; // If disabled, state is transfer low (HREADYOUT and HRESP = 0)
  	$display("clk");
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
      HREADYOUT = 1'b0;
      HRESP = 1'b0;
    end

    TH: // Successful Transfer (Transfer High)
    begin
      // Set State
      next_state = error ? ERR1 : ready ? TH : TL;
      // Set Output
      HREADYOUT = 1'b1;
      HRESP = 1'b0;
    end

    ERR1: // Error repsone, cycle 1
    begin
      // Set State
      next_state = ERR2;
      // Set Output
      HREADYOUT = 1'b0;
      HRESP = 1'b1;
    end

    ERR2: // Error repsone, cycle 1
    begin
      // Set State
      next_state = ready ? TH : TL;
      // Set Output
      HREADYOUT = 1'b1;
      HRESP = 1'b1;
    end

  endcase

end

endmodule // error
