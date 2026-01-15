module Data_Memory(
    input  wire        clk,
    input  wire        MemWrite,
    input  wire [31:0] A,
    input  wire [31:0] WD,
    output wire [31:0] RD
);

reg [31:0] mem [0:255];
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1)
        mem[i] = 32'hDEADBEEF;   // or 0
end
assign RD = mem[A[9:2]];

always @(posedge clk) begin
    if (MemWrite)
        mem[A[9:2]] <= WD;
end

endmodule   
