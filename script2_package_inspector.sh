#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Git
# Purpose: Checks if a FOSS package is installed, retrieves
#          its version/license info, and prints a philosophy
#          note using a case statement.
# ============================================================

# --- Package to inspect (our chosen software) ---
PACKAGE="git"   # Change to your software's package name if different

echo "================================================================"
echo "             FOSS PACKAGE INSPECTOR                            "
echo "================================================================"
echo "  Checking package: $PACKAGE"
echo "----------------------------------------------------------------"

# --- Check if the package is installed using if-then-else ---
# Try dpkg first (Debian/Ubuntu), then rpm (RHEL/Fedora/CentOS)
if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
    # Package is installed on a Debian-based system
    echo "  STATUS : $PACKAGE is INSTALLED (via dpkg)"
    echo ""
    echo "  --- Package Details ---"
    # Extract Version and Architecture fields with grep and pipe
    dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "  Version      : " $3}'
    dpkg -s "$PACKAGE" 2>/dev/null | grep -E "^(Version|Maintainer|Homepage)" \
        | sed 's/^/  /'
elif rpm -q "$PACKAGE" &>/dev/null; then
    # Package is installed on an RPM-based system
    echo "  STATUS : $PACKAGE is INSTALLED (via rpm)"
    echo ""
    echo "  --- Package Details ---"
    # Use rpm -qi to get detailed info, grep for key fields
    rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" \
        | sed 's/^/  /'
else
    # Package is not found on the system
    echo "  STATUS : $PACKAGE is NOT installed on this system."
    echo "  To install on Debian/Ubuntu : sudo apt install $PACKAGE"
    echo "  To install on RHEL/Fedora   : sudo dnf install $PACKAGE"
fi

echo ""
echo "----------------------------------------------------------------"
echo "  --- Open Source Philosophy Note ---"

# --- Case statement: prints a philosophy note based on package name ---
case $PACKAGE in
    git)
        echo "  Git: Born from necessity when Linus Torvalds rejected every"
        echo "  proprietary VCS. 'I'm an egotistical bastard and I name"
        echo "  things after myself.' Git = distributed freedom in code."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  A patchy server for a patchy web — community-driven since 1995."
        ;;
    mysql | mariadb)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual-license model sparked the great copyleft debate."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who just wanted to stream video."
        echo "  Plays anything — because freedom means no format left behind."
        ;;
    firefox)
        echo "  Firefox: A nonprofit's fight for an open web."
        echo "  When IE dominated 90%, Mozilla proved community could compete."
        ;;
    python3 | python)
        echo "  Python: Shaped entirely by community consensus (PEPs)."
        echo "  Guido van Rossum gave it away freely — and the world built on it."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a fork when Oracle acquired OpenOffice."
        echo "  A reminder that open-source communities can outlast corporations."
        ;;
    *)
        # Default case for any other package
        echo "  $PACKAGE: An open-source tool that someone chose to share"
        echo "  freely with the world. That choice made your workflow possible."
        ;;
esac

echo "================================================================"
