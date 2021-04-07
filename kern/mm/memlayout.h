#ifndef __KERN_MM_MEMLAYOUT_H__
#define __KERN_MM_MEMLAYOUT_H__

/* This file contains the definitions for memory management in our OS. */

/* global segment number */
#define SEG_KTEXT    1
#define SEG_KDATA    2
#define SEG_UTEXT    3
#define SEG_UDATA    4
#define SEG_TSS        5

/* global descriptor numbers */
#define GD_KTEXT    ((SEG_KTEXT) << 3)        // kernel text
#define GD_KDATA    ((SEG_KDATA) << 3)        // kernel data
#define GD_UTEXT    ((SEG_UTEXT) << 3)        // user text
#define GD_UDATA    ((SEG_UDATA) << 3)        // user data
#define GD_TSS        ((SEG_TSS) << 3)        // task segment selector

#define DPL_KERNEL    (0)   // DPL_KERNEL 为用户态的特权级为 0；
#define DPL_USER      (3)   // DPL_USER   为内核态的特权级为 3；

#define KERNEL_CS    ((GD_KTEXT) | DPL_KERNEL)  // 内核段的信息；
#define KERNEL_DS    ((GD_KDATA) | DPL_KERNEL)

#define USER_CS        ((GD_UTEXT) | DPL_USER)  // 用户段的信息；
#define USER_DS        ((GD_UDATA) | DPL_USER)

#endif /* !__KERN_MM_MEMLAYOUT_H__ */

