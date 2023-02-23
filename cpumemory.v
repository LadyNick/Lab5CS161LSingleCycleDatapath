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

`define NULL 0
`define MAX_REG 256

module cpumemory #(parameter WORD_SIZE=32,FILENAME="init.coe") (
    input wire clk,
    input wire rst,
    input wire[7:0] instr_read_address,
    output wire[WORD_SIZE-1:0] instr_instruction,
    input wire data_mem_write,   
    input [7:0] data_address,    
    input wire[WORD_SIZE-1:0] data_write_data ,    
    output wire[WORD_SIZE-1:0] data_read_data  
);

// ------------------------------------------
// Init memory 
// ------------------------------------------
	
reg [WORD_SIZE-1:0] buff [`MAX_REG-1:0];

initial begin 
	$readmemb(FILENAME, buff,0,255);
end 

// ------------------------------------------
// Read and Write block 
// ------------------------------------------ 

assign instr_instruction = buff[instr_read_address];
assign data_read_data = buff[data_address];
	
always @(posedge clk) begin 
	if (data_mem_write) begin 
		buff[data_address] = data_write_data;
	end
end 
endmodule
