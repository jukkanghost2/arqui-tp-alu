`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UNC - FCEFyN
// Engineer: Daniele Francisco; Gonzalez Julian
// 
// Create Date: 09.09.2021 08:34:19
// Design Name: 
// Module Name: ALU
// Project Name: TP_ALU
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


module ALU
#(
    //PARAMETERS
    parameter   SIZEDATA = 8,
                SIZEOP = 6
)
(
  //INPUTS
  input      [SIZEDATA - 1:0]   DATOA,
  input      [SIZEDATA - 1:0]   DATOB,
  input      [SIZEOP - 1:0]     OPCODE,
  //OUTPUTS
  output     [SIZEDATA - 1:0]   RESULT,
  output                        CARRY
);
  
  //OPERATIONS
  localparam [SIZEOP - 1:0]     ADD = 6'b100000;
  localparam [SIZEOP - 1:0]     SUB = 6'b100010;
  localparam [SIZEOP - 1:0]     OR = 6'b100101;
  localparam [SIZEOP - 1:0]     XOR = 6'b100110;
  localparam [SIZEOP - 1:0]     AND = 6'b100100;
  localparam [SIZEOP - 1:0]     NOR = 6'b100111;
  localparam [SIZEOP - 1:0]     SRA = 6'b000011;
  localparam [SIZEOP - 1:0]     SRL = 6'b000010;
  
  reg signed [SIZEDATA:0]       TEMP;
  
  assign RESULT = TEMP[SIZEDATA - 1:0];
  assign CARRY = TEMP[SIZEDATA];
  
  always@(*)
    begin
      case(OPCODE)
        ADD: TEMP = DATOA + DATOB;
        SUB: TEMP = DATOA - DATOB;
        OR:  TEMP = DATOA | DATOB;
        XOR: TEMP = DATOA ^ DATOB;
        AND: TEMP = DATOA & DATOB;
        NOR: TEMP = ~(DATOA | DATOB);
        SRA: TEMP = DATOA >>> DATOB;
        SRL: TEMP = DATOA >> DATOB;
        default: TEMP = 0;
      endcase
    end
endmodule
