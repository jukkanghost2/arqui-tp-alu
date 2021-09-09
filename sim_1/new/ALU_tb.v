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
  parameter N_OPS = 8;
  
	//INPUTS
  reg signed    [SIZEDATA - 1:0]    DATOA;
  reg signed    [SIZEDATA - 1:0]    DATOB;
  reg           [SIZEOP - 1:0]      OPCODE;
  	//OUTPUTS
  wire          [SIZEDATA - 1:0]    RESULT;
  wire                              CARRY;
  
  reg [SIZEOP-1:0] OPS[0:N_OPS-1];
  
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
    .RESULT     (RESULT),
    .CARRY      (CARRY)
  );
     
    initial // initial block executes only once
        begin          
            OPS[0] = ADD;
            OPS[1] = SUB;
            OPS[2] = OR;
            OPS[3] = AND;
            OPS[4] = NOR;
            OPS[5] = XOR;
            OPS[6] = SRL;
            OPS[7] = SRA;
        
            for(integer i = 0; i < N_OPS-1; i = i+1)
                begin
                    //SUMA CON CARRY
                    #1 DATOA <= $random;
                    #1 DATOB <= $random;
                    #1 OPCODE <= OPS[i];
                    #1;
                    $display("DATOA %d", DATOA);
                    $display("DATOB %d", DATOB);
                    $display("OPERACION %d", OPCODE);
                    $display("RESULTADO %d", RESULT);
                    $display("CARRY %b", CARRY);
                
                    #period;
                end
            $finish;
        end
endmodule
