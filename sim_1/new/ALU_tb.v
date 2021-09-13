`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2021 08:40:25
// Design Name: 
// Module Name: ALU_tb
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


module alu_tb;
  parameter SIZEDATA = 8;
  parameter SIZEOP = 6;
  
	//INPUTS
  reg signed    [SIZEDATA - 1:0]    DATOA;
  reg signed    [SIZEDATA - 1:0]    DATOB;
  reg           [SIZEOP - 1:0]      OPCODE;
  	//OUTPUTS
  wire          [SIZEDATA - 1:0]    RESULT;
  
 
   // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
  localparam                        period = 20;
  localparam    [SIZEOP - 1:0]      ADD = 6'b100000;
  localparam    [SIZEOP - 1:0]      SUB = 6'b100010;
  localparam    [SIZEOP - 1:0]      OR = 6'b100101;
  localparam    [SIZEOP - 1:0]      XOR = 6'b100110;
  localparam    [SIZEOP - 1:0]      AND = 6'b100100;
  localparam    [SIZEOP - 1:0]      NOR = 6'b100111;
  localparam    [SIZEOP - 1:0]      SRA = 6'b000011;
  localparam    [SIZEOP - 1:0]      SRL = 6'b000010;

  ALU alu_test (
    .DATOA      (DATOA), 
    .DATOB      (DATOB), 
    .OPCODE     (OPCODE), 
    .RESULT     (RESULT)
  );
     
    initial // initial block executes only once
        begin          
        DATOA = 8'b0;
        DATOB = 8'b0;
        OPCODE = 6'b0;
        #10
     
        DATOA = 7;
        DATOB = 2;
        OPCODE = ADD;
        #5
        if (RESULT == 9)
        $display ("passed");
        else 
         begin
        $display ("error");
        $stop;
        end
        
        #10
        
        OPCODE = SUB;
        #5
        if (RESULT == 5)
        $display ("passed");
        else 
         begin
        $display ("error");
        $stop;
        end
        
       
    
            $finish;
        end
endmodule
