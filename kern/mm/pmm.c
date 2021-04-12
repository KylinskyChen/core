#include <defs.h>
#include <x86.h>
#include <mmu.h>
#include <memlayout.h>
#include <pmm.h>

/* *
 * Task State Segment:
 * 任务状态段；
 *
 * The TSS may reside anywhere in memory. A special segment register called
 * the Task Register (TR) holds a segment selector that points a valid TSS
 * segment descriptor which resides in the GDT. Therefore, to use a TSS
 * the following must be done in function gdt_init:
 *   - create a TSS descriptor entry in GDT
 *   - add enough information to the TSS in memory as needed
 *   - load the TR register with a segment selector for that segment
 *
 * TSS 可以驻留在内存的任何地方；
 *
 * 特殊的任务寄存被称为 TR，拥有 1 个段选择子，指向 1 个有效的 TSS 段描述符，存储在全局描述符表 GDT 中；
 *
 * 因此，为了使用 TSS，gdt_init 中以下的操作是十分必要的：
 *  - 在 GDT 中创建 1 个 TSS 描述符的入口；
 *  - 在内存中的 TSS 中增加 TSS 必要的信息；
 *  - 使用该段的段选择器加载 TR 寄存器；
 *
 * There are several fileds in TSS for specifying the new stack pointer when a
 * privilege level change happens. But only the fields SS0 and ESP0 are useful
 * in our os kernel.
 *
 * TSS 中有几个字段，用于在发生特权级别更改时指定新的堆栈指针；
 * 但是在我们的操作系统内核中，只有 SS0 和 ESP0 字段是有用的；
 *
 * The field SS0 contains the stack segment selector for CPL = 0, and the ESP0
 * contains the new ESP value for CPL = 0. When an interrupt happens in protected
 * mode, the x86 CPU will look in the TSS for SS0 and ESP0 and load their value
 * into SS and ESP respectively.
 *
 * 当一个中断发生在保护模式下，x86 CPU 将在 TSS 中查找 SS0 和 ESP0，并分别将它们的值加载到 SS 和 ESP 中。
 * */
static struct taskstate ts = {0};

/* *
 * Global Descriptor Table:
 *
 * 全局描述符表：GDT；
 *
 * The kernel and user segments are identical (except for the DPL). To load
 * the %ss register, the CPL must equal the DPL. Thus, we must duplicate the
 * segments for the user and the kernel. Defined as follows:
 *   - 0x0 :  unused (always faults -- for trapping NULL far pointers)
 *   - 0x8 :  kernel code segment
 *   - 0x10:  kernel data segment
 *   - 0x18:  user code segment
 *   - 0x20:  user data segment
 *   - 0x28:  defined for tss, initialized in gdt_init
 *
 * 内核段和用户段是完全相同的（除了 DPL）；（问题：DPL 是个啥？）
 *
 * 为了加载 %ss 寄存器，CPL 必须等于 DPL；（问题：CPL 又是个啥？）
 *
 * 因此，我们必须为用户态和内核态拷贝段，定义如下；
 *   - 0x0 :  不使用（总是错误，用于捕获空指针；）
 *   - 0x8 :  内核代码段；
 *   - 0x10:  内核数据段；
 *   - 0x18:  用户代码段；
 *   - 0x20:  用户数据段；
 *   - 0x28:  为 TSS 定义，在 gdt_init 中被初始化；
 * */

// 对 ucore 的段进行了重新了定义
// 多了 3 项；
// DPL_KERNEL 为用户态的特权级为 0；
// DPL_USER   为内核态的特权级为 3；
static struct segdesc gdt[] = {
    SEG_NULL,
    [SEG_KTEXT] = SEG(STA_X | STA_R,    0x0, 0xFFFFFFFF, DPL_KERNEL ),
    [SEG_KDATA] = SEG(STA_W,            0x0, 0xFFFFFFFF, DPL_KERNEL ),
    [SEG_UTEXT] = SEG(STA_X | STA_R,    0x0, 0xFFFFFFFF, DPL_USER   ),
    [SEG_UDATA] = SEG(STA_W,            0x0, 0xFFFFFFFF, DPL_USER   ),
    [SEG_TSS]   = SEG_NULL,
};
// 各个段的界限都是 0x0000 0000 ~ 0xFFFF FFFF，任何程序都可以访问任何内存；
// 这样做相当于 uCore 放弃使用段机制，内存权限完全由页机制来限制；

// 内核的页表项与物理页是按顺序排列的；
// 只需要计算出物理页的个数，就可以知道页表项的个数；
// 因为页表项是从 0 地址开始映射的，所以知道页表项个数就可以计算出虚拟地址，当然，这种方法只对内核有效；


// +--------10------+-------10-------+---------12----------+
// | Page Directory |   Page Table   | Offset within Page  |
// |      Index     |     Index      |                     |
// +----------------+----------------+---------------------+
//  \--- PDX(la) --/ \--- PTX(la) --/ \---- PGOFF(la) ----/
//  \----------- PPN(la) -----------/

// 对于线性地址，前 20 位用来确定页表项，代码中用 PPN(la) 获取前 20 位；
// PPN(la) 还可以代表从 0 地址开始到 la 有几个页表项(等于物理页个数)；++

static struct pseudodesc gdt_pd = {
    sizeof(gdt) - 1, (uint32_t)gdt
};

/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 *
 * lgdt：加载全局描述符寄存器，同时，为内核复位数据、代码段寄存器；
 *
 * */
static inline void
lgdt(struct pseudodesc *pd) {
    // lgdt：将 GDT 入口地址存到 (%0) 中；
    asm volatile ("lgdt (%0)" :: "r" (pd));
    // 设置附加段 GS；
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
    // 设置附加段 FS；
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));

    // 设置附加数据段 ES；
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
    // 设置数据段 DS；
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
    // 设置堆栈段 SS；
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));

    // 重新加载 CS；
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
}

/* temporary kernel stack */
uint8_t stack0[1024];

/*
 * 函数功能：初始化默认的 GDT 和 TSS；
 */
static void
gdt_init(void) {
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.

    // TSS：task status sgement：任务状态段；
    // 当我们从用户态跳到内核态时，通过任务状态段的帮助，可以获得正确的堆栈；
    // 此时的基本实现是不安全的，只是一个暂时的值，在 LB2 中我们将它设置到栈顶 STACKTOP；

    // 设定好 ts 之后，从用户态返回内核态时，内核态的堆栈信息保存在 ts 中；

    // ts.ts_esp0、ts.ts_ss0 完成响应的处理；
    // ts：task segment；

    // ts 帮助完成 1 个内核栈的建立，使用户态切到内核态时，能够让 cpu 正确找到内核堆栈的位置；
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
    ts.ts_ss0 = KERNEL_DS;

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
    gdt[SEG_TSS].sd_s = 0;

    // reload all segment registers
    // 将新的 gdt 加载进内核并进行处理；
    lgdt(&gdt_pd);

    // load the TSS
    // 加载 tss 的信息；
    ltr(GD_TSS);
}

/*
 * 函数功能：初始化内存管理；
 */
static void
init_pmm_manager(void) {
    pmm_manager = &default_pmm_manager;
    cprintf("memory management: %s\n", pmm_manager->name);
    pmm_manager->init();
}



/*
 * 函数功能：初始化终端设备；
 */
void
pmm_init(void) {
    gdt_init();
}

