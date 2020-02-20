module ascii_decoder(
	input logic [11:0] num,
	
	output logic [7:0] thousands,
	
	output logic [7:0] hundreds,
	
	output logic [7:0] tens,
	
	output logic [7:0] ones

);

	always_comb
		begin		//splits 12bit number into it's 4 digits and adds 48 to get its ascii value
			
			
			ones = (num % 10'd10) + 8'd48;
			tens = ( (num / 10'd10) % 10'd10 ) + 8'd48;
			hundreds = ( (num / 10'd100) % 10'd10 ) + 8'd48;
			thousands = ((num / 10'd1000) % 10'd10) + 8'd48;
		
		
		end

endmodule