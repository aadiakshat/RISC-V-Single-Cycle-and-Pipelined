`timescale 1ns/1ps

module branch_unit_tb;

reg  [31:0] A;
reg  [31:0] B;
reg  [2:0]  funct3;
wire        take;

Branch_Unit uut(
    .A(A),
    .B(B),
    .funct3(funct3),
    .take(take)
);

initial begin
    funct3 = 3'b000;
    A = 10;  B = 10;  funct3 = 3'b000; #10;
    A = 10;  B = 20;  funct3 = 3'b001; #10;
    A = 5;   B = 8;   funct3 = 3'b100; #10;
    A = 8;   B = 5;   funct3 = 3'b101; #10;
    A = 0;   B = 0;   funct3 = 3'b111; #10;
    $finish;
end

endmodule
