module ahb_lite_master_interface (
  input wire HCLK,
  input wire HRESETn,
  input wire HREADY,
  input wire HRESP,
  input wire [31:0] HRDATA,
  input wire [31:0] destination,
  input wire dest_updated,
  input wire [127:0] encr_text,
  input wire text_rcvd,
  output reg [31:0] HADDR,
  output reg HWRITE,
  output reg [2:0] HSIZE,
  output reg [2:0] HBURST,
  output reg [1:0] HTRANS,
  output reg [31:0] HWDATA
);

// User Defined Types
typedef enum bit [4:0] {IDLE, LOAD1, LOAD2, LOAD3, LOAD4, NONSEQ, SEQ1, SEQ2, SEQ3, SEQ4, SEQ5, SEQ6, SEQ7, SEQ8, SEQ9, SEQ10, SEQ11, SEQ12, SEQ13, SEQ14, SEQ15} stateType;

// Internal Signals
// States
stateType state;
stateType next_state;
// Registers
reg [31:0] dest;
reg [31:0] next_dest;
reg [31:0] next_HWDATA;
reg [31:0] next_HADDR;
reg [127:0] encr_text_1;
reg [127:0] next_encr_text_1;
reg [127:0] encr_text_2;
reg [127:0] next_encr_text_2;
reg [127:0] encr_text_3;
reg [127:0] next_encr_text_3;
reg [127:0] encr_text_4;
reg [127:0] next_encr_text_4;


always_ff @ (posedge HCLK, negedge HRESETn) begin
	if (HRESETn == 1'b0) begin // resets internal registers
  	dest <= 32'b0;
    encr_text_1 <= 128'b0;
    encr_text_2 <= 128'b0;
    encr_text_3 <= 128'b0;
    encr_text_4 <= 128'b0;
    HWDATA <= 32'b0;
    HADDR <= 32'b0;
    state <= IDLE;
  end else begin	// default next signals for internal registers
  	dest <= next_dest;
    encr_text_1 <= next_encr_text_1;
    encr_text_2 <= next_encr_text_2;
    encr_text_3 <= next_encr_text_3;
    encr_text_4 <= next_encr_text_4;
    HWDATA <= next_HWDATA;
    HADDR <= next_dest;
    state <= next_state;
  end
end

always @(negedge HCLK) begin

  // Defaults
  HWRITE = 1'b1;   // Write
  HSIZE = 3'b010;  // Word
  HBURST = 3'b111; // 16-beat incr burst
  HTRANS = 2'b0;   // IDLE

	// Set defaults to avoid latches
	next_encr_text_1	=	encr_text_1;
	next_encr_text_2	= encr_text_2;
	next_encr_text_3	= encr_text_3;
	next_encr_text_4	= encr_text_4;
	next_HWDATA				= 32'b0;
	next_state 				=	state;
	next_dest					= dest;

	// Update destination
  if (dest_updated) begin
  	next_dest = destination;
  end

  casez (state)
    IDLE:
    begin
			// Wait until text is recieved to move out of IDLE state
			if (text_rcvd == 1'b1) begin
				next_state = LOAD1;
			end
			HWRITE = 1'b0;
    end

		// Once out of IDLE, the following four states, load four 128-bit chunks of data
		
    LOAD1:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_encr_text_1 = encr_text;
        next_state = LOAD2;
      //end
    end

    LOAD2:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_encr_text_2 = encr_text;
        next_state = LOAD3;
      //end
    end

    LOAD3:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_encr_text_3 = encr_text;
        next_state = LOAD4;
      //end
    end

    LOAD4:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_encr_text_4 = encr_text;
        next_state = NONSEQ;
      //end
    end
		
		// Once data is loaded and saved internally, it is output
		// a 16-burst mode AHB-Lite protocol.

    NONSEQ:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ1;
        next_dest = dest + 32'h4;
        HTRANS = 2'b10;
        next_HWDATA = encr_text_1[31:0];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ1:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ2;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_1[63:32];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ2:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ3;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_1[95:64];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ3:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ4;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_1[127:96];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ4:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ5;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_2[31:0];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ5:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ6;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_2[63:32];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ6:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ7;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_2[95:64];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ7:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ8;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_2[127:96];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ8:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ9;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_3[31:0];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ9:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ10;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_3[63:32];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ10:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ11;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_3[95:64];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end


    SEQ11:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ12;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_3[127:96];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ12:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ13;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_4[31:0];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end


    SEQ13:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ14;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_4[63:32];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ14:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        next_state = SEQ15;
        next_dest = dest + 32'h4;
        HTRANS = 2'b11;
        next_HWDATA = encr_text_4[95:64];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    SEQ15:
    begin
      //if (HREADY == 1'b1 && HRESP == 1'b0) begin
        if (text_rcvd == 1'b1) begin
          next_state = NONSEQ;
          next_dest = destination;
        end else begin
          next_state = IDLE;
          next_dest = dest;
        end
        HTRANS = 2'b11;
        next_HWDATA = encr_text_4[127:96];
      //end else begin
      //  HTRANS = 2'b01; // busy
      //end
    end

    default:
    begin
      next_state = IDLE;
    end
  endcase
end

endmodule // ahb_lite_master_interface
