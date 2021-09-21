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
  reg                       RESET;
  reg    [SIZEDATA - 1:0]    SWITCHES;
  reg   [N_BUTTONS - 1:0]   BUTTONS;
  	//OUTPUTS
  wire  [SIZEDATA - 1:0]    LEDS;
  reg [SIZEOP-1:0] OPS[0:N_OPS-1];
  reg   signed [SIZEDATA - 1:0]   DATOA;
  reg   signed [SIZEDATA - 1:0]   DATOB;
  reg  signed [SIZEDATA - 1:0] RESULT;

  
   // duration for each bit = 10 * timescale = 10 * 1 ns  = 10ns
  localparam                        period = 20;
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
    .RESET      (RESET),
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
		    RESET = 1;
		    #20
		    RESET = 0;
		    #40

		    for(integer i = 0; i < N_OPS; i = i+1) 
		     begin
		     #(period)
		       SWITCHES = $random; 
		       DATOA = SWITCHES;
		       BUTTONS = 3'b001; //DATOA
		       #(period*2);
		       
		       SWITCHES = $random;
		       if( i > 5) SWITCHES = 3; //PARA OPS SRA Y SRL
		       DATOB = SWITCHES;
		
		       BUTTONS = 3'b010; //DATOB
		       
		       #(period*2);
                
                
		      SWITCHES = OPS[i]; 
		      BUTTONS = 3'b100; //OPCODE
		       #(period*2);
		       RESULT = LEDS;
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
       
       
     always #(period/2) CLK = ~CLK;
endmodule
