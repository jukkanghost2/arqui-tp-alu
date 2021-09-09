`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2021 09:59:46
// Design Name: 
// Module Name: TOP_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP_tb;
  parameter SIZEDATA = 8;
  parameter N_BUTTONS = 3;
  
	//INPUTS
  reg                       CLK;
  reg   [SIZEDATA - 1:0]    SWITCHES;
  reg   [N_BUTTONS - 1:0]   BUTTONS;
  	//OUTPUTS
  wire  [SIZEDATA - 1:0]    LEDS;
  wire                      C_LED;
  
  ALU_top alu_top_test (
    .CLK        (CLK), 
    .SWITCHES   (SWITCHES), 
    .BUTTONS    (BUTTONS), 
    .LEDS       (LEDS),
    .CLED       (CLED)
  );
  
  initial
    begin
        CLK = 1'b0;
        SWITCHES = 8'b0000; 
		BUTTONS = 8'b0000;
		#10;
    end
    
    always #5 CLK = ~CLK;
endmodule
