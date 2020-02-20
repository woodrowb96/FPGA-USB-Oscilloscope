/*serial in parrallel out for the adcs

This module shifts in 12 bits from the adc's and ouputs those bits in parrallel
*/

module sipo(
	
	input logic sclk,				//25Mhz clock to contoll data transfer from adc
	
	input logic sdata,			//serial data in
	
	input logic [1:0] state,		//state from fsm

	output logic [11:0] data		//12 bits data out



	);
	
	logic [11:0] q;		//shift register
	

	always_ff @ (negedge sclk)		//always at neg edge clk
		begin
			case(state)
				2'b00:data <= data;		//if were in s0,s1 data doesnt get updated
				2'b01:data <= data;
				2'b10:begin					//if were in s2 clock in the data into the shift register
					q <= {q[10:0],sdata};
					data <= data;				//dont update data yet
				end
				2'b11:data <= q;			//in s3 we can update data to be equal to the values in shift register
				default:data <= data;
			endcase;
		end
		
		


endmodule