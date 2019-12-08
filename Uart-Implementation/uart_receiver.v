`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    01:55:13 11/12/2018 
// Design Name: 
// Module Name:    uart_receiver 
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
module uart_receiver(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD, Rx_FERROR, Rx_PERROR, Rx_VALID);

input reset, clk;
input [2:0] baud_select;
input Rx_EN;
input RxD;

output [7:0] Rx_DATA;
output Rx_FERROR;
output Rx_PERROR;
output Rx_VALID;

wire [7:0] Rx_DATA;
wire Rx_FERROR;
wire Rx_PERROR;
wire Rx_VALID;

baud_controller baud_controller_rx_instance(.reset(reset),
														  .clk(clk),
														  .baud_select(baud_select),
														  .sample_ENABLE(Rx_sample_ENABLE)
														  );

data_receive data_receive_rx_instance(.reset(reset),
												  .Rx_EN(Rx_EN),
												  .RxD(RxD),
												  .Rx_sample_ENABLE(Rx_sample_ENABLE),
												  .Rx_DATA(Rx_DATA),
												  .Rx_VALID(Rx_VALID),
												  .Rx_PERROR(Rx_PERROR),
												  .Rx_FERROR(Rx_FERROR)
												  );

endmodule
