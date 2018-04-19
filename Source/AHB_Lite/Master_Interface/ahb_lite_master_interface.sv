module ahb_lite_master_interface (
  input wire HCLK,
	input wire HRESETn,
  input wire HREADY,
  input wire HRESP,
  input wire [127:0] HRDATA,
  input wire [127:0] destination,
  input wire [127:0] encr_text,
  input wire signal_recieved,
  output reg [31:0] HADDR,
  output reg HWRITE,
  output reg [2:0] HSIZE,
  output reg [2:0] HBURST,
  output reg [1:0] HTRANS,
  output reg [127:0] HWDATA
);

// User Defined Types
typedef enum bit [2:0] {IDLE,NONSEQ,SEQ1,SEQ2,SEQ3} stateType;

// Internal Signals
stateType state;
stateType next_state;
reg [127:0] dest;
reg [127:0] next_dest;

always_ff @ (posedge HCLK, negedge HRESETn) begin
  if (HRESETn == 1'b0 && HREADY == 1'b1 && HRESP == 1'b0) begin // If selected & !reset & !error
    dest <= next_dest;
    state <= next_state;
  end else begin
    dest <= destination;
    state <= IDLE;
  end
end

always_comb begin

  next_dest <= dest;
  next_state <= state;

  HSIZE <= 3'b100;
  HWRITE <= 1'b1;
  HBURST <= 3'b001;
  HTRANS <= 2'b00;
  HADDR <= dest[31:0];
  HWDATA <= 128'b0;

  case (state)
    IDLE:
    begin
      if (signal_recieved == 1'b1) begin
        next_state <= NONSEQ;
        next_dest <= destination;
      end
      HWRITE <= 1'b0;
    end

    NONSEQ:
    begin
      if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state <= SEQ1;
        next_dest <= dest + 2'h10;
        HTRANS <= 2'b10;
        HWDATA <= encr_text;
      end else begin
        HTRANS <= 2'b01; // busy
      end
    end

    SEQ1:
    begin
      if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state <= SEQ2;
        next_dest <= dest + 2'h10;
        HTRANS <= 2'b11;
        HWDATA <= encr_text;
      end else begin
        HTRANS <= 2'b01; // busy
      end
    end

    SEQ2:
    begin
      if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state <= SEQ3;
        next_dest <= dest + 2'h10;
        HTRANS <= 2'b11;
        HWDATA <= encr_text;
      end else begin
        HTRANS <= 2'b01; // busy
      end
    end

    SEQ3:
    begin
      if (HREADY == 1'b1 && HRESP == 1'b0) begin
        if (signal_recieved == 1'b1) begin
          next_state <= NONSEQ;
          next_dest <= destination;
        end else begin
          next_state <= IDLE;
        end
        HTRANS <= 2'b11;
        HWDATA <= encr_text;
      end else begin
        HTRANS <= 2'b01; // busy
      end
    end

    default:
    begin
      next_state <= IDLE;
    end
  endcase

end

endmodule // ahb_lite_master_interface
