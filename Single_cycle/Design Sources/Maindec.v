module Main_Decoder(
    input  wire [6:0] opcode,
    output reg        RegWrite,
    output reg        ALUSrc,
    output reg        MemWrite,
    output reg [1:0]  ResultSrc,
    output reg        Branch,
    output reg        Jump,
    output reg [1:0]  ImmSrc,
    output reg [1:0]  ALUOp
);

always @(*) begin
    // Default values
    RegWrite  = 0;
    ALUSrc    = 0;
    MemWrite  = 0;
    ResultSrc = 2'b00;
    Branch    = 0;
    Jump      = 0;
    ImmSrc    = 2'b00;
    ALUOp     = 2'b00;

    case(opcode)

        // R-type (add, sub, sll, srl, xor, and, or, slt)
        7'b0110011: begin
            RegWrite = 1;
            ALUSrc   = 0;
            ResultSrc = 2'b00;
            ALUOp   = 2'b10;
            ImmSrc  = 2'b00;
        end

        // I-type (addi, xori, ori, andi, slli, srli, lw)
        7'b0010011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ResultSrc = 2'b00;
            ALUOp   = 2'b10;
            ImmSrc  = 2'b00;
        end

        // Load (lw)
        7'b0000011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ResultSrc = 2'b01;  // data memory output
            ALUOp   = 2'b00;
            ImmSrc  = 2'b00;
        end

        // Store (sw)
        7'b0100011: begin
            RegWrite = 0;
            ALUSrc   = 1;
            MemWrite = 1;
            ALUOp   = 2'b00;
            ImmSrc  = 2'b01; 
        end

        // Branch (beq, bne, blt, bge)
        7'b1100011: begin
            RegWrite = 0;
            ALUSrc   = 0;
            Branch   = 1;
            ALUOp    = 2'b01;
            ImmSrc   = 2'b10;
        end

        // J-type (jal)
        7'b1101111: begin
            RegWrite = 1;
            Jump     = 1;
            ALUSrc   = 0;
            ResultSrc = 2'b10;  // PC+4
            ImmSrc   = 2'b11;
        end

        // JALR
        7'b1100111: begin
            RegWrite = 1;
            Jump     = 1;
            ALUSrc   = 1;
            ResultSrc = 2'b10; 
            ImmSrc   = 2'b00;
            ALUOp    = 2'b00;
        end

        default: begin
        end

    endcase
end

endmodule
