# Simple-CPU

## Key components:

Registers:
* Accumulator: Main working register
* Program Counter: Tracks current instruction address
* Instruction Register: Holds current instruction

Memory:
* 256-byte memory array
* Supports basic memory operations

Instructions:
* LOAD: Load value from memory to accumulator
* STORE: Store accumulator value to memory
* ADD: Add value from memory to accumulator
* SUB: Subtract value from memory from accumulator

ALU (Arithmetic Logic Unit):
* Supports ADD and SUB operations
* Performs arithmetic based on instruction

Control Logic:
* Simple state machine with fetch and execute states
* Handles instruction processing and state transitions

The output waveform:

<img width="742" alt="image" src="https://github.com/user-attachments/assets/2c1fcd15-f9b1-47ba-ace5-685762768d75" />

The waveform shows the CPU executing a simple program. The program counter increments, indicating that the CPU is fetching instructions from memory. The accumulator's values change, suggesting that arithmetic operations are being performed. The specific operations and the program's logic cannot be determined from this waveform alone.
