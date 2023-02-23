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

module processor_tb;

// Inputs
reg clk;
reg rst;

// Outputs
wire [31:0] prog_count;
wire [5:0] instr_opcode;
wire [4:0] reg1_addr;
wire [31:0] reg1_data;
wire [4:0] reg2_addr;
wire [31:0] reg2_data;
wire [4:0] write_reg_addr;
wire [31:0] write_reg_data;

// -------------------------------------------------------
// Setup output file for possible debugging uses
// -------------------------------------------------------
initial begin
    $dumpfile("lab05.vcd");
    $dumpvars(0);
end

processor #(.MEM_FILE("individualInstructions.coe")) uut (
    .clk(clk),
    .rst(rst),
    .prog_count(prog_count),
    .instr_opcode(instr_opcode),
    .reg1_addr(reg1_addr),
    .reg1_data(reg1_data),
    .reg2_addr(reg2_addr),
    .reg2_data(reg2_data),
    .write_reg_addr(write_reg_addr),
    .write_reg_data(write_reg_data)
);
  
initial begin 
    clk = 0; rst = 1; #50; 
    clk = 1; rst = 1; #50; 
    clk = 0; rst = 0; 
         
    forever begin 
        #5 clk = ~clk;
    end 
end 

reg[31:0] result;
reg[31:0] expected;
integer last_instruction; 
integer passedTests = 0;
integer totalTests = 0;
initial begin
    /* Testing an entire program... last_instruction is the PC of the last instruction to execute */
    /*wait (prog_count == last_instruction)
    result = write_reg_data;
    $write("Test Case 1: (init.coe)...");
    totalTests = totalTests + 1;
    expected = 172;
    if (result == expected) begin
        passedTests = passedTests + 1;
        $display("passed.");
    end else begin
        $display("failed. Expected %0d but got %0d",expected,result);
    end*/

   /* Individual tests... Check the result after each instruction */
    @(negedge rst); // Wait for reset
    @(posedge clk); // Skip LW instruction

    @(posedge clk); #1; 
    totalTests = totalTests + 1;
    $write("Test Case %0d: add $a0, $v0, V1...", totalTests);
    if (write_reg_addr === 4 && write_reg_data === 535) begin
        passedTests = passedTests + 1;
        $display("passed.");
    end else begin
        $display("failed.");
    end

    @(posedge clk); #1;
    totalTests = totalTests + 1;
    $write("Test Case %0d: addi $a0, $v0, 100...", totalTests);
    if (write_reg_addr === 4 && write_reg_data === 461) begin
        passedTests = passedTests + 1;
        $display("passed.");
    end else begin
        $display("failed.");
    end

    $display("------------------------------------------------------------------");
    $display("Testing complete\nPassed %0d / %0d tests.",passedTests,totalTests);
    $display("------------------------------------------------------------------");
    $finish();
end
endmodule
