/* This modified multiplexer from past labs output each players score to a different seven seg display

*/

module multiplexer( 

	input logic [11:0] num,
	
	
	input logic [2:0] sel,
	
	output logic [3:0] out

);



	always_comb                    //The case statemetn bellow looks at the selects signal and outputs one of the input signals depending on the value of select
		begin
			case(sel)
				0: out = num % 10'd10;
				1: out = (num / 7'd10) % 10'd10;
				3: out = (num / 7'd100) % 10'd10;
				4: out = (num / 10'd1000) % 10'd10;
				default: out = 4'b0001;
			endcase
		
		end
		
endmodule 
