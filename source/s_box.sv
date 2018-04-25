module s_box
(
	input wire [2:0] sel,
	input wire [127:0] inData,
	output wire [127:0] outData
);

	reg [127:0] out;
	reg [7:0] i;

	always_comb
	begin
		for(i = 0; i < 32; i += 1)
			case ({sel, {inData[i+96], inData[i+64], inData[i+32], inData[i]}})
				7'h00: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h01: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h02: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h03: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
				7'h04: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h05: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
				7'h06: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h07: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h08: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
				7'h09: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
				7'h0A: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
				7'h0B: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
				7'h0C: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h0D: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
				7'h0E: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h0F: {out[i+96], out[i+64], out[i+32], out[i]} = 12;

				7'h10: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h11: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
				7'h12: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
				7'h13: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h14: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h15: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
				7'h16: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h17: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h18: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
				7'h19: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h1A: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
				7'h1B: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h1C: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
				7'h1D: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
				7'h1E: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h1F: {out[i+96], out[i+64], out[i+32], out[i]} = 4;

				7'h20: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h21: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
				7'h22: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h23: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h24: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h25: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
				7'h26: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h27: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h28: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
				7'h29: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
				7'h2A: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
				7'h2B: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
				7'h2C: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
				7'h2D: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h2E: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h2F: {out[i+96], out[i+64], out[i+32], out[i]} = 2;

				7'h30: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
				7'h31: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h32: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h33: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h34: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
				7'h35: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h36: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
				7'h37: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h38: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
				7'h39: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
				7'h3A: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
				7'h3B: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
				7'h3C: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h3D: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h3E: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h3F: {out[i+96], out[i+64], out[i+32], out[i]} = 14;

				7'h40: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
				7'h41: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h42: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h43: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h44: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
				7'h45: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
				7'h46: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h47: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
				7'h48: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
				7'h49: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h4A: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
				7'h4B: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h4C: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h4D: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
				7'h4E: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h4F: {out[i+96], out[i+64], out[i+32], out[i]} = 13;

				7'h50: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h51: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h52: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
				7'h53: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h54: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
				7'h55: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h56: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h57: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
				7'h58: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
				7'h59: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h5A: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
				7'h5B: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h5C: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
				7'h5D: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
				7'h5E: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h5F: {out[i+96], out[i+64], out[i+32], out[i]} = 1;

				7'h60: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h61: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
				7'h62: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
				7'h63: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h64: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h65: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
				7'h66: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
				7'h67: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h68: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
				7'h69: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h6A: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
				7'h6B: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h6C: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
				7'h6D: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h6E: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h6F: {out[i+96], out[i+64], out[i+32], out[i]} = 0;

				7'h70: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
				7'h71: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
				7'h72: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
				7'h73: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
				7'h74: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
				7'h75: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
				7'h76: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
				7'h77: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
				7'h78: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
				7'h79: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
				7'h7A: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
				7'h7B: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
				7'h7C: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
				7'h7D: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
				7'h7E: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
				7'h7F: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
			endcase
	end
	
	assign outData = out;

endmodule
