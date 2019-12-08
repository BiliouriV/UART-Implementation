`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    23:17:47 11/12/2018 
// Design Name: 
// Module Name:    data_receive 
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
module data_receive(reset, Rx_EN, RxD, Rx_sample_ENABLE, Rx_DATA, Rx_VALID, Rx_PERROR, Rx_FERROR);

input reset;
input Rx_EN;
input RxD;
input Rx_sample_ENABLE;

output [7:0] Rx_DATA;
output Rx_VALID;
output Rx_PERROR;
output Rx_FERROR;

reg [7:0] Rx_DATA;
reg Rx_VALID;
reg Rx_PERROR;
reg Rx_FERROR;

reg [7:0] data_counter;
reg [7:0] temp_data;
reg count_enable;

always @(posedge reset or posedge Rx_sample_ENABLE)
begin
	if (reset)
	begin
		data_counter = 8'b00000000;
		Rx_PERROR = 0;
		Rx_FERROR = 0;
		Rx_VALID = 0;
		Rx_DATA = 8'bx;
		count_enable = 0;
		temp_data = 8'bx;
	end
	else
	begin
		if (Rx_EN)
		begin
			if (RxD == 0)
			begin
				count_enable = 1;
			end
			case (data_counter)
				8'b00011000:
				begin
					temp_data[7] = RxD;
					data_counter = data_counter + 1;
				end
				8'b00101000:
				begin
					temp_data[6] = RxD;
					data_counter = data_counter + 1;
				end
				8'b00111000:
				begin
					temp_data[5] = RxD;
					data_counter = data_counter + 1;
				end
				8'b01001000:
				begin
					temp_data[4] = RxD;
					data_counter = data_counter + 1;
				end
				8'b01011000:
				begin
					temp_data[3] = RxD;
					data_counter = data_counter + 1;
				end
				8'b01101000:
				begin
					temp_data[2] = RxD;
					data_counter = data_counter + 1;
				end
				8'b01111000:
				begin
					temp_data[1] = RxD;
					data_counter = data_counter + 1;
				end
				8'b10001000:
				begin
					temp_data[0] = RxD;
					data_counter = data_counter + 1;
				end
				8'b10011000:
				begin
					if (RxD == temp_data[7] + temp_data[6] + temp_data[5] + temp_data[4] + temp_data[3] + temp_data[2] + temp_data[1] + temp_data[0])
					begin
						Rx_PERROR = 0;
						data_counter = data_counter + 1;
					end
					else
					begin
						Rx_PERROR = 1;
						data_counter = data_counter + 1;
					end
				end
				8'b10101000:
				begin
					data_counter = 8'b00000000;
					if (RxD)
					begin
						Rx_FERROR = 0;
						if (Rx_PERROR == 0)
						begin
							Rx_DATA = temp_data;
							Rx_VALID = 1;
							data_counter = 8'b00000000;
							count_enable = 0;
						end
					end
					else
					begin
						Rx_FERROR = 1;
					end
				end
				default:
				begin
					if (count_enable)
					begin
						data_counter = data_counter + 1;
					end
				end
			endcase
		end
		else 
		begin
			data_counter = 8'b00000000;
			Rx_VALID = 0;
			Rx_FERROR = 0;
			Rx_PERROR = 0;
			Rx_DATA = 8'bx;
			count_enable = 0;
			temp_data = 8'bx;
		end
	end
end




endmodule




