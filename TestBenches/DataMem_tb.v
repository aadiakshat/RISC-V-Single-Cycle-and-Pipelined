`timescale 1ns/1ps

module Data_Memory_tb;

reg clk = 0;
reg MemWrite;
reg [31:0] A;
reg [31:0] WD;
wire [31:0] RD;

always #5 clk = ~clk;

Data_Memory uut(.clk(clk), .MemWrite(MemWrite), .A(A), .WD(WD), .RD(RD));

initial begin
    MemWrite = 0;
    A = 32'd8;      WD = 32'hAAAA_BBBB; #10;
    MemWrite = 1;                       #10;
    MemWrite = 0;                       #10;

    A = 32'd12;     WD = 32'hCCCC_DDDD; #10;
    MemWrite = 1;                       #10;
    MemWrite = 0;                       #10;

    $finish;
end

initial begin
    $monitor("t=%0d  A=%0d  RD=%h", $time, A, RD);
end

endmodule
