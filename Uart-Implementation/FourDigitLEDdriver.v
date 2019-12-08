`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    01:55:46 10/07/2018 
// Design Name: 
// Module Name:    FourDigitLEDdriver 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//This module displays characters 0123 

module FourDigitLEDdriver(reset, data, clk, an1, an0, led_a, led_b, led_c, led_d, led_e, led_f, led_g, dp);
input clk, reset;
input [7:0] data;
output an1, an0;
output led_a, led_b, led_c, led_d, led_e, led_f, led_g, dp;

wire dcm_clk;
wire CLK0;
wire an1, an0;
wire sync_reset;
wire [2:0] char;
wire led_a, led_b, led_c, led_d, led_e, led_f, led_g, dp;
wire [6:0] LED;

AntiBounce AntiBounceINSTANCE(
						.clk(clk),
						.button(reset),
						.final_button(sync_reset)
						);



//we use a clock 16 times slower than the clock of FPGA

DCM #(
      .SIM_MODE("SAFE"),  // Simulation: "SAFE" vs. "FAST", see "Synthesis and Simulation Design Guide" for details
      .CLKDV_DIVIDE(16.0), // Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
                          //   7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
      .CLKFX_DIVIDE(1),   // Can be any integer from 1 to 32
      .CLKFX_MULTIPLY(4), // Can be any integer from 2 to 32
      .CLKIN_DIVIDE_BY_2("FALSE"), // TRUE/FALSE to enable CLKIN divide by two feature
      .CLKIN_PERIOD(0.0),  // Specify period of input clock
      .CLKOUT_PHASE_SHIFT("NONE"), // Specify phase shift of NONE, FIXED or VARIABLE
      .CLK_FEEDBACK("1X"),  // Specify clock feedback of NONE, 1X or 2X
      .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
                                            //   an integer from 0 to 15
      .DFS_FREQUENCY_MODE("LOW"),  // HIGH or LOW frequency mode for frequency synthesis
      .DLL_FREQUENCY_MODE("LOW"),  // HIGH or LOW frequency mode for DLL
      .DUTY_CYCLE_CORRECTION("TRUE"), // Duty cycle correction, TRUE or FALSE
      .FACTORY_JF(16'hC080),   // FACTORY JF values
      .PHASE_SHIFT(0),     // Amount of fixed phase shift from -255 to 255
      .STARTUP_WAIT("FALSE")   // Delay configuration DONE until DCM LOCK, TRUE/FALSE
   ) DCM_inst (
      .CLK0(CLK0),     // 0 degree DCM CLK output
      .CLKDV(dcm_clk),   // Divided DCM CLK out (CLKDV_DIVIDE)
      .CLKFB(CLK0),   // DCM clock feedback
      .CLKIN(clk),   // Clock input (from IBUFG, BUFG or DCM)
      .RST(sync_reset)        // DCM asynchronous reset input
   );
	
	
DigitLoader DigitLoaderINSTANCE(
						.clk(dcm_clk),
						.reset(sync_reset),
						.data(data),
						.an1(an1),
						.an0(an0),
						.char(char)
						);
					
LEDdecoder LEDdecoderINSTANCE (.char(char), .LED(LED));  //call LEDdecoder to decode which led light for every character

//assign 0 or 1 values in every led light

assign led_a = LED[6];   
assign led_b = LED[5];
assign led_c = LED[4];
assign led_d = LED[3];
assign led_e = LED[2];
assign led_f = LED[1];
assign led_g = LED[0];

assign dp = 1'b1;   		//dp value is always 1

endmodule

