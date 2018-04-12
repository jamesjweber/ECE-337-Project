module s_box
(
	input wire [2:0] sel,
	input wire [127:0] inData,
	output reg [127:0] outData
);

	reg [7:0] i;
	always_comb
	begin
		for(i = 3; i < 128; i += 4)
			case (sel)
				0: // [3 8 15 1 10 6 5 11 14 13 4 2 7 0 9 12]
					case (inData[i-:3])
						0: outData[i-:3] = 3;
						1: outData[i-:3] = 8;
						2: outData[i-:3] = 15;
						3: outData[i-:3] = 1;
						4: outData[i-:3] = 10;
						5: outData[i-:3] = 6;
						6: outData[i-:3] = 5;
						7: outData[i-:3] = 11;
						8: outData[i-:3] = 14;
						9: outData[i-:3] = 13;
						10: outData[i-:3] = 4;
						11: outData[i-:3] = 2;
						12: outData[i-:3] = 7;
						13: outData[i-:3] = 0;
						14: outData[i-:3] = 9;
						15: outData[i-:3] = 12;
					endcase
				1: // [15 12 2 7 9 0 5 10 1 11 14 8 6 13 3 4]
					case (inData[i-:3])
						0: outData[i-:3] = 15;
						1: outData[i-:3] = 12;
						2: outData[i-:3] = 2;
						3: outData[i-:3] = 7;
						4: outData[i-:3] = 9;
						5: outData[i-:3] = 0;
						6: outData[i-:3] = 5;
						7: outData[i-:3] = 10;
						8: outData[i-:3] = 1;
						9: outData[i-:3] = 11;
						10: outData[i-:3] = 14;
						11: outData[i-:3] = 8;
						12: outData[i-:3] = 6;
						13: outData[i-:3] = 13;
						14: outData[i-:3] = 3;
						15: outData[i-:3] = 4;
					endcase
				2: // [8 6 7 9 3 12 10 15 13 1 14 4 0 11 5 2]
					case (inData[i-:3])
						0: outData[i-:3] = 8;
						1: outData[i-:3] = 6;
						2: outData[i-:3] = 7;
						3: outData[i-:3] = 9;
						4: outData[i-:3] = 3;
						5: outData[i-:3] = 12;
						6: outData[i-:3] = 10;
						7: outData[i-:3] = 15;
						8: outData[i-:3] = 13;
						9: outData[i-:3] = 1;
						10: outData[i-:3] = 14;
						11: outData[i-:3] = 4;
						12: outData[i-:3] = 0;
						13: outData[i-:3] = 11;
						14: outData[i-:3] = 5;
						15: outData[i-:3] = 2;
					endcase
				3: // [0 15 11 8 12 9 6 3 13 1 2 4 10 7 5 14]
					case (inData[i-:3])
						0: outData[i-:3] = 0;
						1: outData[i-:3] = 15;
						2: outData[i-:3] = 11;
						3: outData[i-:3] = 8;
						4: outData[i-:3] = 12;
						5: outData[i-:3] = 9;
						6: outData[i-:3] = 6;
						7: outData[i-:3] = 3;
						8: outData[i-:3] = 13;
						9: outData[i-:3] = 1;
						10: outData[i-:3] = 2;
						11: outData[i-:3] = 4;
						12: outData[i-:3] = 10;
						13: outData[i-:3] = 7;
						14: outData[i-:3] = 5;
						15: outData[i-:3] = 14;
					endcase
				4: // [1 15 8 3 12 0 11 6 2 5 4 10 9 14 7 13]
					case (inData[i-:3])
						0: outData[i-:3] = 1;
						1: outData[i-:3] = 15;
						2: outData[i-:3] = 8;
						3: outData[i-:3] = 3;
						4: outData[i-:3] = 12;
						5: outData[i-:3] = 0;
						6: outData[i-:3] = 11;
						7: outData[i-:3] = 6;
						8: outData[i-:3] = 2;
						9: outData[i-:3] = 5;
						10: outData[i-:3] = 4;
						11: outData[i-:3] = 10;
						12: outData[i-:3] = 9;
						13: outData[i-:3] = 14;
						14: outData[i-:3] = 7;
						15: outData[i-:3] = 13;
					endcase
				5: // [15 5 2 11 4 10 9 12 0 3 14 8 13 6 7 1]
					case (inData[i-:3])
						0: outData[i-:3] = 15;
						1: outData[i-:3] = 5;
						2: outData[i-:3] = 2;
						3: outData[i-:3] = 11;
						4: outData[i-:3] = 4;
						5: outData[i-:3] = 10;
						6: outData[i-:3] = 9;
						7: outData[i-:3] = 12;
						8: outData[i-:3] = 0;
						9: outData[i-:3] = 3;
						10: outData[i-:3] = 14;
						11: outData[i-:3] = 8;
						12: outData[i-:3] = 13;
						13: outData[i-:3] = 6;
						14: outData[i-:3] = 7;
						15: outData[i-:3] = 1;
					endcase
				6: // [7 2 12 5 8 4 6 11 14 9 1 15 13 3 10 0]
					case (inData[i-:3])
						0: outData[i-:3] = 7;
						1: outData[i-:3] = 2;
						2: outData[i-:3] = 12;
						3: outData[i-:3] = 5;
						4: outData[i-:3] = 8;
						5: outData[i-:3] = 4;
						6: outData[i-:3] = 6;
						7: outData[i-:3] = 11;
						8: outData[i-:3] = 14;
						9: outData[i-:3] = 9;
						10: outData[i-:3] = 1;
						11: outData[i-:3] = 15;
						12: outData[i-:3] = 13;
						13: outData[i-:3] = 3;
						14: outData[i-:3] = 10;
						15: outData[i-:3] = 0;
					endcase
				7: // [1 13 15 0 14 8 2 11 7 4 12 10 9 3 5 6]
					case (inData[i-:3])
						0: outData[i-:3] = 1;
						1: outData[i-:3] = 13;
						2: outData[i-:3] = 15;
						3: outData[i-:3] = 0;
						4: outData[i-:3] = 14;
						5: outData[i-:3] = 8;
						6: outData[i-:3] = 2;
						7: outData[i-:3] = 11;
						8: outData[i-:3] = 7;
						9: outData[i-:3] = 4;
						10: outData[i-:3] = 12;
						11: outData[i-:3] = 10;
						12: outData[i-:3] = 9;
						13: outData[i-:3] = 3;
						14: outData[i-:3] = 5;
						15: outData[i-:3] = 6;
					endcase
			endcase
	end

endmodule
