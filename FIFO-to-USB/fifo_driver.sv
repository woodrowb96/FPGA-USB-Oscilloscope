module fifo_driver(

	input logic [1:0] state,
	
	input logic [7:0] data_in,

	output logic [7:0] data_out,
	
	output logic wr,
	
	output logic siwu
	

	);
	

	
	parameter s0 = 2'd0;	//
	parameter s1 = 2'd1;
	parameter s2 = 2'd2;
	
	always_ff@(*)
		begin
						
			siwu <= 1'd1;
			
			case(state)
				s0:begin
					
					wr <= 1'd1;	//fifo no longer reads data in
					data_out <= data_in;	//update data_out with new data_in
				
				end
				s1:begin
					
					wr <= 1'd0;			//fifo can read in data from data_out bus
					data_out <= data_out;		//data_out doesnt get updated
					
				
				end
				
				s2:begin
					
					wr <= 1'd1;		//fifo cant read data at data_out bus
					data_out <= data_in;
					
				
				end
				default:begin
					
					wr <= 1'd1;			//fifo cant read data at data_out bus
					data_out <= data_in;
					
					
				end
			endcase;
		end
	
endmodule
