`timescale 1ns/1ps

module rv32i_pipeline_top_tb;

    reg clk;
    reg reset;

    // DUT
    rv32i_pipeline_top dut (
        .clk   (clk),
        .reset (reset)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // dump for GTKWave
        $dumpfile("sim.vcd");
        $dumpvars(0, rv32i_pipeline_top_tb);

        // init
        clk   = 0;
        reset = 1;

        // hold reset
        #20;
        reset = 0;

        // run simulation
        #500;

        $display("Simulation finished");
        $finish;
    end

endmodule
