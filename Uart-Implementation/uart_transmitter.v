`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    00:12:20 11/12/2018 
// Design Name: 
// Module Name:    uart_transmitter 
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
module uart_transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);

input reset, clk;
input [7:0] Tx_DATA;
input [2:0] baud_select;
input Tx_EN;
input Tx_WR;

output TxD;
output Tx_BUSY;

wire Tx_sample_ENABLE;
wire TxD;
wire Tx_BUSY;

baud_controller baud_controller_tx_instance(.reset(reset),
														  .clk(clk),
														  .baud_select(baud_select),
														  .sample_ENABLE(Tx_sample_ENABLE)
														  );
														  
data_transfer data_transfer_tx_instance(.reset(reset),
													 .Tx_sample_ENABLE(Tx_sample_ENABLE),
													 .Tx_DATA(Tx_DATA),
													 .Tx_EN(Tx_EN),
													 .Tx_WR(Tx_WR),
													 .Tx_BUSY(Tx_BUSY),
													 .TxD(TxD)
													 );

endmodule
