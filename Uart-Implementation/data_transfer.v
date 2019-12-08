`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    00:48:18 11/12/2018 
// Design Name: 
// Module Name:    data_transfer 
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
module data_transfer(reset, Tx_sample_ENABLE, Tx_DATA, Tx_EN, Tx_WR, Tx_BUSY, TxD);

input reset;
input Tx_sample_ENABLE;
input [7:0] Tx_DATA;
input Tx_EN;
input Tx_WR;

output Tx_BUSY;
output TxD;

reg Tx_BUSY;
reg TxD;
reg [3:0] enable_counter;
reg [3:0] data_counter;
reg write_enable;

wire parity_bit;

assign parity_bit = Tx_DATA[7] + Tx_DATA[6] + Tx_DATA[5] + Tx_DATA[4] + Tx_DATA[3] + Tx_DATA[2] + Tx_DATA[1] + Tx_DATA[0];

always @(posedge reset or posedge Tx_sample_ENABLE)
begin
	if (reset)
	begin
		Tx_BUSY = 0;
		TxD = 1;
		enable_counter = 4'b0000;
		data_counter = 4'b0000;
		write_enable = 0;
	end
	else
	begin
		if (Tx_EN)
		begin
			if (Tx_WR)
			begin
				write_enable = 1;
			end
			else if (write_enable)
			begin
				enable_counter = enable_counter + 1;
				if (enable_counter == 4'b1111)
				begin
					case (data_counter)	
						4'b0000:					//start bit
						begin
							TxD = 0;
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b0001:					//1st symbol character
						begin
							TxD = Tx_DATA[7];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b0010:					//2nd symbol character
						begin
							TxD = Tx_DATA[6];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b0011:					//3rd symbol character
						begin
							TxD = Tx_DATA[5];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b0100:					//4th symbol character
						begin
							TxD = Tx_DATA[4];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b0101:					//5th symbol character
						begin
							TxD = Tx_DATA[3];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b0110:					//6th symbol character
						begin
							TxD = Tx_DATA[2];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b0111:					//7th symbol character
						begin
							TxD = Tx_DATA[1];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b1000:					//8th symbol character
						begin
							TxD = Tx_DATA[0];
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b1001:					//parity bit
						begin
							TxD = parity_bit;
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						4'b1010:					//stop bit
						begin
							TxD = 1;
							Tx_BUSY = 1;
							data_counter = data_counter + 1;
						end
						default:
						begin
							data_counter = 4'b0000;					//data_counter returns to its initial value
							TxD = 1;
							Tx_BUSY = 0;
							write_enable = 0;
						end			
					endcase
				end
			end
		end
		else 
		begin
			Tx_BUSY = 0;
			TxD = 1;
			enable_counter = 4'b0000;
			data_counter = 4'b0000;
			write_enable = 0;
		end
	end
	
	
end






/*
always @(posedge Tx_sample_ENABLE or posedge reset)
begin
	if (reset)
	begin
		enable_counter = 4'b0000;
		data_counter = 4'b0000;
		Tx_BUSY = 0;
		TxD = 1;
		write_enable = 0;
	end
	else
	begin
		if (Tx_EN)
		begin
			if (Tx_WR)										//when Tx_WR = 1
			begin
				write_enable = 1;
				if (write_enable)
				begin
					if (Tx_sample_ENABLE)
					begin
						if (enable_counter == 4'b1111)		//16 sample_ENABLE circles
						begin
							parity_bit = Tx_DATA[7] + Tx_DATA[6] + Tx_DATA[5] + Tx_DATA[4] + Tx_DATA[3] + Tx_DATA[2] + Tx_DATA[1] + Tx_DATA[0];
							case (data_counter)	
								4'b0000:					//start bit
								begin
									TxD = 0;
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b0001:					//1st symbol character
								begin
									TxD = Tx_DATA[7];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b0010:					//2nd symbol character
								begin
									TxD = Tx_DATA[6];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b0011:					//3rd symbol character
								begin
									TxD = Tx_DATA[5];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b0100:					//4th symbol character
								begin
									TxD = Tx_DATA[4];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b0101:					//5th symbol character
								begin
									TxD = Tx_DATA[3];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b0110:					//6th symbol character
								begin
									TxD = Tx_DATA[2];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b0111:					//7th symbol character
								begin
									TxD = Tx_DATA[1];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b1000:					//8th symbol character
								begin
									TxD = Tx_DATA[0];
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b1001:					//parity bit
								begin
									TxD = parity_bit;
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								4'b1010:					//stop bit
								begin
									TxD = 1;
									Tx_BUSY = 1;
									data_counter = data_counter + 1;
								end
								default:
								begin
									data_counter = 4'b0000;					//data_counter returns to its initial value
									TxD = 1;
									Tx_BUSY = 0;
								end			
							endcase
							enable_counter = 4'b0000;			//enable_counter returns to its initial value
						end			
						else
						begin
						enable_counter = enable_counter + 1;	
						end
					end
					else
					begin 
						enable_counter = 4'b0000;
						data_counter = 4'b0000;
						TxD = 1;
						Tx_BUSY = 0;
					end
				end
			end
			else
			begin
				write_enable = 0;
			end
			end
			else
			begin
				enable_counter = 4'b0000;
				data_counter = 4'b0000;
				Tx_BUSY = 0;
				TxD = 1;
				write_enable = 0;
			end
		end
	end
*/

endmodule
