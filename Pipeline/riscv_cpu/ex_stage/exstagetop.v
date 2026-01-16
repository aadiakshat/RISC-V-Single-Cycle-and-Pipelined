`include "alu.v"
`include "alucontrol.v"
`include "branch_unit.v"
module ex_stage_top(
    input  [31:0] pc,
    input  [31:0] rs1_data,
    input  [31:0] rs2_data,
    input  [31:0] imm,
    input  [4:0]  rd,
    input  [2:0]  funct3,
    input         funct7,

    input         reg_write,
    input         mem_read,
    input         mem_write,
    input         mem_to_reg,
    input         alu_src,
    input         branch,
    input  [1:0]  alu_op,

    output [31:0] alu_result,
    output [31:0] rs2_out,
    output [4:0]  rd_out,

    output        branch_taken,
    output [31:0] pc_branch,

    output        reg_write_out,
    output        mem_read_out,
    output        mem_write_out,
    output        mem_to_reg_out
);

wire [31:0] alu_in2;
wire [3:0]  alu_ctrl;
wire zero;

// Select ALU second operand
assign alu_in2 = (alu_src) ? imm : rs2_data;

// ALU control
alu_control alu_ctrl_unit(
    .alu_op(alu_op),
    .funct3(funct3),
    .funct7(funct7),
    .alu_ctrl(alu_ctrl)
);

// ALU
alu alu_unit(
    .a(rs1_data),
    .b(alu_in2),
    .alu_ctrl(alu_ctrl),
    .result(alu_result),
    .zero(zero)
);

// Branch unit
branch_unit bu(
    .rs1(rs1_data),
    .rs2(rs2_data),
    .imm(imm),
    .pc(pc),
    .branch(branch),
    .branch_taken(branch_taken),
    .pc_branch(pc_branch)
);

// Pass-throughs
assign rs2_out        = rs2_data;
assign rd_out         = rd;
assign reg_write_out  = reg_write;
assign mem_read_out   = mem_read;
assign mem_write_out  = mem_write;
assign mem_to_reg_out = mem_to_reg;

endmodule
