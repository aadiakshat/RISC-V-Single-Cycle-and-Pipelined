module Register_File(
    input wire        clk, WE3,
    input wire [4:0]  RA1, RA2, WA3,
    input wire [31:0] WD3,
    output wire [31:0] RD1, RD2
);

reg [31:0] REG_MEM_BLOCK [31:0];
integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        REG_MEM_BLOCK[i] = 32'h00000000;
end

always @(posedge clk) begin
    if (WE3 && (WA3 != 0))     
        REG_MEM_BLOCK[WA3] <= WD3;
end

assign RD1 = (RA1 != 0) ? REG_MEM_BLOCK[RA1] : 32'b0;
assign RD2 = (RA2 != 0) ? REG_MEM_BLOCK[RA2] : 32'b0;

endmodule
