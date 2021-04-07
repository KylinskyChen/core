#include <defs.h>
#include <stdio.h>
#include <string.h>
#include <console.h>
#include <kdebug.h>
#include <picirq.h>
#include <trap.h>
#include <clock.h>
#include <intr.h>
#include <pmm.h>
#include <kmonitor.h>

void kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

/*
 * 函数功能：内核入口；
 */
void
kern_init(void){
    extern char edata[], end[];
    memset(edata, 0, end - edata);

    // 初始化控制台（控制显卡交互）；
    // 只有设置好了对显卡的控制后，std_out 输出的信息（例如 cprintf）才能显示在控制台中；
    cons_init();

    // const char *message = "xiechen's os is loading ...";
    // cprintf("%s\n\n", message);

    // print_kerninfo();

    grade_backtrace();

    // 初始化物理内存管理器；
    pmm_init();

    // 初始化中断控制器；
    // 当一个外设产生中断后，中断控制器会将中断产生一个对应的中断号，传给 cpu 去处理；
    pic_init();                
    // 初始化中断描述符表；
    idt_init();

    // 初始化时钟中断；
    clock_init();
    // 开中断，使能中断，真正产生中断的地方；
    intr_enable();              

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    // 从内核态能跳到用户态，再从用户态通过系统调用，跳到内核态；
    // 1 个好问题：如何构造一个用户态的运行环境？
    lab1_switch_test();

    // 阻塞，避免内核程序退出。通过监听中断事件进行服务；
    while (1);
}

// -------------------------------------------------------------------------------
// 功能：堆栈追踪；

// ebp:0x00007b28 eip:0x001009b6 args:0x00010094 0x00010094 0x00007b58 0x00100097 
//     kern/debug/kdebug.c:305: print_stackframe+21
// ebp:0x00007b38 eip:0x00100ca5 args:0x00000000 0x00000000 0x00000000 0x00007ba8 
//     kern/debug/kmonitor.c:125: mon_backtrace+10
// ebp:0x00007b58 eip:0x00100097 args:0x00000000 0x00007b80 0xffff0000 0x00007b84 
//     kern/init/init.c:48: grade_backtrace2+33
// ebp:0x00007b78 eip:0x001000c0 args:0x00000000 0xffff0000 0x00007ba4 0x00000029 
//     kern/init/init.c:53: grade_backtrace1+38
// ebp:0x00007b98 eip:0x001000de args:0x00000000 0x00100000 0xffff0000 0x0000001d 
//     kern/init/init.c:58: grade_backtrace0+23
// ebp:0x00007bb8 eip:0x00100103 args:0x0010359c 0x00103580 0x0000136a 0x00000000 
//     kern/init/init.c:63: grade_backtrace+34
// ebp:0x00007be8 eip:0x00100055 args:0x00000000 0x00000000 0x00000000 0x00007c4f 
//     kern/init/init.c:28: kern_init+84
// ebp:0x00007bf8 eip:0x00007d64 args:0xc031fcfa 0xc08ed88e 0x64e4d08e 0xfa7502a8 
//     <unknow>: -- 0x00007d63 --

// ebp 指向的堆栈位置储存着调用者的 ebp；
// 以此为线索可以得到所有使用堆栈的函数 ebp；
// ebp + 4 指向调用者调用时的 eip；
// ebp + 8 等是（可能的）参数。

// 输出中，堆栈最深一层对应的是第一个使用堆栈的函数，bootmain.c 中 的bootmain；
// bootloader 设置的堆栈从 0x7c00 开始，使用 call bootmain 转入 bootmain 函数；
// call 指令压栈，所以 bootmain 中 ebp 为 0x7bf8 = 0x7c00 - 4；

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
    mon_backtrace(0, NULL, NULL);
}

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
}

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
    grade_backtrace1(arg0, arg2);
}

void
grade_backtrace(void) {
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
}

// -------------------------------------------------------------------------------

static void
lab1_print_cur_status(void) {
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3); // 将 cs 的值赋值给 reg；
                                                // 如果 cs 为 00 则在内核态；
                                                //     cs 为 11 则为用户态；
    cprintf("%d:  cs = %x\n", round, reg1);
    cprintf("%d:  ds = %x\n", round, reg2);
    cprintf("%d:  es = %x\n", round, reg3);
    cprintf("%d:  ss = %x\n", round, reg4);
    round ++;
}

static void
lab1_switch_to_user(void) {

// 调用 T_SWITCH_TOU 中断；

// 注意：从中断返回时，会多 pop 2 位，用这两位的值更新 ss、sp，损坏堆栈；
//      所以要先把栈压 2 位，并在从中断返回后修复 esp；

    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
	    "sub $0x8, %%esp \n"
	    "int %0 \n"
	    "movl %%ebp, %%esp"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
    // 进入 T_SWITCH_TOU 中断；
}

static void
lab1_switch_to_kernel(void) {

// 注意从中断返回时，esp 仍在 TSS 指示的堆栈中，所以要在从中断返回后修复 esp；

    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
	    "int %0 \n"
	    "movl %%ebp, %%esp \n"
	    : 
	    : "i"(T_SWITCH_TOK)
	);
}

static void
lab1_switch_test(void) {
    lab1_print_cur_status();
    cprintf("+++ switch to  user  mode +++\n");
    // 内核切用户态；
    lab1_switch_to_user();
    // 打印当前状态；
    lab1_print_cur_status();
    cprintf("+++ switch to kernel mode +++\n");
    // 用户态切内核态；
    lab1_switch_to_kernel();
    // 打印当前状态；
    lab1_print_cur_status();
}

