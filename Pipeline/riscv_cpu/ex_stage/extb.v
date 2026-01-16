`timescale 1ns/1ps

module ex_stage_tb;

    // Inputs
    reg [31:0] pc;
    reg [31:0] rs1_data;
    reg [31:0] rs2_data;
    reg [31:0] imm;
    reg [4:0]  rd;
    reg [2:0]  funct3;
    reg        funct7;

    reg        reg_write;
    reg        mem_read;
    reg        mem_write;
    reg        mem_to_reg;
    reg        alu_src;
    reg        branch;
    reg [1:0]  alu_op;

    // Outputs
    wire [31:0] alu_result;
    wire [31:0] rs2_out;
    wire [4:0]  rd_out;

    wire        branch_taken;
    wire [31:0] pc_branch;

    wire        reg_write_out;
    wire        mem_read_out;
    wire        mem_write_out;
    wire        mem_to_reg_out;

    // DUT
    ex_stage_top dut (
        .pc(pc),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm(imm),
        .rd(rd),
        .funct3(funct3),
        .funct7(funct7),

        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .branch(branch),
        .alu_op(alu_op),

        .alu_result(alu_result),
        .rs2_out(rs2_out),
        .rd_out(rd_out),

        .branch_taken(branch_taken),
        .pc_branch(pc_branch),

        .reg_write_out(reg_write_out),
        .mem_read_out(mem_read_out),
        .mem_write_out(mem_write_out),
        .mem_to_reg_out(mem_to_reg_out)
    );

    initial begin
        // -------------------------
        // TEST 1: addi x2, x1, 5
        // -------------------------
        pc = 32'd100;
        rs1_data = 32'd10;
        rs2_data = 32'd0;
        imm = 32'd5;
        rd = 5'd2;
        funct3 = 3'b000;
        funct7 = 1'b0;

        reg_write = 1;
        mem_read = 0;
        mem_write = 0;
        mem_to_reg = 0;
        alu_src = 1;        // immediate
        branch = 0;
        alu_op = 2'b10;     // arithmetic

        #10;

        // -------------------------
        // TEST 2: add x3, x1, x2
        // -------------------------
        rs1_data = 32'd10;
        rs2_data = 32'd20;
        imm = 32'd0;
        rd = 5'd3;
        funct3 = 3'b000;
        funct7 = 1'b0;

        alu_src = 0;        // use rs2
        branch = 0;
        alu_op = 2'b10;

        #10;

        // -------------------------
        // TEST 3: beq x1, x2, label
        // x1 == x2 → branch taken
        // -------------------------
        pc = 32'd200;
        rs1_data = 32'd15;
        rs2_data = 32'd15;
        imm = 32'd16;       // branch offset
        rd = 5'd0;
        funct3 = 3'b000;
        funct7 = 1'b0;

        reg_write = 0;
        alu_src = 0;
        branch = 1;
        alu_op = 2'b01;     // branch

        #10;

        // -------------------------
        // TEST 4: beq not taken
        // -------------------------
        rs1_data = 32'd10;
        rs2_data = 32'd20;

        #10;

        $finish;
    end

    // Monitor
    initial begin
        $monitor(
            "time=%0t | alu_res=%0d | branch_taken=%b | pc_branch=%0d | rd=%0d",
            $time, alu_result, branch_taken, pc_branch, rd_out
        );
    end

endmodule
