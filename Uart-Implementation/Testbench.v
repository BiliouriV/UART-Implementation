`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
//
// Create Date:   00:46:04 11/14/2018
// Design Name:   uart_system
// Module Name:   C:/Users/Victoria Biliouris/Desktop/LAB2_2138/LAB2_2138_partD_additional/Testbench_partD_additional.v
// Project Name:  LAB2_2138_partD_additional
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_system
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Testbench;

	// Inputs
	reg clk;
	reg reset;
	reg [2:0] baud_select;
	reg Tx_EN;
	reg Rx_EN;
	reg Tx_WR;
	reg [7:0] Tx_DATA;

	// Outputs
	wire Tx_BUSY;
	wire [7:0] Rx_DATA;
	wire Rx_VALID;
	wire Rx_PERROR;
	wire Rx_FERROR;
	wire an0;
	wire an1;
	wire led_a;
	wire led_b;
	wire led_c;
	wire led_d;
	wire led_e;
	wire led_f;
	wire led_g;
	wire dp;

	// Instantiate the Unit Under Test (UUT)
	uart_system uut (
		.clk(clk), 
		.reset(reset), 
		.baud_select(baud_select), 
		.Tx_EN(Tx_EN), 
		.Rx_EN(Rx_EN), 
		.Tx_WR(Tx_WR), 
		.Tx_DATA(Tx_DATA), 
		.Tx_BUSY(Tx_BUSY), 
		.Rx_DATA(Rx_DATA), 
		.Rx_VALID(Rx_VALID), 
		.Rx_PERROR(Rx_PERROR), 
		.Rx_FERROR(Rx_FERROR), 
		.an0(an0), 
		.an1(an1), 
		.led_a(led_a), 
		.led_b(led_b), 
		.led_c(led_c), 
		.led_d(led_d), 
		.led_e(led_e), 
		.led_f(led_f), 
		.led_g(led_g), 
		.dp(dp)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		baud_select = 0;
		Tx_EN = 0;
		Rx_EN = 0;
		Tx_WR = 0;
		Tx_DATA = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		#100 reset = 1;
		#300 reset = 0;
		
		#100 baud_select = 3'b111;
		
		#100 Tx_EN = 1;
		Rx_EN = 1;
		#100 Tx_DATA = 8'b10101010;
		
		#100 Tx_WR = 1;
		#200 Tx_WR = 0;
		
		#100000000 Tx_DATA = 8'b10001001;
		
		#100 Tx_WR = 1;
		#700 Tx_WR = 0;
		
	end
    
	always
		#10 clk = !clk;
	
endmodule

