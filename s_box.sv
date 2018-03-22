module s_box
(
	input wire [2:0] sel,
	input wire [127:0] inData,
	output wire [127:0] outData
);

	integer i;

	always_comb
	begin
		for(i = 3; i < 128; i += 4)
		begin
			case(sel)
				3'd0:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'h3;
						4'h1: outData[i:i-3] = 4'h8;
						4'h2: outData[i:i-3] = 4'hF;
						4'h3: outData[i:i-3] = 4'h1;
						4'h4: outData[i:i-3] = 4'hA;
						4'h5: outData[i:i-3] = 4'h6;
						4'h6: outData[i:i-3] = 4'h5;
						4'h7: outData[i:i-3] = 4'hB;
						4'h8: outData[i:i-3] = 4'hE;
						4'h9: outData[i:i-3] = 4'hD;
						4'hA: outData[i:i-3] = 4'h4;
						4'hB: outData[i:i-3] = 4'h2;
						4'hC: outData[i:i-3] = 4'h7;
						4'hD: outData[i:i-3] = 4'h0;
						4'hE: outData[i:i-3] = 4'h9;
						4'hF: outData[i:i-3] = 4'hC;
					endcase
				end

				3'd1:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'hF;
						4'h1: outData[i:i-3] = 4'hC;
						4'h2: outData[i:i-3] = 4'h2;
						4'h3: outData[i:i-3] = 4'h7;
						4'h4: outData[i:i-3] = 4'h9;
						4'h5: outData[i:i-3] = 4'h0;
						4'h6: outData[i:i-3] = 4'h5;
						4'h7: outData[i:i-3] = 4'hA;
						4'h8: outData[i:i-3] = 4'h1;
						4'h9: outData[i:i-3] = 4'hB;
						4'hA: outData[i:i-3] = 4'hE;
						4'hB: outData[i:i-3] = 4'h8;
						4'hC: outData[i:i-3] = 4'h6;
						4'hD: outData[i:i-3] = 4'hD;
						4'hE: outData[i:i-3] = 4'h3;
						4'hF: outData[i:i-3] = 4'h4;
					endcase
				end

				3'd2:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'h8;
						4'h1: outData[i:i-3] = 4'h6;
						4'h2: outData[i:i-3] = 4'h7;
						4'h3: outData[i:i-3] = 4'h9;
						4'h4: outData[i:i-3] = 4'h3;
						4'h5: outData[i:i-3] = 4'hC;
						4'h6: outData[i:i-3] = 4'hA;
						4'h7: outData[i:i-3] = 4'hF;
						4'h8: outData[i:i-3] = 4'hD;
						4'h9: outData[i:i-3] = 4'h1;
						4'hA: outData[i:i-3] = 4'hE;
						4'hB: outData[i:i-3] = 4'h4;
						4'hC: outData[i:i-3] = 4'h0;
						4'hD: outData[i:i-3] = 4'hB;
						4'hE: outData[i:i-3] = 4'h5;
						4'hF: outData[i:i-3] = 4'h2;
					endcase
				end

				3'd3:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'h0;
						4'h1: outData[i:i-3] = 4'hF;
						4'h2: outData[i:i-3] = 4'hB;
						4'h3: outData[i:i-3] = 4'h8;
						4'h4: outData[i:i-3] = 4'hC;
						4'h5: outData[i:i-3] = 4'h9;
						4'h6: outData[i:i-3] = 4'h6;
						4'h7: outData[i:i-3] = 4'h3;
						4'h8: outData[i:i-3] = 4'hD;
						4'h9: outData[i:i-3] = 4'h1;
						4'hA: outData[i:i-3] = 4'h2;
						4'hB: outData[i:i-3] = 4'h4;
						4'hC: outData[i:i-3] = 4'hA;
						4'hD: outData[i:i-3] = 4'h7;
						4'hE: outData[i:i-3] = 4'h5;
						4'hF: outData[i:i-3] = 4'hE;
					endcase
				end

				3'd4:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'h1;
						4'h1: outData[i:i-3] = 4'hF;
						4'h2: outData[i:i-3] = 4'h8;
						4'h3: outData[i:i-3] = 4'h3;
						4'h4: outData[i:i-3] = 4'hC;
						4'h5: outData[i:i-3] = 4'h0;
						4'h6: outData[i:i-3] = 4'hB;
						4'h7: outData[i:i-3] = 4'h6;
						4'h8: outData[i:i-3] = 4'h2;
						4'h9: outData[i:i-3] = 4'h5;
						4'hA: outData[i:i-3] = 4'h4;
						4'hB: outData[i:i-3] = 4'hA;
						4'hC: outData[i:i-3] = 4'h9;
						4'hD: outData[i:i-3] = 4'hE;
						4'hE: outData[i:i-3] = 4'h7;
						4'hF: outData[i:i-3] = 4'hD;
					endcase
				end

				3'd5:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'hF;
						4'h1: outData[i:i-3] = 4'h5;
						4'h2: outData[i:i-3] = 4'h2;
						4'h3: outData[i:i-3] = 4'hB;
						4'h4: outData[i:i-3] = 4'h4;
						4'h5: outData[i:i-3] = 4'hA;
						4'h6: outData[i:i-3] = 4'h9;
						4'h7: outData[i:i-3] = 4'hC;
						4'h8: outData[i:i-3] = 4'h0;
						4'h9: outData[i:i-3] = 4'h3;
						4'hA: outData[i:i-3] = 4'hE;
						4'hB: outData[i:i-3] = 4'h8;
						4'hC: outData[i:i-3] = 4'hD;
						4'hD: outData[i:i-3] = 4'h6;
						4'hE: outData[i:i-3] = 4'h7;
						4'hF: outData[i:i-3] = 4'h1;
					endcase
				end

				3'd6:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'h7;
						4'h1: outData[i:i-3] = 4'h2;
						4'h2: outData[i:i-3] = 4'hC;
						4'h3: outData[i:i-3] = 4'h5;
						4'h4: outData[i:i-3] = 4'h8;
						4'h5: outData[i:i-3] = 4'h4;
						4'h6: outData[i:i-3] = 4'h6;
						4'h7: outData[i:i-3] = 4'hB;
						4'h8: outData[i:i-3] = 4'hE;
						4'h9: outData[i:i-3] = 4'h9;
						4'hA: outData[i:i-3] = 4'h1;
						4'hB: outData[i:i-3] = 4'hF;
						4'hC: outData[i:i-3] = 4'hD;
						4'hD: outData[i:i-3] = 4'h3;
						4'hE: outData[i:i-3] = 4'hA;
						4'hF: outData[i:i-3] = 4'h0;
					endcase
				end
			
				3'd7:
				begin
					case(inData[i:i-3])
						4'h0: outData[i:i-3] = 4'h1;
						4'h1: outData[i:i-3] = 4'hD;
						4'h2: outData[i:i-3] = 4'hF;
						4'h3: outData[i:i-3] = 4'h0;
						4'h4: outData[i:i-3] = 4'hE;
						4'h5: outData[i:i-3] = 4'h8;
						4'h6: outData[i:i-3] = 4'h2;
						4'h7: outData[i:i-3] = 4'hB;
						4'h8: outData[i:i-3] = 4'h7;
						4'h9: outData[i:i-3] = 4'h4;
						4'hA: outData[i:i-3] = 4'hC;
						4'hB: outData[i:i-3] = 4'hA;
						4'hC: outData[i:i-3] = 4'h9;
						4'hD: outData[i:i-3] = 4'h3;
						4'hE: outData[i:i-3] = 4'h5;
						4'hF: outData[i:i-3] = 4'h6;
					endcase
				end
			endcase
		end
	end

endmodule