`timescale 1ns/1ps

module alu_decoder_tb;

reg [2:0] funct3;
reg       funct7b5;
reg [1:0] ALUOp;
wire [3:0] ALUControl;

ALU_Decoder uut(
    .funct3(funct3),
    .funct7b5(funct7b5),
    .ALUOp(ALUOp),
    .ALUControl(ALUControl)
);

initial begin
    ALUOp = 2'b00; funct3 = 3'b000; funct7b5 = 0; #10;
    ALUOp = 2'b01; funct3 = 3'b000; funct7b5 = 0; #10;

    ALUOp = 2'b10; funct3 = 3'b000; funct7b5 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b000; funct7b5 = 1; #10;

    ALUOp = 2'b10; funct3 = 3'b010; funct7b5 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b011; funct7b5 = 0; #10;

    ALUOp = 2'b10; funct3 = 3'b100; funct7b5 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b110; funct7b5 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b111; funct7b5 = 0; #10;

    ALUOp = 2'b10; funct3 = 3'b001; funct7b5 = 0; #10;

    ALUOp = 2'b10; funct3 = 3'b101; funct7b5 = 0; #10;
    ALUOp = 2'b10; funct3 = 3'b101; funct7b5 = 1; #10;

    $finish;
end

endmodule
