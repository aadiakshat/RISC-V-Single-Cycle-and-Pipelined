`timescale 1ns/1ps

module if_id (
    input clk,
    input reset,
    input if_id_write,      // for stalling later

    input  [31:0] pc_plus4_in,
    input  [31:0] instr_in,

    output reg [31:0] pc_plus4_out,
    output reg [31:0] instr_out
);

    always @(posedge clk) begin
        if (reset) begin
            pc_plus4_out <= 32'd0;
            instr_out    <= 32'd0;
        end
        else if (if_id_write) begin
            pc_plus4_out <= pc_plus4_in;
            instr_out    <= instr_in;
        end
    end

endmodule
