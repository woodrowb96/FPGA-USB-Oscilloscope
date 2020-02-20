module selector(

	input logic [3:0] select,
	

	input logic [7:0] ch_one_th,
	
	input logic [7:0] ch_one_h,
	
	input logic [7:0]	ch_one_t,
	
	input logic [7:0]	ch_one_o,
	
	input logic [7:0]	ch_two_th,
	
	input logic [7:0]	ch_two_h,
	
	input logic [7:0]	ch_two_t,
	
	input logic [7:0]	ch_two_o,
	
	input logic [7:0]	v_scale,
	
	input logic [7:0]	t_scale,
	
	input logic [7:0]	trigger_level,
	
	input logic [7:0]	switch_value,
	
	output logic [7:0] data

	);
	
	always_comb
		begin
			
			case(select)		//select which charecter in the packet to send out over uart
				4'd0:data = 8'd115;		//s
				4'd1:data = ch_one_th;	//channel 1 thousands
				4'd2:data = ch_one_h;
				4'd3:data = ch_one_t;
				4'd4:data = ch_one_o;	//channel 1 ones place 
				4'd5:data = ch_two_th;	//channel 2
				4'd6:data = ch_two_h;
				4'd7:data = ch_two_t;
				4'd8:data = ch_two_o;
				4'd9:data = v_scale;		//1 digit value of voltage rotary encoder
				4'd10:data = t_scale;		//time rotary encoder
				4'd11:data = trigger_level;	//trigger rotary encoder
				4'd12:data = switch_value;		//value of switch
				default:data = 8'd115;
			endcase;
			
		end
				
				
			
	
endmodule