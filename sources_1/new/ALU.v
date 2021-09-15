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
  input         [SIZEDATA - 1:0]   DATOA,
  input         [SIZEDATA - 1:0]   DATOB,
  input         [SIZEOP - 1:0]     OPCODE,
  //OUTPUTS
  output reg    [SIZEDATA - 1:0]   RESULT
);
  
  //OPERATIONS
  localparam [SIZEOP - 1:0]     ADD = 6'b100000;
  localparam [SIZEOP - 1:0]     SUB = 6'b100010;
  localparam [SIZEOP - 1:0]     OR  = 6'b100101;
  localparam [SIZEOP - 1:0]     XOR = 6'b100110;
  localparam [SIZEOP - 1:0]     AND = 6'b100100;
  localparam [SIZEOP - 1:0]     NOR = 6'b100111;
  localparam [SIZEOP - 1:0]     SRA = 6'b000011;
  localparam [SIZEOP - 1:0]     SRL = 6'b000010;
  
  reg signed [SIZEDATA - 1:0]   DATOSIGA;

  always@(*)
    begin
      case(OPCODE)
        ADD: RESULT = DATOA + DATOB;
        SUB: RESULT = DATOA - DATOB;
        OR:  RESULT = DATOA | DATOB;
        XOR: RESULT = DATOA ^ DATOB;
        AND: RESULT = DATOA & DATOB;
        NOR: RESULT = ~(DATOA | DATOB);
        SRA: 
            begin
                DATOSIGA = DATOA;
                RESULT = DATOSIGA >>> DATOB;
            end
        SRL:
            begin
                DATOSIGA = DATOA;
                RESULT = DATOSIGA >> DATOB;
            end
        default: RESULT = 0;
      endcase
    end
endmodule
