
module rv32i_pipeline_top (
    input clk,
    input reset
);

    /* ================= IF → ID ================= */
    wire [31:0] if_id_pc_plus4;
    wire [31:0] if_id_instr;

    /* ================= ID → EX ================= */
    wire [31:0] id_rs1_data;
    wire [31:0] id_rs2_data;
    wire [31:0] id_imm;
    wire [4:0]  id_rd;
    wire [2:0]  id_funct3;
    wire        id_funct7;

    wire        id_reg_write;
    wire        id_mem_read;
    wire        id_mem_write;
    wire        id_mem_to_reg;
    wire        id_alu_src;
    wire        id_branch;
    wire [1:0]  id_alu_op;

    /* ================= EX → MEM ================= */
    wire [31:0] ex_alu_result;
    wire [31:0] ex_rs2_out;
    wire [4:0]  ex_rd_out;

    wire        ex_branch_taken;
    wire [31:0] ex_pc_branch;

    wire        ex_reg_write_out;
    wire        ex_mem_read_out;
    wire        ex_mem_write_out;
    wire        ex_mem_to_reg_out;

    /* ================= MEM → WB ================= */
    wire [31:0] mem_data_mem;
    wire [31:0] mem_alu_res_mem;
    wire [4:0]  mem_rd_mem;
    wire        mem_reg_write_mem;
    wire        mem_mem_to_reg_mem;

    /* ================= WB ================= */
    wire [31:0] wb_data;

    assign wb_data = mem_mem_to_reg_mem ? mem_data_mem : mem_alu_res_mem;

    /* ================= IF STAGE ================= */
    if_top IF (
        .clk(clk),
        .reset(reset),
        .pc_write(1'b1),          // no hazard unit yet
        .if_id_write(1'b1),
        .branch_taken(ex_branch_taken),
        .pc_branch(ex_pc_branch),
        .if_id_pc_plus4(if_id_pc_plus4),
        .if_id_instr(if_id_instr)
    );

    /* ================= ID STAGE ================= */
    id_stage_top ID (
        .clk(clk),
        .reset(reset),
        .instr(if_id_instr),
        .pc_plus4(if_id_pc_plus4),

        .wb_reg_write(mem_reg_write_mem),
        .wb_rd(mem_rd_mem),
        .wb_data(wb_data),

        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data),
        .imm(id_imm),
        .rd(id_rd),
        .funct3(id_funct3),
        .funct7(id_funct7),

        .reg_write(id_reg_write),
        .mem_read(id_mem_read),
        .mem_write(id_mem_write),
        .mem_to_reg(id_mem_to_reg),
        .alu_src(id_alu_src),
        .branch(id_branch),
        .alu_op(id_alu_op)
    );

    /* ================= EX STAGE ================= */
    ex_stage_top EX (
        .pc(if_id_pc_plus4 - 32'd4), // recover PC of instr
        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data),
        .imm(id_imm),
        .rd(id_rd),
        .funct3(id_funct3),
        .funct7(id_funct7),

        .reg_write(id_reg_write),
        .mem_read(id_mem_read),
        .mem_write(id_mem_write),
        .mem_to_reg(id_mem_to_reg),
        .alu_src(id_alu_src),
        .branch(id_branch),
        .alu_op(id_alu_op),

        .alu_result(ex_alu_result),
        .rs2_out(ex_rs2_out),
        .rd_out(ex_rd_out),

        .branch_taken(ex_branch_taken),
        .pc_branch(ex_pc_branch),

        .reg_write_out(ex_reg_write_out),
        .mem_read_out(ex_mem_read_out),
        .mem_write_out(ex_mem_write_out),
        .mem_to_reg_out(ex_mem_to_reg_out)
    );

    /* ================= MEM STAGE ================= */
    mem_stage MEM (
        .clk(clk),

        .alu_res_ex(ex_alu_result),
        .rs2_val_ex(ex_rs2_out),
        .rd_ex(ex_rd_out),
        .mem_read_ex(ex_mem_read_out),
        .mem_write_ex(ex_mem_write_out),
        .reg_write_ex(ex_reg_write_out),
        .mem_to_reg_ex(ex_mem_to_reg_out),

        .mem_data_mem(mem_data_mem),
        .alu_res_mem(mem_alu_res_mem),
        .rd_mem(mem_rd_mem),
        .reg_write_mem(mem_reg_write_mem),
        .mem_to_reg_mem(mem_mem_to_reg_mem)
    );

endmodule
