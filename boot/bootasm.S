#include <asm.h>

.set PROT_MODE_CSEG,    0x08
.set PROT_MODE_DSEG,    0x10
.set CR0_PE_ON,         0x01

.global start
start:
.code16
    cli
    cld

    xorw %ax, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss

seta20.1:
    inb $0x64, %al
    testb $0x02, %al
    jnz seta20.1

seta20.2:
    inb $0x64, %al
    testb $0x02, %al
    jnz seta20.2

    movb $0xdf, %al
    outb %al, $0x60

    lgdt gdtdesc
    movl %cr0, %eax
    orl $CR0_PE_ON, %eax
    movl %eax, %cr0

    ljmp $PROT_MODE_CSEG, $protcseg

.code32
protcseg:
    movw $PROT_MODE_DSEG, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    movw %ax, %ss

    movl $0x00, %ebp
    movl $start, %esp
    call bootmain

spin:
    jmp spin

.p2align 2
gdt:
    SEG_NULLASM
    SEG_ASM(STA_X | STA_R, 0x00, 0xffffffff)
    SEG_ASM(STA_W        , 0x00, 0xffffffff)

gdtdesc:
    .word 0x17
    .long gdt

