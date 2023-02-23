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

module alu_control (	
	input wire [1:0]	alu_op,	
	input wire [5:0]	instruction_5_0,	
	output reg [3:0] 	alu_out   
);

always @(*)
begin 

 if (alu_op==2'b00) begin // LW and SW 
	alu_out = `ALU_ADD ; 
 end 

 else if (alu_op==2'b01) begin  // Branch 
		alu_out = `ALU_SUBTRACT ; 
 end 
	
 else begin 
	
	case (instruction_5_0)   // R Type Instruction 
		`FUNCT_AND : 		 alu_out = `ALU_AND ; 
		`FUNCT_OR  : 		 alu_out = `ALU_OR ; 
		`FUNCT_ADD : 		 alu_out = `ALU_ADD ; 
		`FUNCT_SUBTRACT  : alu_out = `ALU_SUBTRACT ; 
		`FUNCT_LESS_THAN : alu_out = `ALU_LESS_THAN ; 
		`FUNCT_NOR  : 		 alu_out = `ALU_NOR ; 
		default    :       alu_out = `ALU_ADD ;      
	endcase 
	
  end // End else 

end  // End block 

endmodule
