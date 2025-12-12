`timescale 1ns/1ps

module main_decoder_tb;

reg [6:0] opcode;
wire RegWrite;
wire ALUSrc;
wire MemWrite;
wire [1:0] ResultSrc;
wire Branch;
wire Jump;
wire [1:0] ImmSrc;
wire [1:0] ALUOp;

Main_Decoder uut(
    .opcode(opcode),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .Jump(Jump),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp)
);

initial begin
    opcode = 7'b0110011; #10;
    opcode = 7'b0010011; #10;
    opcode = 7'b0000011; #10;
    opcode = 7'b0100011; #10;
    opcode = 7'b1100011; #10;
    opcode = 7'b1101111; #10;
    opcode = 7'b1100111; #10;
    opcode = 7'b0000000; #10;
    $finish;
end

endmodule
