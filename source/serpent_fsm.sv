module serpent_fsm
(
	input wire clk,
	input wire n_rst,
	input wire go,
	output wire [2:0] sBoxSelect,
	output wire [2:0] keyBoxSelect,
	output wire [5:0] round,
	output wire done,
	output wire rst,
	output wire keyLock
);

typedef enum bit [3:0] {IDLE, START, R0, R1, R2, R3, R4, R5, R6, NR7, FR7, END} stateType;
stateType state;
stateType nextState;
reg [3:0] tick;
always_ff @ (negedge n_rst, posedge clk)
begin
	if(1'b0 == n_rst)
	begin
		state <= IDLE;
	end
	else
	begin
		state <= nextState;
	end
end

always_comb
begin
	rcving = 0;
	w_enable = 0;
	r_error = 0;
	case(state)
	IDLE:begin
		done = 1;
		round = 5'b0;
		sBoxSelect = 3'd0;
		keyBoxSelect = 3'd3;
		rst = 1;
		if(go == 1)
		begin
			nextState = START; 
		end
		else
		begin
			nextState = IDLE;
		end
	end
	START:begin
		keyLock = 0;
		if(tick == 7)
		begin
			nextState = R1;
			tick = 0;
			keyLock = 1;
		end
		else
		begin
			tick = tick + 1;
			nextState = START;
		end
	end
	R1:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = R2;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1; 
			keyLock = 1;
		end
		else
		begin
			nextState = R1;
			tick = tick + 1;
		end
	end
	R2:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = R3;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			keyLock = 1;
		end
		else
		begin
			nextState = R2;
			tick = tick + 1;
		end
	end
	R3:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = R4;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			keyLock = 1;
		end
		else
		begin
			nextState = R3;
			tick = tick + 1;
		end
	end
	R4:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = R5;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			keyLock = 1;
		end
		else
		begin
			nextState = R4;
			tick = tick + 1;
		end
	end
	R5:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = R6;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			keyLock = 1;
		end
		else
		begin
			nextState = R5;
			tick = tick + 1;
		end
	end	
	R6:begin
		keyLock = 0;
		if(tick == 3 && round > 29)
		begin
			nextState = FR7;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			keyLock = 1;
		end
		else if(tick == 3)
		begin
			nextState = NR7;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyLock = 1;
		end
		else
		begin
			nextState = R6;
			tick = tick + 1;
		end
	end
	NR7:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = R0;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			keyLock = 1;
		end
		else
		begin
			nextState = NR7;
			tick = tick + 1;
		end
	end
	FR7:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = END;
			tick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			keyLock = 1;
		end
		else
		begin
			nextState = FR7;
			tick = tick + 1;
		end
	end
	END:begin
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = START;
			tick = 0; 
		end
		else
		begin
			tick = tick + 1;
			nextState = END;
		end
	end
	default:begin
		nextState = IDLE;	
	end
endcase
end


endmodule
