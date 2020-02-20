 module rotary_encoder_decoder(
	
	input logic a,
	
	input logic b,

	//output logic [7:0] rotary_value		//ascii value of r encoder
	
	output logic [11:0] rotary_value

	);
	
	logic [1:0] num;
	
	always_comb		//combine the 2 bits of the rotary encoder into the first 2 bits of a 12 bit number
						//and convert it into its ascii vallue
		begin
			num = {a,b};
			
			rotary_value = num + 8'd48;		//add 48 to get its ascii value
			
		end
	
endmodule
	
	