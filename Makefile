COLOR_GREEN		:= \033[32m
COLOR_BLUE		:= \033[36m
COLOR_YELLOW	:= \033[33m
COLOR_RESET		:= \033[0m

CXX			:= gcc
ASM			:= nasm
LD			:= ld

CFLAGS		:= -m32 -fno-builtin -fno-stack-protector -fno-pic -nostdlib -nodefaultlibs -Wall -Werror -Wextra -O2 -std=gnu99
ASMFLAGS	:= -f elf32
LDFLAGS		:= -m elf_i386 -T

LINKER_CFG	:= boot/linker.ld
GRUB_CFG	:= boot/grub.cfg

ELF			:= build/iso/kfs
ISO			:= build/iso/kfs.iso

ASM_SRCS	:= boot/boot.asm
CXX_SRCS	:= $(shell find kernel -name "*.c")

ASM_OBJS	:= $(patsubst %.asm, build/%.o, $(ASM_SRCS))
CXX_OBJS	:= $(patsubst %.c, build/%.o, $(CXX_SRCS))

all: $(ASM_OBJS) $(CXX_OBJS) $(ELF) $(ISO)

clean:
	@echo "$(COLOR_YELLOW)Cleaning build directory$(COLOR_RESET)"
	@rm -rf build

re: clean all

run:
	@env -i PATH=/usr/bin:/bin HOME=$(HOME) DISPLAY=$(DISPLAY) qemu-system-i386 -cdrom $(ISO)

.PHONY: all run clean re

build/%.o: %.asm
	@mkdir -p $(dir $@)
	@echo "$(COLOR_BLUE)Compiling $<...$(COLOR_RESET)"
	@$(ASM) $(ASMFLAGS) $< -o $@

build/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "$(COLOR_BLUE)Compiling $<...$(COLOR_RESET)"
	@$(CXX) $(CFLAGS) -Ikernel -c $< -o $@

$(ELF): $(ASM_OBJS) $(CXX_OBJS) $(LINKER_CFG)
	@mkdir -p build/iso
	@echo "$(COLOR_BLUE)Linking...$(COLOR_RESET)"
	@$(LD) $(LDFLAGS) $(LINKER_CFG) -o $@ $(ASM_OBJS) $(CXX_OBJS)
	@echo "$(COLOR_GREEN)Linking successful!$(COLOR_RESET)"

$(ISO): $(ELF)
	@mkdir -p build/iso/boot/grub
	@cp $(GRUB_CFG) build/iso/boot/grub/grub.cfg
	@echo "$(COLOR_BLUE)Building ISO...$(COLOR_RESET)"
	@grub-mkrescue -o $@ build/iso 2>/dev/null
	@echo "$(COLOR_GREEN)ISO built!$(COLOR_RESET)"