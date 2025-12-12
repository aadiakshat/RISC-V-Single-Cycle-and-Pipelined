module Instruction_Memory(
    input  wire [31:0] A,
    output wire [31:0] RD
);

    reg [31:0] I_MEM_BLOCK [0:255];   // 256 words = 1 KB instruction memory

    initial begin
        $readmemh("instructions.txt", I_MEM_BLOCK);
    end

    assign RD = I_MEM_BLOCK[A[31:2]];   // word aligned

endmodule
