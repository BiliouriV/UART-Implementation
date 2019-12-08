`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Thessaly
// Engineer: Viktoria Biliouri
// 
// Create Date:    00:22:03 10/22/2018 
// Design Name: 
// Module Name:    AntiBounce 
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


//In this module, we create a synchronizer and an antibounce curcuit
//for the buttons that we use in the project.
//The signal should be passed by 2 Flip Flops in order to synchronize
//with the clock period
//Then we should count the number of bounces and stabilize our signal


module AntiBounce(clk, button, final_button);

input clk, button;
output final_button;
reg sync_button, tmp_button, final_button;
reg [14:0] counter;            //check purposes
//reg [3:0] counter;

always @(posedge clk)   		//1st flip flop
begin
	tmp_button = button;
end

always @(posedge clk)			//2nd flip flop
begin
	sync_button = tmp_button;
end

//we estimate how many bounces the button will make 
//when we press it for about 0.08 sec.

always @(posedge clk or negedge sync_button)
begin
	if(sync_button == 0)
	begin
		counter = 15'b000000000000000;
		final_button = 0;
	end
	else if(sync_button)										//every time button is 1 counter increases
	begin
		counter = counter + 15'b000000000000001;
		if (counter > 15'b110000110101000)				//if it reaches its high value stabilize the button
		begin
			final_button = 1;
			counter = counter - 15'b000000000000001;
		end
		else 
		begin
			final_button = 0;
		end
	end		
end


//the content below is for check purposes

/*always @(posedge clk or negedge sync_button)
begin
	if(sync_button == 0)
	begin
		counter = 4'b0000;
		final_button = 0;
	end
	else if(sync_button)
	begin
		counter = counter + 4'b0001;
		if (counter > 4'b1000)
		begin
			final_button = 1;
			counter = counter - 4'b0001;
		end
		else 
		begin
			final_button = 0;
		end
	end		
end*/


endmodule
