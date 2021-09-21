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
  wire  signed [SIZEDATA - 1:0]    RESULT;
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
    .RESULT     (RESULT)
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
            
                      
        DATOA = 8'b0;
        DATOB = 8'b0;
        OPCODE = 6'b0;
        #10
        
            
        
     for(integer i = 0; i < N_OPS; i = i+1) 
		     begin
		     #(period)
		       DATOA =  $urandom; 
		      
		       #(period*2);
		       
		        DATOB = $urandom;
		       if( i > 5) DATOB = 3; //PARA OPS SRA Y SRL
		
		       #(period*2);
                
                
		      OPCODE = OPS[i]; 
		       #(period*2);
		       case(i)
		          0: if((DATOA + DATOB) != RESULT) $display("%d %d %d %d error en suma", DATOA, DATOB, RESULT, DATOA + DATOB);
		          1: if((DATOA - DATOB) != RESULT) $display("%d %d %d %d error en resta", DATOA, DATOB, RESULT, DATOA - DATOB);
		          2: if((DATOA | DATOB) != RESULT) $display("%b %b %b %b error en or", DATOA, DATOB, RESULT, DATOA | DATOB);
		          3: if((DATOA & DATOB) != RESULT) $display("%b %b %b %b error en and", DATOA, DATOB, RESULT, DATOA & DATOB);
		          4: if(~(DATOA | DATOB) != RESULT) $display("%b %b %b %b error en nor", DATOA, DATOB, RESULT, ~(DATOA | DATOB));
		          5: if((DATOA ^ DATOB) != RESULT) $display("%b %b %b %b error en xor", DATOA, DATOB, RESULT, DATOA ^ DATOB);
		          6: if((DATOA >> DATOB) != RESULT) $display("%b %b %b %b error en srl", DATOA, DATOB, RESULT, DATOA >> DATOB);
		          7: if((DATOA >>> DATOB) != RESULT) $display("%b %b %b %b error en sra", DATOA, DATOB, RESULT, DATOA >>> DATOB);
		       endcase
		       
		      end
		      #(period);

            $finish;
        
            
     end
       
endmodule
