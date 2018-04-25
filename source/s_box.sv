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
			case (sel)
				0: // [3 8 15 1 10 6 5 11 14 13 4 2 7 0 9 12]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
					endcase
				1: // [15 12 2 7 9 0 5 10 1 11 14 8 6 13 3 4]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
					endcase
				2: // [8 6 7 9 3 12 10 15 13 1 14 4 0 11 5 2]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
					endcase
				3: // [0 15 11 8 12 9 6 3 13 1 2 4 10 7 5 14]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
					endcase
				4: // [1 15 8 3 12 0 11 6 2 5 4 10 9 14 7 13]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
					endcase
				5: // [15 5 2 11 4 10 9 12 0 3 14 8 13 6 7 1]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
					endcase
				6: // [7 2 12 5 8 4 6 11 14 9 1 15 13 3 10 0]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
					endcase
				7: // [1 13 15 0 14 8 2 11 7 4 12 10 9 3 5 6]
					case ({inData[i], inData[i+32], inData[i+64], inData[i+96]})
						0: {out[i+96], out[i+64], out[i+32], out[i]} = 1;
						1: {out[i+96], out[i+64], out[i+32], out[i]} = 13;
						2: {out[i+96], out[i+64], out[i+32], out[i]} = 15;
						3: {out[i+96], out[i+64], out[i+32], out[i]} = 0;
						4: {out[i+96], out[i+64], out[i+32], out[i]} = 14;
						5: {out[i+96], out[i+64], out[i+32], out[i]} = 8;
						6: {out[i+96], out[i+64], out[i+32], out[i]} = 2;
						7: {out[i+96], out[i+64], out[i+32], out[i]} = 11;
						8: {out[i+96], out[i+64], out[i+32], out[i]} = 7;
						9: {out[i+96], out[i+64], out[i+32], out[i]} = 4;
						10: {out[i+96], out[i+64], out[i+32], out[i]} = 12;
						11: {out[i+96], out[i+64], out[i+32], out[i]} = 10;
						12: {out[i+96], out[i+64], out[i+32], out[i]} = 9;
						13: {out[i+96], out[i+64], out[i+32], out[i]} = 3;
						14: {out[i+96], out[i+64], out[i+32], out[i]} = 5;
						15: {out[i+96], out[i+64], out[i+32], out[i]} = 6;
					endcase
			endcase
	end
	
	assign outData = out;

endmodule
