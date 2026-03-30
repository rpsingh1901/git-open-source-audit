#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Git
# Purpose: Loops through key system directories and reports
#          disk usage, owner, and permissions for each.
#          Also checks Git's config directory specifically.
# ============================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/var" "/usr/share")

echo "================================================================"
echo "          DISK AND PERMISSION AUDITOR                          "
echo "================================================================"
printf "  %-20s %-25s %-10s\n" "Directory" "Permissions (type user group)" "Size"
echo "----------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # ls -ld gives directory info; awk extracts permissions, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        # du -sh gives human-readable size; cut removes the path, keeps size
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        # Print formatted row
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "$SIZE"
    else
        # Directory doesn't exist on this system
        printf "  %-20s %s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo ""
echo "================================================================"
echo "  GIT CONFIG DIRECTORY CHECK (Chosen Software: Git)           "
echo "================================================================"

# --- Check Git's global config directory specifically ---
# Git stores its system config in /etc/gitconfig and user config in ~/.gitconfig
GIT_SYSTEM_CONF="/etc/gitconfig"
GIT_USER_CONF="$HOME/.gitconfig"
GIT_GLOBAL_DIR="$HOME/.config/git"

# Check system-wide git configuration file
if [ -f "$GIT_SYSTEM_CONF" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONF" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$GIT_SYSTEM_CONF" 2>/dev/null | cut -f1)
    echo "  System config : $GIT_SYSTEM_CONF"
    echo "  Permissions   : $PERMS | Size: $SIZE"
else
    echo "  System config : $GIT_SYSTEM_CONF — not found (Git may not be installed)"
fi

echo ""

# Check user-level git config file
if [ -f "$GIT_USER_CONF" ]; then
    PERMS=$(ls -l "$GIT_USER_CONF" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$GIT_USER_CONF" 2>/dev/null | cut -f1)
    echo "  User config   : $GIT_USER_CONF"
    echo "  Permissions   : $PERMS | Size: $SIZE"
else
    echo "  User config   : $GIT_USER_CONF — not found (no user config set yet)"
fi

echo ""

# Check ~/.config/git directory (newer Git versions use this)
if [ -d "$GIT_GLOBAL_DIR" ]; then
    PERMS=$(ls -ld "$GIT_GLOBAL_DIR" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$GIT_GLOBAL_DIR" 2>/dev/null | cut -f1)
    echo "  Config dir    : $GIT_GLOBAL_DIR"
    echo "  Permissions   : $PERMS | Size: $SIZE"
else
    echo "  Config dir    : $GIT_GLOBAL_DIR — not found"
fi

echo ""

# Check where the git binary lives
GIT_BIN=$(which git 2>/dev/null)
if [ -n "$GIT_BIN" ]; then
    PERMS=$(ls -l "$GIT_BIN" | awk '{print $1, $3, $4}')
    echo "  Git binary    : $GIT_BIN"
    echo "  Permissions   : $PERMS"
    echo "  Version       : $(git --version)"
else
    echo "  Git binary    : not found in PATH (install with: sudo apt install git)"
fi

echo "================================================================"
