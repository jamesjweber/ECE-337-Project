module serpent_fsm
(
	input wire clk,
	input wire go,
	output logic [2:0] sBoxSelect,
	output logic [2:0] keyBoxSelect,
	output logic [5:0] round,
	output logic done,
	output logic rst,
	output logic keyLock,
	output logic fsmGo
);

typedef enum bit [3:0] {IDLE, START, R0, R1, R2, R3, R4, R5, R6, NR7, FR7, END} stateType;
stateType state;
stateType nextState;
reg [2:0] tick;
reg [2:0] newTick;
always_ff @ (posedge clk)
begin
	if(go != 1 && state == IDLE)
	begin
		state <= IDLE;
		tick <= 0;
	end
	else
	begin
		state <= nextState;
		tick <= newTick;
	end
end

always_comb
begin
	newTick = tick + 1;
	case(state)
	IDLE:begin
		keyLock = 0;
		fsmGo = 0;
		done = 1;
		round = 5'b0;
		sBoxSelect = 3'd0;
		keyBoxSelect = 3'd3;
		rst = 1;
		if(go == 1)
		begin
			nextState = START;
			rst = 0;
			done = 0;
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
			nextState = R0;
		end
		else
		begin
			
			nextState = START;
		end
	end
	R0:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		else if(tick == 1)
		begin
			fsmGo = 1;
		end
		else	if(tick == 3)
		begin
			nextState = R1;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1; 
		end
		else
		begin
			nextState = R0;
		end
	end
	R1:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3)
		begin
			nextState = R2;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1; 
		end
		else
		begin
			nextState = R1;
		end
	end
	R2:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3)
		begin
			nextState = R3;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
		end
		else
		begin
			nextState = R2;
		end
	end
	R3:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3)
		begin
			nextState = R4;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
		end
		else
		begin
			nextState = R3;
			
		end
	end
	R4:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3)
		begin
			nextState = R5;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
		end
		else
		begin
			nextState = R4;
			
		end
	end
	R5:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3)
		begin
			nextState = R6;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
		end
		else
		begin
			nextState = R5;
			
		end
	end	
	R6:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3 && round > 29)
		begin
			nextState = FR7;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
		end
		else if(tick == 3)
		begin
			nextState = NR7;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
		end
		else
		begin
			nextState = R6;
			
		end
	end
	NR7:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3)
		begin
			nextState = R0;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
		end
		else
		begin
			nextState = NR7;
			
		end
	end
	FR7:begin
		keyLock = 0;
		if(tick == 0)
		begin
			keyLock = 1;
		end
		if(tick == 3)
		begin
			nextState = END;
			newTick = 0;
			round = round + 1;
			sBoxSelect = sBoxSelect + 1;
			keyBoxSelect = keyBoxSelect - 1;
			done = 1;
		end
		else
		begin
			nextState = FR7;
			
		end
	end
	END:begin
		done = 1;
		keyLock = 0;
		if(tick == 3)
		begin
			nextState = IDLE;
			newTick = 0;
		end
		else
		begin
			
			nextState = END;
		end
	end
	default:begin
		nextState = IDLE;	
	end
endcase
end


endmodule
