`timescale 1ns/1ps

module id_stage_top_tb;

    reg clk;
    reg reset;

    reg [31:0] instr;
    reg [31:0] pc_plus4;

    // WB inputs (for regfile writeback)
    reg wb_reg_write;
    reg [4:0] wb_rd;
    reg [31:0] wb_data;

    // Outputs from ID stage
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] imm;
    wire [4:0]  rd;
    wire [2:0]  funct3;
    wire        funct7;

    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire alu_src;
    wire branch;
    wire [1:0] alu_op;

    // DUT
    id_stage_top dut(
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .pc_plus4(pc_plus4),

        .wb_reg_write(wb_reg_write),
        .wb_rd(wb_rd),
        .wb_data(wb_data),

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
        .alu_op(alu_op)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin
        // init
        clk = 0;
        reset = 1;
        instr = 0;
        pc_plus4 = 0;

        wb_reg_write = 0;
        wb_rd = 0;
        wb_data = 0;

        #10 reset = 0;

        // -------------------------
        // Write x1 = 10 (simulate WB)
        // -------------------------
        #10;
        wb_reg_write = 1;
        wb_rd = 5'd1;
        wb_data = 32'd10;

        #10;
        wb_reg_write = 0;

        // -------------------------
        // Test instruction: addi x2, x1, 5
        // opcode = 0010011
        // -------------------------
        instr = 32'b000000000101_00001_000_00010_0010011;
        pc_plus4 = 32'd4;

        #20;

        // -------------------------
        // Finish
        // -------------------------
        $finish;
    end

    // Monitor
    initial begin
        $monitor(
            "time=%0t | instr=%h | rs1=%0d rs2=%0d | imm=%0d | rd=%0d | reg_write=%b alu_src=%b alu_op=%b",
            $time, instr, rs1_data, rs2_data, imm, rd,
            reg_write, alu_src, alu_op
        );
    end

endmodule
