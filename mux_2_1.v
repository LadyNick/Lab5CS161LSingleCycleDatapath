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

module mux_2_1 (select_in, datain1, datain2, data_out);

// Parameters 
parameter WORD_SIZE = 32 ; 

// Input and outputs 
// Modelling with Continuous Assignments 

input  wire select_in ;  
input  wire [WORD_SIZE-1:0] datain1 ; 
input  wire [WORD_SIZE-1:0] datain2 ; 
output wire [WORD_SIZE-1:0] data_out ;

assign data_out = (select_in) ? datain2 : datain1;

endmodule
