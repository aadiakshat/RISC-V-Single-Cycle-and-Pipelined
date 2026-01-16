`include "id_ex.v"
`include "control_unit.v"
`include "imm_gen.v"
`include "regfile.v"
module id_stage_top(
    input clk,
    input reset,
    input [31:0] instr,
    input [31:0] pc_plus4,

    
    input wb_reg_write,
    input [4:0] wb_rd,
    input [31:0] wb_data,

    
    output [31:0] rs1_data,
    output [31:0] rs2_data,
    output [31:0] imm,
    output [4:0]  rd,
    output [2:0]  funct3,
    output        funct7,

    output reg_write,
    output mem_read,
    output mem_write,
    output mem_to_reg,
    output alu_src,
    output branch,
    output [1:0] alu_op
);

wire [4:0] rs1 = instr[19:15];
wire [4:0] rs2 = instr[24:20];
assign rd      = instr[11:7];
assign funct3  = instr[14:12];
assign funct7  = instr[30];

// Control unit
control_unit cu(
    .opcode(instr[6:0]),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .alu_src(alu_src),
    .branch(branch),
    .alu_op(alu_op)
);

// Register file
regfile rf(
    .clk(clk),
    .reg_write(wb_reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(wb_rd),
    .wd(wb_data),
    .rd1(rs1_data),
    .rd2(rs2_data)
);

// Immediate generator
imm_gen ig(
    .instr(instr),
    .imm(imm)
);

endmodule
