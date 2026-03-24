# ➕ Number Adder — x86_64 Assembly

An x86_64 assembly program that takes two numbers from
the user, adds them together, and prints the result.
Built with manual string-to-integer and integer-to-string
conversion routines — no standard library used.

## 📋 What It Does

- Prompts the user for two numbers
- Reads them as raw strings from stdin
- Converts each string to an integer manually
- Adds them together
- Converts the result back to a string
- Prints the sum to stdout

## 🛠️ Tech Stack

- **Language:** x86_64 Assembly (NASM)
- **Architecture:** x86_64 (64-bit)
- **OS:** Linux
- **Syscalls:** Custom `syscalls.asm` macro file

## ⚙️ How It Works Internally

| Routine | What it does |
|---|---|
| `convert_str_to_int` | Loops through each character, subtracts ASCII '0', builds the integer |
| `convert_int_to_str` | Divides by 10 repeatedly, pushes remainders to stack |
| `make_string_from_stack` | Pops digits off the stack into the `sum` buffer |
| `find_sum` | Calls str-to-int on both numbers and adds results |

## 🚀 Getting Started

### Prerequisites
- NASM assembler
- Linux environment

### Install NASM
  sudo apt install nasm

### Assemble & Run

1. Assemble
   nasm -f elf64 adder.asm -o adder.o

2. Link
   ld adder.o -o adder

3. Run
   ./adder

## 📁 Project Structure

├── adder.asm         # Main program
├── syscalls.asm      # Custom syscall macros (write, read, exit)
└── README.md         # You are here

## ⚠️ Known Limitations

- Buffer size is fixed at 8 bytes

## 📄 License

MIT License
