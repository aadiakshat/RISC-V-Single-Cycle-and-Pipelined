`timescale 1ns/1ns
module Maintop_tb;
reg clk = 0;
reg rst = 1;
always #5 clk = ~clk;

Maintop uut (
    .clk(clk),
    .rst(rst)
);

initial begin
    rst = 1; #20;
    rst = 0;
    #500;
    $finish;
end

// Monitor every clock cycle
always @(posedge clk) begin
    $display("Time=%0t PC=%h Instr=%h RD1=%h RD2=%h ALUResult=%h", 
             $time, uut.PC, uut.Instr, uut.RD1, uut.RD2, uut.ALUResult);
end

// Check initial state
initial begin
    #21;  // Right after reset releases
    $display("\n=== After Reset ===");
    $display("PC should be 0x00000000, actual PC=%h", uut.PC);
end

endmodule