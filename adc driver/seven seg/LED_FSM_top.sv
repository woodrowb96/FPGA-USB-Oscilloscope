//seven seg top from past lab with no parser and modified multiplexer*/

module LED_FSM_top( 
	/**************************/
	/* Set inputs and outputs */
	/* to the whole FPGA here */
	/**************************/
	//input logic reset_n, //be sure to set this input to PullUp, or connect the pin to 3.3V
	
	input logic clk,
	
	input logic [11:0] num,
	
	output logic [6:0] h0,

	output logic [6:0] h1,
	
	output logic [6:0] h2,
	
	output logic [6:0] h3
	
	
	);
		/*******************************/
		/* Set internal variables here */
		/*******************************/
	
		logic clk_slow;	//used for slowed down, 5 Hz clock
		logic [3:0] mult_out;
		logic [2:0] state;
		logic [6:0] s;
		
		/***********************/
		/* Define modules here */
		/***********************/
		
		
		multiplexer seven_seg_mult( 

				.num(num),
				.sel(state),
				.out(mult_out)

			);
			
		decoder seven_seg_dec(

			.din(mult_out),	
			
			.s(s)
			

		);
		
		selector_seven_seg select(
		
			.s(s),
			
			.sel(state),
		
		   .h0(h0),
			
			.h1(h1),
			
			.h2(h2),
			
			.h3(h3)
		);



		
		state_machine FSM_1(
			.clk_i(clk),
			//.reset_n(reset_n),
			.state(state));
			

endmodule
