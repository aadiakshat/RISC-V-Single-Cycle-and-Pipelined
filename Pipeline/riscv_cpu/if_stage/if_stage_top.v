`timescale 1ns/1ps
`include "pc.v"
`include "instr_mem.v"
`include "if_id.v"

module if_top (
    input clk,
    input reset,
    input pc_write,
    input if_id_write,
    input branch_taken,
    input [31:0] pc_branch,
    output [31:0] if_id_pc_plus4,
    output [31:0] if_id_instr
);

    wire [31:0] pc_curr;
    wire [31:0] pc_plus4;
    wire [31:0] instr;

    // PC + 4
    assign pc_plus4 = pc_curr + 32'd4;
    wire [31:0] pc_next = (!branch_taken)? pc_plus4 : pc_branch ;
    // PC
    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .pc_next(pc_next),
        .pc_curr(pc_curr)
    );

    // Instruction memory
    imem imem (
        .addr(pc_curr),
        .instr(instr)
    );

    // IF/ID pipeline register
    if_id if_id_inst (
        .clk(clk),
        .reset(reset),
        .if_id_write(if_id_write),
        .pc_plus4_in(pc_plus4),
        .instr_in(instr),
        .pc_plus4_out(if_id_pc_plus4),
        .instr_out(if_id_instr)
    );

endmodule
