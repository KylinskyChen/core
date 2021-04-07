#include <memlayout.h>

# vectors.s 在这里给出所有的静态分区；
.text
.globl __alltraps
__alltraps:
    # 所有的中断会跳到这里；
    # 保存：

    # 存入寄存器来创建一个静态分区框架，栈此时看起来像一个框架；
    pushl %ds
    pushl %es
    pushl %fs
    pushl %gs
    pushal

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
    movw %ax, %ds
    movw %ax, %es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp

    # call trap(tf), where tf=%esp
    call trap

    # pop the pushed stack pointer
    popl %esp

    # return falls through to trapret...
.globl __trapret
__trapret:
    # 恢复；
    # restore registers from stack
    popal

    # restore %ds, %es, %fs and %gs
    popl %gs
    popl %fs
    popl %es
    popl %ds

    # get rid of the trap number and error code
    addl $0x8, %esp

    # 返回；
    # 从内核态跳到用户态，使用用户态的堆栈；
    iret

