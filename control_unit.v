//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: 
// Email: 
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

//=========================================================================
//
// DO NOT CHANGE ANYTHING BELOW THIS COMMENT. IT IS PROVIDED TO MAKE SURE 
// YOUR LAB IS SUCCESSFULL. 
//
//=========================================================================

`timescale 1ns / 1ps

`include "cpu_constant_library.v"
 
module control_unit (
 input wire[5:0] instr_op   ,   
 output reg	 reg_dst    ,    
 output reg	 branch     ,  
 output reg  mem_read   ,   
 output reg	 mem_to_reg ,   
 output reg  [1:0]	 alu_op     ,  
 output reg  mem_write  ,    
 output reg	 alu_src    ,   
 output reg	 reg_write   );

always @(*)
begin 
	
    reg_dst     = 0;
    branch      = 0;
    mem_read    = 0;
    mem_to_reg  = 0;
    alu_op      = 0;
    mem_write   = 0;
    alu_src     = 0;
    reg_write   = 0;
	 
    case (instr_op)  

	   `OPCODE_R_TYPE :        
					
					begin 	
						reg_dst    = 1;
                  reg_write  = 1;
                  alu_op     = 2;
					end 
					
      `OPCODE_ADDI : 
						begin 
						 alu_src    = 1;
                   reg_write  = 1;
						end 
                                                
      `OPCODE_LOAD_WORD :  
						 begin 
							alu_src    = 1;
                     mem_to_reg = 1;
                     reg_write  = 1;
                     mem_read   = 1;
						 end  	
                                        
      `OPCODE_STORE_WORD :
						begin 
							alu_src    = 1;
							mem_write  = 1;
						end 
                                        
      `OPCODE_BRANCH_EQ :  
		
						begin 
							reg_dst  = 1;
							branch   = 1;
                     alu_op   = 1;
						end 	
                                        
      default :    branch = 0 ; 
        
    endcase;
	 
end 

endmodule
