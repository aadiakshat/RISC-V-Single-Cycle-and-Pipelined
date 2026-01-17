`include "data_mem.v"
`include "mem_wb.v"
module mem_stage (
    input  wire        clk,

    // from EX/MEM
    input  wire [31:0] alu_res_ex,
    input  wire [31:0] rs2_val_ex,
    input  wire [4:0]  rd_ex,
    input  wire        mem_read_ex,
    input  wire        mem_write_ex,
    input  wire        reg_write_ex,
    input  wire        mem_to_reg_ex,

    // to MEM/WB
    output wire [31:0] mem_data_mem,
    output wire [31:0] alu_res_mem,
    output wire [4:0]  rd_mem,
    output wire        reg_write_mem,
    output wire        mem_to_reg_mem
);

    data_mem dm (
        .clk(clk),
        .mem_read(mem_read_ex),
        .mem_write(mem_write_ex),
        .addr(alu_res_ex),
        .write_data(rs2_val_ex),
        .read_data(mem_data_mem)
    );

    // Forward signals
    assign alu_res_mem   = alu_res_ex;
    assign rd_mem        = rd_ex;
    assign reg_write_mem = reg_write_ex;
    assign mem_to_reg_mem = mem_to_reg_ex;

endmodule
