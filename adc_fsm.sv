/*
This state machine controlles the data aquesition process., and sends cotroll signals to the adc's

This moduel has the state register and next state logic and output logic. 

The state is output to the sipo module, which shifts in bits from the adc
for the state machine.
*/


module fsm(

	input logic clk,		//25Mhz clock 
	
	input logic [4:0] count,		//count how many clock cycles have passed
	
	input logic reset_n,			//active low signal to reset module
	
	output logic cs,			//controll signal 
	
	output logic reset_cnt_n,	//reset counter
	
	output logic [1:0] state,	
	
	output logic enable  //enable sent to fifo_usb_driver block during s1

	);
	

	logic [1:0] state_next;
	
	parameter s0 = 2'd0;			//Idle state, wait for  enough clock cycles for  t_quiet to pass 
	parameter s1 = 2'd1;			//reset counter
	parameter s2 = 2'd2;			//read in data, wait for 14 clock cycles
	parameter s3 = 2'd3;			//reset counter
	
	always_ff @ (posedge clk, negedge reset_n)//state register
		begin
			if(!reset_n)
				begin
					state <= s0;
				end
			
			else
				begin
					state <= state_next;		//state always goea to next state
				end
		end
		
	always_comb		//next state and output logic
		begin

			case(state)
				s0:begin						//state s0
					
					
					cs = 1'b1;					//cs and count reset are both high
					reset_cnt_n  =1'b1;
					
					enable = 1'b1;
					//2 = 1.25M, 8 = 1M
					if(count < 5'd2)			//if enough clk cycles havent passed stay in s0
						state_next = s0;
						
					else							//else go to next state
						state_next = s1;
					
				
				end
				s1:begin					//state s1
				
				
					cs = 1'b1;					//reset_cnt_n goes low to reset count
					reset_cnt_n = 1'b0;
					state_next = s2;			//allways go to next state
					
					enable = 1'b0;
				
				end
			
			s2:begin								//state s2
					
					
					cs = 1'b0;					//cs goes low to start serial data transfer
					reset_cnt_n = 1'b1;
					
					enable = 1'b1;
					
					if(count < 5'd14)		//if 14 cycles havent passed stay in s2
						state_next = s2;
					else
						state_next = s3;		//after 14 clk cycles go to next state
				
				end
				
				s3:begin			// state s3
				
				
					cs = 1'b1;					//cs goes high to end serial transfer
					reset_cnt_n = 1'b0;		//reset the clock to get ready for s0
					state_next = s0;			//always go to s0 next
					
					enable = 1'b1;
				end
				
				default:begin			//default
					cs = 1'b1;
					reset_cnt_n = 1'b1;
					state = s0;
					state_next = s0;
					enable = 1'b1;
				end
			endcase
		
		
		end
	
endmodule 