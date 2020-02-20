//This module is used to slow the de10's 50Mhz clk down to 25Mhz for ADC data transfer


//counting up to the following values will result in the following frequencies
//  0: frequency_slow = frequency_in/2  ,
//	 1: frequency_slow = frequency_in/4
//  2: freq_slow = freq_in/8

module clock_counter_adc(

	input logic clk_in,		//50 Mhz clock in
	
	input logic reset_n,		//reset
	
	output logic clk_slow	//25Mhz clock for sckl
	
	

	);

	logic [13:0] count;		//used to count up 
	

	
	
	always_ff @ (posedge clk_in, negedge reset_n)
		begin//always_ff
			
			
			if(!reset_n)		//if reset clk goes low and count is 0
				
				begin//if
					clk_slow <= 1'b0;
					count <= 1'd0;
				end//if
			
			else if(count >= 14'd0)		//******use this line to determine clk_slow frequency********
												//count up to this many cyles of input clk

				begin//else if
					clk_slow <= ~clk_slow;
					count <= 1'd0;
				end//else if
		
			else
			
				begin//else
					count <= count + 1'd1;	//if we have not yet reached count keep incrementing
				end//else
				
			
		end//always_ff
		


endmodule
