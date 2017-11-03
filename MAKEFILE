#################
# RAZE makefile #
#################

# Compiler flags
CFLAGS  = -Wall -O3 -m486
NASMFLAGS = -w+orphan-labels

# Programs
CC      = gcc
NASM    = nasm

####################################
# Spectrum emulator - test program #
####################################
all: spec.exe

spec.exe: spec.o spechelp.o raze.o
	$(CC) $^ -o $@ -lalleg
	@echo Test program assembled!

spec.o: spec.c spec.h raze.h
spechelp.o: spechelp.c spec.h raze.h

#############
# RAZE core #
#############

# This pre-processes the .ASM file
raze2.asm: raze.asm raze.inc raze.reg
	$(NASM) $(NASMFLAGS) -e $< -o $@

# This assembles the file, once it's been pre-processed
raze.o: raze2.asm
	$(NASM) $(NASMFLAGS) -f coff $< -o $@ -praze.reg
	@echo RAZE core assembled!
