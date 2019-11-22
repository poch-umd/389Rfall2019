#!/bin/sh

# Tries to look for a wordlist to use, falls back to a (hopefully available) github source

ROCKYOU_GZ=/usr/share/wordlists/rockyou.txt.gz
ROCKYOU_TX=/usr/share/wordlists/rockyou.txt
ROCKYOU_GH=https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

if [ -f rockyou.txt.gz ]; then
  ROCKYOU_CMD='zcat'
  ROCKYOU_PATH=rockyou.txt.gz
elif [ -f rockyou.txt ]; then
  ROCKYOU_CMD='cat'
  ROCKYOU_PATH=rockyou.txt
elif [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
  ROCKYOU_CMD='zcat'
  ROCKYOU_PATH=${ROCKYOU_GZ}
elif [ -f /usr/share/wordlists/rockyou.txt ]; then
  ROCKYOU_CMD='cat'
  ROCKYOU_PATH=${ROCKYOU_TX}
else
  ROCKYOU_CMD='wget -qO-'
  ROCKYOU_PATH=${ROCKYOU_GH}
fi

${ROCKYOU_CMD} ${ROCKYOU_PATH}
