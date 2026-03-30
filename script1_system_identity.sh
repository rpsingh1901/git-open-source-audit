#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Git
# Purpose: Displays a welcome screen with system information
#          and open-source license details of the OS.
# ============================================================

# --- Student and software metadata ---
STUDENT_NAME="[Your Name]"          # Replace with your actual name
SOFTWARE_CHOICE="Git"               # Chosen open-source software

# --- Gather system info using command substitution $() ---
KERNEL=$(uname -r)                          # Kernel version
USER_NAME=$(whoami)                         # Currently logged-in user
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%d %B %Y %H:%M:%S')  # Formatted current date and time

# --- Detect Linux distribution name from /etc/os-release ---
if [ -f /etc/os-release ]; then
    # Source the file to read variables like NAME
    . /etc/os-release
    DISTRO_NAME=$NAME
else
    # Fallback if /etc/os-release doesn't exist
    DISTRO_NAME="Unknown Distribution"
fi

# --- Determine the OS license (Linux kernel is GPL v2) ---
OS_LICENSE="GNU General Public License version 2 (GPL v2)"

# --- Display formatted welcome screen ---
echo "================================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT            "
echo "================================================================"
echo "  Student    : $STUDENT_NAME"
echo "  Software   : $SOFTWARE_CHOICE"
echo "================================================================"
echo ""
echo "  Distribution : $DISTRO_NAME"
echo "  Kernel       : $KERNEL"
echo "  Logged In As : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $CURRENT_DATE"
echo ""
echo "----------------------------------------------------------------"
echo "  OS License   : $OS_LICENSE"
echo "  The Linux kernel is free software; you can redistribute it"
echo "  and/or modify it under the terms of the GPL v2."
echo "----------------------------------------------------------------"
echo ""
echo "  'Free software is a matter of liberty, not price.'"
echo "  — Richard Stallman, GNU Project"
echo ""
echo "================================================================"
