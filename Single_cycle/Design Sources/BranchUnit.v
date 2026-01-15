module Branch_Unit(
    input  wire [31:0] A,
    input  wire [31:0] B,
    input  wire [2:0]  funct3,
    output reg         take
);

always @(*) begin
    case (funct3)
        3'b000: take = (A == B);
        3'b001: take = (A != B);
        3'b100: take = ($signed(A) <  $signed(B));
        3'b101: take = ($signed(A) >= $signed(B));
        default: take = 0;
    endcase
end

endmodule
