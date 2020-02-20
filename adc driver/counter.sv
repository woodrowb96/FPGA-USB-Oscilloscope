module counter(	//counts the  number of clock cycles since the last resent_n

	input logic sclk,		//25Mhz clock	
	
	input reset_n,			//active low reset count to 0
	
	output logic [4:0] count		

	);
	
	always_ff @(negedge sclk, negedge reset_n)	//count the number of negative falling edge
		begin
			if(!reset_n)			//if reset set count to 0
				count <= 5'd0;			
			else
				count <= count + 5'd1;		//else increment count
			
		end
	

endmodule
