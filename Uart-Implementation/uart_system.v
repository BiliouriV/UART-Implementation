`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri 
// 
// Create Date:    02:36:55 11/13/2018 
// Design Name: 
// Module Name:    uart_system 
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
module uart_system(clk, reset, baud_select, Tx_EN, Rx_EN,Tx_WR, Tx_DATA, Tx_BUSY, Rx_DATA, Rx_VALID, Rx_PERROR, Rx_FERROR, an0, an1, led_a, led_b, led_c, led_d, led_e, led_f, led_g, dp);

input clk, reset;
input [2:0] baud_select;
input Tx_EN, Rx_EN, Tx_WR;
input [7:0] Tx_DATA;


output Tx_BUSY;
output [7:0] Rx_DATA;
output Rx_VALID, Rx_PERROR, Rx_FERROR;

output an1, an0;
output led_a, led_b, led_c, led_d, led_e, led_f, led_g, dp;

wire Tx_BUSY;
wire [7:0] Rx_DATA;
wire Rx_VALID;
wire Rx_PERROR;
wire Rx_FERROR;
wire an1, an0;
wire led_a, led_b, led_c, led_d, led_e, led_f, led_g, dp;

wire TxD;
//wire RxD;

uart_transmitter uart_transmitter_INSTANCE(.reset(reset),
														 .clk(clk),
														 .Tx_DATA(Tx_DATA),
														 .baud_select(baud_select),
														 .Tx_WR(Tx_WR),
														 .Tx_EN(Tx_EN),
														 .TxD(TxD),
														 .Tx_BUSY(Tx_BUSY)
														 );

uart_receiver uart_receiver_INSTANCE(.reset(reset),
												 .clk(clk),
												 .Rx_DATA(Rx_DATA),
												 .baud_select(baud_select),
												 .Rx_EN(Rx_EN),
												 .RxD(TxD),
												 .Rx_FERROR(Rx_FERROR),
												 .Rx_PERROR(Rx_PERROR),
												 .Rx_VALID(Rx_VALID)
												 );


FourDigitLEDdriver FourDigitLED_driver_INSTANCE(.reset(reset),
																.data(Rx_DATA),
																.clk(clk),
																.an1(an1),
																.an0(an0),
																.led_a(led_a),
																.led_b(led_b),
																.led_c(led_c),
																.led_d(led_d),
																.led_e(led_e),
																.led_f(led_f),
																.led_g(led_g),
																.dp(dp)
																);

endmodule
