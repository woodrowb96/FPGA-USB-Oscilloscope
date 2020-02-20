module fifo_fsm(
	input logic clk,
	
	input logic txe,
	
	input logic reset_n,
	
	input logic enable,
	
	output logic [1:0] state,
	
	output logic [3:0] select

	);
	
	parameter s0 = 2'd0;		//reset value at data_out bus
	parameter s1 = 2'd1;		//send value at data_out bus to fifo on ft232h	
	parameter s2 = 2'd2;		//wait for falling edge of enable signal to send next packet
	
	logic [1:0] next_state;
	logic [3:0] next_select;
	
	always_ff@(posedge clk, negedge reset_n)
		begin 
			if(!reset_n)
				begin	//during reset reset back to s0 and select = 0
				
				state <= s0;
				select <= 4'd0;
							
				end
			else
				begin			//next_state and next_select always go to there next values
									
				state <= next_state;
				select <= next_select;
				
				end
		end
		
	always_comb
		begin
			
			case(state)
				
				s0:begin
				

					if(txe == 1'b0 )		//if txe is low we can move to next state and send 
												//value at data_out bus to ft232h
						begin
							next_state = s1;
							
						end
					
					else
						begin
							next_state = s0;	//if txe - 1 stay in this state
							
						end
						
						next_select = select;	// select stays the same
				
				end
				s1:begin
						
					
						if(select <= 4'd11)		//if select <= 11 then incriment select and go back to s1
							begin
								next_select = select + 4'd1;	//increment select to get the next charecter in the packet
								next_state = s0;
							end
						else
							begin
								next_select = 4'd0;	//once all charecters have been sent reset select back to 0
								next_state = s2;		//go to s2 and wait for new sample to send over
							end
							
							
						
				end
				
				s2:begin
				
			
					next_select= 4'd0; 		//select stays at 0
				
					if(enable == 1'b0)			//on falling edge of enable go to s0 and send next packet
						begin
							next_state = s0;
			
						end
						
					else 
						begin
							next_state = s2;	//else stay in this state
	
						end
				
				
				end
				
				default:begin
					next_state = s2;
					next_select = 4'd0;
					
				end
			
			endcase
		
		end
	
endmodule
