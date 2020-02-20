module tx_driver(
	
	input logic [7:0] data,		//8bits of data to be sent over uart
	
	input logic clk,			//clk, that sets the baud rate
	
	input logic reset_n,		//active low reset
	

	output logic [3:0] select,		//select sent out to selector to select which part of 8bits charecter of the packet
											// is being sent this moment to tx
		
	output logic tx			//serial output 
	
	);
		
		logic [7:0] q;			//register holding the 8 data bits
		logic [3:0] count;		//count how many clk cycles have passed	
		logic [1:0] state;		//current state 
		logic [1:0] next_state;
		logic [3:0] next_select;	
		
		parameter s0 = 2'd0;		//start bit and update value in register q
		parameter s1 = 2'd1;		//transmite data and stop
		parameter s2 = 2'd2;		//idle and move to next select
	
	
	always_ff@(posedge clk, negedge reset_n)
		begin
			
			
			if(!reset_n)
				begin
					state <= s0;
					select <= 0;
					count <= 0;
				end
			
			
			else		//if its not being reset
				begin
					state <= next_state;			//state and seleect always go to there next value
					select <= next_select;
					
					if(state == 2'b1)				//if were in s1(data transmite state) we need to count clk cycles
						begin
							count <= count + 1'b1;
						end
				
				else							//else we dont and just have count at 0
						begin
							count <= 1'b0;
						end
				end
	
	
	
		end
		
	always_ff@(*)
		begin
		
			case(state)			//state will determine what is sent over tx for this clk cycle
				
				
				s0:begin					//state0: start bit, and update value in q
				
					tx <= 1'b0;			//send a start bit of 0
					next_state <= s1;	//alwasy go to s1 next
					q <= data;			//update q to be what is currently in data bus
					
					next_select <= select;		//select does not change
				
				end
				
				s1:begin						//s1: 8 data bits  and stop bit are sent
					
						q <= q;							//q is constant during this state
						next_select <= select;		//select stays the same
	
			
					if(count <= 4'd7)		//if count is less than 7
						begin	
											
							tx <= q[count];	//send bit 0 through 7 stored in q over tx
							next_state <= s1;		//stay in this state next clk cycle
							
						end
						
					else			//if count is creater than 7
						begin
							tx <= 1'b1;			//send stop bit
							next_state <= s2;		//move to next state 
						end
					
						
				end
				s2:begin			//s2: idle and update select
				
					q <= q;		//q stays constant
					tx <= 1'b1;		//tx is HIGH
					next_state <= s0;	//always go to s0 after this stae
					
					
					
					if(select <= 4'd11)			//as long as sel is less than 11 we can keep incrementing it
						next_select <= select + 4'b1;
					else								//if state is greater than 11 send it back to 0
						next_select <= 4'd0;
					
				
				end
				default:begin			//default restart at s0
					next_state <= s0;
					q <= data;
					
					next_select <= 4'd0;
					
				end
			endcase
		end
	
	
	
endmodule