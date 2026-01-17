`timescale 1ns/1ps

module mem_stage_tb;

    reg clk;

    // EX/MEM inputs
    reg [31:0] alu_res_ex;
    reg [31:0] rs2_val_ex;
    reg [4:0]  rd_ex;
    reg        mem_read_ex;
    reg        mem_write_ex;
    reg        reg_write_ex;
    reg        mem_to_reg_ex;

    // MEM/WB outputs
    wire [31:0] mem_data_mem;
    wire [31:0] alu_res_mem;
    wire [4:0]  rd_mem;
    wire        reg_write_mem;
    wire        mem_to_reg_mem;

    // DUT
    mem_stage dut (
        .clk(clk),
        .alu_res_ex(alu_res_ex),
        .rs2_val_ex(rs2_val_ex),
        .rd_ex(rd_ex),
        .mem_read_ex(mem_read_ex),
        .mem_write_ex(mem_write_ex),
        .reg_write_ex(reg_write_ex),
        .mem_to_reg_ex(mem_to_reg_ex),
        .mem_data_mem(mem_data_mem),
        .alu_res_mem(alu_res_mem),
        .rd_mem(rd_mem),
        .reg_write_mem(reg_write_mem),
        .mem_to_reg_mem(mem_to_reg_mem)
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // default
        alu_res_ex     = 0;
        rs2_val_ex     = 0;
        rd_ex          = 0;
        mem_read_ex   = 0;
        mem_write_ex  = 0;
        reg_write_ex  = 0;
        mem_to_reg_ex = 0;

        #10;

        // =====================
        // STORE WORD (SW)
        // mem[4] = 42
        // =====================
        alu_res_ex    = 32'd16;      // address (word index = 4)
        rs2_val_ex    = 32'd42;
        mem_write_ex = 1;
        mem_read_ex  = 0;

        #10;
        mem_write_ex = 0;

        // =====================
        // LOAD WORD (LW)
        // rd = x5
        // =====================
        alu_res_ex     = 32'd16;
        mem_read_ex   = 1;
        reg_write_ex  = 1;
        mem_to_reg_ex = 1;
        rd_ex          = 5;

        #10;

        // End
        #10;
        $finish;
    end

    // Monitor
    initial begin
        $monitor(
            "time=%0t | mem_read=%b mem_write=%b addr=%d write_data=%d | read_data=%d | rd=%d",
            $time,
            mem_read_ex,
            mem_write_ex,
            alu_res_ex,
            rs2_val_ex,
            mem_data_mem,
            rd_mem
        );
    end

endmodule
