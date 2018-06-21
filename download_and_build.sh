#!/bin/bash

# download_and_build.sh
# Copyright (C) 2018  Joe Testa <jtesta@positronsecurity.com>
#
# This script will download the rainbowcrack tools from
# http://project-rainbowcrack.com/, check the archive hash, and build the snap.


# The expected SHA-256 hash of the rainbowcrack ZIP archive.
EXPECTED_HASH=89268b61ac956695325845a3be29bfa6cc89de5ae628334f58b7b5803e691353

# Delete any previously-downloaded archive.
rm -rf rainbowcrack-1.7-linux64.zip rainbowcrack-1.7-linux64

# Download the RainbowCrack v1.7 archive.
wget http://project-rainbowcrack.com/rainbowcrack-1.7-linux64.zip

# Check the SHA-256 hash.
CALCULATED_HASH=`sha256sum rainbowcrack-1.7-linux64.zip | cut -f1 -d" "`

if [[ $CALCULATED_HASH != $EXPECTED_HASH ]]; then
    echo "ERROR: SHA-256 hash of rainbowcrack archive does not match the expected value!"
    echo
    echo "Calculated: $CALCULATED_HASH"
    echo "Expected:   $EXPECTED_HASH"
    echo
    echo "Terminating."
    exit -1
fi

echo -e "\nSHA-256 hash of rainbowcrack archive verified.\n"

# Extract the rainbowcrack tools.
unzip rainbowcrack-1.7-linux64.zip

# Do a clean build.
snapcraft clean
snapcraft
