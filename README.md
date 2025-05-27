# 🧠 run_and_dump.ps1

## Overview

This PowerShell script automates the execution of a PE file (simulated malware) and creates a memory dump using `winpmem_mini_x64_rc2.exe`. The resulting `.elf` file is then copied to a designated shared folder for forensic analysis.

## Features

- Verifies administrator privileges
- Launches a PE file (e.g., malware sample)
- Creates a memory dump with WinPmem
- Waits until the dump file is created (max 60 seconds)
- Copies the file to a shared drive and opens the directory

## Requirements

- Windows with PowerShell
- `PE_FILE.exe` located at `C:\MalwareLab\`
- `winpmem_mini_x64_rc2.exe` located at `C:\Tools\`
- A shared folder mapped to `X:\`

## Usage

```powershell
.un_and_dump.ps1
```

> Important: PowerShell must be run as **Administrator**

## Output

- Memory dump file (e.g., `memdump_20250527_1933.elf`)
- File is copied to `X:\` for later analysis (e.g., in REMnux with Volatility3)

## Educational Purpose

This script was developed for use in malware analysis labs as part of the **IT Security Specialist** training program. It enables controlled sample execution and memory capture for later investigation.
