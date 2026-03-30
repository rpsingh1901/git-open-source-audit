#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Git
# Purpose: Asks the user three interactive questions and
#          generates a personalised open-source philosophy
#          statement, saved to a .txt file.
# Concepts: read, string concatenation, file writing (>/>>) ,
#           date command, aliases (demonstrated via comment)
# ============================================================

# --- Alias concept demonstration ---
# In a live terminal session, aliases shorten commands. For example:
#   alias today='date +%d-%m-%Y'
# We can't set aliases in non-interactive scripts, but we
# achieve the same result with a function below.

# --- Function as alias equivalent for formatted date ---
today() {
    date '+%d %B %Y'
}

# --- Welcome header ---
echo "================================================================"
echo "        OPEN SOURCE MANIFESTO GENERATOR                       "
echo "================================================================"
echo "  Answer three questions to generate your personal manifesto."
echo "  It will be saved as a .txt file when you are done."
echo "================================================================"
echo ""

# --- Interactive input using 'read' with prompts ---

# Question 1: A tool they use every day
read -p "  1. Name one open-source tool you use every day: " TOOL

# Question 2: What freedom means in one word
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM

# Question 3: Something they would build and share
read -p "  3. Name one thing you would build and share freely: " BUILD

# --- Get current date and logged-in user ---
DATE=$(today)               # Uses our function defined above
AUTHOR=$(whoami)            # Current user's login name

# --- Compose output filename: manifesto_username.txt ---
OUTPUT="manifesto_${AUTHOR}.txt"

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Write manifesto to file using > (overwrite) and >> (append) ---

# First line: title (overwrites any existing file with > )
echo "================================================================" > "$OUTPUT"
echo "         MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Metadata block
echo "  Author  : $AUTHOR" >> "$OUTPUT"
echo "  Date    : $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- String concatenation to build the manifesto paragraph ---
# We build PARA using variable expansion and concatenation

PARA="I believe that software should be free — not as in free beer, but "
PARA+="free as in $FREEDOM. Every day, I rely on $TOOL, a tool that "
PARA+="someone chose to share with the world rather than lock behind a "
PARA+="paywall. That choice gave me — and millions of others — the power "
PARA+="to learn, to build, and to contribute."
PARA+=" "
PARA+="Standing on the shoulders of open-source giants, I commit to giving "
PARA+="back. If I had the skill today, I would build $BUILD and share it "
PARA+="freely, because I understand now that every great tool — Linux, Git, "
PARA+="Python, the web itself — began with one person deciding that their "
PARA+="work belonged to everyone."
PARA+=" "
PARA+="Open source is not just a license. It is a philosophy. It is the "
PARA+="belief that knowledge shared is knowledge multiplied, that "
PARA+="transparency builds trust, and that the act of contributing — even "
PARA+="something small — is what keeps the commons alive."

# Write the paragraph to the output file
echo "$PARA" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Closing signature block
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Signed : $AUTHOR" >> "$OUTPUT"
echo "  Date   : $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  'Given enough eyeballs, all bugs are shallow.'" >> "$OUTPUT"
echo "  — Eric S. Raymond, The Cathedral and the Bazaar" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# --- Confirm save and display the result ---
echo "  Manifesto saved to: $OUTPUT"
echo ""
echo "================================================================"
echo "  YOUR MANIFESTO:"
echo "================================================================"
echo ""

# cat the file to display it in the terminal
cat "$OUTPUT"
