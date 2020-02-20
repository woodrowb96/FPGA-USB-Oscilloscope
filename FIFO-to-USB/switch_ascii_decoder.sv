 module switch_ascii_decoder(
	
	input logic switch,
	
	output logic [7:0] switch_value

	);
	
	
	always_comb
		begin
			switch_value = switch + 8'd48;		//add 48 to get the ascii value of the switches current state
			
		end
	
endmodule
	