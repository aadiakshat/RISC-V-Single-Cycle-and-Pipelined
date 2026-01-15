module pc (input clk, input reset, input pc_write, output reg [31:0]pc_curr,input [31:0]pc_next);
    always  @(posedge clk) begin
        if(reset)
            pc_curr <= 32'b0;
        else if(pc_write)
            pc_curr <= pc_next;
    end
endmodule
