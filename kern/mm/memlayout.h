#ifndef __KERN_MM_MEMLAYOUT_H__
#define __KERN_MM_MEMLAYOUT_H__

/* This file contains the definitions for memory management in our OS. */

// 这个文件中包含了操作系统中，用于内存管理的定义；

/* global segment number */

// 全局的段号；

#define SEG_KTEXT    1  // 内核文本段；
#define SEG_KDATA    2  // 内核数据段；
#define SEG_UTEXT    3  // 用户文本段；
#define SEG_UDATA    4  // 用户数据段；
#define SEG_TSS      5  // 任务状态段；

/* global descriptor numbers */

// 全局描述符号；

#define GD_KTEXT    ((SEG_KTEXT) << 3)      // kernel text
                                            // 内核文本；
#define GD_KDATA    ((SEG_KDATA) << 3)      // kernel data
                                            // 内核数据；
#define GD_UTEXT    ((SEG_UTEXT) << 3)      // user text
                                            // 用户文本；
#define GD_UDATA    ((SEG_UDATA) << 3)      // user data
                                            // 用户数据；
#define GD_TSS        ((SEG_TSS) << 3)      // task segment selector
                                            // 任务段选择子；

#define DPL_KERNEL    (0)   // DPL_KERNEL 为用户态的特权级为 0；
#define DPL_USER      (3)   // DPL_USER   为内核态的特权级为 3；

#define KERNEL_CS    ((GD_KTEXT) | DPL_KERNEL)  // 内核段的信息；
#define KERNEL_DS    ((GD_KDATA) | DPL_KERNEL)

#define USER_CS        ((GD_UTEXT) | DPL_USER)  // 用户段的信息；
#define USER_DS        ((GD_UDATA) | DPL_USER)

#endif /* !__KERN_MM_MEMLAYOUT_H__ */

