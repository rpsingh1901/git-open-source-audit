
## Repository Structure

```
oss-audit-[rollnumber]/
├── README.md
├── script1_system_identity.sh
├── script2_package_inspector.sh
├── script3_disk_permission_auditor.sh
├── script4_log_analyzer.sh
└── script5_manifesto_generator.sh
```

---

## Script Descriptions

### Script 1 — System Identity Report (`script1_system_identity.sh`)
Displays a formatted welcome screen with the Linux distro name, kernel version, logged-in user, home directory, system uptime, date/time, and the open-source licence of the OS (GPL v2 for Linux).  
**Concepts:** Variables, `echo`, command substitution `$()`, `/etc/os-release` sourcing.

### Script 2 — FOSS Package Inspector (`script2_package_inspector.sh`)
Checks whether `git` is installed using `dpkg` (Debian/Ubuntu) or `rpm` (RHEL/Fedora). Extracts version and licence info using `grep`. Prints a philosophy note for the package using a `case` statement.  
**Concepts:** `if-then-else`, `case`, `dpkg`/`rpm`, pipes with `grep`.

### Script 3 — Disk and Permission Auditor (`script3_disk_permission_auditor.sh`)
Loops over an array of key system directories with a `for` loop. Extracts permissions (via `ls -ld | awk`) and size (via `du -sh | cut`) for each. Also audits Git's specific config files and binary.  
**Concepts:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`.

### Script 4 — Log File Analyzer (`script4_log_analyzer.sh`)
Reads a log file line-by-line with a `while read` loop, counting lines matching a keyword. Includes a retry loop if the file isn't found. Displays total count, percentage, and the last 5 matching lines.  
**Concepts:** `while IFS= read`, counter variables, `$1`/`$2` arguments, `grep -iq`, retry loop, `awk` for float math.

### Script 5 — Open Source Manifesto Generator (`script5_manifesto_generator.sh`)
Asks three interactive questions with `read -p`, builds a personalised paragraph using string concatenation (`+=`), and saves it to `manifesto_[username].txt` using `>` and `>>`.  
**Concepts:** `read`, string concatenation, file writing (`>`/`>>`), `date`, functions as alias equivalents.

---

## How to Run the Scripts on Linux

### Prerequisites
- A Linux system (Ubuntu/Debian/Fedora or any modern distro)
- Bash shell (default on all Linux systems)
- Git installed: `sudo apt install git` (Ubuntu) or `sudo dnf install git` (Fedora)

### Step 1 — Clone the repository
```bash
git clone https://github.com/[your-username]/oss-audit-[rollnumber].git
cd oss-audit-[rollnumber]
```

### Step 2 — Make scripts executable
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3 — Run each script

**Script 1:**
```bash
./script1_system_identity.sh
```

**Script 2:**
```bash
./script2_package_inspector.sh
```

**Script 3:**
```bash
./script3_disk_permission_auditor.sh
```

**Script 4** (requires a log file):
```bash
./script4_log_analyzer.sh /var/log/syslog error
# or with a custom log file:
./script4_log_analyzer.sh /var/log/auth.log warning
```

**Script 5** (interactive — will ask you 3 questions):
```bash
./script5_manifesto_generator.sh
```

---

## Dependencies

| Dependency | Used In | Install |
|------------|---------|---------|
| `bash` | All scripts | Pre-installed on all Linux systems |
| `git` | Script 2 | `sudo apt install git` |
| `dpkg` or `rpm` | Script 2 | Pre-installed (distro-dependent) |
| `awk`, `cut`, `grep` | Scripts 3, 4 | Part of GNU coreutils — pre-installed |
| `du`, `ls` | Script 3 | Part of GNU coreutils — pre-installed |
| Standard `/var/log/` files | Script 4 | Present on all Linux systems |

---

## Notes
- Scripts were written and tested on Ubuntu 22.04 LTS.
- Script 4 requires read permission on the target log file. Use `sudo` if needed for system logs.
- All scripts include inline comments explaining each section.
