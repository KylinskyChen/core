# 从库环境变量中导入 asm.h 文件的内容；
#include <asm.h>

# 操作系统加载到内存中的第一个程序入口；

# 启动 CPU：切换到 32 位保护模式，跳转到 C 程序中；
# BIOS 从硬盘的第一个块，物理内存地址为 0x7C00 的位置，以实模式 %cs = 0 %ip = 7c00 开始执行；

# 定义常量；
.set PROT_MODE_CSEG,        0x8                     # 内核代码段选择器；
                                                    # 段的描述子；
.set PROT_MODE_DSEG,        0x10                    # 内核数据段选择器；
.set CR0_PE_ON,             0x1                     # 保护模式使能标识；
.set SMAP,                  0x534d4150

# 实模式的起始地址为 0:7c00，为 bootloader 的起始地址；
.globl start
start:
.code16                                             # 指定为 16 位模式；
    cli                                             # 失能中断；
    cld                                             # String operations increment；（方向标志位置 0 指令）；

    # 关注点 1：
    # 设置重要段寄存器：DS、ES、SS；
    #
    #   DS：数据段 (Data Segment)；
    #   ES：附加数据段 (Extra Segment)；
    #   SS：堆栈段 (Stack Segment)；
    #
    #   AX：累加器；
    #
    # xorw 异或运算，16 位；
    # movw 字传送，16 位；

    xorw %ax, %ax                                   # Segment number zero
    movw %ax, %ds                                   # -> Data Segment
    movw %ax, %es                                   # -> Extra Segment
    movw %ax, %ss                                   # -> Stack Segment

    # 关注点 2：
    # 使能 A20 地址线；
    #
    # 为了兼容早期的 PC 机，物理地址行 20 被固定在较低的位置，因此高于 1MB 的地址默认为 0，这段代码会取消它；
    #
    # al：累加器；
    #
    # inb：I/O 端口输入，8 位；
    # outb：I/O 端口输出，8 位；
    # testb：测试，8 位（两操作数作与运算，仅修改标志位，不回送结果）；
    # jne/jnz：不等于时转移；

seta20.1:
                                                    # 从输入缓冲（端口 0x64）读取一个数据到累加器中；
    inb $0x64, %al                                  # 等待 8042 Input buffer 为空；
    testb $0x2, %al                                 # 如果 %al 第低 2 位为 1，则 ZF = 0, 则跳转；
    jnz seta20.1                                    # 如果 %al 第低 2 位为 0，则 ZF = 1, 则不跳转；

    movb $0xd1, %al                                 # 0xd1 -> port 0x64
    outb %al, $0x64                                 # 0xd1: 向 8042 的输出端口 P2 写入信息；

seta20.2:
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al
    jnz seta20.2

    movb $0xdf, %al                                 # 0xdf -> port 0x60
    outb %al, $0x60                                 # 0xdf = 11011111，设置 P2 的 A20 位（第 1 位）为 1；

    # 关注点 3：
    # 全局描述符表 GDT：存放 8 字节的段描述符，段描述符包含段的属性；
    #
    # 段选择符       ：总共 16 位，高 13 位用作全局描述符表中的索引位，GDT 的第一项总是设为 0，
    #                   因此孔断选择符的逻辑地址会被认为是无效的，从而引起一个处理器异常；
    #                   GDT 表项最大数目是 8191 个，即 2^13 - 1；
    #
    # 从实模式切换到保护模式，使用 GDT 引导和段转换，使虚拟地址与物理地址相同，有效的内存映射在切换期间不会改变；
    # lgdt 指令是将 GDT 入口地址存到 gdtdesc 寄存器里；
    #
    # orl：32 位或运算；
    #
    # eax：32 位累加器；
    # cr0：32 位控制寄存器；

    lgdt gdtdesc                                    # 通过 lgdt 指令把表的地址和大小装入 GDTR 寄存器；

    movl %cr0, %eax                                 # 获取 CR0 寄存器中的数值；
    orl $CR0_PE_ON, %eax                            # 0 位是保护允许位 PE (Protedted Enable)，置 1 来启动保护模式；
    movl %eax, %cr0                                 # 将累加器的值赋给 cr0；

    # 到这里，跳转到下一个指令，但在 32 位代码段；
    # 将处理器切换到 32 位模式；
    # ljmp：将处理器切换到 32 位模式，以 32 位模式进行跳转；
    #
    # PROT_MODE_CSEG = 0x8，内核代码段选择器；
    #
    # 由于上面的代码已经打开了保护模式了，所以这里要使用逻辑地址，而不是之前实模式的地址了；
    # 这里用到了 PROT_MODE_CSEG，它的值是 0x8
    # 根据段选择子的格式定义，0x8 翻译为：
    #　　　　　　　    INDEX　　　　　　　TI     CPL
    #　　　　    0000 0000 0000 1      00      0
    # INDEX 代表 GDT 中的索引，TI 代表是否使用 GDTR 中的 GDT，CPL 代表处于的特权级；

    ljmp $PROT_MODE_CSEG, $protcseg                 # 跳转到程序段 protcseg；

.code32                                             # 汇编 32 位模式；
protcseg:                                           # 32 位段地址；
    # 关注点 4：
    # 设置保护模式的数据段寄存器并跳转到主程序；
    #
    # PROT_MODE_DSEG = 0x10，内核数据段选择器；
    #
    # DS：数据段 (Data Segment)；
    # ES：附加数据段 (Extra Segment)；
    # SS：堆栈段 (Stack Segment)；
    # FS：附加段；
    # GS：附加段；
                                                    # 前面有一个空段，一个 code 段，所以数据段为 16；
    movw $PROT_MODE_DSEG, %ax                       # 数据段选择器；
    movw %ax, %ds                                   # -> DS：数据段 (Data Segment)；
    movw %ax, %es                                   # -> ES：附加数据段 (Extra Segment)；
    movw %ax, %fs                                   # -> FS：附加段；
    movw %ax, %gs                                   # -> GS：附加段；
    movw %ax, %ss                                   # -> SS：堆栈段 (Stack Segment)；

    # 到这里，地址空间就设置好了；

    # 设置堆栈指针并调用 C 中的程序，堆栈区域从 0 到 start (0x7C00)；
    #
    # 为了让读内核的 bootmain 有数据可以放；
    #
    # esp   栈指针寄存器 (extended stack pointer)
    #       寄存器存放当前线程的栈顶指针；
    # ebp   基址指针寄存器 (extended base pointer)
    #       寄存器存放当前线程的栈底指针；
    # eip
    #       寄存器存放下一个 CPU 指令存放的内存地址；
    #       当 CPU 执行完当前的指令后，从 eip 寄存器中读取下一条指令的内存地址，然后继续执行。

                                                    # 堆栈是向低地址生长的；
    movl $0x0, %ebp                                 # 清空当前线程栈底指针，设置函数调用栈链式最开始的地方为 0；
    movl $start, %esp                               # 将 start 放到栈顶，设置栈的堆栈的空间大小；
    call bootmain                                   # 调用 bootmain 函数；

    # bootmain 返回的地方，实际上不会执行到这里，若执行到此处则循环；
spin:
    jmp spin

.data
# GDTR 引导程序；
.p2align 2                                          # 强制 4 字节对齐；
gdt:                                                # #标识符，表示地址；
    SEG_NULLASM                                     # 第一段永远为 0，不用；
                                                    # 创建两个 4G 空间的段；
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # bootloader 和 kernel 的代码段；
                                                    # 代码段是可执行、可读；
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # bootloader 和 kernel 数据段；
                                                    # 数据段为可写；

gdtdesc:                                            # GDTR 寄存器，用 lgdt 加载；
    .word 0x17                                      # sizeof(gdt) - 1
    .long gdt                                       # address gdt
