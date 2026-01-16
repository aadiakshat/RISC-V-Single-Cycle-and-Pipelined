module ex_mem(
    input clk,
    input reset,

    input  [31:0] alu_result_in,
    input  [31:0] rs2_data_in,
    input  [4:0]  rd_in,

    input         reg_write_in,
    input         mem_read_in,
    input         mem_write_in,
    input         mem_to_reg_in,

    output reg [31:0] alu_result,
    output reg [31:0] rs2_data,
    output reg [4:0]  rd,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg
);

always @(posedge clk) begin
    if (reset) begin
        alu_result <= 0;
        rs2_data   <= 0;
        rd         <= 0;
        reg_write  <= 0;
        mem_read   <= 0;
        mem_write  <= 0;
        mem_to_reg <= 0;
    end else begin
        alu_result <= alu_result_in;
        rs2_data   <= rs2_data_in;
        rd         <= rd_in;
        reg_write  <= reg_write_in;
        mem_read   <= mem_read_in;
        mem_write  <= mem_write_in;
        mem_to_reg <= mem_to_reg_in;
    end
end

endmodule
