# 🗳️ Electronic Voting Machine in Verilog

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Language: Verilog](https://img.shields.io/badge/language-Verilog-orange.svg)]()
[![Platform: FPGA Zynq-7000](https://img.shields.io/badge/platform-Zynq--7000-blueviolet.svg)]()

This repository contains the RTL implementation of a **secure Electronic Voting Machine (EVM)** using **Verilog HDL**, designed on a **Zynq-7000 FPGA evaluation board**. The EVM system incorporates encrypted voter UID validation, OLED display interfacing, push-button input, and FSM-controlled password authentication to ensure robust and tamper-proof voting.

---


## 📌 Project Features

- 🔐 **Encrypted Voter UID Verification**
- 🧠 **FSM-Controlled Mode Switching & Password Authentication**
- 🖥️ **OLED Display for Voting Info and Results**
- 💡 **LED Output Indicators**
- 🧾 **VVPAT-style vote confirmation**
- ⌨️ **Push-Button Based Input with Debouncing**
- 🧪 **Testbench-based Simulation with GTKWave**

---

## 🧭 System Workflow

### 🔁 Mode-Based Operation:
- `mode = 1`: Voting mode (enabled by polling officer)
- `mode = 0`: Result counting mode (requires password to decrypt and display)

### 👤 Voter Flow:
1. Voter inputs UID (via switch or manually in prototype)
2. Control unit verifies:
   - UID exists in encrypted database
   - Voter hasn’t already voted
3. Vote is accepted, candidate count updated
4. VVPAT displays confirmation
5. Voter cannot re-vote

### 🔓 Result Viewing:
- After voting ends, authorized personnel enters a **4-bit password** via push-buttons
- FSM verifies the password sequence
- Decrypted results are displayed via OLED or VIO

---

## 🔁 EVM System Flowchart

The flowchart below illustrates the complete functional behavior of the Electronic Voting Machine (EVM), from voter validation to result display:

![EVM Flowchart](https://github.com/SayantanMandal2000/electronic-voting-machine-verilog/blob/main/sim/EVM_FlowChart.png)

### 🧭 Flow Description

1. **System Start**  
   The EVM begins in either **voting mode** (`mode = 1`) or **result mode** (`mode = 0`), as set by the polling officer.

---

### 🗳️ Voting Mode (`mode = 1`)
- Voter is prompted to **enter their UID**.
- The system:
  - Verifies the **validity of the UID**.
  - Checks if the voter has **already voted**.
- If UID is **invalid**, the voter is rejected.
- If UID is **valid** and the voter hasn't voted:
  - Voter selects from **4 candidates**.
  - Corresponding vote bank is incremented.
  - Voter is marked as having **voted** (status flag = 1).

---

### 🔐 Result Mode (`mode = 0`)
- Election officer is prompted to **enter a 4-bit password**.
- FSM verifies the password:
  - If incorrect → retry prompt.
  - If correct → **results are decrypted and displayed**.
- The officer can then **press candidate buttons** to see:
  - Total votes received by each candidate.
  - Final results including winner and total votes.

---

### 🛡️ Security Measures
- **Encrypted UID validation**
- **One vote per UID enforcement**
- **FSM-controlled password-protected result access**

This ensures the voting process is **transparent**, **tamper-resistant**, and **secure**.

---

## 🧠 FSM: Password Pattern Recognition for Secure Access

The Finite State Machine (FSM) depicted below controls **password validation** for result access in the EVM system.

![EVM FSM]([images/EVM_FSM.png](https://github.com/SayantanMandal2000/electronic-voting-machine-verilog/blob/main/sim/EVM_FSM.png))

### 🔒 FSM Overview

This FSM is designed to validate a **4-bit binary password pattern** entered via **two push buttons** (B1 and B0):

- **B1** and **B0** represent individual binary bits (e.g., B1=1, B0=0).
- The system moves through states `S0` to `S4` in a predefined sequence, checking input values at each stage.
- Only the correct **input pattern** leads to **state S4**, where the result is unlocked.

---

### 🧾 FSM Behavior by States

| State | Description                              | Inputs (B1,B0) | Outputs (Open, Error) |
|-------|------------------------------------------|----------------|------------------------|
| S0    | Initial/Reset State                      | -              | Open=0, Error=0        |
| S1    | First correct input received             | B1=1, B0=0     | Open=0, Error=0        |
| S2    | Second correct input                     | B1=0, B0=1     | Open=0, Error=0        |
| S3    | Third correct input                      | B1=1, B0=1     | Open=0, Error=0        |
| S4    | Final correct input – Password accepted  | B1=0, B0=0     | Open=1, Error=0        |
| E1-E4 | Error states triggered by wrong sequence | Various        | Open=0, Error=1 (in E4)|

---

### ❌ Error Detection Logic

- If at **any point** an incorrect bit combination is entered:
  - FSM transitions to one of the error states (`E1`, `E2`, `E3`, `E4`).
  - The system remains **locked** (`Open=0`) and triggers an error flag (`Error=1` in `E4`).
  - User must restart the password sequence.

---

### ✅ Correct Password Flow

- Correct sequence:  
  **S0 → S1 → S2 → S3 → S4** with inputs:  
  `B1B0 = 10 → 01 → 11 → 00`

- At **S4**, output `Open = 1` unlocks the results.

This ensures **only authorized personnel** with knowledge of the binary password pattern can access and display election results securely.

---

## 🧰 Tools & Technologies

| Component          | Description                                   |
|--------------------|-----------------------------------------------|
| **FPGA Board**      | Zynq ZED board (Zynq-7000 series)             |
| **Language**        | Verilog HDL                                   |
| **Simulation**      | Vivado, GTKWave                               |
| **Debug**           | Virtual Input/Output (VIO)                    |
| **Security**        | UID encryption + push-button password (FSM)  |

---

## 📊 Synthesis Summary

| Parameter            | Value          |
| -------------------- | -------------- |
| Total On-Chip Power  | 0.108 W        |
| Thermal Margin       | 58.8 °C (4.9W) |
| Setup (WNS)          | 28.78 ns       |
| Hold (WHS)           | 28.78 ns       |
| Pulse Width Slack    | 15.25 ns       |
| LUT & FF Utilization | Optimized      |

---

## 🚧 Challenges & Resolutions

| Challenge                      | Description & Solution                                                                |
| ------------------------------ | ------------------------------------------------------------------------------------- |
| Garbage values on OLED         | Unused GDRAM areas showed garbage; solved by padding OLED string data with zero bytes |
| Multiple votes due to bouncing | Resolved using **debouncing circuit** and **clock division** on button input          |
| LED Clock Mismatch             | Zynq clock too fast for LED updates; added counter to reduce frequency                |

---

## 🎓 Educational Value

This project is an excellent case study for:

- 📘 **Verilog RTL Design**: FSM control, voting logic, encryption/decryption  
- 💻 **FPGA Programming**: Synthesis, real-time interfacing, I/O handling  
- 🔄 **Hardware-Software Co-Design**: OLED, push-buttons
- 🛠️ **Debugging & Simulation**: VIO observation, GTKWave waveform analysis  
- 🔐 **Security-Driven Digital Logic**: Password protection & UID validation  
