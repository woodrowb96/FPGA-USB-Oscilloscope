/* This is the top level module for the USB SOCilloscope*/


module usb_oscope(

	
	/////adc io/////	

	input logic clk,
	
	input logic sdata_ch2,	//serial data sent from adc
	
	input logic sdata_ch1,
	
	input logic reset_n,
	
	output logic sclk_ch1,	//serial clk to adc
	
	output logic sclk_ch2,
	
	output logic cs_ch1,		//cs to adcs
	
	output logic cs_ch2,
	
	
	//////fifo io//////
	input logic txe,			//txe signal from fifo to usb chip
	
	input logic clk_in,		//clk from fifo to usb 
	
	input logic a_v,			//voltage Rotary encoder
	input logic b_v,
	input logic a_t,			//time rotary encoder
	input logic b_t,
	input logic a_tr,			//trigger level rotary encoder
	input logic b_tr,
	input logic switch,		//channel select switch
		
	output logic [7:0] data_out,		//adc samples out
	
	output logic wr,			//write enable signal to fifo
	
	output logic siwu,		//always high
	
	
	
	
	/////seven seg////////	
	output logic [6:0] h0,
	
	output logic [6:0] h1,
	
	output logic [6:0] h2,
	
	output logic [6:0] h3
	

	);
	
	logic cs;
	
	logic sclk;
	
	logic [11:0] data_ch1;
	
	logic [11:0] data_ch2;
	
	logic enable;
	
	always_comb
		begin
			sclk_ch1 = sclk;
			
			sclk_ch2 = sclk;
			
			cs_ch1 = cs;
			
			cs_ch2 = cs;
		end
	
	
	
	
	adc_driver adc_driver(

		.clk(clk),		
		.sdata_ch1(sdata_ch1),	
		.sdata_ch2(sdata_ch2),
		.reset_n(reset_n), 
		.sclk(sclk),	
		.cs(cs),		
		.data_ch1(data_ch1), 
		.data_ch2(data_ch2),		
		.h0(h0),
		.h1(h1),
		.h2(h2),
		.h3(h3),
		
		.enable(enable)
		

	);
	
	
	
	
	fifo_to_usb fifo_to_usb(
	
		.data_out(data_out),
	
		.txe(txe),
	
		.clk_in(clk_in),
	
		.reset_n(reset_n),
	
		.enable(enable),
	
		.ch_one_volt(data_ch1),
	
		.ch_two_volt(data_ch2),

		.a_v(a_v),
		.b_v(b_v),
		.a_t(a_t),
		.b_t(b_t),
		.a_tr(a_tr),
		.b_tr(b_tr),
		.switch(switch),
	
	
	
		.wr(wr),
	
		.siwu(siwu)

	);
	
	
	

	
endmodule