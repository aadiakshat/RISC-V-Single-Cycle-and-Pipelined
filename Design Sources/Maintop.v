module Maintop(
    input  wire clk,
    input  wire rst,
    output wire [7:0]leds
);
assign leds = ALUResult[7:0];
wire [31:0] PC;
wire [31:0] PCNext;

// Instruction
wire [31:0] Instr;

// Register file outputs
wire [31:0] RD1, RD2;

// Immediate
wire [31:0] ImmExt;

// ALU
wire [31:0] ALUInB;
wire [31:0] ALUResult;

// Memory
wire [31:0] MemRD;

// Writeback
wire [31:0] WriteData;
wire [31:0] PCPlus4;

// Control
wire RegWrite, ALUSrc, MemWrite, Branch, Jump;
wire [1:0] ResultSrc, ImmSrc, ALUOp;
wire [3:0] ALUControl;

// Instruction fields
wire [2:0] funct3  = Instr[14:12];
wire [4:0] rs1     = Instr[19:15];
wire [4:0] rs2     = Instr[24:20];
wire [4:0] rd      = Instr[11:7];
wire       funct7b5 = Instr[30];

// Branch
wire BranchTake;
wire isJalr = (Instr[6:0] == 7'b1100111);

// PC register
PC pc_inst(
    .clk(clk),
    .reset(rst),
    .PCNext(PCNext),
    .PC(PC)
);

// Instruction memory
Instruction_Memory imem(
    .A(PC),
    .RD(Instr)
);

// Main decoder
Main_Decoder dec_main(
    .opcode(Instr[6:0]),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .Jump(Jump),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp)
);

// Immediate generator
Extend ext(
    .Instr(Instr[31:0]),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);

// Register file
Register_File rf(
    .clk(clk),
    .WE3(RegWrite),
    .RA1(rs1),
    .RA2(rs2),
    .WA3(rd),
    .WD3(WriteData),
    .RD1(RD1),
    .RD2(RD2)
);

// ALU decoder
ALU_Decoder dec_alu(
    .funct3(funct3),
    .funct7b5(funct7b5),
    .ALUOp(ALUOp),
    .ALUControl(ALUControl)
);

// ALU B input mux
assign ALUInB = ALUSrc ? ImmExt : RD2;

// ALU
ALU alu_inst(
    .A(RD1),
    .B(ALUInB),
    .ALUControl(ALUControl),
    .Zero(),
    .Result(ALUResult)
);

// Data memory
Data_Memory dmem(
    .clk(clk),
    .MemWrite(MemWrite),
    .A(ALUResult),
    .WD(RD2),
    .RD(MemRD)
);

// Branch unit
Branch_Unit bu(
    .A(RD1),
    .B(RD2),
    .funct3(funct3),
    .take(BranchTake)
);

// PC logic
assign PCPlus4 = PC + 4;

assign PCNext =
    isJalr         ? ((RD1 + ImmExt) & ~1) :
    Jump           ? (PC + ImmExt) :
    (Branch && BranchTake) ? (PC + ImmExt) :
                            PCPlus4;

// Writeback mux
assign WriteData =
    (ResultSrc == 2'b00) ? ALUResult :
    (ResultSrc == 2'b01) ? MemRD :
    (ResultSrc == 2'b10) ? PCPlus4 :
                           32'b0;

endmodule
