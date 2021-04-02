#include <defs.h>
#include <x86.h>
#include <elf.h>

/* *********************************************************************
 * 这是一个非常简单的引导加载程序，它的唯一工作是从第一个 IDE 硬盘引导 ELF 内核映像；
 *
 * 磁盘布局
 * 
 *  * 这个程序 (bootasm.S and bootmain.c) 是一个 bootloader 引导程序；
 *    它应该存储在磁盘的第一个扇区中；
 *
 *  * 第二个扇区开始保存内核镜像；
 *
 *  * 内核映像必须是 ELF 格式；
 *
 * 启动步骤：
 * 
 *  1. 当 CPU 上电时，将 BIOS 加载到内存中并执行它；
 * 
 *  2. BIOS 初始化设备、中断向量表，读取引导设备的第一个扇区到内存并跳转执行；
 * 
 *  3. 如果当前的 bootloader 被存储在硬盘驱动器的第一个扇区，这段代码开始接管 CPU；
 *
 *  4. bootasm.S 控制 CPU 启动，设置保护模式和栈，接着运行 C 代码，调用 bootmain()；
 *
 *  5. 这个文件中的 bootmain() 函数接管 CPU，读取内核代码并跳转到内核代码中执行。
 * */

#define SECTSIZE        512
#define ELFHDR          ((struct elfhdr *)0x10000)      // 暂存空间；
                                                        // kernel.ld 文件中设置的内核起始地址为 0x10000；

/*
 * 函数功能：等待磁盘就绪；
 */
static void
waitdisk(void) {
    // 0x1F7 的输入 1100 0000 最高 2 位，如果为 0100 0000 中的 01，则跳出循环；
    while ((inb(0x1F7) & 0xC0) != 0x40)
        /* 空跑； */;
}

/*
 * 函数功能：从 secno 读取单个扇区到 dst；
 */
static void
readsect(void *dst, uint32_t secno) {
    // 等待磁盘就绪；
    waitdisk();

    outb(0x1F2, 1);                             // count = 1，读取数量为 1；
    outb(0x1F3, secno & 0xFF);                  // 表示读取磁盘的扇区编号；
    outb(0x1F4, (secno >> 8) & 0xFF);           // 扇区号；
    outb(0x1F5, (secno >> 16) & 0xFF);          // 柱面号低 8 位；
    outb(0x1F6, ((secno >> 24) & 0xF) | 0xE0);  // 柱面号高 8 位，0xE0 = 11100000，代表主驱动器，LBA 寻址方式；
    outb(0x1F7, 0x20);                          // cmd 0x20，读取扇区的指令；

    // 等待磁盘就绪；
    waitdisk();

    // 使用 32 位串输入指令 insl 来读取数据到 dst；
    insl(0x1F0, dst, SECTSIZE / 4);
}

/* 
 * 函数功能：从内核的虚拟地址 va 偏移 offset 的位置读取 count 个字节；
 * 备   注：可能复制读取的数据比请求的数据要多；
 */
static void
readseg(uintptr_t va, uint32_t count, uint32_t offset) {
    uintptr_t end_va = va + count;

    // 四舍五入到区域边界，获取当前所在块的首地址；
    va -= offset % SECTSIZE;

    // 从字节转换到扇区，内核从扇区 1 开始；
    // 由于第 1 个扇区被 bootloader 占据，kernel 内核从第二个扇区开始(下标为 1)，所以扇区号需要增加 1；
    uint32_t secno = (offset / SECTSIZE) + 1;

    // 如果觉得这种读取方式慢，可以一次读取多个扇区；
    // 我们写入内存的数据可能要比请求的多，不过问题不大，我们按递增顺序加载数据；
    for (; va < end_va; va += SECTSIZE, secno ++) {
        readsect((void *)va, secno);
    }
}

/* 
 * 函数功能：bootloader 的入口；
 */
void
bootmain(void) {
    // 读取磁盘第 1 页来获得 ELFHDR 的数据；
    // 读取 4K 的数据；
    readseg((uintptr_t)ELFHDR, SECTSIZE * 8, 0);

    // 检查 ELF 的有效性；
    // 第一页上的 ELFHDR->e_magic 数值必须等于 ELF_MAGIC 0x464C457FU；
    if (ELFHDR->e_magic != ELF_MAGIC) {
        goto bad;
    }

    struct proghdr *ph, *eph;

    // 加载每个程序段（忽略 ph 标志）；
    // 指向内核程序 program header table 头部；
    ph = (struct proghdr *)((uintptr_t)ELFHDR + ELFHDR->e_phoff);
    // 指向内核程序 program header table 尾部；
    eph = ph + ELFHDR->e_phnum;

    for (; ph < eph; ph ++) {
        // 逐段将内核程序读入内存；
        readseg(ph->p_va & 0xFFFFFF, ph->p_memsz, ph->p_offset);
    }

    // 从 ELF 的头部信息中找到内核起始点的函数地址；
    // 运行之后不再返回；
    ((void (*)(void))(ELFHDR->e_entry & 0xFFFFFF))();

bad:
    outw(0x8A00, 0x8A00);
    outw(0x8A00, 0x8E00);

    // 空循环，将程序阻塞在这里；
    while (1);
}

