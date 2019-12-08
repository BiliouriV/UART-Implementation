`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: 
// 
// Create Date:    23:49:16 10/21/2018 
// Design Name: 
// Module Name:    DigitLoader 
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
module DigitLoader(clk, reset, data, an1, an0, char);

input clk, reset;
input [7:0] data;
output an1, an0;

output [2:0] char;
reg an1, an0;
reg [2:0] char;
reg [2:0] char0;
reg [2:0] char1;
reg [2:0] counter;

always @(data)
begin
	case (data)
		8'b10101010:
		begin
			char0 = 3'b000;
			char1 = 3'b000;
		end
		8'b01010101:
		begin
			char0 = 3'b001;
			char1 = 3'b001;
		end
		8'b11001100:
		begin
			char0 = 3'b010;
			char1 = 3'b010;
		end
		default:					//10001001
		begin
			char0 = 3'b100;
			char1 = 3'b011;
		end
	endcase
end

always @(posedge clk or posedge reset)
begin
	/*case (data)
		8'b10101010:
		begin
			char0 = 3'b000;
			char1 = 3'b000;
		end
		8'b01010101:
		begin
			char0 = 3'b001;
			char1 = 3'b001;
		end
		8'b11001100:
		begin
			char0 = 3'b010;
			char1 = 3'b010;
		end
		8'b10001001:
		begin
			char0 = 3'b011;
			char1 = 3'b100;
		end
	endcase*/
	if(reset)
	begin 
		an1 = 1'b1;
		an0 = 1'b1;
		counter = 3'b111;
		char = char0;
	end
	else if (counter == 3'b111)		 			//checks if counter is 1111 -> no led can light			
	begin
		an1 = 1'b1;
		an0 = 1'b1;
		char = char0;						//char is 0000 to show number 0 when an3 is on, in 1 circle
		counter = counter - 3'b001;
	end
	else if (counter == 3'b110)			// checks if counter is 1110 -> an3 is on
	begin
		an1 = 1'b1;
		an0 = 1'b1;
		counter = counter - 3'b001;
	end
	else if (counter == 3'b101)			//checks if counter is 1101 -> no led can light
	begin
		an1 = 1'b1;
		an0 = 1'b0;
		counter = counter - 3'b001;
	end
	else if (counter == 3'b100)			//checks if counter is 1100 -> no led can light
	begin
		an1 = 1'b1;
		an0 = 1'b1;
		char = char1;						//char is 0001 ready to show number 1 in 2 circles, when an2 is on
		counter = counter - 3'b001;
	end
	else if (counter == 3'b011)			//checks if counter is 1011 -> no led is on
	begin
		an1 = 1'b1;
		an0 = 1'b1;
		counter = counter - 3'b001;
	end
	else if (counter == 3'b010)			//checks if counter is 1010 -> an2 is on
	begin
		an1 = 1'b0;
		an0 = 1'b1;
		counter = counter - 3'b001;
	end
	else if (counter == 3'b001)			//checks if counter is 1001 -> no led can light
	begin
		an1 = 1'b1;
		an0 = 1'b1;
		counter = counter - 3'b001;
	end
	else// if (counter == 3'b000)			//checks if counter is 1000 -> no led can light
	begin
		an1 = 1'b1;
		an0 = 1'b1;
		char = char0;						//char is ready to show number 2 in 2 circles, when an1 is on
		counter = 3'b111;
	end
end



endmodule
