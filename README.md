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

![EVM Flowchart](images/EVM_FlowChart.png)

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
