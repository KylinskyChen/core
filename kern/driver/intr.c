#include <x86.h>
#include <intr.h>

/*
 * 函数功能：使能 irq 中断；
 */
void
intr_enable(void) {
    sti();
}

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
    cli();
}

