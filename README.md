# Light Tie Link CPU-Memory System in Verilog

This project simulates a simple CPU-to-Memory communication model connected via a Light Tie Link using traditional Verilog.  
The CPU performs a write followed by a read, while the Tie Link transparently bridges the signals to a memory module.  
Vivado simulation confirms correct protocol behavior with access acknowledgment and data integrity.

## Modules
- `cpu.v`: FSM-based CPU that writes and reads from memory
- `memory.v`: Simple 256-byte RAM with read/write and ready signals
- `light_tielink.v`: Transparent pass-through interconnect (tie link)
- `top_tielink.v`: Integrates all modules for simulation
- `tb_top_tielink.v`: Testbench to verify all possible outcomes (PUT_FULL_DATA, GET, ACKs)

## Simulation Outcome
-  Correct `write_en`/`read_en` sequence
-  Proper `ready` handshakes
-  Accurate data round-trip from `wdata` → `rdata`

## Files Included
- Verilog source files
- Testbench
- Simulation waveforms
- Project report (with embedded screenshots)

## Tools Used
- Vivado (for simulation and RTL analysis)

## Report
A full PDF/DOCX report is available with waveform captures and explanation of all behaviors.
