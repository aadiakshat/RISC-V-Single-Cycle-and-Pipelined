# RISC-V Verilog Processor

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)
![ISA](https://img.shields.io/badge/ISA-RISC--V%20RV32I-green)
![Architecture](https://img.shields.io/badge/Architecture-Single--Cycle%20%7C%20Pipelined-orange)

A Register-Transfer Level (RTL) implementation of a RISC-V processor written in Verilog. This project implements the **RV32I** (Base Integer) instruction set and targets Xilinx FPGAs. It includes both **Single-Cycle** and **Pipelined** implementations, along with testbenches for verification and constraint files for FPGA deployment.

---

## 📂 Repository Structure

```
├── Pipeline/
│   ├── riscv_cpu/
│   │   ├── ex_stage/          # Execute stage modules
│   │   ├── id_stage/          # Instruction decode stage modules
│   │   ├── if_stage/          # Instruction fetch stage modules
│   │   └── mem_stage/         # Memory access stage modules
│   └── Screenshots/           # Pipelined implementation waveforms and diagrams
│
└── Single_cycle/
    ├── Design Sources/        # Single-cycle Verilog source files
    ├── RISC_V_Single_Cycle_Processor/
    │   ├── rtl/              # RTL design files
    │   └── tb/               # Testbench files
    ├── Screenshots/          # Single-cycle waveforms and diagrams
    └── TestBenches/          # Additional simulation files
```

### Key Components

| File/Folder | Description |
|:------------|:------------|
| **`Pipeline/`** | Pipelined processor implementation with separate pipeline stage modules (IF, ID, EX, MEM, WB) |
| **`Single_cycle/`** | Single-cycle processor implementation with all modules (ALU, Control Unit, RegFile, etc.) |
| **`Screenshots/`** | Waveform simulations and implementation diagrams for both architectures |
| **`constraints.xdc`** | Xilinx Design Constraints file for mapping I/O to specific FPGA pins |
| **`instructions.txt`** | Hexadecimal machine code loaded into Instruction Memory for testing |

---

## 🏗️ Architecture

This repository contains two processor implementations:

### 1. Single-Cycle Processor
- **Architecture:** Single-Cycle (one instruction per clock cycle)
- **ISA:** RISC-V RV32I
- **Data Width:** 32-bit
- **Memory Model:** Harvard Architecture (Separate Instruction and Data memory)
- **Simplicity:** Easy to understand and debug
- **Performance:** Lower clock frequency due to critical path through entire instruction

### 2. Pipelined Processor
- **Architecture:** 5-Stage Pipeline (IF → ID → EX → MEM → WB)
- **ISA:** RISC-V RV32I
- **Data Width:** 32-bit
- **Memory Model:** Harvard Architecture
- **Performance:** Higher throughput with instruction-level parallelism
- **Features:** Hazard detection and forwarding logic

#### Pipeline Stages
1. **IF (Instruction Fetch):** Fetch instruction from memory
2. **ID (Instruction Decode):** Decode instruction and read registers
3. **EX (Execute):** Perform ALU operations
4. **MEM (Memory Access):** Load/Store operations
5. **WB (Write Back):** Write results back to register file

---

## 🚀 Getting Started

### Prerequisites
- **Xilinx Vivado** (WebPACK or Standard Edition)
- **Icarus Verilog** (optional, for command-line simulation)
- A text editor (VS Code, Notepad++)

### How to Simulate

#### For Single-Cycle Processor:
1. Open **Xilinx Vivado**
2. Create a new project and select "RTL Project"
3. **Add Sources:** Import all files from `Single_cycle/Design Sources/` or `Single_cycle/RISC_V_Single_Cycle_Processor/rtl/`
4. **Add Simulation Sources:** Import files from `Single_cycle/TestBenches/` or `Single_cycle/RISC_V_Single_Cycle_Processor/tb/`
5. **Load Program:** Ensure `instructions.txt` is in the simulation working directory
6. Click **Run Simulation → Run Behavioral Simulation**

#### For Pipelined Processor:
1. Open **Xilinx Vivado**
2. Create a new project and select "RTL Project"
3. **Add Sources:** Import all modules from `Pipeline/riscv_cpu/` subdirectories
4. **Add Simulation Sources:** Import testbench files (if available)
5. **Load Program:** Update instruction memory initialization file path
6. Click **Run Simulation → Run Behavioral Simulation**

### How to Synthesize (FPGA)
1. **Add Constraints:** Import `constraints.xdc` into the project
2. Select your target FPGA part (e.g., Artix-7, Basys 3)
3. Click **Run Synthesis** followed by **Run Implementation**
4. Generate Bitstream and program the device

---

## 📝 Instruction Loading

The processor reads instructions from `instructions.txt`. To run a new program:

1. Compile your Assembly/C code to RISC-V machine code (hex format)
2. Paste the hex instructions into `instructions.txt`
3. Re-run the simulation (no need to re-synthesize for simulation)

**Example format:**
```
00000093  // addi x1, x0, 0
00100113  // addi x2, x0, 1
002081B3  // add x3, x1, x2
```

---

## 🧪 Testing

Both implementations include testbenches for verification:
- **Functional Testing:** Verify correct execution of RV32I instructions
- **Waveform Analysis:** Debug signal flow and timing issues
- **Corner Cases:** Test hazards, forwarding, and edge conditions (pipelined version)

Check the `Screenshots/` folders for example waveforms and simulation results.

---

## 🛠️ Future Improvements

- [x] ~~Implement Pipelining~~ ✅ **Completed!**
- [ ] Add hazard detection and data forwarding (if not already implemented)
- [ ] Implement branch prediction
- [ ] Add support for M extension (Multiplication/Division)
- [ ] Add support for Compressed (C) instructions
- [ ] Add UART interface for I/O
- [ ] Implement cache memory
- [ ] Add interrupt handling (CSR support)

---

## 📊 Performance Comparison

| Feature | Single-Cycle | Pipelined |
|:--------|:-------------|:----------|
| CPI (Cycles Per Instruction) | 1.0 | ~1.0 (ideal) |
| Clock Frequency | Lower | Higher |
| Throughput | 1 instruction/cycle | Up to 5 instructions in flight |
| Complexity | Low | Medium-High |
| Resource Usage | Moderate | Higher (pipeline registers) |

---

## 📚 Resources

- [RISC-V ISA Specification](https://riscv.org/technical/specifications/)
- [Xilinx Vivado Documentation](https://www.xilinx.com/support/documentation-navigation/design-hubs/dh0072-vivado-design-hub.html)
- [Digital Design and Computer Architecture (RISC-V Edition)](https://www.elsevier.com/books/digital-design-and-computer-architecture/harris/978-0-12-820064-3)

---

## 📜 License

This project is open-source and available for educational purposes.

---

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

---

## 📧 Contact

For questions or suggestions, please open an issue in this repository.

---

**⭐ If you find this project helpful, please consider giving it a star!**
