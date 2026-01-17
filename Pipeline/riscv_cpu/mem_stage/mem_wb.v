module mem_wb_reg (
    input  wire        clk,
    input  wire        reset,

    input  wire [31:0] mem_data_mem,
    input  wire [31:0] alu_res_mem,
    input  wire [4:0]  rd_mem,
    input  wire        reg_write_mem,
    input  wire        mem_to_reg_mem,

    output reg  [31:0] mem_data_wb,
    output reg  [31:0] alu_res_wb,
    output reg  [4:0]  rd_wb,
    output reg         reg_write_wb,
    output reg         mem_to_reg_wb
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            mem_data_wb   <= 0;
            alu_res_wb    <= 0;
            rd_wb         <= 0;
            reg_write_wb  <= 0;
            mem_to_reg_wb <= 0;
        end else begin
            mem_data_wb   <= mem_data_mem;
            alu_res_wb    <= alu_res_mem;
            rd_wb         <= rd_mem;
            reg_write_wb  <= reg_write_mem;
            mem_to_reg_wb <= mem_to_reg_mem;
        end
    end

endmodule
