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

`define WORD_SIZE 32 

module alu (alu_control_in,  channel_a_in , channel_b_in , zero_out , alu_result_out);

// ---------------------------------------------------------
// Input output declarations 
// --------------------------------------------------------- 

input wire [3:0] alu_control_in ;  
input wire [`WORD_SIZE-1:0] channel_a_in ; 
input wire [`WORD_SIZE-1:0] channel_b_in ; 

output reg zero_out ; 
output reg [`WORD_SIZE-1:0] alu_result_out ; 

reg [`WORD_SIZE-1:0] temp ; 

// ---------------------------------------------------------
// Parameters 
// --------------------------------------------------------- 

always @(*) 

begin

	case (alu_control_in)   // R Type Instruction 
	
		`ALU_AND :      temp = channel_a_in & channel_b_in ; 
		`ALU_OR :       temp = channel_a_in | channel_b_in ; 
		`ALU_ADD :      temp = channel_a_in + channel_b_in ; 
		`ALU_SUBTRACT : temp = channel_a_in - channel_b_in ; 
		`ALU_NOR :  temp = ~ (channel_a_in | channel_b_in) ; 
		
		`ALU_LESS_THAN :  
		
						if (channel_a_in < channel_b_in) begin 
							temp = { `WORD_SIZE {1'b1} } ; 
						end 
						
						else begin 
							 temp = { `WORD_SIZE {1'b0} } ; 
						end  
		
		default : temp = { `WORD_SIZE {1'b0} } ; 
	
	endcase

	// Final results 
	
	alu_result_out = temp ; 
	zero_out = (temp == 0) ? 1 : 0 ; 

end 

endmodule
