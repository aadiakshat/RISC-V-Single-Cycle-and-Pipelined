`timescale 1ns/1ps

module if_tb;

    reg clk;
    reg reset;
    reg pc_write;
    reg if_id_write;

    wire [31:0] if_id_pc_plus4;
    wire [31:0] if_id_instr;

    // DUT
    if_top dut (
        .clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .if_id_write(if_id_write),
        .if_id_pc_plus4(if_id_pc_plus4),
        .if_id_instr(if_id_instr)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns period
    end

    initial begin
        $display("==== IF STAGE TEST ====");
        $monitor(
            "T=%0t | reset=%b pc_write=%b if_id_write=%b | PC+4=%0d | Instr=0x%h",
            $time, reset, pc_write, if_id_write,
            if_id_pc_plus4, if_id_instr
        );

        // Initial values
        reset       = 1;
        pc_write    = 0;
        if_id_write = 0;

        // Apply reset
        #10;
        reset = 0;

        // Enable PC and IF/ID
        pc_write    = 1;
        if_id_write = 1;

        // Let it run for a few cycles
        #60;

        // Stall IF/ID (PC still runs)
        if_id_write = 0;
        #20;

        // Resume
        if_id_write = 1;
        #30;

        $finish;
    end

endmodule
