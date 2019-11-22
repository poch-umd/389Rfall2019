CC=gcc
CFLAGS=-g -fno-stack-protector -fno-pie -fPIC
LDLIBS=-lcrypto
OBJECTS=crypto.o common.o
TARGETS=ledger crack

ledger: ledger.o $(OBJECTS)

writeup/crack:
	make -j 4 -C writeup

clean:
	rm -rf *.o $(TARGETS) *.bin

all: ledger writeup/crack

.PHONY=clean
.DEFAULT_GOAL=all
