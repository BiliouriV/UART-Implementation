`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    01:47:17 10/07/2018 
// Design Name: 
// Module Name:    LEDdecoder 
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

//This module decodes the characters that we want to be displayed 
//and combines the characters with the led lights that should be open
//characters : 0123456789abcdEF 

module LEDdecoder(char, LED);

input [2:0] char;
output [6:0] LED;

wire [6:0] LED;
reg led_a, led_b, led_c, led_d, led_e, led_f, led_g;

always @(char)
begin
	if (char == 4'b000)       //if char is 000, design A with led lights
	begin 
		led_a = 1'b0;
		led_b = 1'b0;
		led_c = 1'b0;
		led_d = 1'b1;
		led_e = 1'b0;
		led_f = 1'b0;
		led_g = 1'b0;
	end
	else if (char == 4'b001)	//if char is 001, design number 5 with led lights
	begin
		led_a = 1'b0;
		led_b = 1'b1;
		led_c = 1'b0;
		led_d = 1'b0;
		led_e = 1'b1;
		led_f = 1'b0;
		led_g = 1'b0;
	end
	else if (char == 4'b010)  //if char is 010, design C with led lights
	begin
		led_a = 1'b0;
		led_b = 1'b1;
		led_c = 1'b1;
		led_d = 1'b0;
		led_e = 1'b0;
		led_f = 1'b0;
		led_g = 1'b1;
	end
	else if (char == 4'b011)  //if char is 011, design number 8 with led lights
	begin
		led_a = 1'b0;
		led_b = 1'b0;
		led_c = 1'b0;
		led_d = 1'b0;
		led_e = 1'b0;
		led_f = 1'b0;
		led_g = 1'b0;
	end
	else //if (char == 4'b100)  //if char is 100, design number 9 with led lights
	begin
		led_a = 1'b0;
		led_b = 1'b0;
		led_c = 1'b0;
		led_d = 1'b0;
		led_e = 1'b1;
		led_f = 1'b0;
		led_g = 1'b0;
	end
end
	
//combine all the led lights to 7bit LED

assign LED[6] = led_a;
assign LED[5] = led_b;
assign LED[4] = led_c;
assign LED[3] = led_d;
assign LED[2] = led_e;
assign LED[1] = led_f;
assign LED[0] = led_g;

endmodule
