/*
This is the top level for the adc_driver module

this module sends control signals to the 2 adcs,

and reads in the sample with a pair of sipo modules.


There is also a module called LED_FSM_top, which drives

a sev seg display which was used to debug. 

*/

module adc_driver(

	input logic clk,		//50Mhz clock
	input logic sdata_ch2,	//serial data from adc
	input logic sdata_ch1,
	input logic reset_n, //reset
	
	output logic sclk,	//25Mhz clock tro adc

	output logic cs,		//controll signal to adc
	
	output logic enable, //enable signal to fifo to start new burt of data

	
	output logic [11:0] data_ch1, //12 bit digital data read in from adc
	output logic [11:0] data_ch2,
  
 

	// seven seg output logic if seven seg driver module is connected
	
	output logic [6:0] h0,

	output logic [6:0] h1,
	
	output logic [6:0] h2,
	
	output logic [6:0] h3
	


	);
	
	logic [1:0]state;		//state of fsm
	logic [4:0] count;	//count of counter
	logic reset_count;	//reset the counter

	
	
	clock_counter_adc clk_count(
		.clk_in(clk),
		.reset_n(reset_n),
		.clk_slow(sclk)
	
	
	);
	
	
	counter counter(
		.sclk(sclk),
		.reset_n(reset_count),
		.count(count)
	
	);
	
	fsm fsm(			//fsm drives sipo for both channels

		.clk(sclk),
		.reset_n(reset_n),
		.count(count),	
		.cs(cs),
		.reset_cnt_n(reset_count),
		.state(state),
		.enable(enable)
	);
	
	sipo sipo_ch_one( 	//sipo for channel one
	
	.sclk(sclk),
	
	.sdata(sdata_ch1),
	
	.state(state),
	
	.data(data_ch1)
	

	);

	sipo sipo_ch_two(		//sipo for channel two
	
	.sclk(sclk),
	
	.sdata(sdata_ch2),
	
	.state(state),
	
	.data(data_ch2),
	

	);
	
	 

	LED_FSM_top LED_FSM_top(  //Can Output one of the channels digital value to 7 seb to debug
	
	.clk(sclk),
	
	.num(data_ch2),
	
	.h0(h0),

	.h1(h1),
	
	.h2(h2),
	
	.h3(h3)
	
	
	);
	



endmodule