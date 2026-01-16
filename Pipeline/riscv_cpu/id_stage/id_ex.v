module id_ex(
    input clk,
    input reset,

    input [31:0] pc_plus4_in,
    input [31:0] rs1_data_in,
    input [31:0] rs2_data_in,
    input [31:0] imm_in,
    input [4:0]  rd_in,
    input [2:0]  funct3_in,
    input        funct7_in,

    input reg_write_in,
    input mem_read_in,
    input mem_write_in,
    input mem_to_reg_in,
    input alu_src_in,
    input branch_in,
    input [1:0] alu_op_in,

    output reg [31:0] pc_plus4,
    output reg [31:0] rs1_data,
    output reg [31:0] rs2_data,
    output reg [31:0] imm,
    output reg [4:0]  rd,
    output reg [2:0]  funct3,
    output reg        funct7,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg alu_src,
    output reg branch,
    output reg [1:0] alu_op
);

always @(posedge clk) begin
    if(reset) begin
        pc_plus4 <= 0;
        rs1_data <= 0;
        rs2_data <= 0;
        imm      <= 0;
        rd       <= 0;
        funct3  <= 0;
        funct7  <= 0;
        reg_write <= 0;
        mem_read  <= 0;
        mem_write <= 0;
        mem_to_reg<= 0;
        alu_src   <= 0;
        branch    <= 0;
        alu_op    <= 0;
    end else begin
        pc_plus4 <= pc_plus4_in;
        rs1_data <= rs1_data_in;
        rs2_data <= rs2_data_in;
        imm      <= imm_in;
        rd       <= rd_in;
        funct3  <= funct3_in;
        funct7  <= funct7_in;

        reg_write <= reg_write_in;
        mem_read  <= mem_read_in;
        mem_write <= mem_write_in;
        mem_to_reg<= mem_to_reg_in;
        alu_src   <= alu_src_in;
        branch    <= branch_in;
        alu_op    <= alu_op_in;
    end
end
endmodule
