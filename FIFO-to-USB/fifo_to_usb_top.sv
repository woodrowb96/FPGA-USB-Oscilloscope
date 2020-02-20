module fifo_to_usb(  //top level module
	
	output logic [7:0] data_out,	//8 bit data bus out to ft232h fifo-usb bridge
	
	input logic txe,		//active low transmit enable, when low data can be written to ft232h fifo 
	
	input logic clk_in,	//60Mhz clock signal from ft232h board
	
	input logic reset_n,	//active low to reset the entire module
	
	input logic enable,		//from adc_driver, send new packet into ft232h fifo on falling edge
	
	
	input logic [11:0] ch_one_volt,	//digital voltage values from adc_driver
	
	input logic [11:0] ch_two_volt,

	input logic a_v,//2 bit rotary encoder values
	input logic b_v,//voltage
	input logic a_t,//time
	input logic b_t,
	input logic a_tr,//trigger
	input logic b_tr,
	input logic switch,//channel select switch
	
	
	
	output logic wr, // active low writte enable to the ft232h board
							//when signal is low ft232h reads in whatever data is on the bus each 60mhz clock cycle
	
	output logic siwu	//always high, sent out to ft232h board

	);
	
	logic [1:0] state;
	
	logic [3:0] select;
	
	logic [7:0] data_in;
	
	////
	
	logic [7:0] ch_one_th;
	
	logic [7:0] ch_one_h;
	
	logic [7:0]	ch_one_t;
	
	logic [7:0]	ch_one_o;
	
	logic [7:0]	ch_two_th;

	logic [7:0]	ch_two_h;
	
	logic [7:0]	ch_two_t;
	
	logic [7:0]	ch_two_o;
	
	logic [7:0]	v_scale;
	
	logic [7:0]	t_scale;
	
	logic [7:0]	trigger_level;
	
	logic [7:0]	switch_value;
	
	

	
	fifo_driver fifo_driver(
	
		.state(state),

		.data_out(data_out),
		
		.data_in(data_in),
	
		.wr(wr),
	
		.siwu(siwu)
		
		
		
		);
		
	fifo_fsm fifo_fsm(

		.clk(clk_in),
		
		.txe(txe),
		
		.reset_n(reset_n),
		
		.enable(enable),
	
		.state(state),
		
		.select(select)

		);
		
	
	
	selector selector(
	
		.select(select),
	
		.ch_one_th(ch_one_th),
	
		.ch_one_h(ch_one_h),
	
		.ch_one_t(ch_one_t),
	
		.ch_one_o(ch_one_o),
	
		.ch_two_th(ch_two_th),
	
		.ch_two_h(ch_two_h),
	
		.ch_two_t(ch_two_t),
	
		.ch_two_o(ch_two_o),
		
		.v_scale(v_scale),
	
		.t_scale(t_scale),
	
		.trigger_level(trigger_level),
	
		.switch_value(switch_value),

		.data(data_in)

	);
	
	ascii_decoder ch_one(
		.num(ch_one_volt),
	
		.thousands(ch_one_th),
	
		.hundreds(ch_one_h),
	
		.tens(ch_one_t),
	
		.ones(ch_one_o)

	);
	
	ascii_decoder ch_two(
		
		.num(ch_two_volt),
	
		.thousands(ch_two_th),
	
		.hundreds(ch_two_h),
	
		.tens(ch_two_t),
	
		.ones(ch_two_o)

	);
	
	rotary_encoder_decoder volt_knob(
	
	.a(a_v),
	
	.b(b_v),

	.rotary_value(v_scale)

	);
	
	rotary_encoder_decoder time_knob(
	
	.a(a_t),
	
	.b(b_t),

	.rotary_value(t_scale)

	);
	
	rotary_encoder_decoder trigger_knob(
	
	.a(a_tr),
	
	.b(b_tr),

	.rotary_value(trigger_level)

	);
	
	 switch_ascii_decoder witch_ascii_decoder(
	
		.switch(switch),
	 
		.switch_value(switch_value)

	);
	
endmodule
