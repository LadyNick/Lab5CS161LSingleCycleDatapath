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

`timescale 1ns / 1ps
`include "cpu_constant_library.v"
module processor #(parameter WORD_SIZE=32,MEM_FILE="init.coe") (
    input clk,
    input rst,   
	 // Debug signals 
    output [WORD_SIZE-1:0] prog_count, 
    output [5:0] instr_opcode,
    output [4:0] reg1_addr,
    output [WORD_SIZE-1:0] reg1_data,
    output [4:0] reg2_addr,
    output [WORD_SIZE-1:0] reg2_data,
    output [4:0] write_reg_addr,
    output [WORD_SIZE-1:0] write_reg_data 
);

// ----------------------------------------------
// Insert solution below here
// ----------------------------------------------

    assign prog_count = pc_out;
    assign instr_opcode = instruction_out[31:26];
    assign reg1_addr = instruction_out[25:21];
    assign reg2_addr = instruction_out[20:16];
    assign write_reg_addr = instruction_out[15:11];

    alu pc_adder(
        .alu_control_in(`ALU_ADD), 
        .channel_a_in(pc_out), 
        .channel_b_in(32'h4), 
        .alu_result_out(pc_in));

    //Wires for the PC
    wire [WORD_SIZE-1:0] pc_in;
    wire [WORD_SIZE-1:0] pc_out;

    gen_register PC(
        .clk(clk), 
        .rst(rst), 
        .write_en(clk), 
        .data_in(pc_in), 
        .data_out(pc_out));

    //Wires for the insruction
    wire [WORD_SIZE-1:0] instruction_out;

    cpumemory RAM(
        .clk(clk), 
        .rst(rst), 
        .instr_read_address(), 
        .instr_instruction(), 
        .data_address(), 
        .data_write_data(), 
        .data_read_data());

    





endmodule
