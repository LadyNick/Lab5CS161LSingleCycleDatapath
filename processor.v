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
    assign write_reg_addr = writeregmuxout;
    assign write_reg_data = step4muxout;
    assign reg1_data = regdata1;
    assign reg2_data = regdata2;
    assign instr_extend = instruction_out[15:0]; //step 2?
    wire [WORD_SIZE-1:0] step4muxout; 
    wire [WORD_SIZE-1:0] writeregmuxout;
    wire [WORD_SIZE-1:0] regdata1;
    wire [WORD_SIZE-1:0] regdata2;
    wire regdstselectin;
    wire branchandmux;
    wire memreaddatamem;
    wire memtoregmux;
    wire [1:0] aluopaluctrl;
    wire memwritedatamem;
    wire alusrcmux;
    wire regwriteregwrite;
    //wire [WORD_SIZE-1:0] datamuxwritedataout;
    wire zero;
    wire [WORD_SIZE-1:0] aluout;
    wire [3:0] aluctrloutalu;
    wire [WORD_SIZE-1:0] alumuxout;
    wire [WORD_SIZE-1:0] datamemmuxchan2;
    wire [WORD_SIZE-1:0] pcadderout;
    wire [WORD_SIZE-1:0] step5muxchan2;

    alu pc_adder(
        .alu_control_in(`ALU_ADD), 
        .channel_a_in(pc_out), 
        .channel_b_in(32'h4), 
        .alu_result_out(pcadderout));

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

    cpumemory #(.FILENAME(MEM_FILE)) RAM( //Instruction memory, also for step 4 cpumemory module
        .clk(clk), 
        .rst(rst), 
        .instr_read_address(pc_out[9:2]), 
        .instr_instruction(instruction_out),
        .data_mem_write(memwritedatamem),
        .data_address(aluout[7:0]),
        .data_write_data(regdata2),
        .data_read_data(datamemmuxchan2)
    );   

    //STEP 2

    control_unit Control(
        .instr_op(instr_opcode),
        .reg_dst(regdstselectin), 
        .branch(branchandmux),
        .mem_read(memreaddatamem),
        .mem_to_reg(memtoregmux),
        .alu_op(aluopaluctrl),
        .mem_write(memwritedatamem),
        .alu_src(alusrcmux),
        .reg_write(regwriteregwrite));

    cpu_registers Registers(
        .clk(clk),
        .rst(rst),
        .reg_write(regwriteregwrite),
        .read_register_1(reg1_addr),
        .read_register_2(reg2_addr),
        .write_register(writeregmuxout[4:0]), //expects 5 bits 
        .write_data(step4muxout), 
        .read_data_1(regdata1), 
        .read_data_2(regdata2)); 

    mux_2_1 WriteRegMux(
        .select_in(regdstselectin),
        .datain1({27'd0, reg2_addr}),
        .datain2({27'd0, instruction_out[15:11]}),
        .data_out(writeregmuxout));

    //STEP 3
    alu_control ALUControl(
        .alu_op(aluopaluctrl), 
        .instruction_5_0(instruction_out[5:0]),
        .alu_out(aluctrloutalu)); 


   //check for sign of instruction_out 16 bits
    wire extend;

    always @(posedge clk)begin
        extend[32:0] <= { {16{instruction_out[15]}}, instruction_out[15:0]};
    end

    /*if(instruction_out[15] == 0)
        assign extend = {16'h0000, instruction_out[15:0]};
    else
        assign extend = {16'hFFFF, instruction_out[15:0]};
    */

    mux_2_1 MuxAlu(
        .select_in(alusrcmux),
        .datain1(regdata2),
        .datain2(extend), //sign extend inst 15-0 to 32 bits
        .data_out(alumuxout));

    alu ALU(
        .alu_control_in(aluctrloutalu), 
        .channel_a_in(regdata1),
        .channel_b_in(alumuxout),
        .zero_out(zero),
        .alu_result_out(aluout));

    //STEP 4
    mux_2_1 step4mux(
        .select_in(memtoregmux),
        .datain1(aluout),
        .datain2(datamemmuxchan2),
        .data_out(step4muxout));


    /*cpumemory DataMemory(
        .clk(clk),
        .rst(rst),
        //.instr_read_address(), TA says we can ignore these
        //.instr_instruction(),
        .data_mem_write(memwritedatamem),
        .data_address(aluout[7:0]),
        .data_write_data(regdata2),
        .data_read_data(datamemmuxchan2)); */

        //TA also said to ignore memread signal
    //STEP 5

    wire [WORD_SIZE-1:0] shiftleft2 = extend << 2;

    alu Step5(
        .alu_control_in(`ALU_ADD),
        .channel_a_in(pcadderout),
        .channel_b_in(shiftleft2),
        //.zero_out(), there is no zero in the image so 
        //i assume we can ignore
        .alu_result_out(step5muxchan2));

    wire step5muxand = branchandmux & zero; 

    mux_2_1 step5mux(
        .select_in(step5muxand),
        .datain1(pcadderout),
        .datain2(step5muxchan2),
        .data_out(pc_in)); 




endmodule
