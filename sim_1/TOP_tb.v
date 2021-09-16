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
  parameter SIZEOP = 6;
  parameter N_BUTTONS = 3;
  parameter N_OPS = 8;

	//INPUTS
  reg                       CLK;
  reg   [SIZEDATA - 1:0]    SWITCHES;
  reg   [N_BUTTONS - 1:0]   BUTTONS;
  	//OUTPUTS
  wire  [SIZEDATA - 1:0]    LEDS;
  reg   [SIZEOP-1:0]        OPS[0:N_OPS-1];

  
   // duration for each bit = 10 * timescale = 10 * 1 ns  = 10ns
  localparam                        period = 10;
  localparam    [SIZEOP - 1:0]      ADD = 6'b100000;
  localparam    [SIZEOP - 1:0]      SUB = 6'b100010;
  localparam    [SIZEOP - 1:0]      OR = 6'b100101;
  localparam    [SIZEOP - 1:0]      XOR = 6'b100110;
  localparam    [SIZEOP - 1:0]      AND = 6'b100100;
  localparam    [SIZEOP - 1:0]      NOR = 6'b100111;
  localparam    [SIZEOP - 1:0]      SRA = 6'b000011;
  localparam    [SIZEOP - 1:0]      SRL = 6'b000010;
  
  ALU_top alu_top_test (
    .CLK        (CLK), 
    .SWITCHES   (SWITCHES), 
    .BUTTONS    (BUTTONS), 
    .LEDS       (LEDS)
  );
  
  initial
    begin          
      OPS[0] = ADD;
      OPS[1] = SUB;
      OPS[2] = OR;
      OPS[3] = AND;
      OPS[4] = NOR;
      OPS[5] = XOR;
      OPS[6] = SRL;
      OPS[7] = SRA;
            
      CLK = 1'b0;
      SWITCHES = 8'b0; 
		  BUTTONS = 3'b0;
		  #period;

		  for(integer i = 0; i < N_OPS-1; i = i+1) 
		    begin
          SWITCHES = $random; 
          BUTTONS = 3'b001; //DATOA        
          #period;
          
          SWITCHES = $random; 
          BUTTONS = 3'b010; //DATOB               
          #period;
    
          SWITCHES = OPS[i]; 
          BUTTONS = 3'b100; //OPCODE                
          #period;
		    end
		    
      $finish;
    end
    
  always @(BUTTONS)
    begin
      $display("SWITCHES %d", SWITCHES);
      $display("BOTON %b", BUTTONS);
      $display("RESULT %d", LEDS);
    end

  always #(period/2) CLK = ~CLK;

endmodule