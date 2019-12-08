`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    22:41:28 11/11/2018 
// Design Name: 
// Module Name:    baud_controller 
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
module baud_controller(reset, clk, baud_select, sample_ENABLE);

input reset, clk;
input [2:0] baud_select;
output sample_ENABLE;

reg sample_ENABLE;
reg [13:0] counter;

always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		sample_ENABLE = 0;
		counter = 14'b0;
	end
	else
	begin
		if (baud_select == 3'b000)
		begin
			counter = counter + 1;
			if (counter == 14'b10100010101111)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
		else if (baud_select == 3'b001)
		begin
			counter = counter + 1;
			if (counter == 14'b00101000101100)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
		else if (baud_select == 3'b010)
		begin
			counter = counter + 1;
			if (counter == 14'b00001010001011)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
		else if (baud_select == 3'b011)
		begin
			counter = counter + 1;
			if (counter == 14'b00000101000110)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
		else if (baud_select == 3'b100)
		begin
			counter = counter + 1;
			if (counter == 14'b00000010100011)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
		else if (baud_select == 3'b101)
		begin
			counter = counter + 1;
			if (counter == 14'b00000001010001)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
		else if (baud_select == 3'b110)
		begin
			counter = counter + 1;
			if (counter == 14'b00000000110110)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
		else
		begin
			counter = counter + 1;
			if (counter == 14'b00000000011011)
			begin
				sample_ENABLE = 1;
				counter = 14'b0;
			end
			else 
			begin
				sample_ENABLE = 0;
			end
		end
	end
end

endmodule
