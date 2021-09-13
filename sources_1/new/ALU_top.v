`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2021 09:13:40
// Design Name: 
// Module Name: ALU_top
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


module ALU_top
#(
    //PARAMETERS
    parameter   SIZEDATA = 8,
                SIZEOP = 6,
                N_BUTTONS = 3
)
(
  //INPUTS
  input                         CLK,
  input      [SIZEDATA - 1:0]   SWITCHES,
  input      [N_BUTTONS - 1:0]  BUTTONS,
  //OUTPUTS
  output     [SIZEDATA - 1:0]   LEDS,
  output                        C_LED
);

  reg signed [SIZEDATA - 1:0]   DATOA;
  reg signed [SIZEDATA - 1:0]   DATOB;
  reg        [SIZEOP - 1:0]     OPCODE;
    
  ALU
  Modu_ALU(.DATOA          (DATOA),
           .DATOB          (DATOB),
           .OPCODE         (OPCODE),
           .RESULT         (LEDS)      
  );
  
  always @(posedge CLK)
    begin
        if(BUTTONS[0] == 1'b1)
            DATOA   <= SWITCHES;
        if(BUTTONS[1] == 1'b1)
            DATOB   <= SWITCHES;
        if(BUTTONS[2] == 1'b1)
            OPCODE  <= SWITCHES;           
    end
endmodule
