module branch_unit(
    input  [31:0] rs1,
    input  [31:0] rs2,
    input  [31:0] imm,
    input  [31:0] pc,
    input         branch,

    output reg        branch_taken,
    output reg [31:0] pc_branch
);

always @(*) begin
    if (branch && (rs1 == rs2)) begin
        branch_taken = 1'b1;
        pc_branch    = pc + imm;
    end else begin
        branch_taken = 1'b0;
        pc_branch    = 32'b0;
    end
end

endmodule
