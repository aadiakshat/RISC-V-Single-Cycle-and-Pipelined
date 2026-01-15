module imem (
    input  [31:0] addr,
    output [31:0] instr
);
    reg [31:0] mem [0:255];

    initial begin
        mem[0] = 32'h00000013;
        mem[1] = 32'h00100093;
        mem[2] = 32'h00200113;
    end


    assign instr = mem[addr[9:2]];
endmodule
