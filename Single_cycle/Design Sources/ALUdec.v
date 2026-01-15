module ALU_Decoder(
    input  wire [2:0] funct3,
    input  wire       funct7b5,
    input  wire [1:0] ALUOp,
    output reg  [3:0] ALUControl
);

always @(*) begin
    case (ALUOp)

        2'b00: ALUControl = 4'b0000;  // ADD (lw, sw, addi, jalr)

        2'b01: ALUControl = 4'b0001;  // SUB (branches)

        2'b10: begin                 // R-type or I-type ALU
            case (funct3)

                3'b000: // ADD or SUB
                    ALUControl = funct7b5 ? 4'b0001 : 4'b0000;

                3'b111: ALUControl = 4'b0010;  // AND
                3'b110: ALUControl = 4'b0011;  // OR
                3'b100: ALUControl = 4'b0100;  // XOR

                3'b010: ALUControl = 4'b0101;  // SLT
                3'b011: ALUControl = 4'b0110;  // SLTU

                3'b001: ALUControl = 4'b0111;  // SLL
                3'b101: ALUControl = funct7b5 ? 4'b1001 : 4'b1000;  // SRA / SRL

                default: ALUControl = 4'b0000;
            endcase
        end

        default: ALUControl = 4'b0000;
    endcase
end

endmodule
