module alu_control(
    input [1:0] alu_op,
    input [2:0] funct3,
    input       funct7,
    output reg [3:0] alu_ctrl
);

always @(*) begin
    case(alu_op)

        2'b00: alu_ctrl = 4'b0010; // LW, SW → ADD
        2'b01: alu_ctrl = 4'b0110; // BEQ → SUB

        2'b10: begin // R-type / I-type
            case(funct3)
                3'b000: alu_ctrl = (funct7) ? 4'b0110 : 4'b0010; // sub/add
                3'b111: alu_ctrl = 4'b0000; // AND
                3'b110: alu_ctrl = 4'b0001; // OR
                3'b010: alu_ctrl = 4'b0111; // SLT
                default: alu_ctrl = 4'b0000;
            endcase
        end

        default: alu_ctrl = 4'b0000;
    endcase
end
endmodule
