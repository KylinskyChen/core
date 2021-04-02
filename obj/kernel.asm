
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
void kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

void
kern_init(void){
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	53                   	push   %ebx
  100004:	83 ec 14             	sub    $0x14,%esp
  100007:	e8 84 02 00 00       	call   100290 <__x86.get_pc_thunk.bx>
  10000c:	81 c3 44 f9 00 00    	add    $0xf944,%ebx
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100012:	c7 c0 20 0e 11 00    	mov    $0x110e20,%eax
  100018:	89 c2                	mov    %eax,%edx
  10001a:	c7 c0 50 f9 10 00    	mov    $0x10f950,%eax
  100020:	29 c2                	sub    %eax,%edx
  100022:	89 d0                	mov    %edx,%eax
  100024:	83 ec 04             	sub    $0x4,%esp
  100027:	50                   	push   %eax
  100028:	6a 00                	push   $0x0
  10002a:	c7 c0 50 f9 10 00    	mov    $0x10f950,%eax
  100030:	50                   	push   %eax
  100031:	e8 61 32 00 00       	call   103297 <memset>
  100036:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100039:	e8 2e 18 00 00       	call   10186c <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10003e:	8d 83 74 41 ff ff    	lea    -0xbe8c(%ebx),%eax
  100044:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100047:	83 ec 08             	sub    $0x8,%esp
  10004a:	ff 75 f4             	pushl  -0xc(%ebp)
  10004d:	8d 83 90 41 ff ff    	lea    -0xbe70(%ebx),%eax
  100053:	50                   	push   %eax
  100054:	e8 aa 02 00 00       	call   100303 <cprintf>
  100059:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  10005c:	e8 ca 09 00 00       	call   100a2b <print_kerninfo>

    grade_backtrace();
  100061:	e8 9d 00 00 00       	call   100103 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100066:	e8 8c 2e 00 00       	call   102ef7 <pmm_init>

    pic_init();                 // init interrupt controller
  10006b:	e8 8b 19 00 00       	call   1019fb <pic_init>
    idt_init();                 // init interrupt descriptor table
  100070:	e8 1d 1b 00 00       	call   101b92 <idt_init>

    clock_init();               // init clock interrupt
  100075:	e8 ee 0e 00 00       	call   100f68 <clock_init>
    intr_enable();              // enable irq interrupt
  10007a:	e8 c4 1a 00 00       	call   101b43 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10007f:	e8 b3 01 00 00       	call   100237 <lab1_switch_test>

    /* do nothing */
    while (1);
  100084:	eb fe                	jmp    100084 <kern_init+0x84>

00100086 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100086:	55                   	push   %ebp
  100087:	89 e5                	mov    %esp,%ebp
  100089:	53                   	push   %ebx
  10008a:	83 ec 04             	sub    $0x4,%esp
  10008d:	e8 fa 01 00 00       	call   10028c <__x86.get_pc_thunk.ax>
  100092:	05 be f8 00 00       	add    $0xf8be,%eax
    mon_backtrace(0, NULL, NULL);
  100097:	83 ec 04             	sub    $0x4,%esp
  10009a:	6a 00                	push   $0x0
  10009c:	6a 00                	push   $0x0
  10009e:	6a 00                	push   $0x0
  1000a0:	89 c3                	mov    %eax,%ebx
  1000a2:	e8 9e 0e 00 00       	call   100f45 <mon_backtrace>
  1000a7:	83 c4 10             	add    $0x10,%esp
}
  1000aa:	90                   	nop
  1000ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000ae:	c9                   	leave  
  1000af:	c3                   	ret    

001000b0 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  1000b0:	55                   	push   %ebp
  1000b1:	89 e5                	mov    %esp,%ebp
  1000b3:	53                   	push   %ebx
  1000b4:	83 ec 04             	sub    $0x4,%esp
  1000b7:	e8 d0 01 00 00       	call   10028c <__x86.get_pc_thunk.ax>
  1000bc:	05 94 f8 00 00       	add    $0xf894,%eax
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000c1:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000c7:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1000cd:	51                   	push   %ecx
  1000ce:	52                   	push   %edx
  1000cf:	53                   	push   %ebx
  1000d0:	50                   	push   %eax
  1000d1:	e8 b0 ff ff ff       	call   100086 <grade_backtrace2>
  1000d6:	83 c4 10             	add    $0x10,%esp
}
  1000d9:	90                   	nop
  1000da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000dd:	c9                   	leave  
  1000de:	c3                   	ret    

001000df <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000df:	55                   	push   %ebp
  1000e0:	89 e5                	mov    %esp,%ebp
  1000e2:	83 ec 08             	sub    $0x8,%esp
  1000e5:	e8 a2 01 00 00       	call   10028c <__x86.get_pc_thunk.ax>
  1000ea:	05 66 f8 00 00       	add    $0xf866,%eax
    grade_backtrace1(arg0, arg2);
  1000ef:	83 ec 08             	sub    $0x8,%esp
  1000f2:	ff 75 10             	pushl  0x10(%ebp)
  1000f5:	ff 75 08             	pushl  0x8(%ebp)
  1000f8:	e8 b3 ff ff ff       	call   1000b0 <grade_backtrace1>
  1000fd:	83 c4 10             	add    $0x10,%esp
}
  100100:	90                   	nop
  100101:	c9                   	leave  
  100102:	c3                   	ret    

00100103 <grade_backtrace>:

void
grade_backtrace(void) {
  100103:	55                   	push   %ebp
  100104:	89 e5                	mov    %esp,%ebp
  100106:	83 ec 08             	sub    $0x8,%esp
  100109:	e8 7e 01 00 00       	call   10028c <__x86.get_pc_thunk.ax>
  10010e:	05 42 f8 00 00       	add    $0xf842,%eax
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  100113:	8d 80 b0 06 ff ff    	lea    -0xf950(%eax),%eax
  100119:	83 ec 04             	sub    $0x4,%esp
  10011c:	68 00 00 ff ff       	push   $0xffff0000
  100121:	50                   	push   %eax
  100122:	6a 00                	push   $0x0
  100124:	e8 b6 ff ff ff       	call   1000df <grade_backtrace0>
  100129:	83 c4 10             	add    $0x10,%esp
}
  10012c:	90                   	nop
  10012d:	c9                   	leave  
  10012e:	c3                   	ret    

0010012f <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  10012f:	55                   	push   %ebp
  100130:	89 e5                	mov    %esp,%ebp
  100132:	53                   	push   %ebx
  100133:	83 ec 14             	sub    $0x14,%esp
  100136:	e8 55 01 00 00       	call   100290 <__x86.get_pc_thunk.bx>
  10013b:	81 c3 15 f8 00 00    	add    $0xf815,%ebx
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100141:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100144:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100147:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10014a:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  10014d:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100151:	0f b7 c0             	movzwl %ax,%eax
  100154:	83 e0 03             	and    $0x3,%eax
  100157:	89 c2                	mov    %eax,%edx
  100159:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  10015f:	83 ec 04             	sub    $0x4,%esp
  100162:	52                   	push   %edx
  100163:	50                   	push   %eax
  100164:	8d 83 95 41 ff ff    	lea    -0xbe6b(%ebx),%eax
  10016a:	50                   	push   %eax
  10016b:	e8 93 01 00 00       	call   100303 <cprintf>
  100170:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  100173:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100177:	0f b7 d0             	movzwl %ax,%edx
  10017a:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100180:	83 ec 04             	sub    $0x4,%esp
  100183:	52                   	push   %edx
  100184:	50                   	push   %eax
  100185:	8d 83 a3 41 ff ff    	lea    -0xbe5d(%ebx),%eax
  10018b:	50                   	push   %eax
  10018c:	e8 72 01 00 00       	call   100303 <cprintf>
  100191:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  100194:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100198:	0f b7 d0             	movzwl %ax,%edx
  10019b:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001a1:	83 ec 04             	sub    $0x4,%esp
  1001a4:	52                   	push   %edx
  1001a5:	50                   	push   %eax
  1001a6:	8d 83 b1 41 ff ff    	lea    -0xbe4f(%ebx),%eax
  1001ac:	50                   	push   %eax
  1001ad:	e8 51 01 00 00       	call   100303 <cprintf>
  1001b2:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  1001b5:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1001b9:	0f b7 d0             	movzwl %ax,%edx
  1001bc:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001c2:	83 ec 04             	sub    $0x4,%esp
  1001c5:	52                   	push   %edx
  1001c6:	50                   	push   %eax
  1001c7:	8d 83 bf 41 ff ff    	lea    -0xbe41(%ebx),%eax
  1001cd:	50                   	push   %eax
  1001ce:	e8 30 01 00 00       	call   100303 <cprintf>
  1001d3:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  1001d6:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001da:	0f b7 d0             	movzwl %ax,%edx
  1001dd:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001e3:	83 ec 04             	sub    $0x4,%esp
  1001e6:	52                   	push   %edx
  1001e7:	50                   	push   %eax
  1001e8:	8d 83 cd 41 ff ff    	lea    -0xbe33(%ebx),%eax
  1001ee:	50                   	push   %eax
  1001ef:	e8 0f 01 00 00       	call   100303 <cprintf>
  1001f4:	83 c4 10             	add    $0x10,%esp
    round ++;
  1001f7:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001fd:	83 c0 01             	add    $0x1,%eax
  100200:	89 83 70 01 00 00    	mov    %eax,0x170(%ebx)
}
  100206:	90                   	nop
  100207:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10020a:	c9                   	leave  
  10020b:	c3                   	ret    

0010020c <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  10020c:	55                   	push   %ebp
  10020d:	89 e5                	mov    %esp,%ebp
  10020f:	e8 78 00 00 00       	call   10028c <__x86.get_pc_thunk.ax>
  100214:	05 3c f7 00 00       	add    $0xf73c,%eax
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
  100219:	83 ec 08             	sub    $0x8,%esp
  10021c:	cd 78                	int    $0x78
  10021e:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
}
  100220:	90                   	nop
  100221:	5d                   	pop    %ebp
  100222:	c3                   	ret    

00100223 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  100223:	55                   	push   %ebp
  100224:	89 e5                	mov    %esp,%ebp
  100226:	e8 61 00 00 00       	call   10028c <__x86.get_pc_thunk.ax>
  10022b:	05 25 f7 00 00       	add    $0xf725,%eax
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
  100230:	cd 79                	int    $0x79
  100232:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp \n"
	    : 
	    : "i"(T_SWITCH_TOK)
	);
}
  100234:	90                   	nop
  100235:	5d                   	pop    %ebp
  100236:	c3                   	ret    

00100237 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  100237:	55                   	push   %ebp
  100238:	89 e5                	mov    %esp,%ebp
  10023a:	53                   	push   %ebx
  10023b:	83 ec 04             	sub    $0x4,%esp
  10023e:	e8 4d 00 00 00       	call   100290 <__x86.get_pc_thunk.bx>
  100243:	81 c3 0d f7 00 00    	add    $0xf70d,%ebx
    lab1_print_cur_status();
  100249:	e8 e1 fe ff ff       	call   10012f <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  10024e:	83 ec 0c             	sub    $0xc,%esp
  100251:	8d 83 dc 41 ff ff    	lea    -0xbe24(%ebx),%eax
  100257:	50                   	push   %eax
  100258:	e8 a6 00 00 00       	call   100303 <cprintf>
  10025d:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  100260:	e8 a7 ff ff ff       	call   10020c <lab1_switch_to_user>
    lab1_print_cur_status();
  100265:	e8 c5 fe ff ff       	call   10012f <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10026a:	83 ec 0c             	sub    $0xc,%esp
  10026d:	8d 83 fc 41 ff ff    	lea    -0xbe04(%ebx),%eax
  100273:	50                   	push   %eax
  100274:	e8 8a 00 00 00       	call   100303 <cprintf>
  100279:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  10027c:	e8 a2 ff ff ff       	call   100223 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100281:	e8 a9 fe ff ff       	call   10012f <lab1_print_cur_status>
}
  100286:	90                   	nop
  100287:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10028a:	c9                   	leave  
  10028b:	c3                   	ret    

0010028c <__x86.get_pc_thunk.ax>:
  10028c:	8b 04 24             	mov    (%esp),%eax
  10028f:	c3                   	ret    

00100290 <__x86.get_pc_thunk.bx>:
  100290:	8b 1c 24             	mov    (%esp),%ebx
  100293:	c3                   	ret    

00100294 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100294:	55                   	push   %ebp
  100295:	89 e5                	mov    %esp,%ebp
  100297:	53                   	push   %ebx
  100298:	83 ec 04             	sub    $0x4,%esp
  10029b:	e8 ec ff ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1002a0:	05 b0 f6 00 00       	add    $0xf6b0,%eax
    cons_putc(c);
  1002a5:	83 ec 0c             	sub    $0xc,%esp
  1002a8:	ff 75 08             	pushl  0x8(%ebp)
  1002ab:	89 c3                	mov    %eax,%ebx
  1002ad:	e8 fd 15 00 00       	call   1018af <cons_putc>
  1002b2:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  1002b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002b8:	8b 00                	mov    (%eax),%eax
  1002ba:	8d 50 01             	lea    0x1(%eax),%edx
  1002bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002c0:	89 10                	mov    %edx,(%eax)
}
  1002c2:	90                   	nop
  1002c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1002c6:	c9                   	leave  
  1002c7:	c3                   	ret    

001002c8 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002c8:	55                   	push   %ebp
  1002c9:	89 e5                	mov    %esp,%ebp
  1002cb:	53                   	push   %ebx
  1002cc:	83 ec 14             	sub    $0x14,%esp
  1002cf:	e8 b8 ff ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1002d4:	05 7c f6 00 00       	add    $0xf67c,%eax
    int cnt = 0;
  1002d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002e0:	ff 75 0c             	pushl  0xc(%ebp)
  1002e3:	ff 75 08             	pushl  0x8(%ebp)
  1002e6:	8d 55 f4             	lea    -0xc(%ebp),%edx
  1002e9:	52                   	push   %edx
  1002ea:	8d 90 44 09 ff ff    	lea    -0xf6bc(%eax),%edx
  1002f0:	52                   	push   %edx
  1002f1:	89 c3                	mov    %eax,%ebx
  1002f3:	e8 2d 33 00 00       	call   103625 <vprintfmt>
  1002f8:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1002fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100301:	c9                   	leave  
  100302:	c3                   	ret    

00100303 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100303:	55                   	push   %ebp
  100304:	89 e5                	mov    %esp,%ebp
  100306:	83 ec 18             	sub    $0x18,%esp
  100309:	e8 7e ff ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  10030e:	05 42 f6 00 00       	add    $0xf642,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100313:	8d 45 0c             	lea    0xc(%ebp),%eax
  100316:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100319:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10031c:	83 ec 08             	sub    $0x8,%esp
  10031f:	50                   	push   %eax
  100320:	ff 75 08             	pushl  0x8(%ebp)
  100323:	e8 a0 ff ff ff       	call   1002c8 <vcprintf>
  100328:	83 c4 10             	add    $0x10,%esp
  10032b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100331:	c9                   	leave  
  100332:	c3                   	ret    

00100333 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100333:	55                   	push   %ebp
  100334:	89 e5                	mov    %esp,%ebp
  100336:	53                   	push   %ebx
  100337:	83 ec 04             	sub    $0x4,%esp
  10033a:	e8 4d ff ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  10033f:	05 11 f6 00 00       	add    $0xf611,%eax
    cons_putc(c);
  100344:	83 ec 0c             	sub    $0xc,%esp
  100347:	ff 75 08             	pushl  0x8(%ebp)
  10034a:	89 c3                	mov    %eax,%ebx
  10034c:	e8 5e 15 00 00       	call   1018af <cons_putc>
  100351:	83 c4 10             	add    $0x10,%esp
}
  100354:	90                   	nop
  100355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100358:	c9                   	leave  
  100359:	c3                   	ret    

0010035a <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10035a:	55                   	push   %ebp
  10035b:	89 e5                	mov    %esp,%ebp
  10035d:	83 ec 18             	sub    $0x18,%esp
  100360:	e8 27 ff ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  100365:	05 eb f5 00 00       	add    $0xf5eb,%eax
    int cnt = 0;
  10036a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100371:	eb 14                	jmp    100387 <cputs+0x2d>
        cputch(c, &cnt);
  100373:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  100377:	83 ec 08             	sub    $0x8,%esp
  10037a:	8d 55 f0             	lea    -0x10(%ebp),%edx
  10037d:	52                   	push   %edx
  10037e:	50                   	push   %eax
  10037f:	e8 10 ff ff ff       	call   100294 <cputch>
  100384:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  100387:	8b 45 08             	mov    0x8(%ebp),%eax
  10038a:	8d 50 01             	lea    0x1(%eax),%edx
  10038d:	89 55 08             	mov    %edx,0x8(%ebp)
  100390:	0f b6 00             	movzbl (%eax),%eax
  100393:	88 45 f7             	mov    %al,-0x9(%ebp)
  100396:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  10039a:	75 d7                	jne    100373 <cputs+0x19>
    }
    cputch('\n', &cnt);
  10039c:	83 ec 08             	sub    $0x8,%esp
  10039f:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1003a2:	50                   	push   %eax
  1003a3:	6a 0a                	push   $0xa
  1003a5:	e8 ea fe ff ff       	call   100294 <cputch>
  1003aa:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1003ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003b0:	c9                   	leave  
  1003b1:	c3                   	ret    

001003b2 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003b2:	55                   	push   %ebp
  1003b3:	89 e5                	mov    %esp,%ebp
  1003b5:	53                   	push   %ebx
  1003b6:	83 ec 14             	sub    $0x14,%esp
  1003b9:	e8 d2 fe ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  1003be:	81 c3 92 f5 00 00    	add    $0xf592,%ebx
    int c;
    while ((c = cons_getc()) == 0)
  1003c4:	e8 20 15 00 00       	call   1018e9 <cons_getc>
  1003c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003d0:	74 f2                	je     1003c4 <getchar+0x12>
        /* do nothing */;
    return c;
  1003d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003d5:	83 c4 14             	add    $0x14,%esp
  1003d8:	5b                   	pop    %ebx
  1003d9:	5d                   	pop    %ebp
  1003da:	c3                   	ret    

001003db <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  1003db:	55                   	push   %ebp
  1003dc:	89 e5                	mov    %esp,%ebp
  1003de:	53                   	push   %ebx
  1003df:	83 ec 14             	sub    $0x14,%esp
  1003e2:	e8 a9 fe ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  1003e7:	81 c3 69 f5 00 00    	add    $0xf569,%ebx
    if (prompt != NULL) {
  1003ed:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1003f1:	74 15                	je     100408 <readline+0x2d>
        cprintf("%s", prompt);
  1003f3:	83 ec 08             	sub    $0x8,%esp
  1003f6:	ff 75 08             	pushl  0x8(%ebp)
  1003f9:	8d 83 1b 42 ff ff    	lea    -0xbde5(%ebx),%eax
  1003ff:	50                   	push   %eax
  100400:	e8 fe fe ff ff       	call   100303 <cprintf>
  100405:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  100408:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10040f:	e8 9e ff ff ff       	call   1003b2 <getchar>
  100414:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100417:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10041b:	79 0a                	jns    100427 <readline+0x4c>
            return NULL;
  10041d:	b8 00 00 00 00       	mov    $0x0,%eax
  100422:	e9 87 00 00 00       	jmp    1004ae <readline+0xd3>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100427:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10042b:	7e 2c                	jle    100459 <readline+0x7e>
  10042d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100434:	7f 23                	jg     100459 <readline+0x7e>
            cputchar(c);
  100436:	83 ec 0c             	sub    $0xc,%esp
  100439:	ff 75 f0             	pushl  -0x10(%ebp)
  10043c:	e8 f2 fe ff ff       	call   100333 <cputchar>
  100441:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  100444:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100447:	8d 50 01             	lea    0x1(%eax),%edx
  10044a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10044d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100450:	88 94 03 90 01 00 00 	mov    %dl,0x190(%ebx,%eax,1)
  100457:	eb 50                	jmp    1004a9 <readline+0xce>
        }
        else if (c == '\b' && i > 0) {
  100459:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10045d:	75 1a                	jne    100479 <readline+0x9e>
  10045f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100463:	7e 14                	jle    100479 <readline+0x9e>
            cputchar(c);
  100465:	83 ec 0c             	sub    $0xc,%esp
  100468:	ff 75 f0             	pushl  -0x10(%ebp)
  10046b:	e8 c3 fe ff ff       	call   100333 <cputchar>
  100470:	83 c4 10             	add    $0x10,%esp
            i --;
  100473:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  100477:	eb 30                	jmp    1004a9 <readline+0xce>
        }
        else if (c == '\n' || c == '\r') {
  100479:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  10047d:	74 06                	je     100485 <readline+0xaa>
  10047f:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  100483:	75 8a                	jne    10040f <readline+0x34>
            cputchar(c);
  100485:	83 ec 0c             	sub    $0xc,%esp
  100488:	ff 75 f0             	pushl  -0x10(%ebp)
  10048b:	e8 a3 fe ff ff       	call   100333 <cputchar>
  100490:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  100493:	8d 93 90 01 00 00    	lea    0x190(%ebx),%edx
  100499:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10049c:	01 d0                	add    %edx,%eax
  10049e:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1004a1:	8d 83 90 01 00 00    	lea    0x190(%ebx),%eax
  1004a7:	eb 05                	jmp    1004ae <readline+0xd3>
        c = getchar();
  1004a9:	e9 61 ff ff ff       	jmp    10040f <readline+0x34>
        }
    }
}
  1004ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1004b1:	c9                   	leave  
  1004b2:	c3                   	ret    

001004b3 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1004b3:	55                   	push   %ebp
  1004b4:	89 e5                	mov    %esp,%ebp
  1004b6:	53                   	push   %ebx
  1004b7:	83 ec 14             	sub    $0x14,%esp
  1004ba:	e8 d1 fd ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  1004bf:	81 c3 91 f4 00 00    	add    $0xf491,%ebx
    if (is_panic) {
  1004c5:	8b 83 90 05 00 00    	mov    0x590(%ebx),%eax
  1004cb:	85 c0                	test   %eax,%eax
  1004cd:	75 4e                	jne    10051d <__panic+0x6a>
        goto panic_dead;
    }
    is_panic = 1;
  1004cf:	c7 83 90 05 00 00 01 	movl   $0x1,0x590(%ebx)
  1004d6:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1004d9:	8d 45 14             	lea    0x14(%ebp),%eax
  1004dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1004df:	83 ec 04             	sub    $0x4,%esp
  1004e2:	ff 75 0c             	pushl  0xc(%ebp)
  1004e5:	ff 75 08             	pushl  0x8(%ebp)
  1004e8:	8d 83 1e 42 ff ff    	lea    -0xbde2(%ebx),%eax
  1004ee:	50                   	push   %eax
  1004ef:	e8 0f fe ff ff       	call   100303 <cprintf>
  1004f4:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  1004f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004fa:	83 ec 08             	sub    $0x8,%esp
  1004fd:	50                   	push   %eax
  1004fe:	ff 75 10             	pushl  0x10(%ebp)
  100501:	e8 c2 fd ff ff       	call   1002c8 <vcprintf>
  100506:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  100509:	83 ec 0c             	sub    $0xc,%esp
  10050c:	8d 83 3a 42 ff ff    	lea    -0xbdc6(%ebx),%eax
  100512:	50                   	push   %eax
  100513:	e8 eb fd ff ff       	call   100303 <cprintf>
  100518:	83 c4 10             	add    $0x10,%esp
  10051b:	eb 01                	jmp    10051e <__panic+0x6b>
        goto panic_dead;
  10051d:	90                   	nop
    va_end(ap);

panic_dead:
    intr_disable();
  10051e:	e8 31 16 00 00       	call   101b54 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100523:	83 ec 0c             	sub    $0xc,%esp
  100526:	6a 00                	push   $0x0
  100528:	e8 fe 08 00 00       	call   100e2b <kmonitor>
  10052d:	83 c4 10             	add    $0x10,%esp
  100530:	eb f1                	jmp    100523 <__panic+0x70>

00100532 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100532:	55                   	push   %ebp
  100533:	89 e5                	mov    %esp,%ebp
  100535:	53                   	push   %ebx
  100536:	83 ec 14             	sub    $0x14,%esp
  100539:	e8 52 fd ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  10053e:	81 c3 12 f4 00 00    	add    $0xf412,%ebx
    va_list ap;
    va_start(ap, fmt);
  100544:	8d 45 14             	lea    0x14(%ebp),%eax
  100547:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10054a:	83 ec 04             	sub    $0x4,%esp
  10054d:	ff 75 0c             	pushl  0xc(%ebp)
  100550:	ff 75 08             	pushl  0x8(%ebp)
  100553:	8d 83 3c 42 ff ff    	lea    -0xbdc4(%ebx),%eax
  100559:	50                   	push   %eax
  10055a:	e8 a4 fd ff ff       	call   100303 <cprintf>
  10055f:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100562:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100565:	83 ec 08             	sub    $0x8,%esp
  100568:	50                   	push   %eax
  100569:	ff 75 10             	pushl  0x10(%ebp)
  10056c:	e8 57 fd ff ff       	call   1002c8 <vcprintf>
  100571:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  100574:	83 ec 0c             	sub    $0xc,%esp
  100577:	8d 83 3a 42 ff ff    	lea    -0xbdc6(%ebx),%eax
  10057d:	50                   	push   %eax
  10057e:	e8 80 fd ff ff       	call   100303 <cprintf>
  100583:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  100586:	90                   	nop
  100587:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10058a:	c9                   	leave  
  10058b:	c3                   	ret    

0010058c <is_kernel_panic>:

bool
is_kernel_panic(void) {
  10058c:	55                   	push   %ebp
  10058d:	89 e5                	mov    %esp,%ebp
  10058f:	e8 f8 fc ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  100594:	05 bc f3 00 00       	add    $0xf3bc,%eax
    return is_panic;
  100599:	8b 80 90 05 00 00    	mov    0x590(%eax),%eax
}
  10059f:	5d                   	pop    %ebp
  1005a0:	c3                   	ret    

001005a1 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1005a1:	55                   	push   %ebp
  1005a2:	89 e5                	mov    %esp,%ebp
  1005a4:	83 ec 20             	sub    $0x20,%esp
  1005a7:	e8 e0 fc ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1005ac:	05 a4 f3 00 00       	add    $0xf3a4,%eax
    int l = *region_left, r = *region_right, any_matches = 0;
  1005b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b4:	8b 00                	mov    (%eax),%eax
  1005b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1005b9:	8b 45 10             	mov    0x10(%ebp),%eax
  1005bc:	8b 00                	mov    (%eax),%eax
  1005be:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1005c8:	e9 d2 00 00 00       	jmp    10069f <stab_binsearch+0xfe>
        int true_m = (l + r) / 2, m = true_m;
  1005cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1005d3:	01 d0                	add    %edx,%eax
  1005d5:	89 c2                	mov    %eax,%edx
  1005d7:	c1 ea 1f             	shr    $0x1f,%edx
  1005da:	01 d0                	add    %edx,%eax
  1005dc:	d1 f8                	sar    %eax
  1005de:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1005e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1005e4:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1005e7:	eb 04                	jmp    1005ed <stab_binsearch+0x4c>
            m --;
  1005e9:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1005ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005f0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1005f3:	7c 1f                	jl     100614 <stab_binsearch+0x73>
  1005f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005f8:	89 d0                	mov    %edx,%eax
  1005fa:	01 c0                	add    %eax,%eax
  1005fc:	01 d0                	add    %edx,%eax
  1005fe:	c1 e0 02             	shl    $0x2,%eax
  100601:	89 c2                	mov    %eax,%edx
  100603:	8b 45 08             	mov    0x8(%ebp),%eax
  100606:	01 d0                	add    %edx,%eax
  100608:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10060c:	0f b6 c0             	movzbl %al,%eax
  10060f:	39 45 14             	cmp    %eax,0x14(%ebp)
  100612:	75 d5                	jne    1005e9 <stab_binsearch+0x48>
        }
        if (m < l) {    // no match in [l, m]
  100614:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100617:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10061a:	7d 0b                	jge    100627 <stab_binsearch+0x86>
            l = true_m + 1;
  10061c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10061f:	83 c0 01             	add    $0x1,%eax
  100622:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100625:	eb 78                	jmp    10069f <stab_binsearch+0xfe>
        }

        // actual binary search
        any_matches = 1;
  100627:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10062e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100631:	89 d0                	mov    %edx,%eax
  100633:	01 c0                	add    %eax,%eax
  100635:	01 d0                	add    %edx,%eax
  100637:	c1 e0 02             	shl    $0x2,%eax
  10063a:	89 c2                	mov    %eax,%edx
  10063c:	8b 45 08             	mov    0x8(%ebp),%eax
  10063f:	01 d0                	add    %edx,%eax
  100641:	8b 40 08             	mov    0x8(%eax),%eax
  100644:	39 45 18             	cmp    %eax,0x18(%ebp)
  100647:	76 13                	jbe    10065c <stab_binsearch+0xbb>
            *region_left = m;
  100649:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10064f:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100651:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100654:	83 c0 01             	add    $0x1,%eax
  100657:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10065a:	eb 43                	jmp    10069f <stab_binsearch+0xfe>
        } else if (stabs[m].n_value > addr) {
  10065c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10065f:	89 d0                	mov    %edx,%eax
  100661:	01 c0                	add    %eax,%eax
  100663:	01 d0                	add    %edx,%eax
  100665:	c1 e0 02             	shl    $0x2,%eax
  100668:	89 c2                	mov    %eax,%edx
  10066a:	8b 45 08             	mov    0x8(%ebp),%eax
  10066d:	01 d0                	add    %edx,%eax
  10066f:	8b 40 08             	mov    0x8(%eax),%eax
  100672:	39 45 18             	cmp    %eax,0x18(%ebp)
  100675:	73 16                	jae    10068d <stab_binsearch+0xec>
            *region_right = m - 1;
  100677:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10067a:	8d 50 ff             	lea    -0x1(%eax),%edx
  10067d:	8b 45 10             	mov    0x10(%ebp),%eax
  100680:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  100682:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100685:	83 e8 01             	sub    $0x1,%eax
  100688:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10068b:	eb 12                	jmp    10069f <stab_binsearch+0xfe>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  10068d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100690:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100693:	89 10                	mov    %edx,(%eax)
            l = m;
  100695:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100698:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  10069b:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  10069f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1006a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1006a5:	0f 8e 22 ff ff ff    	jle    1005cd <stab_binsearch+0x2c>
        }
    }

    if (!any_matches) {
  1006ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1006af:	75 0f                	jne    1006c0 <stab_binsearch+0x11f>
        *region_right = *region_left - 1;
  1006b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006b4:	8b 00                	mov    (%eax),%eax
  1006b6:	8d 50 ff             	lea    -0x1(%eax),%edx
  1006b9:	8b 45 10             	mov    0x10(%ebp),%eax
  1006bc:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1006be:	eb 3f                	jmp    1006ff <stab_binsearch+0x15e>
        l = *region_right;
  1006c0:	8b 45 10             	mov    0x10(%ebp),%eax
  1006c3:	8b 00                	mov    (%eax),%eax
  1006c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1006c8:	eb 04                	jmp    1006ce <stab_binsearch+0x12d>
  1006ca:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1006ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d1:	8b 00                	mov    (%eax),%eax
  1006d3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1006d6:	7e 1f                	jle    1006f7 <stab_binsearch+0x156>
  1006d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1006db:	89 d0                	mov    %edx,%eax
  1006dd:	01 c0                	add    %eax,%eax
  1006df:	01 d0                	add    %edx,%eax
  1006e1:	c1 e0 02             	shl    $0x2,%eax
  1006e4:	89 c2                	mov    %eax,%edx
  1006e6:	8b 45 08             	mov    0x8(%ebp),%eax
  1006e9:	01 d0                	add    %edx,%eax
  1006eb:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1006ef:	0f b6 c0             	movzbl %al,%eax
  1006f2:	39 45 14             	cmp    %eax,0x14(%ebp)
  1006f5:	75 d3                	jne    1006ca <stab_binsearch+0x129>
        *region_left = l;
  1006f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1006fd:	89 10                	mov    %edx,(%eax)
}
  1006ff:	90                   	nop
  100700:	c9                   	leave  
  100701:	c3                   	ret    

00100702 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100702:	55                   	push   %ebp
  100703:	89 e5                	mov    %esp,%ebp
  100705:	53                   	push   %ebx
  100706:	83 ec 34             	sub    $0x34,%esp
  100709:	e8 82 fb ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  10070e:	81 c3 42 f2 00 00    	add    $0xf242,%ebx
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100714:	8b 45 0c             	mov    0xc(%ebp),%eax
  100717:	8d 93 5c 42 ff ff    	lea    -0xbda4(%ebx),%edx
  10071d:	89 10                	mov    %edx,(%eax)
    info->eip_line = 0;
  10071f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100722:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100729:	8b 45 0c             	mov    0xc(%ebp),%eax
  10072c:	8d 93 5c 42 ff ff    	lea    -0xbda4(%ebx),%edx
  100732:	89 50 08             	mov    %edx,0x8(%eax)
    info->eip_fn_namelen = 9;
  100735:	8b 45 0c             	mov    0xc(%ebp),%eax
  100738:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  10073f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100742:	8b 55 08             	mov    0x8(%ebp),%edx
  100745:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100748:	8b 45 0c             	mov    0xc(%ebp),%eax
  10074b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100752:	c7 c0 30 43 10 00    	mov    $0x104330,%eax
  100758:	89 45 f4             	mov    %eax,-0xc(%ebp)
    stab_end = __STAB_END__;
  10075b:	c7 c0 d0 c0 10 00    	mov    $0x10c0d0,%eax
  100761:	89 45 f0             	mov    %eax,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100764:	c7 c0 d1 c0 10 00    	mov    $0x10c0d1,%eax
  10076a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10076d:	c7 c0 c4 e1 10 00    	mov    $0x10e1c4,%eax
  100773:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100776:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100779:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10077c:	76 0d                	jbe    10078b <debuginfo_eip+0x89>
  10077e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100781:	83 e8 01             	sub    $0x1,%eax
  100784:	0f b6 00             	movzbl (%eax),%eax
  100787:	84 c0                	test   %al,%al
  100789:	74 0a                	je     100795 <debuginfo_eip+0x93>
        return -1;
  10078b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100790:	e9 91 02 00 00       	jmp    100a26 <debuginfo_eip+0x324>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100795:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10079c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10079f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a2:	29 c2                	sub    %eax,%edx
  1007a4:	89 d0                	mov    %edx,%eax
  1007a6:	c1 f8 02             	sar    $0x2,%eax
  1007a9:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1007af:	83 e8 01             	sub    $0x1,%eax
  1007b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1007b5:	ff 75 08             	pushl  0x8(%ebp)
  1007b8:	6a 64                	push   $0x64
  1007ba:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1007bd:	50                   	push   %eax
  1007be:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1007c1:	50                   	push   %eax
  1007c2:	ff 75 f4             	pushl  -0xc(%ebp)
  1007c5:	e8 d7 fd ff ff       	call   1005a1 <stab_binsearch>
  1007ca:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  1007cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007d0:	85 c0                	test   %eax,%eax
  1007d2:	75 0a                	jne    1007de <debuginfo_eip+0xdc>
        return -1;
  1007d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007d9:	e9 48 02 00 00       	jmp    100a26 <debuginfo_eip+0x324>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1007de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007e1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1007e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007e7:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1007ea:	ff 75 08             	pushl  0x8(%ebp)
  1007ed:	6a 24                	push   $0x24
  1007ef:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1007f2:	50                   	push   %eax
  1007f3:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1007f6:	50                   	push   %eax
  1007f7:	ff 75 f4             	pushl  -0xc(%ebp)
  1007fa:	e8 a2 fd ff ff       	call   1005a1 <stab_binsearch>
  1007ff:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  100802:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100805:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100808:	39 c2                	cmp    %eax,%edx
  10080a:	7f 7c                	jg     100888 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10080c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10080f:	89 c2                	mov    %eax,%edx
  100811:	89 d0                	mov    %edx,%eax
  100813:	01 c0                	add    %eax,%eax
  100815:	01 d0                	add    %edx,%eax
  100817:	c1 e0 02             	shl    $0x2,%eax
  10081a:	89 c2                	mov    %eax,%edx
  10081c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10081f:	01 d0                	add    %edx,%eax
  100821:	8b 00                	mov    (%eax),%eax
  100823:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100826:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100829:	29 d1                	sub    %edx,%ecx
  10082b:	89 ca                	mov    %ecx,%edx
  10082d:	39 d0                	cmp    %edx,%eax
  10082f:	73 22                	jae    100853 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100831:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100834:	89 c2                	mov    %eax,%edx
  100836:	89 d0                	mov    %edx,%eax
  100838:	01 c0                	add    %eax,%eax
  10083a:	01 d0                	add    %edx,%eax
  10083c:	c1 e0 02             	shl    $0x2,%eax
  10083f:	89 c2                	mov    %eax,%edx
  100841:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100844:	01 d0                	add    %edx,%eax
  100846:	8b 10                	mov    (%eax),%edx
  100848:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10084b:	01 c2                	add    %eax,%edx
  10084d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100850:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100853:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100856:	89 c2                	mov    %eax,%edx
  100858:	89 d0                	mov    %edx,%eax
  10085a:	01 c0                	add    %eax,%eax
  10085c:	01 d0                	add    %edx,%eax
  10085e:	c1 e0 02             	shl    $0x2,%eax
  100861:	89 c2                	mov    %eax,%edx
  100863:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100866:	01 d0                	add    %edx,%eax
  100868:	8b 50 08             	mov    0x8(%eax),%edx
  10086b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10086e:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100871:	8b 45 0c             	mov    0xc(%ebp),%eax
  100874:	8b 40 10             	mov    0x10(%eax),%eax
  100877:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10087a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10087d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100880:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100883:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100886:	eb 15                	jmp    10089d <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  100888:	8b 45 0c             	mov    0xc(%ebp),%eax
  10088b:	8b 55 08             	mov    0x8(%ebp),%edx
  10088e:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100891:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100894:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  100897:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10089a:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  10089d:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008a0:	8b 40 08             	mov    0x8(%eax),%eax
  1008a3:	83 ec 08             	sub    $0x8,%esp
  1008a6:	6a 3a                	push   $0x3a
  1008a8:	50                   	push   %eax
  1008a9:	e8 49 28 00 00       	call   1030f7 <strfind>
  1008ae:	83 c4 10             	add    $0x10,%esp
  1008b1:	89 c2                	mov    %eax,%edx
  1008b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008b6:	8b 40 08             	mov    0x8(%eax),%eax
  1008b9:	29 c2                	sub    %eax,%edx
  1008bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008be:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1008c1:	83 ec 0c             	sub    $0xc,%esp
  1008c4:	ff 75 08             	pushl  0x8(%ebp)
  1008c7:	6a 44                	push   $0x44
  1008c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1008cc:	50                   	push   %eax
  1008cd:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1008d0:	50                   	push   %eax
  1008d1:	ff 75 f4             	pushl  -0xc(%ebp)
  1008d4:	e8 c8 fc ff ff       	call   1005a1 <stab_binsearch>
  1008d9:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  1008dc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008df:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008e2:	39 c2                	cmp    %eax,%edx
  1008e4:	7f 24                	jg     10090a <debuginfo_eip+0x208>
        info->eip_line = stabs[rline].n_desc;
  1008e6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008e9:	89 c2                	mov    %eax,%edx
  1008eb:	89 d0                	mov    %edx,%eax
  1008ed:	01 c0                	add    %eax,%eax
  1008ef:	01 d0                	add    %edx,%eax
  1008f1:	c1 e0 02             	shl    $0x2,%eax
  1008f4:	89 c2                	mov    %eax,%edx
  1008f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008f9:	01 d0                	add    %edx,%eax
  1008fb:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  1008ff:	0f b7 d0             	movzwl %ax,%edx
  100902:	8b 45 0c             	mov    0xc(%ebp),%eax
  100905:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100908:	eb 13                	jmp    10091d <debuginfo_eip+0x21b>
        return -1;
  10090a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10090f:	e9 12 01 00 00       	jmp    100a26 <debuginfo_eip+0x324>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100914:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100917:	83 e8 01             	sub    $0x1,%eax
  10091a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10091d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100920:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100923:	39 c2                	cmp    %eax,%edx
  100925:	7c 56                	jl     10097d <debuginfo_eip+0x27b>
           && stabs[lline].n_type != N_SOL
  100927:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10092a:	89 c2                	mov    %eax,%edx
  10092c:	89 d0                	mov    %edx,%eax
  10092e:	01 c0                	add    %eax,%eax
  100930:	01 d0                	add    %edx,%eax
  100932:	c1 e0 02             	shl    $0x2,%eax
  100935:	89 c2                	mov    %eax,%edx
  100937:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10093a:	01 d0                	add    %edx,%eax
  10093c:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100940:	3c 84                	cmp    $0x84,%al
  100942:	74 39                	je     10097d <debuginfo_eip+0x27b>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100944:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100947:	89 c2                	mov    %eax,%edx
  100949:	89 d0                	mov    %edx,%eax
  10094b:	01 c0                	add    %eax,%eax
  10094d:	01 d0                	add    %edx,%eax
  10094f:	c1 e0 02             	shl    $0x2,%eax
  100952:	89 c2                	mov    %eax,%edx
  100954:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100957:	01 d0                	add    %edx,%eax
  100959:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10095d:	3c 64                	cmp    $0x64,%al
  10095f:	75 b3                	jne    100914 <debuginfo_eip+0x212>
  100961:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100964:	89 c2                	mov    %eax,%edx
  100966:	89 d0                	mov    %edx,%eax
  100968:	01 c0                	add    %eax,%eax
  10096a:	01 d0                	add    %edx,%eax
  10096c:	c1 e0 02             	shl    $0x2,%eax
  10096f:	89 c2                	mov    %eax,%edx
  100971:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100974:	01 d0                	add    %edx,%eax
  100976:	8b 40 08             	mov    0x8(%eax),%eax
  100979:	85 c0                	test   %eax,%eax
  10097b:	74 97                	je     100914 <debuginfo_eip+0x212>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10097d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100980:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100983:	39 c2                	cmp    %eax,%edx
  100985:	7c 46                	jl     1009cd <debuginfo_eip+0x2cb>
  100987:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10098a:	89 c2                	mov    %eax,%edx
  10098c:	89 d0                	mov    %edx,%eax
  10098e:	01 c0                	add    %eax,%eax
  100990:	01 d0                	add    %edx,%eax
  100992:	c1 e0 02             	shl    $0x2,%eax
  100995:	89 c2                	mov    %eax,%edx
  100997:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10099a:	01 d0                	add    %edx,%eax
  10099c:	8b 00                	mov    (%eax),%eax
  10099e:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1009a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1009a4:	29 d1                	sub    %edx,%ecx
  1009a6:	89 ca                	mov    %ecx,%edx
  1009a8:	39 d0                	cmp    %edx,%eax
  1009aa:	73 21                	jae    1009cd <debuginfo_eip+0x2cb>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1009ac:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009af:	89 c2                	mov    %eax,%edx
  1009b1:	89 d0                	mov    %edx,%eax
  1009b3:	01 c0                	add    %eax,%eax
  1009b5:	01 d0                	add    %edx,%eax
  1009b7:	c1 e0 02             	shl    $0x2,%eax
  1009ba:	89 c2                	mov    %eax,%edx
  1009bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009bf:	01 d0                	add    %edx,%eax
  1009c1:	8b 10                	mov    (%eax),%edx
  1009c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1009c6:	01 c2                	add    %eax,%edx
  1009c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009cb:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1009cd:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1009d0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1009d3:	39 c2                	cmp    %eax,%edx
  1009d5:	7d 4a                	jge    100a21 <debuginfo_eip+0x31f>
        for (lline = lfun + 1;
  1009d7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1009da:	83 c0 01             	add    $0x1,%eax
  1009dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1009e0:	eb 18                	jmp    1009fa <debuginfo_eip+0x2f8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1009e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009e5:	8b 40 14             	mov    0x14(%eax),%eax
  1009e8:	8d 50 01             	lea    0x1(%eax),%edx
  1009eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009ee:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1009f1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009f4:	83 c0 01             	add    $0x1,%eax
  1009f7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1009fa:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1009fd:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100a00:	39 c2                	cmp    %eax,%edx
  100a02:	7d 1d                	jge    100a21 <debuginfo_eip+0x31f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100a04:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100a07:	89 c2                	mov    %eax,%edx
  100a09:	89 d0                	mov    %edx,%eax
  100a0b:	01 c0                	add    %eax,%eax
  100a0d:	01 d0                	add    %edx,%eax
  100a0f:	c1 e0 02             	shl    $0x2,%eax
  100a12:	89 c2                	mov    %eax,%edx
  100a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a17:	01 d0                	add    %edx,%eax
  100a19:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100a1d:	3c a0                	cmp    $0xa0,%al
  100a1f:	74 c1                	je     1009e2 <debuginfo_eip+0x2e0>
        }
    }
    return 0;
  100a21:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100a26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100a29:	c9                   	leave  
  100a2a:	c3                   	ret    

00100a2b <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100a2b:	55                   	push   %ebp
  100a2c:	89 e5                	mov    %esp,%ebp
  100a2e:	53                   	push   %ebx
  100a2f:	83 ec 04             	sub    $0x4,%esp
  100a32:	e8 59 f8 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100a37:	81 c3 19 ef 00 00    	add    $0xef19,%ebx
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100a3d:	83 ec 0c             	sub    $0xc,%esp
  100a40:	8d 83 66 42 ff ff    	lea    -0xbd9a(%ebx),%eax
  100a46:	50                   	push   %eax
  100a47:	e8 b7 f8 ff ff       	call   100303 <cprintf>
  100a4c:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100a4f:	83 ec 08             	sub    $0x8,%esp
  100a52:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100a58:	50                   	push   %eax
  100a59:	8d 83 7f 42 ff ff    	lea    -0xbd81(%ebx),%eax
  100a5f:	50                   	push   %eax
  100a60:	e8 9e f8 ff ff       	call   100303 <cprintf>
  100a65:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100a68:	83 ec 08             	sub    $0x8,%esp
  100a6b:	c7 c0 c3 3a 10 00    	mov    $0x103ac3,%eax
  100a71:	50                   	push   %eax
  100a72:	8d 83 97 42 ff ff    	lea    -0xbd69(%ebx),%eax
  100a78:	50                   	push   %eax
  100a79:	e8 85 f8 ff ff       	call   100303 <cprintf>
  100a7e:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  100a81:	83 ec 08             	sub    $0x8,%esp
  100a84:	c7 c0 50 f9 10 00    	mov    $0x10f950,%eax
  100a8a:	50                   	push   %eax
  100a8b:	8d 83 af 42 ff ff    	lea    -0xbd51(%ebx),%eax
  100a91:	50                   	push   %eax
  100a92:	e8 6c f8 ff ff       	call   100303 <cprintf>
  100a97:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  100a9a:	83 ec 08             	sub    $0x8,%esp
  100a9d:	c7 c0 20 0e 11 00    	mov    $0x110e20,%eax
  100aa3:	50                   	push   %eax
  100aa4:	8d 83 c7 42 ff ff    	lea    -0xbd39(%ebx),%eax
  100aaa:	50                   	push   %eax
  100aab:	e8 53 f8 ff ff       	call   100303 <cprintf>
  100ab0:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100ab3:	c7 c0 20 0e 11 00    	mov    $0x110e20,%eax
  100ab9:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100abf:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100ac5:	29 c2                	sub    %eax,%edx
  100ac7:	89 d0                	mov    %edx,%eax
  100ac9:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100acf:	85 c0                	test   %eax,%eax
  100ad1:	0f 48 c2             	cmovs  %edx,%eax
  100ad4:	c1 f8 0a             	sar    $0xa,%eax
  100ad7:	83 ec 08             	sub    $0x8,%esp
  100ada:	50                   	push   %eax
  100adb:	8d 83 e0 42 ff ff    	lea    -0xbd20(%ebx),%eax
  100ae1:	50                   	push   %eax
  100ae2:	e8 1c f8 ff ff       	call   100303 <cprintf>
  100ae7:	83 c4 10             	add    $0x10,%esp
}
  100aea:	90                   	nop
  100aeb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100aee:	c9                   	leave  
  100aef:	c3                   	ret    

00100af0 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100af0:	55                   	push   %ebp
  100af1:	89 e5                	mov    %esp,%ebp
  100af3:	53                   	push   %ebx
  100af4:	81 ec 24 01 00 00    	sub    $0x124,%esp
  100afa:	e8 91 f7 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100aff:	81 c3 51 ee 00 00    	add    $0xee51,%ebx
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100b05:	83 ec 08             	sub    $0x8,%esp
  100b08:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100b0b:	50                   	push   %eax
  100b0c:	ff 75 08             	pushl  0x8(%ebp)
  100b0f:	e8 ee fb ff ff       	call   100702 <debuginfo_eip>
  100b14:	83 c4 10             	add    $0x10,%esp
  100b17:	85 c0                	test   %eax,%eax
  100b19:	74 17                	je     100b32 <print_debuginfo+0x42>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100b1b:	83 ec 08             	sub    $0x8,%esp
  100b1e:	ff 75 08             	pushl  0x8(%ebp)
  100b21:	8d 83 0a 43 ff ff    	lea    -0xbcf6(%ebx),%eax
  100b27:	50                   	push   %eax
  100b28:	e8 d6 f7 ff ff       	call   100303 <cprintf>
  100b2d:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100b30:	eb 67                	jmp    100b99 <print_debuginfo+0xa9>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b39:	eb 1c                	jmp    100b57 <print_debuginfo+0x67>
            fnname[j] = info.eip_fn_name[j];
  100b3b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b41:	01 d0                	add    %edx,%eax
  100b43:	0f b6 00             	movzbl (%eax),%eax
  100b46:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b4f:	01 ca                	add    %ecx,%edx
  100b51:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b53:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b57:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b5a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100b5d:	7c dc                	jl     100b3b <print_debuginfo+0x4b>
        fnname[j] = '\0';
  100b5f:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b68:	01 d0                	add    %edx,%eax
  100b6a:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100b6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100b70:	8b 55 08             	mov    0x8(%ebp),%edx
  100b73:	89 d1                	mov    %edx,%ecx
  100b75:	29 c1                	sub    %eax,%ecx
  100b77:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100b7a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100b7d:	83 ec 0c             	sub    $0xc,%esp
  100b80:	51                   	push   %ecx
  100b81:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b87:	51                   	push   %ecx
  100b88:	52                   	push   %edx
  100b89:	50                   	push   %eax
  100b8a:	8d 83 26 43 ff ff    	lea    -0xbcda(%ebx),%eax
  100b90:	50                   	push   %eax
  100b91:	e8 6d f7 ff ff       	call   100303 <cprintf>
  100b96:	83 c4 20             	add    $0x20,%esp
}
  100b99:	90                   	nop
  100b9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100b9d:	c9                   	leave  
  100b9e:	c3                   	ret    

00100b9f <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100b9f:	55                   	push   %ebp
  100ba0:	89 e5                	mov    %esp,%ebp
  100ba2:	83 ec 10             	sub    $0x10,%esp
  100ba5:	e8 e2 f6 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  100baa:	05 a6 ed 00 00       	add    $0xeda6,%eax
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100baf:	8b 45 04             	mov    0x4(%ebp),%eax
  100bb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100bb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100bb8:	c9                   	leave  
  100bb9:	c3                   	ret    

00100bba <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100bba:	55                   	push   %ebp
  100bbb:	89 e5                	mov    %esp,%ebp
  100bbd:	53                   	push   %ebx
  100bbe:	83 ec 24             	sub    $0x24,%esp
  100bc1:	e8 ca f6 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100bc6:	81 c3 8a ed 00 00    	add    $0xed8a,%ebx
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100bcc:	89 e8                	mov    %ebp,%eax
  100bce:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();
  100bd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100bd7:	e8 c3 ff ff ff       	call   100b9f <read_eip>
  100bdc:	89 45 f0             	mov    %eax,-0x10(%ebp)

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  100bdf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100be6:	e9 93 00 00 00       	jmp    100c7e <print_stackframe+0xc4>
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
  100beb:	83 ec 04             	sub    $0x4,%esp
  100bee:	ff 75 f0             	pushl  -0x10(%ebp)
  100bf1:	ff 75 f4             	pushl  -0xc(%ebp)
  100bf4:	8d 83 38 43 ff ff    	lea    -0xbcc8(%ebx),%eax
  100bfa:	50                   	push   %eax
  100bfb:	e8 03 f7 ff ff       	call   100303 <cprintf>
  100c00:	83 c4 10             	add    $0x10,%esp
        uint32_t *args = (uint32_t *)ebp + 2;
  100c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c06:	83 c0 08             	add    $0x8,%eax
  100c09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < 4; j ++) {
  100c0c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100c13:	eb 28                	jmp    100c3d <print_stackframe+0x83>
            cprintf("0x%08x ", args[j]);
  100c15:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100c18:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100c1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100c22:	01 d0                	add    %edx,%eax
  100c24:	8b 00                	mov    (%eax),%eax
  100c26:	83 ec 08             	sub    $0x8,%esp
  100c29:	50                   	push   %eax
  100c2a:	8d 83 54 43 ff ff    	lea    -0xbcac(%ebx),%eax
  100c30:	50                   	push   %eax
  100c31:	e8 cd f6 ff ff       	call   100303 <cprintf>
  100c36:	83 c4 10             	add    $0x10,%esp
        for (j = 0; j < 4; j ++) {
  100c39:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100c3d:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100c41:	7e d2                	jle    100c15 <print_stackframe+0x5b>
        }
        cprintf("\n");
  100c43:	83 ec 0c             	sub    $0xc,%esp
  100c46:	8d 83 5c 43 ff ff    	lea    -0xbca4(%ebx),%eax
  100c4c:	50                   	push   %eax
  100c4d:	e8 b1 f6 ff ff       	call   100303 <cprintf>
  100c52:	83 c4 10             	add    $0x10,%esp
        print_debuginfo(eip - 1);
  100c55:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100c58:	83 e8 01             	sub    $0x1,%eax
  100c5b:	83 ec 0c             	sub    $0xc,%esp
  100c5e:	50                   	push   %eax
  100c5f:	e8 8c fe ff ff       	call   100af0 <print_debuginfo>
  100c64:	83 c4 10             	add    $0x10,%esp
        eip = ((uint32_t *)ebp)[1];
  100c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c6a:	83 c0 04             	add    $0x4,%eax
  100c6d:	8b 00                	mov    (%eax),%eax
  100c6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = ((uint32_t *)ebp)[0];
  100c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c75:	8b 00                	mov    (%eax),%eax
  100c77:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  100c7a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100c7e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c82:	74 0a                	je     100c8e <print_stackframe+0xd4>
  100c84:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100c88:	0f 8e 5d ff ff ff    	jle    100beb <print_stackframe+0x31>
    }
}
  100c8e:	90                   	nop
  100c8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100c92:	c9                   	leave  
  100c93:	c3                   	ret    

00100c94 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100c94:	55                   	push   %ebp
  100c95:	89 e5                	mov    %esp,%ebp
  100c97:	53                   	push   %ebx
  100c98:	83 ec 14             	sub    $0x14,%esp
  100c9b:	e8 f0 f5 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100ca0:	81 c3 b0 ec 00 00    	add    $0xecb0,%ebx
    int argc = 0;
  100ca6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100cad:	eb 0c                	jmp    100cbb <parse+0x27>
            *buf ++ = '\0';
  100caf:	8b 45 08             	mov    0x8(%ebp),%eax
  100cb2:	8d 50 01             	lea    0x1(%eax),%edx
  100cb5:	89 55 08             	mov    %edx,0x8(%ebp)
  100cb8:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  100cbe:	0f b6 00             	movzbl (%eax),%eax
  100cc1:	84 c0                	test   %al,%al
  100cc3:	74 20                	je     100ce5 <parse+0x51>
  100cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  100cc8:	0f b6 00             	movzbl (%eax),%eax
  100ccb:	0f be c0             	movsbl %al,%eax
  100cce:	83 ec 08             	sub    $0x8,%esp
  100cd1:	50                   	push   %eax
  100cd2:	8d 83 e0 43 ff ff    	lea    -0xbc20(%ebx),%eax
  100cd8:	50                   	push   %eax
  100cd9:	e8 dc 23 00 00       	call   1030ba <strchr>
  100cde:	83 c4 10             	add    $0x10,%esp
  100ce1:	85 c0                	test   %eax,%eax
  100ce3:	75 ca                	jne    100caf <parse+0x1b>
        }
        if (*buf == '\0') {
  100ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  100ce8:	0f b6 00             	movzbl (%eax),%eax
  100ceb:	84 c0                	test   %al,%al
  100ced:	74 69                	je     100d58 <parse+0xc4>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100cef:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100cf3:	75 14                	jne    100d09 <parse+0x75>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100cf5:	83 ec 08             	sub    $0x8,%esp
  100cf8:	6a 10                	push   $0x10
  100cfa:	8d 83 e5 43 ff ff    	lea    -0xbc1b(%ebx),%eax
  100d00:	50                   	push   %eax
  100d01:	e8 fd f5 ff ff       	call   100303 <cprintf>
  100d06:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d0c:	8d 50 01             	lea    0x1(%eax),%edx
  100d0f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100d12:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100d19:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d1c:	01 c2                	add    %eax,%edx
  100d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  100d21:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100d23:	eb 04                	jmp    100d29 <parse+0x95>
            buf ++;
  100d25:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100d29:	8b 45 08             	mov    0x8(%ebp),%eax
  100d2c:	0f b6 00             	movzbl (%eax),%eax
  100d2f:	84 c0                	test   %al,%al
  100d31:	74 88                	je     100cbb <parse+0x27>
  100d33:	8b 45 08             	mov    0x8(%ebp),%eax
  100d36:	0f b6 00             	movzbl (%eax),%eax
  100d39:	0f be c0             	movsbl %al,%eax
  100d3c:	83 ec 08             	sub    $0x8,%esp
  100d3f:	50                   	push   %eax
  100d40:	8d 83 e0 43 ff ff    	lea    -0xbc20(%ebx),%eax
  100d46:	50                   	push   %eax
  100d47:	e8 6e 23 00 00       	call   1030ba <strchr>
  100d4c:	83 c4 10             	add    $0x10,%esp
  100d4f:	85 c0                	test   %eax,%eax
  100d51:	74 d2                	je     100d25 <parse+0x91>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100d53:	e9 63 ff ff ff       	jmp    100cbb <parse+0x27>
            break;
  100d58:	90                   	nop
        }
    }
    return argc;
  100d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100d5c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100d5f:	c9                   	leave  
  100d60:	c3                   	ret    

00100d61 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100d61:	55                   	push   %ebp
  100d62:	89 e5                	mov    %esp,%ebp
  100d64:	56                   	push   %esi
  100d65:	53                   	push   %ebx
  100d66:	83 ec 50             	sub    $0x50,%esp
  100d69:	e8 22 f5 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100d6e:	81 c3 e2 eb 00 00    	add    $0xebe2,%ebx
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100d74:	83 ec 08             	sub    $0x8,%esp
  100d77:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100d7a:	50                   	push   %eax
  100d7b:	ff 75 08             	pushl  0x8(%ebp)
  100d7e:	e8 11 ff ff ff       	call   100c94 <parse>
  100d83:	83 c4 10             	add    $0x10,%esp
  100d86:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100d89:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100d8d:	75 0a                	jne    100d99 <runcmd+0x38>
        return 0;
  100d8f:	b8 00 00 00 00       	mov    $0x0,%eax
  100d94:	e9 8b 00 00 00       	jmp    100e24 <runcmd+0xc3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100da0:	eb 5f                	jmp    100e01 <runcmd+0xa0>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100da2:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100da5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100da8:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100dae:	89 d0                	mov    %edx,%eax
  100db0:	01 c0                	add    %eax,%eax
  100db2:	01 d0                	add    %edx,%eax
  100db4:	c1 e0 02             	shl    $0x2,%eax
  100db7:	01 f0                	add    %esi,%eax
  100db9:	8b 00                	mov    (%eax),%eax
  100dbb:	83 ec 08             	sub    $0x8,%esp
  100dbe:	51                   	push   %ecx
  100dbf:	50                   	push   %eax
  100dc0:	e8 41 22 00 00       	call   103006 <strcmp>
  100dc5:	83 c4 10             	add    $0x10,%esp
  100dc8:	85 c0                	test   %eax,%eax
  100dca:	75 31                	jne    100dfd <runcmd+0x9c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100dcc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100dcf:	8d 8b 18 00 00 00    	lea    0x18(%ebx),%ecx
  100dd5:	89 d0                	mov    %edx,%eax
  100dd7:	01 c0                	add    %eax,%eax
  100dd9:	01 d0                	add    %edx,%eax
  100ddb:	c1 e0 02             	shl    $0x2,%eax
  100dde:	01 c8                	add    %ecx,%eax
  100de0:	8b 10                	mov    (%eax),%edx
  100de2:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100de5:	83 c0 04             	add    $0x4,%eax
  100de8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100deb:	83 e9 01             	sub    $0x1,%ecx
  100dee:	83 ec 04             	sub    $0x4,%esp
  100df1:	ff 75 0c             	pushl  0xc(%ebp)
  100df4:	50                   	push   %eax
  100df5:	51                   	push   %ecx
  100df6:	ff d2                	call   *%edx
  100df8:	83 c4 10             	add    $0x10,%esp
  100dfb:	eb 27                	jmp    100e24 <runcmd+0xc3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100dfd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100e04:	83 f8 02             	cmp    $0x2,%eax
  100e07:	76 99                	jbe    100da2 <runcmd+0x41>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100e09:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100e0c:	83 ec 08             	sub    $0x8,%esp
  100e0f:	50                   	push   %eax
  100e10:	8d 83 03 44 ff ff    	lea    -0xbbfd(%ebx),%eax
  100e16:	50                   	push   %eax
  100e17:	e8 e7 f4 ff ff       	call   100303 <cprintf>
  100e1c:	83 c4 10             	add    $0x10,%esp
    return 0;
  100e1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100e24:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100e27:	5b                   	pop    %ebx
  100e28:	5e                   	pop    %esi
  100e29:	5d                   	pop    %ebp
  100e2a:	c3                   	ret    

00100e2b <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100e2b:	55                   	push   %ebp
  100e2c:	89 e5                	mov    %esp,%ebp
  100e2e:	53                   	push   %ebx
  100e2f:	83 ec 14             	sub    $0x14,%esp
  100e32:	e8 59 f4 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100e37:	81 c3 19 eb 00 00    	add    $0xeb19,%ebx
    cprintf("Welcome to the kernel debug monitor!!\n");
  100e3d:	83 ec 0c             	sub    $0xc,%esp
  100e40:	8d 83 1c 44 ff ff    	lea    -0xbbe4(%ebx),%eax
  100e46:	50                   	push   %eax
  100e47:	e8 b7 f4 ff ff       	call   100303 <cprintf>
  100e4c:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100e4f:	83 ec 0c             	sub    $0xc,%esp
  100e52:	8d 83 44 44 ff ff    	lea    -0xbbbc(%ebx),%eax
  100e58:	50                   	push   %eax
  100e59:	e8 a5 f4 ff ff       	call   100303 <cprintf>
  100e5e:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100e61:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100e65:	74 0e                	je     100e75 <kmonitor+0x4a>
        print_trapframe(tf);
  100e67:	83 ec 0c             	sub    $0xc,%esp
  100e6a:	ff 75 08             	pushl  0x8(%ebp)
  100e6d:	e8 16 0f 00 00       	call   101d88 <print_trapframe>
  100e72:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100e75:	83 ec 0c             	sub    $0xc,%esp
  100e78:	8d 83 69 44 ff ff    	lea    -0xbb97(%ebx),%eax
  100e7e:	50                   	push   %eax
  100e7f:	e8 57 f5 ff ff       	call   1003db <readline>
  100e84:	83 c4 10             	add    $0x10,%esp
  100e87:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100e8a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100e8e:	74 e5                	je     100e75 <kmonitor+0x4a>
            if (runcmd(buf, tf) < 0) {
  100e90:	83 ec 08             	sub    $0x8,%esp
  100e93:	ff 75 08             	pushl  0x8(%ebp)
  100e96:	ff 75 f4             	pushl  -0xc(%ebp)
  100e99:	e8 c3 fe ff ff       	call   100d61 <runcmd>
  100e9e:	83 c4 10             	add    $0x10,%esp
  100ea1:	85 c0                	test   %eax,%eax
  100ea3:	78 02                	js     100ea7 <kmonitor+0x7c>
        if ((buf = readline("K> ")) != NULL) {
  100ea5:	eb ce                	jmp    100e75 <kmonitor+0x4a>
                break;
  100ea7:	90                   	nop
            }
        }
    }
}
  100ea8:	90                   	nop
  100ea9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100eac:	c9                   	leave  
  100ead:	c3                   	ret    

00100eae <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100eae:	55                   	push   %ebp
  100eaf:	89 e5                	mov    %esp,%ebp
  100eb1:	56                   	push   %esi
  100eb2:	53                   	push   %ebx
  100eb3:	83 ec 10             	sub    $0x10,%esp
  100eb6:	e8 d5 f3 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100ebb:	81 c3 95 ea 00 00    	add    $0xea95,%ebx
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ec1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100ec8:	eb 44                	jmp    100f0e <mon_help+0x60>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100eca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ecd:	8d 8b 14 00 00 00    	lea    0x14(%ebx),%ecx
  100ed3:	89 d0                	mov    %edx,%eax
  100ed5:	01 c0                	add    %eax,%eax
  100ed7:	01 d0                	add    %edx,%eax
  100ed9:	c1 e0 02             	shl    $0x2,%eax
  100edc:	01 c8                	add    %ecx,%eax
  100ede:	8b 08                	mov    (%eax),%ecx
  100ee0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ee3:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100ee9:	89 d0                	mov    %edx,%eax
  100eeb:	01 c0                	add    %eax,%eax
  100eed:	01 d0                	add    %edx,%eax
  100eef:	c1 e0 02             	shl    $0x2,%eax
  100ef2:	01 f0                	add    %esi,%eax
  100ef4:	8b 00                	mov    (%eax),%eax
  100ef6:	83 ec 04             	sub    $0x4,%esp
  100ef9:	51                   	push   %ecx
  100efa:	50                   	push   %eax
  100efb:	8d 83 6d 44 ff ff    	lea    -0xbb93(%ebx),%eax
  100f01:	50                   	push   %eax
  100f02:	e8 fc f3 ff ff       	call   100303 <cprintf>
  100f07:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100f0a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f11:	83 f8 02             	cmp    $0x2,%eax
  100f14:	76 b4                	jbe    100eca <mon_help+0x1c>
    }
    return 0;
  100f16:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f1b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100f1e:	5b                   	pop    %ebx
  100f1f:	5e                   	pop    %esi
  100f20:	5d                   	pop    %ebp
  100f21:	c3                   	ret    

00100f22 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100f22:	55                   	push   %ebp
  100f23:	89 e5                	mov    %esp,%ebp
  100f25:	53                   	push   %ebx
  100f26:	83 ec 04             	sub    $0x4,%esp
  100f29:	e8 5e f3 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  100f2e:	05 22 ea 00 00       	add    $0xea22,%eax
    print_kerninfo();
  100f33:	89 c3                	mov    %eax,%ebx
  100f35:	e8 f1 fa ff ff       	call   100a2b <print_kerninfo>
    return 0;
  100f3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f3f:	83 c4 04             	add    $0x4,%esp
  100f42:	5b                   	pop    %ebx
  100f43:	5d                   	pop    %ebp
  100f44:	c3                   	ret    

00100f45 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100f45:	55                   	push   %ebp
  100f46:	89 e5                	mov    %esp,%ebp
  100f48:	53                   	push   %ebx
  100f49:	83 ec 04             	sub    $0x4,%esp
  100f4c:	e8 3b f3 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  100f51:	05 ff e9 00 00       	add    $0xe9ff,%eax
    print_stackframe();
  100f56:	89 c3                	mov    %eax,%ebx
  100f58:	e8 5d fc ff ff       	call   100bba <print_stackframe>
    return 0;
  100f5d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f62:	83 c4 04             	add    $0x4,%esp
  100f65:	5b                   	pop    %ebx
  100f66:	5d                   	pop    %ebp
  100f67:	c3                   	ret    

00100f68 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100f68:	55                   	push   %ebp
  100f69:	89 e5                	mov    %esp,%ebp
  100f6b:	53                   	push   %ebx
  100f6c:	83 ec 14             	sub    $0x14,%esp
  100f6f:	e8 1c f3 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  100f74:	81 c3 dc e9 00 00    	add    $0xe9dc,%ebx
  100f7a:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100f80:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f84:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f88:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f8c:	ee                   	out    %al,(%dx)
  100f8d:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100f93:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100f97:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f9b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f9f:	ee                   	out    %al,(%dx)
  100fa0:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100fa6:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
  100faa:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100fae:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100fb2:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100fb3:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  100fb9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("++ setup timer interrupts\n");
  100fbf:	83 ec 0c             	sub    $0xc,%esp
  100fc2:	8d 83 76 44 ff ff    	lea    -0xbb8a(%ebx),%eax
  100fc8:	50                   	push   %eax
  100fc9:	e8 35 f3 ff ff       	call   100303 <cprintf>
  100fce:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100fd1:	83 ec 0c             	sub    $0xc,%esp
  100fd4:	6a 00                	push   $0x0
  100fd6:	e8 e7 09 00 00       	call   1019c2 <pic_enable>
  100fdb:	83 c4 10             	add    $0x10,%esp
}
  100fde:	90                   	nop
  100fdf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100fe2:	c9                   	leave  
  100fe3:	c3                   	ret    

00100fe4 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100fe4:	55                   	push   %ebp
  100fe5:	89 e5                	mov    %esp,%ebp
  100fe7:	83 ec 10             	sub    $0x10,%esp
  100fea:	e8 9d f2 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  100fef:	05 61 e9 00 00       	add    $0xe961,%eax
  100ff4:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ffa:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100ffe:	89 c2                	mov    %eax,%edx
  101000:	ec                   	in     (%dx),%al
  101001:	88 45 f1             	mov    %al,-0xf(%ebp)
  101004:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  10100a:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10100e:	89 c2                	mov    %eax,%edx
  101010:	ec                   	in     (%dx),%al
  101011:	88 45 f5             	mov    %al,-0xb(%ebp)
  101014:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  10101a:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10101e:	89 c2                	mov    %eax,%edx
  101020:	ec                   	in     (%dx),%al
  101021:	88 45 f9             	mov    %al,-0x7(%ebp)
  101024:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  10102a:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  10102e:	89 c2                	mov    %eax,%edx
  101030:	ec                   	in     (%dx),%al
  101031:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  101034:	90                   	nop
  101035:	c9                   	leave  
  101036:	c3                   	ret    

00101037 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  101037:	55                   	push   %ebp
  101038:	89 e5                	mov    %esp,%ebp
  10103a:	83 ec 20             	sub    $0x20,%esp
  10103d:	e8 17 09 00 00       	call   101959 <__x86.get_pc_thunk.cx>
  101042:	81 c1 0e e9 00 00    	add    $0xe90e,%ecx
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  101048:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  10104f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101052:	0f b7 00             	movzwl (%eax),%eax
  101055:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  101059:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10105c:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  101061:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101064:	0f b7 00             	movzwl (%eax),%eax
  101067:	66 3d 5a a5          	cmp    $0xa55a,%ax
  10106b:	74 12                	je     10107f <cga_init+0x48>
        cp = (uint16_t*)MONO_BUF;
  10106d:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  101074:	66 c7 81 b6 05 00 00 	movw   $0x3b4,0x5b6(%ecx)
  10107b:	b4 03 
  10107d:	eb 13                	jmp    101092 <cga_init+0x5b>
    } else {
        *cp = was;
  10107f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101082:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101086:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  101089:	66 c7 81 b6 05 00 00 	movw   $0x3d4,0x5b6(%ecx)
  101090:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  101092:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  101099:	0f b7 c0             	movzwl %ax,%eax
  10109c:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  1010a0:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010a4:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1010a8:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1010ac:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  1010ad:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010b4:	83 c0 01             	add    $0x1,%eax
  1010b7:	0f b7 c0             	movzwl %ax,%eax
  1010ba:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1010be:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  1010c2:	89 c2                	mov    %eax,%edx
  1010c4:	ec                   	in     (%dx),%al
  1010c5:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  1010c8:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1010cc:	0f b6 c0             	movzbl %al,%eax
  1010cf:	c1 e0 08             	shl    $0x8,%eax
  1010d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  1010d5:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010dc:	0f b7 c0             	movzwl %ax,%eax
  1010df:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1010e3:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010e7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010eb:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010ef:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  1010f0:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010f7:	83 c0 01             	add    $0x1,%eax
  1010fa:	0f b7 c0             	movzwl %ax,%eax
  1010fd:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101101:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101105:	89 c2                	mov    %eax,%edx
  101107:	ec                   	in     (%dx),%al
  101108:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  10110b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10110f:	0f b6 c0             	movzbl %al,%eax
  101112:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  101115:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101118:	89 81 b0 05 00 00    	mov    %eax,0x5b0(%ecx)
    crt_pos = pos;
  10111e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101121:	66 89 81 b4 05 00 00 	mov    %ax,0x5b4(%ecx)
}
  101128:	90                   	nop
  101129:	c9                   	leave  
  10112a:	c3                   	ret    

0010112b <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  10112b:	55                   	push   %ebp
  10112c:	89 e5                	mov    %esp,%ebp
  10112e:	53                   	push   %ebx
  10112f:	83 ec 34             	sub    $0x34,%esp
  101132:	e8 22 08 00 00       	call   101959 <__x86.get_pc_thunk.cx>
  101137:	81 c1 19 e8 00 00    	add    $0xe819,%ecx
  10113d:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  101143:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101147:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  10114b:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  10114f:	ee                   	out    %al,(%dx)
  101150:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  101156:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
  10115a:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  10115e:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101162:	ee                   	out    %al,(%dx)
  101163:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  101169:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
  10116d:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101171:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101175:	ee                   	out    %al,(%dx)
  101176:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  10117c:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
  101180:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101184:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101188:	ee                   	out    %al,(%dx)
  101189:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  10118f:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
  101193:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101197:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10119b:	ee                   	out    %al,(%dx)
  10119c:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  1011a2:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
  1011a6:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1011aa:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1011ae:	ee                   	out    %al,(%dx)
  1011af:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  1011b5:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
  1011b9:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1011bd:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1011c1:	ee                   	out    %al,(%dx)
  1011c2:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011c8:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  1011cc:	89 c2                	mov    %eax,%edx
  1011ce:	ec                   	in     (%dx),%al
  1011cf:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  1011d2:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  1011d6:	3c ff                	cmp    $0xff,%al
  1011d8:	0f 95 c0             	setne  %al
  1011db:	0f b6 c0             	movzbl %al,%eax
  1011de:	89 81 b8 05 00 00    	mov    %eax,0x5b8(%ecx)
  1011e4:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011ea:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1011ee:	89 c2                	mov    %eax,%edx
  1011f0:	ec                   	in     (%dx),%al
  1011f1:	88 45 f1             	mov    %al,-0xf(%ebp)
  1011f4:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1011fa:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1011fe:	89 c2                	mov    %eax,%edx
  101200:	ec                   	in     (%dx),%al
  101201:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101204:	8b 81 b8 05 00 00    	mov    0x5b8(%ecx),%eax
  10120a:	85 c0                	test   %eax,%eax
  10120c:	74 0f                	je     10121d <serial_init+0xf2>
        pic_enable(IRQ_COM1);
  10120e:	83 ec 0c             	sub    $0xc,%esp
  101211:	6a 04                	push   $0x4
  101213:	89 cb                	mov    %ecx,%ebx
  101215:	e8 a8 07 00 00       	call   1019c2 <pic_enable>
  10121a:	83 c4 10             	add    $0x10,%esp
    }
}
  10121d:	90                   	nop
  10121e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101221:	c9                   	leave  
  101222:	c3                   	ret    

00101223 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101223:	55                   	push   %ebp
  101224:	89 e5                	mov    %esp,%ebp
  101226:	83 ec 20             	sub    $0x20,%esp
  101229:	e8 5e f0 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  10122e:	05 22 e7 00 00       	add    $0xe722,%eax
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101233:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10123a:	eb 09                	jmp    101245 <lpt_putc_sub+0x22>
        delay();
  10123c:	e8 a3 fd ff ff       	call   100fe4 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101241:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101245:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10124b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10124f:	89 c2                	mov    %eax,%edx
  101251:	ec                   	in     (%dx),%al
  101252:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101255:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101259:	84 c0                	test   %al,%al
  10125b:	78 09                	js     101266 <lpt_putc_sub+0x43>
  10125d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101264:	7e d6                	jle    10123c <lpt_putc_sub+0x19>
    }
    outb(LPTPORT + 0, c);
  101266:	8b 45 08             	mov    0x8(%ebp),%eax
  101269:	0f b6 c0             	movzbl %al,%eax
  10126c:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101272:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101275:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101279:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10127d:	ee                   	out    %al,(%dx)
  10127e:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101284:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101288:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10128c:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101290:	ee                   	out    %al,(%dx)
  101291:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  101297:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
  10129b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10129f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012a3:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1012a4:	90                   	nop
  1012a5:	c9                   	leave  
  1012a6:	c3                   	ret    

001012a7 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1012a7:	55                   	push   %ebp
  1012a8:	89 e5                	mov    %esp,%ebp
  1012aa:	e8 dd ef ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1012af:	05 a1 e6 00 00       	add    $0xe6a1,%eax
    if (c != '\b') {
  1012b4:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1012b8:	74 0d                	je     1012c7 <lpt_putc+0x20>
        lpt_putc_sub(c);
  1012ba:	ff 75 08             	pushl  0x8(%ebp)
  1012bd:	e8 61 ff ff ff       	call   101223 <lpt_putc_sub>
  1012c2:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1012c5:	eb 1e                	jmp    1012e5 <lpt_putc+0x3e>
        lpt_putc_sub('\b');
  1012c7:	6a 08                	push   $0x8
  1012c9:	e8 55 ff ff ff       	call   101223 <lpt_putc_sub>
  1012ce:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  1012d1:	6a 20                	push   $0x20
  1012d3:	e8 4b ff ff ff       	call   101223 <lpt_putc_sub>
  1012d8:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  1012db:	6a 08                	push   $0x8
  1012dd:	e8 41 ff ff ff       	call   101223 <lpt_putc_sub>
  1012e2:	83 c4 04             	add    $0x4,%esp
}
  1012e5:	90                   	nop
  1012e6:	c9                   	leave  
  1012e7:	c3                   	ret    

001012e8 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1012e8:	55                   	push   %ebp
  1012e9:	89 e5                	mov    %esp,%ebp
  1012eb:	56                   	push   %esi
  1012ec:	53                   	push   %ebx
  1012ed:	83 ec 20             	sub    $0x20,%esp
  1012f0:	e8 9b ef ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  1012f5:	81 c3 5b e6 00 00    	add    $0xe65b,%ebx
    // set black on white
    if (!(c & ~0xFF)) {
  1012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1012fe:	b0 00                	mov    $0x0,%al
  101300:	85 c0                	test   %eax,%eax
  101302:	75 07                	jne    10130b <cga_putc+0x23>
        c |= 0x0700;
  101304:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10130b:	8b 45 08             	mov    0x8(%ebp),%eax
  10130e:	0f b6 c0             	movzbl %al,%eax
  101311:	83 f8 0a             	cmp    $0xa,%eax
  101314:	74 54                	je     10136a <cga_putc+0x82>
  101316:	83 f8 0d             	cmp    $0xd,%eax
  101319:	74 60                	je     10137b <cga_putc+0x93>
  10131b:	83 f8 08             	cmp    $0x8,%eax
  10131e:	0f 85 92 00 00 00    	jne    1013b6 <cga_putc+0xce>
    case '\b':
        if (crt_pos > 0) {
  101324:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10132b:	66 85 c0             	test   %ax,%ax
  10132e:	0f 84 a8 00 00 00    	je     1013dc <cga_putc+0xf4>
            crt_pos --;
  101334:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10133b:	83 e8 01             	sub    $0x1,%eax
  10133e:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101345:	8b 45 08             	mov    0x8(%ebp),%eax
  101348:	b0 00                	mov    $0x0,%al
  10134a:	83 c8 20             	or     $0x20,%eax
  10134d:	89 c1                	mov    %eax,%ecx
  10134f:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  101355:	0f b7 93 b4 05 00 00 	movzwl 0x5b4(%ebx),%edx
  10135c:	0f b7 d2             	movzwl %dx,%edx
  10135f:	01 d2                	add    %edx,%edx
  101361:	01 d0                	add    %edx,%eax
  101363:	89 ca                	mov    %ecx,%edx
  101365:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  101368:	eb 72                	jmp    1013dc <cga_putc+0xf4>
    case '\n':
        crt_pos += CRT_COLS;
  10136a:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101371:	83 c0 50             	add    $0x50,%eax
  101374:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  10137b:	0f b7 b3 b4 05 00 00 	movzwl 0x5b4(%ebx),%esi
  101382:	0f b7 8b b4 05 00 00 	movzwl 0x5b4(%ebx),%ecx
  101389:	0f b7 c1             	movzwl %cx,%eax
  10138c:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  101392:	c1 e8 10             	shr    $0x10,%eax
  101395:	89 c2                	mov    %eax,%edx
  101397:	66 c1 ea 06          	shr    $0x6,%dx
  10139b:	89 d0                	mov    %edx,%eax
  10139d:	c1 e0 02             	shl    $0x2,%eax
  1013a0:	01 d0                	add    %edx,%eax
  1013a2:	c1 e0 04             	shl    $0x4,%eax
  1013a5:	29 c1                	sub    %eax,%ecx
  1013a7:	89 ca                	mov    %ecx,%edx
  1013a9:	89 f0                	mov    %esi,%eax
  1013ab:	29 d0                	sub    %edx,%eax
  1013ad:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
        break;
  1013b4:	eb 27                	jmp    1013dd <cga_putc+0xf5>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1013b6:	8b 8b b0 05 00 00    	mov    0x5b0(%ebx),%ecx
  1013bc:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013c3:	8d 50 01             	lea    0x1(%eax),%edx
  1013c6:	66 89 93 b4 05 00 00 	mov    %dx,0x5b4(%ebx)
  1013cd:	0f b7 c0             	movzwl %ax,%eax
  1013d0:	01 c0                	add    %eax,%eax
  1013d2:	01 c8                	add    %ecx,%eax
  1013d4:	8b 55 08             	mov    0x8(%ebp),%edx
  1013d7:	66 89 10             	mov    %dx,(%eax)
        break;
  1013da:	eb 01                	jmp    1013dd <cga_putc+0xf5>
        break;
  1013dc:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1013dd:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013e4:	66 3d cf 07          	cmp    $0x7cf,%ax
  1013e8:	76 5d                	jbe    101447 <cga_putc+0x15f>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1013ea:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013f0:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1013f6:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013fc:	83 ec 04             	sub    $0x4,%esp
  1013ff:	68 00 0f 00 00       	push   $0xf00
  101404:	52                   	push   %edx
  101405:	50                   	push   %eax
  101406:	e8 d6 1e 00 00       	call   1032e1 <memmove>
  10140b:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10140e:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  101415:	eb 16                	jmp    10142d <cga_putc+0x145>
            crt_buf[i] = 0x0700 | ' ';
  101417:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  10141d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101420:	01 d2                	add    %edx,%edx
  101422:	01 d0                	add    %edx,%eax
  101424:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101429:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10142d:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101434:	7e e1                	jle    101417 <cga_putc+0x12f>
        }
        crt_pos -= CRT_COLS;
  101436:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10143d:	83 e8 50             	sub    $0x50,%eax
  101440:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101447:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  10144e:	0f b7 c0             	movzwl %ax,%eax
  101451:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101455:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
  101459:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10145d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101461:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101462:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101469:	66 c1 e8 08          	shr    $0x8,%ax
  10146d:	0f b6 c0             	movzbl %al,%eax
  101470:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  101477:	83 c2 01             	add    $0x1,%edx
  10147a:	0f b7 d2             	movzwl %dx,%edx
  10147d:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101481:	88 45 e9             	mov    %al,-0x17(%ebp)
  101484:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101488:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10148c:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  10148d:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  101494:	0f b7 c0             	movzwl %ax,%eax
  101497:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  10149b:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
  10149f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1014a3:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1014a7:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  1014a8:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1014af:	0f b6 c0             	movzbl %al,%eax
  1014b2:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  1014b9:	83 c2 01             	add    $0x1,%edx
  1014bc:	0f b7 d2             	movzwl %dx,%edx
  1014bf:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1014c3:	88 45 f1             	mov    %al,-0xf(%ebp)
  1014c6:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1014ca:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1014ce:	ee                   	out    %al,(%dx)
}
  1014cf:	90                   	nop
  1014d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1014d3:	5b                   	pop    %ebx
  1014d4:	5e                   	pop    %esi
  1014d5:	5d                   	pop    %ebp
  1014d6:	c3                   	ret    

001014d7 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1014d7:	55                   	push   %ebp
  1014d8:	89 e5                	mov    %esp,%ebp
  1014da:	83 ec 10             	sub    $0x10,%esp
  1014dd:	e8 aa ed ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1014e2:	05 6e e4 00 00       	add    $0xe46e,%eax
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1014e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1014ee:	eb 09                	jmp    1014f9 <serial_putc_sub+0x22>
        delay();
  1014f0:	e8 ef fa ff ff       	call   100fe4 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1014f5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1014f9:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014ff:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101503:	89 c2                	mov    %eax,%edx
  101505:	ec                   	in     (%dx),%al
  101506:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101509:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10150d:	0f b6 c0             	movzbl %al,%eax
  101510:	83 e0 20             	and    $0x20,%eax
  101513:	85 c0                	test   %eax,%eax
  101515:	75 09                	jne    101520 <serial_putc_sub+0x49>
  101517:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10151e:	7e d0                	jle    1014f0 <serial_putc_sub+0x19>
    }
    outb(COM1 + COM_TX, c);
  101520:	8b 45 08             	mov    0x8(%ebp),%eax
  101523:	0f b6 c0             	movzbl %al,%eax
  101526:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10152c:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10152f:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101533:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101537:	ee                   	out    %al,(%dx)
}
  101538:	90                   	nop
  101539:	c9                   	leave  
  10153a:	c3                   	ret    

0010153b <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  10153b:	55                   	push   %ebp
  10153c:	89 e5                	mov    %esp,%ebp
  10153e:	e8 49 ed ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101543:	05 0d e4 00 00       	add    $0xe40d,%eax
    if (c != '\b') {
  101548:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10154c:	74 0d                	je     10155b <serial_putc+0x20>
        serial_putc_sub(c);
  10154e:	ff 75 08             	pushl  0x8(%ebp)
  101551:	e8 81 ff ff ff       	call   1014d7 <serial_putc_sub>
  101556:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101559:	eb 1e                	jmp    101579 <serial_putc+0x3e>
        serial_putc_sub('\b');
  10155b:	6a 08                	push   $0x8
  10155d:	e8 75 ff ff ff       	call   1014d7 <serial_putc_sub>
  101562:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  101565:	6a 20                	push   $0x20
  101567:	e8 6b ff ff ff       	call   1014d7 <serial_putc_sub>
  10156c:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  10156f:	6a 08                	push   $0x8
  101571:	e8 61 ff ff ff       	call   1014d7 <serial_putc_sub>
  101576:	83 c4 04             	add    $0x4,%esp
}
  101579:	90                   	nop
  10157a:	c9                   	leave  
  10157b:	c3                   	ret    

0010157c <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10157c:	55                   	push   %ebp
  10157d:	89 e5                	mov    %esp,%ebp
  10157f:	53                   	push   %ebx
  101580:	83 ec 14             	sub    $0x14,%esp
  101583:	e8 08 ed ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  101588:	81 c3 c8 e3 00 00    	add    $0xe3c8,%ebx
    int c;
    while ((c = (*proc)()) != -1) {
  10158e:	eb 36                	jmp    1015c6 <cons_intr+0x4a>
        if (c != 0) {
  101590:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101594:	74 30                	je     1015c6 <cons_intr+0x4a>
            cons.buf[cons.wpos ++] = c;
  101596:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  10159c:	8d 50 01             	lea    0x1(%eax),%edx
  10159f:	89 93 d4 07 00 00    	mov    %edx,0x7d4(%ebx)
  1015a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1015a8:	88 94 03 d0 05 00 00 	mov    %dl,0x5d0(%ebx,%eax,1)
            if (cons.wpos == CONSBUFSIZE) {
  1015af:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  1015b5:	3d 00 02 00 00       	cmp    $0x200,%eax
  1015ba:	75 0a                	jne    1015c6 <cons_intr+0x4a>
                cons.wpos = 0;
  1015bc:	c7 83 d4 07 00 00 00 	movl   $0x0,0x7d4(%ebx)
  1015c3:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1015c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1015c9:	ff d0                	call   *%eax
  1015cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1015ce:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1015d2:	75 bc                	jne    101590 <cons_intr+0x14>
            }
        }
    }
}
  1015d4:	90                   	nop
  1015d5:	83 c4 14             	add    $0x14,%esp
  1015d8:	5b                   	pop    %ebx
  1015d9:	5d                   	pop    %ebp
  1015da:	c3                   	ret    

001015db <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1015db:	55                   	push   %ebp
  1015dc:	89 e5                	mov    %esp,%ebp
  1015de:	83 ec 10             	sub    $0x10,%esp
  1015e1:	e8 a6 ec ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1015e6:	05 6a e3 00 00       	add    $0xe36a,%eax
  1015eb:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1015f1:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1015f5:	89 c2                	mov    %eax,%edx
  1015f7:	ec                   	in     (%dx),%al
  1015f8:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1015fb:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1015ff:	0f b6 c0             	movzbl %al,%eax
  101602:	83 e0 01             	and    $0x1,%eax
  101605:	85 c0                	test   %eax,%eax
  101607:	75 07                	jne    101610 <serial_proc_data+0x35>
        return -1;
  101609:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10160e:	eb 2a                	jmp    10163a <serial_proc_data+0x5f>
  101610:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101616:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10161a:	89 c2                	mov    %eax,%edx
  10161c:	ec                   	in     (%dx),%al
  10161d:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101620:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101624:	0f b6 c0             	movzbl %al,%eax
  101627:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  10162a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  10162e:	75 07                	jne    101637 <serial_proc_data+0x5c>
        c = '\b';
  101630:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101637:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10163a:	c9                   	leave  
  10163b:	c3                   	ret    

0010163c <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10163c:	55                   	push   %ebp
  10163d:	89 e5                	mov    %esp,%ebp
  10163f:	83 ec 08             	sub    $0x8,%esp
  101642:	e8 45 ec ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101647:	05 09 e3 00 00       	add    $0xe309,%eax
    if (serial_exists) {
  10164c:	8b 90 b8 05 00 00    	mov    0x5b8(%eax),%edx
  101652:	85 d2                	test   %edx,%edx
  101654:	74 12                	je     101668 <serial_intr+0x2c>
        cons_intr(serial_proc_data);
  101656:	83 ec 0c             	sub    $0xc,%esp
  101659:	8d 80 8b 1c ff ff    	lea    -0xe375(%eax),%eax
  10165f:	50                   	push   %eax
  101660:	e8 17 ff ff ff       	call   10157c <cons_intr>
  101665:	83 c4 10             	add    $0x10,%esp
    }
}
  101668:	90                   	nop
  101669:	c9                   	leave  
  10166a:	c3                   	ret    

0010166b <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10166b:	55                   	push   %ebp
  10166c:	89 e5                	mov    %esp,%ebp
  10166e:	53                   	push   %ebx
  10166f:	83 ec 24             	sub    $0x24,%esp
  101672:	e8 e2 02 00 00       	call   101959 <__x86.get_pc_thunk.cx>
  101677:	81 c1 d9 e2 00 00    	add    $0xe2d9,%ecx
  10167d:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101683:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101687:	89 c2                	mov    %eax,%edx
  101689:	ec                   	in     (%dx),%al
  10168a:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  10168d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101691:	0f b6 c0             	movzbl %al,%eax
  101694:	83 e0 01             	and    $0x1,%eax
  101697:	85 c0                	test   %eax,%eax
  101699:	75 0a                	jne    1016a5 <kbd_proc_data+0x3a>
        return -1;
  10169b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1016a0:	e9 73 01 00 00       	jmp    101818 <kbd_proc_data+0x1ad>
  1016a5:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1016ab:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1016af:	89 c2                	mov    %eax,%edx
  1016b1:	ec                   	in     (%dx),%al
  1016b2:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1016b5:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1016b9:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1016bc:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1016c0:	75 19                	jne    1016db <kbd_proc_data+0x70>
        // E0 escape character
        shift |= E0ESC;
  1016c2:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016c8:	83 c8 40             	or     $0x40,%eax
  1016cb:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1016d1:	b8 00 00 00 00       	mov    $0x0,%eax
  1016d6:	e9 3d 01 00 00       	jmp    101818 <kbd_proc_data+0x1ad>
    } else if (data & 0x80) {
  1016db:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016df:	84 c0                	test   %al,%al
  1016e1:	79 4b                	jns    10172e <kbd_proc_data+0xc3>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1016e3:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016e9:	83 e0 40             	and    $0x40,%eax
  1016ec:	85 c0                	test   %eax,%eax
  1016ee:	75 09                	jne    1016f9 <kbd_proc_data+0x8e>
  1016f0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016f4:	83 e0 7f             	and    $0x7f,%eax
  1016f7:	eb 04                	jmp    1016fd <kbd_proc_data+0x92>
  1016f9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016fd:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101700:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101704:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  10170b:	ff 
  10170c:	83 c8 40             	or     $0x40,%eax
  10170f:	0f b6 c0             	movzbl %al,%eax
  101712:	f7 d0                	not    %eax
  101714:	89 c2                	mov    %eax,%edx
  101716:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10171c:	21 d0                	and    %edx,%eax
  10171e:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  101724:	b8 00 00 00 00       	mov    $0x0,%eax
  101729:	e9 ea 00 00 00       	jmp    101818 <kbd_proc_data+0x1ad>
    } else if (shift & E0ESC) {
  10172e:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101734:	83 e0 40             	and    $0x40,%eax
  101737:	85 c0                	test   %eax,%eax
  101739:	74 13                	je     10174e <kbd_proc_data+0xe3>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10173b:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10173f:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101745:	83 e0 bf             	and    $0xffffffbf,%eax
  101748:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    }

    shift |= shiftcode[data];
  10174e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101752:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  101759:	ff 
  10175a:	0f b6 d0             	movzbl %al,%edx
  10175d:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101763:	09 d0                	or     %edx,%eax
  101765:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    shift ^= togglecode[data];
  10176b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10176f:	0f b6 84 01 b0 f7 ff 	movzbl -0x850(%ecx,%eax,1),%eax
  101776:	ff 
  101777:	0f b6 d0             	movzbl %al,%edx
  10177a:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101780:	31 d0                	xor    %edx,%eax
  101782:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)

    c = charcode[shift & (CTL | SHIFT)][data];
  101788:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10178e:	83 e0 03             	and    $0x3,%eax
  101791:	8b 94 81 34 00 00 00 	mov    0x34(%ecx,%eax,4),%edx
  101798:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10179c:	01 d0                	add    %edx,%eax
  10179e:	0f b6 00             	movzbl (%eax),%eax
  1017a1:	0f b6 c0             	movzbl %al,%eax
  1017a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1017a7:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017ad:	83 e0 08             	and    $0x8,%eax
  1017b0:	85 c0                	test   %eax,%eax
  1017b2:	74 22                	je     1017d6 <kbd_proc_data+0x16b>
        if ('a' <= c && c <= 'z')
  1017b4:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1017b8:	7e 0c                	jle    1017c6 <kbd_proc_data+0x15b>
  1017ba:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1017be:	7f 06                	jg     1017c6 <kbd_proc_data+0x15b>
            c += 'A' - 'a';
  1017c0:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1017c4:	eb 10                	jmp    1017d6 <kbd_proc_data+0x16b>
        else if ('A' <= c && c <= 'Z')
  1017c6:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1017ca:	7e 0a                	jle    1017d6 <kbd_proc_data+0x16b>
  1017cc:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1017d0:	7f 04                	jg     1017d6 <kbd_proc_data+0x16b>
            c += 'a' - 'A';
  1017d2:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1017d6:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017dc:	f7 d0                	not    %eax
  1017de:	83 e0 06             	and    $0x6,%eax
  1017e1:	85 c0                	test   %eax,%eax
  1017e3:	75 30                	jne    101815 <kbd_proc_data+0x1aa>
  1017e5:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1017ec:	75 27                	jne    101815 <kbd_proc_data+0x1aa>
        cprintf("Rebooting!\n");
  1017ee:	83 ec 0c             	sub    $0xc,%esp
  1017f1:	8d 81 91 44 ff ff    	lea    -0xbb6f(%ecx),%eax
  1017f7:	50                   	push   %eax
  1017f8:	89 cb                	mov    %ecx,%ebx
  1017fa:	e8 04 eb ff ff       	call   100303 <cprintf>
  1017ff:	83 c4 10             	add    $0x10,%esp
  101802:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101808:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10180c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101810:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101814:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101815:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101818:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10181b:	c9                   	leave  
  10181c:	c3                   	ret    

0010181d <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  10181d:	55                   	push   %ebp
  10181e:	89 e5                	mov    %esp,%ebp
  101820:	83 ec 08             	sub    $0x8,%esp
  101823:	e8 64 ea ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101828:	05 28 e1 00 00       	add    $0xe128,%eax
    cons_intr(kbd_proc_data);
  10182d:	83 ec 0c             	sub    $0xc,%esp
  101830:	8d 80 1b 1d ff ff    	lea    -0xe2e5(%eax),%eax
  101836:	50                   	push   %eax
  101837:	e8 40 fd ff ff       	call   10157c <cons_intr>
  10183c:	83 c4 10             	add    $0x10,%esp
}
  10183f:	90                   	nop
  101840:	c9                   	leave  
  101841:	c3                   	ret    

00101842 <kbd_init>:

static void
kbd_init(void) {
  101842:	55                   	push   %ebp
  101843:	89 e5                	mov    %esp,%ebp
  101845:	53                   	push   %ebx
  101846:	83 ec 04             	sub    $0x4,%esp
  101849:	e8 42 ea ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  10184e:	81 c3 02 e1 00 00    	add    $0xe102,%ebx
    // drain the kbd buffer
    kbd_intr();
  101854:	e8 c4 ff ff ff       	call   10181d <kbd_intr>
    pic_enable(IRQ_KBD);
  101859:	83 ec 0c             	sub    $0xc,%esp
  10185c:	6a 01                	push   $0x1
  10185e:	e8 5f 01 00 00       	call   1019c2 <pic_enable>
  101863:	83 c4 10             	add    $0x10,%esp
}
  101866:	90                   	nop
  101867:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10186a:	c9                   	leave  
  10186b:	c3                   	ret    

0010186c <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10186c:	55                   	push   %ebp
  10186d:	89 e5                	mov    %esp,%ebp
  10186f:	53                   	push   %ebx
  101870:	83 ec 04             	sub    $0x4,%esp
  101873:	e8 18 ea ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  101878:	81 c3 d8 e0 00 00    	add    $0xe0d8,%ebx
    cga_init();
  10187e:	e8 b4 f7 ff ff       	call   101037 <cga_init>
    serial_init();
  101883:	e8 a3 f8 ff ff       	call   10112b <serial_init>
    kbd_init();
  101888:	e8 b5 ff ff ff       	call   101842 <kbd_init>
    if (!serial_exists) {
  10188d:	8b 83 b8 05 00 00    	mov    0x5b8(%ebx),%eax
  101893:	85 c0                	test   %eax,%eax
  101895:	75 12                	jne    1018a9 <cons_init+0x3d>
        cprintf("serial port does not exist!!\n");
  101897:	83 ec 0c             	sub    $0xc,%esp
  10189a:	8d 83 9d 44 ff ff    	lea    -0xbb63(%ebx),%eax
  1018a0:	50                   	push   %eax
  1018a1:	e8 5d ea ff ff       	call   100303 <cprintf>
  1018a6:	83 c4 10             	add    $0x10,%esp
    }
}
  1018a9:	90                   	nop
  1018aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1018ad:	c9                   	leave  
  1018ae:	c3                   	ret    

001018af <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1018af:	55                   	push   %ebp
  1018b0:	89 e5                	mov    %esp,%ebp
  1018b2:	83 ec 08             	sub    $0x8,%esp
  1018b5:	e8 d2 e9 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1018ba:	05 96 e0 00 00       	add    $0xe096,%eax
    lpt_putc(c);
  1018bf:	ff 75 08             	pushl  0x8(%ebp)
  1018c2:	e8 e0 f9 ff ff       	call   1012a7 <lpt_putc>
  1018c7:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  1018ca:	83 ec 0c             	sub    $0xc,%esp
  1018cd:	ff 75 08             	pushl  0x8(%ebp)
  1018d0:	e8 13 fa ff ff       	call   1012e8 <cga_putc>
  1018d5:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  1018d8:	83 ec 0c             	sub    $0xc,%esp
  1018db:	ff 75 08             	pushl  0x8(%ebp)
  1018de:	e8 58 fc ff ff       	call   10153b <serial_putc>
  1018e3:	83 c4 10             	add    $0x10,%esp
}
  1018e6:	90                   	nop
  1018e7:	c9                   	leave  
  1018e8:	c3                   	ret    

001018e9 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1018e9:	55                   	push   %ebp
  1018ea:	89 e5                	mov    %esp,%ebp
  1018ec:	53                   	push   %ebx
  1018ed:	83 ec 14             	sub    $0x14,%esp
  1018f0:	e8 9b e9 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  1018f5:	81 c3 5b e0 00 00    	add    $0xe05b,%ebx
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1018fb:	e8 3c fd ff ff       	call   10163c <serial_intr>
    kbd_intr();
  101900:	e8 18 ff ff ff       	call   10181d <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101905:	8b 93 d0 07 00 00    	mov    0x7d0(%ebx),%edx
  10190b:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  101911:	39 c2                	cmp    %eax,%edx
  101913:	74 39                	je     10194e <cons_getc+0x65>
        c = cons.buf[cons.rpos ++];
  101915:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  10191b:	8d 50 01             	lea    0x1(%eax),%edx
  10191e:	89 93 d0 07 00 00    	mov    %edx,0x7d0(%ebx)
  101924:	0f b6 84 03 d0 05 00 	movzbl 0x5d0(%ebx,%eax,1),%eax
  10192b:	00 
  10192c:	0f b6 c0             	movzbl %al,%eax
  10192f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101932:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  101938:	3d 00 02 00 00       	cmp    $0x200,%eax
  10193d:	75 0a                	jne    101949 <cons_getc+0x60>
            cons.rpos = 0;
  10193f:	c7 83 d0 07 00 00 00 	movl   $0x0,0x7d0(%ebx)
  101946:	00 00 00 
        }
        return c;
  101949:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10194c:	eb 05                	jmp    101953 <cons_getc+0x6a>
    }
    return 0;
  10194e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101953:	83 c4 14             	add    $0x14,%esp
  101956:	5b                   	pop    %ebx
  101957:	5d                   	pop    %ebp
  101958:	c3                   	ret    

00101959 <__x86.get_pc_thunk.cx>:
  101959:	8b 0c 24             	mov    (%esp),%ecx
  10195c:	c3                   	ret    

0010195d <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  10195d:	55                   	push   %ebp
  10195e:	89 e5                	mov    %esp,%ebp
  101960:	83 ec 14             	sub    $0x14,%esp
  101963:	e8 24 e9 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101968:	05 e8 df 00 00       	add    $0xdfe8,%eax
  10196d:	8b 55 08             	mov    0x8(%ebp),%edx
  101970:	66 89 55 ec          	mov    %dx,-0x14(%ebp)
    irq_mask = mask;
  101974:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  101978:	66 89 90 b0 fb ff ff 	mov    %dx,-0x450(%eax)
    if (did_init) {
  10197f:	8b 80 dc 07 00 00    	mov    0x7dc(%eax),%eax
  101985:	85 c0                	test   %eax,%eax
  101987:	74 36                	je     1019bf <pic_setmask+0x62>
        outb(IO_PIC1 + 1, mask);
  101989:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10198d:	0f b6 c0             	movzbl %al,%eax
  101990:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101996:	88 45 f9             	mov    %al,-0x7(%ebp)
  101999:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10199d:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1019a1:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  1019a2:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1019a6:	66 c1 e8 08          	shr    $0x8,%ax
  1019aa:	0f b6 c0             	movzbl %al,%eax
  1019ad:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  1019b3:	88 45 fd             	mov    %al,-0x3(%ebp)
  1019b6:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1019ba:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1019be:	ee                   	out    %al,(%dx)
    }
}
  1019bf:	90                   	nop
  1019c0:	c9                   	leave  
  1019c1:	c3                   	ret    

001019c2 <pic_enable>:

void
pic_enable(unsigned int irq) {
  1019c2:	55                   	push   %ebp
  1019c3:	89 e5                	mov    %esp,%ebp
  1019c5:	53                   	push   %ebx
  1019c6:	e8 c1 e8 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1019cb:	05 85 df 00 00       	add    $0xdf85,%eax
    pic_setmask(irq_mask & ~(1 << irq));
  1019d0:	8b 55 08             	mov    0x8(%ebp),%edx
  1019d3:	bb 01 00 00 00       	mov    $0x1,%ebx
  1019d8:	89 d1                	mov    %edx,%ecx
  1019da:	d3 e3                	shl    %cl,%ebx
  1019dc:	89 da                	mov    %ebx,%edx
  1019de:	f7 d2                	not    %edx
  1019e0:	0f b7 80 b0 fb ff ff 	movzwl -0x450(%eax),%eax
  1019e7:	21 d0                	and    %edx,%eax
  1019e9:	0f b7 c0             	movzwl %ax,%eax
  1019ec:	50                   	push   %eax
  1019ed:	e8 6b ff ff ff       	call   10195d <pic_setmask>
  1019f2:	83 c4 04             	add    $0x4,%esp
}
  1019f5:	90                   	nop
  1019f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1019f9:	c9                   	leave  
  1019fa:	c3                   	ret    

001019fb <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1019fb:	55                   	push   %ebp
  1019fc:	89 e5                	mov    %esp,%ebp
  1019fe:	83 ec 40             	sub    $0x40,%esp
  101a01:	e8 53 ff ff ff       	call   101959 <__x86.get_pc_thunk.cx>
  101a06:	81 c1 4a df 00 00    	add    $0xdf4a,%ecx
    did_init = 1;
  101a0c:	c7 81 dc 07 00 00 01 	movl   $0x1,0x7dc(%ecx)
  101a13:	00 00 00 
  101a16:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  101a1c:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
  101a20:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101a24:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101a28:	ee                   	out    %al,(%dx)
  101a29:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  101a2f:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
  101a33:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101a37:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101a3b:	ee                   	out    %al,(%dx)
  101a3c:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101a42:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
  101a46:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101a4a:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101a4e:	ee                   	out    %al,(%dx)
  101a4f:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  101a55:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
  101a59:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101a5d:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101a61:	ee                   	out    %al,(%dx)
  101a62:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101a68:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
  101a6c:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101a70:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101a74:	ee                   	out    %al,(%dx)
  101a75:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101a7b:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
  101a7f:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101a83:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101a87:	ee                   	out    %al,(%dx)
  101a88:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101a8e:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
  101a92:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101a96:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101a9a:	ee                   	out    %al,(%dx)
  101a9b:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101aa1:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
  101aa5:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101aa9:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101aad:	ee                   	out    %al,(%dx)
  101aae:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101ab4:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
  101ab8:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101abc:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101ac0:	ee                   	out    %al,(%dx)
  101ac1:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101ac7:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
  101acb:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101acf:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101ad3:	ee                   	out    %al,(%dx)
  101ad4:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101ada:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
  101ade:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101ae2:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101ae6:	ee                   	out    %al,(%dx)
  101ae7:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101aed:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
  101af1:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101af5:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101af9:	ee                   	out    %al,(%dx)
  101afa:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  101b00:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
  101b04:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101b08:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101b0c:	ee                   	out    %al,(%dx)
  101b0d:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  101b13:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
  101b17:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101b1b:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101b1f:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101b20:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101b27:	66 83 f8 ff          	cmp    $0xffff,%ax
  101b2b:	74 13                	je     101b40 <pic_init+0x145>
        pic_setmask(irq_mask);
  101b2d:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101b34:	0f b7 c0             	movzwl %ax,%eax
  101b37:	50                   	push   %eax
  101b38:	e8 20 fe ff ff       	call   10195d <pic_setmask>
  101b3d:	83 c4 04             	add    $0x4,%esp
    }
}
  101b40:	90                   	nop
  101b41:	c9                   	leave  
  101b42:	c3                   	ret    

00101b43 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101b43:	55                   	push   %ebp
  101b44:	89 e5                	mov    %esp,%ebp
  101b46:	e8 41 e7 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101b4b:	05 05 de 00 00       	add    $0xde05,%eax
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101b50:	fb                   	sti    
    sti();
}
  101b51:	90                   	nop
  101b52:	5d                   	pop    %ebp
  101b53:	c3                   	ret    

00101b54 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101b54:	55                   	push   %ebp
  101b55:	89 e5                	mov    %esp,%ebp
  101b57:	e8 30 e7 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101b5c:	05 f4 dd 00 00       	add    $0xddf4,%eax
}

static inline void
cli(void) {
    asm volatile ("cli");
  101b61:	fa                   	cli    
    cli();
}
  101b62:	90                   	nop
  101b63:	5d                   	pop    %ebp
  101b64:	c3                   	ret    

00101b65 <print_ticks>:
#include <console.h>
#include <kdebug.h>
#include <string.h>
#define TICK_NUM 100

static void print_ticks() {
  101b65:	55                   	push   %ebp
  101b66:	89 e5                	mov    %esp,%ebp
  101b68:	53                   	push   %ebx
  101b69:	83 ec 04             	sub    $0x4,%esp
  101b6c:	e8 1b e7 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101b71:	05 df dd 00 00       	add    $0xdddf,%eax
    cprintf("%d ticks\n",TICK_NUM);
  101b76:	83 ec 08             	sub    $0x8,%esp
  101b79:	6a 64                	push   $0x64
  101b7b:	8d 90 bb 44 ff ff    	lea    -0xbb45(%eax),%edx
  101b81:	52                   	push   %edx
  101b82:	89 c3                	mov    %eax,%ebx
  101b84:	e8 7a e7 ff ff       	call   100303 <cprintf>
  101b89:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101b8c:	90                   	nop
  101b8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101b90:	c9                   	leave  
  101b91:	c3                   	ret    

00101b92 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101b92:	55                   	push   %ebp
  101b93:	89 e5                	mov    %esp,%ebp
  101b95:	83 ec 10             	sub    $0x10,%esp
  101b98:	e8 ef e6 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101b9d:	05 b3 dd 00 00       	add    $0xddb3,%eax
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101ba2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101ba9:	e9 c7 00 00 00       	jmp    101c75 <idt_init+0xe3>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101bae:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101bb4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101bb7:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101bba:	89 d1                	mov    %edx,%ecx
  101bbc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bbf:	66 89 8c d0 f0 07 00 	mov    %cx,0x7f0(%eax,%edx,8)
  101bc6:	00 
  101bc7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bca:	66 c7 84 d0 f2 07 00 	movw   $0x8,0x7f2(%eax,%edx,8)
  101bd1:	00 08 00 
  101bd4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bd7:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101bde:	00 
  101bdf:	83 e1 e0             	and    $0xffffffe0,%ecx
  101be2:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101be9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bec:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101bf3:	00 
  101bf4:	83 e1 1f             	and    $0x1f,%ecx
  101bf7:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101bfe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c01:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c08:	00 
  101c09:	83 e1 f0             	and    $0xfffffff0,%ecx
  101c0c:	83 c9 0e             	or     $0xe,%ecx
  101c0f:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c16:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c19:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c20:	00 
  101c21:	83 e1 ef             	and    $0xffffffef,%ecx
  101c24:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c2b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c2e:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c35:	00 
  101c36:	83 e1 9f             	and    $0xffffff9f,%ecx
  101c39:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c40:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c43:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c4a:	00 
  101c4b:	83 c9 80             	or     $0xffffff80,%ecx
  101c4e:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c55:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101c5b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101c5e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101c61:	c1 ea 10             	shr    $0x10,%edx
  101c64:	89 d1                	mov    %edx,%ecx
  101c66:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c69:	66 89 8c d0 f6 07 00 	mov    %cx,0x7f6(%eax,%edx,8)
  101c70:	00 
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101c71:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101c75:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c78:	81 fa ff 00 00 00    	cmp    $0xff,%edx
  101c7e:	0f 86 2a ff ff ff    	jbe    101bae <idt_init+0x1c>
    }
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101c84:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101c8a:	8b 92 e4 01 00 00    	mov    0x1e4(%edx),%edx
  101c90:	66 89 90 b8 0b 00 00 	mov    %dx,0xbb8(%eax)
  101c97:	66 c7 80 ba 0b 00 00 	movw   $0x8,0xbba(%eax)
  101c9e:	08 00 
  101ca0:	0f b6 90 bc 0b 00 00 	movzbl 0xbbc(%eax),%edx
  101ca7:	83 e2 e0             	and    $0xffffffe0,%edx
  101caa:	88 90 bc 0b 00 00    	mov    %dl,0xbbc(%eax)
  101cb0:	0f b6 90 bc 0b 00 00 	movzbl 0xbbc(%eax),%edx
  101cb7:	83 e2 1f             	and    $0x1f,%edx
  101cba:	88 90 bc 0b 00 00    	mov    %dl,0xbbc(%eax)
  101cc0:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101cc7:	83 e2 f0             	and    $0xfffffff0,%edx
  101cca:	83 ca 0e             	or     $0xe,%edx
  101ccd:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101cd3:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101cda:	83 e2 ef             	and    $0xffffffef,%edx
  101cdd:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101ce3:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101cea:	83 ca 60             	or     $0x60,%edx
  101ced:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101cf3:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101cfa:	83 ca 80             	or     $0xffffff80,%edx
  101cfd:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101d03:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101d09:	8b 92 e4 01 00 00    	mov    0x1e4(%edx),%edx
  101d0f:	c1 ea 10             	shr    $0x10,%edx
  101d12:	66 89 90 be 0b 00 00 	mov    %dx,0xbbe(%eax)
  101d19:	8d 80 50 00 00 00    	lea    0x50(%eax),%eax
  101d1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101d22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101d25:	0f 01 18             	lidtl  (%eax)
	// load the IDT
    lidt(&idt_pd);
}
  101d28:	90                   	nop
  101d29:	c9                   	leave  
  101d2a:	c3                   	ret    

00101d2b <trapname>:

static const char *
trapname(int trapno) {
  101d2b:	55                   	push   %ebp
  101d2c:	89 e5                	mov    %esp,%ebp
  101d2e:	e8 59 e5 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101d33:	05 1d dc 00 00       	add    $0xdc1d,%eax
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101d38:	8b 55 08             	mov    0x8(%ebp),%edx
  101d3b:	83 fa 13             	cmp    $0x13,%edx
  101d3e:	77 0c                	ja     101d4c <trapname+0x21>
        return excnames[trapno];
  101d40:	8b 55 08             	mov    0x8(%ebp),%edx
  101d43:	8b 84 90 f0 00 00 00 	mov    0xf0(%eax,%edx,4),%eax
  101d4a:	eb 1a                	jmp    101d66 <trapname+0x3b>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101d4c:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101d50:	7e 0e                	jle    101d60 <trapname+0x35>
  101d52:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101d56:	7f 08                	jg     101d60 <trapname+0x35>
        return "Hardware Interrupt";
  101d58:	8d 80 c5 44 ff ff    	lea    -0xbb3b(%eax),%eax
  101d5e:	eb 06                	jmp    101d66 <trapname+0x3b>
    }
    return "(unknown trap)";
  101d60:	8d 80 d8 44 ff ff    	lea    -0xbb28(%eax),%eax
}
  101d66:	5d                   	pop    %ebp
  101d67:	c3                   	ret    

00101d68 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101d68:	55                   	push   %ebp
  101d69:	89 e5                	mov    %esp,%ebp
  101d6b:	e8 1c e5 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  101d70:	05 e0 db 00 00       	add    $0xdbe0,%eax
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101d75:	8b 45 08             	mov    0x8(%ebp),%eax
  101d78:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d7c:	66 83 f8 08          	cmp    $0x8,%ax
  101d80:	0f 94 c0             	sete   %al
  101d83:	0f b6 c0             	movzbl %al,%eax
}
  101d86:	5d                   	pop    %ebp
  101d87:	c3                   	ret    

00101d88 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101d88:	55                   	push   %ebp
  101d89:	89 e5                	mov    %esp,%ebp
  101d8b:	53                   	push   %ebx
  101d8c:	83 ec 14             	sub    $0x14,%esp
  101d8f:	e8 fc e4 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  101d94:	81 c3 bc db 00 00    	add    $0xdbbc,%ebx
    cprintf("trapframe at %p\n", tf);
  101d9a:	83 ec 08             	sub    $0x8,%esp
  101d9d:	ff 75 08             	pushl  0x8(%ebp)
  101da0:	8d 83 19 45 ff ff    	lea    -0xbae7(%ebx),%eax
  101da6:	50                   	push   %eax
  101da7:	e8 57 e5 ff ff       	call   100303 <cprintf>
  101dac:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101daf:	8b 45 08             	mov    0x8(%ebp),%eax
  101db2:	83 ec 0c             	sub    $0xc,%esp
  101db5:	50                   	push   %eax
  101db6:	e8 d3 01 00 00       	call   101f8e <print_regs>
  101dbb:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  101dc1:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101dc5:	0f b7 c0             	movzwl %ax,%eax
  101dc8:	83 ec 08             	sub    $0x8,%esp
  101dcb:	50                   	push   %eax
  101dcc:	8d 83 2a 45 ff ff    	lea    -0xbad6(%ebx),%eax
  101dd2:	50                   	push   %eax
  101dd3:	e8 2b e5 ff ff       	call   100303 <cprintf>
  101dd8:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  101dde:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101de2:	0f b7 c0             	movzwl %ax,%eax
  101de5:	83 ec 08             	sub    $0x8,%esp
  101de8:	50                   	push   %eax
  101de9:	8d 83 3d 45 ff ff    	lea    -0xbac3(%ebx),%eax
  101def:	50                   	push   %eax
  101df0:	e8 0e e5 ff ff       	call   100303 <cprintf>
  101df5:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101df8:	8b 45 08             	mov    0x8(%ebp),%eax
  101dfb:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101dff:	0f b7 c0             	movzwl %ax,%eax
  101e02:	83 ec 08             	sub    $0x8,%esp
  101e05:	50                   	push   %eax
  101e06:	8d 83 50 45 ff ff    	lea    -0xbab0(%ebx),%eax
  101e0c:	50                   	push   %eax
  101e0d:	e8 f1 e4 ff ff       	call   100303 <cprintf>
  101e12:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101e15:	8b 45 08             	mov    0x8(%ebp),%eax
  101e18:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101e1c:	0f b7 c0             	movzwl %ax,%eax
  101e1f:	83 ec 08             	sub    $0x8,%esp
  101e22:	50                   	push   %eax
  101e23:	8d 83 63 45 ff ff    	lea    -0xba9d(%ebx),%eax
  101e29:	50                   	push   %eax
  101e2a:	e8 d4 e4 ff ff       	call   100303 <cprintf>
  101e2f:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101e32:	8b 45 08             	mov    0x8(%ebp),%eax
  101e35:	8b 40 30             	mov    0x30(%eax),%eax
  101e38:	83 ec 0c             	sub    $0xc,%esp
  101e3b:	50                   	push   %eax
  101e3c:	e8 ea fe ff ff       	call   101d2b <trapname>
  101e41:	83 c4 10             	add    $0x10,%esp
  101e44:	89 c2                	mov    %eax,%edx
  101e46:	8b 45 08             	mov    0x8(%ebp),%eax
  101e49:	8b 40 30             	mov    0x30(%eax),%eax
  101e4c:	83 ec 04             	sub    $0x4,%esp
  101e4f:	52                   	push   %edx
  101e50:	50                   	push   %eax
  101e51:	8d 83 76 45 ff ff    	lea    -0xba8a(%ebx),%eax
  101e57:	50                   	push   %eax
  101e58:	e8 a6 e4 ff ff       	call   100303 <cprintf>
  101e5d:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101e60:	8b 45 08             	mov    0x8(%ebp),%eax
  101e63:	8b 40 34             	mov    0x34(%eax),%eax
  101e66:	83 ec 08             	sub    $0x8,%esp
  101e69:	50                   	push   %eax
  101e6a:	8d 83 88 45 ff ff    	lea    -0xba78(%ebx),%eax
  101e70:	50                   	push   %eax
  101e71:	e8 8d e4 ff ff       	call   100303 <cprintf>
  101e76:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101e79:	8b 45 08             	mov    0x8(%ebp),%eax
  101e7c:	8b 40 38             	mov    0x38(%eax),%eax
  101e7f:	83 ec 08             	sub    $0x8,%esp
  101e82:	50                   	push   %eax
  101e83:	8d 83 97 45 ff ff    	lea    -0xba69(%ebx),%eax
  101e89:	50                   	push   %eax
  101e8a:	e8 74 e4 ff ff       	call   100303 <cprintf>
  101e8f:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101e92:	8b 45 08             	mov    0x8(%ebp),%eax
  101e95:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e99:	0f b7 c0             	movzwl %ax,%eax
  101e9c:	83 ec 08             	sub    $0x8,%esp
  101e9f:	50                   	push   %eax
  101ea0:	8d 83 a6 45 ff ff    	lea    -0xba5a(%ebx),%eax
  101ea6:	50                   	push   %eax
  101ea7:	e8 57 e4 ff ff       	call   100303 <cprintf>
  101eac:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb2:	8b 40 40             	mov    0x40(%eax),%eax
  101eb5:	83 ec 08             	sub    $0x8,%esp
  101eb8:	50                   	push   %eax
  101eb9:	8d 83 b9 45 ff ff    	lea    -0xba47(%ebx),%eax
  101ebf:	50                   	push   %eax
  101ec0:	e8 3e e4 ff ff       	call   100303 <cprintf>
  101ec5:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101ec8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101ecf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101ed6:	eb 41                	jmp    101f19 <print_trapframe+0x191>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  101edb:	8b 50 40             	mov    0x40(%eax),%edx
  101ede:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101ee1:	21 d0                	and    %edx,%eax
  101ee3:	85 c0                	test   %eax,%eax
  101ee5:	74 2b                	je     101f12 <print_trapframe+0x18a>
  101ee7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101eea:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101ef1:	85 c0                	test   %eax,%eax
  101ef3:	74 1d                	je     101f12 <print_trapframe+0x18a>
            cprintf("%s,", IA32flags[i]);
  101ef5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ef8:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101eff:	83 ec 08             	sub    $0x8,%esp
  101f02:	50                   	push   %eax
  101f03:	8d 83 c8 45 ff ff    	lea    -0xba38(%ebx),%eax
  101f09:	50                   	push   %eax
  101f0a:	e8 f4 e3 ff ff       	call   100303 <cprintf>
  101f0f:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101f12:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101f16:	d1 65 f0             	shll   -0x10(%ebp)
  101f19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f1c:	83 f8 17             	cmp    $0x17,%eax
  101f1f:	76 b7                	jbe    101ed8 <print_trapframe+0x150>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101f21:	8b 45 08             	mov    0x8(%ebp),%eax
  101f24:	8b 40 40             	mov    0x40(%eax),%eax
  101f27:	c1 e8 0c             	shr    $0xc,%eax
  101f2a:	83 e0 03             	and    $0x3,%eax
  101f2d:	83 ec 08             	sub    $0x8,%esp
  101f30:	50                   	push   %eax
  101f31:	8d 83 cc 45 ff ff    	lea    -0xba34(%ebx),%eax
  101f37:	50                   	push   %eax
  101f38:	e8 c6 e3 ff ff       	call   100303 <cprintf>
  101f3d:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101f40:	83 ec 0c             	sub    $0xc,%esp
  101f43:	ff 75 08             	pushl  0x8(%ebp)
  101f46:	e8 1d fe ff ff       	call   101d68 <trap_in_kernel>
  101f4b:	83 c4 10             	add    $0x10,%esp
  101f4e:	85 c0                	test   %eax,%eax
  101f50:	75 36                	jne    101f88 <print_trapframe+0x200>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101f52:	8b 45 08             	mov    0x8(%ebp),%eax
  101f55:	8b 40 44             	mov    0x44(%eax),%eax
  101f58:	83 ec 08             	sub    $0x8,%esp
  101f5b:	50                   	push   %eax
  101f5c:	8d 83 d5 45 ff ff    	lea    -0xba2b(%ebx),%eax
  101f62:	50                   	push   %eax
  101f63:	e8 9b e3 ff ff       	call   100303 <cprintf>
  101f68:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f6e:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101f72:	0f b7 c0             	movzwl %ax,%eax
  101f75:	83 ec 08             	sub    $0x8,%esp
  101f78:	50                   	push   %eax
  101f79:	8d 83 e4 45 ff ff    	lea    -0xba1c(%ebx),%eax
  101f7f:	50                   	push   %eax
  101f80:	e8 7e e3 ff ff       	call   100303 <cprintf>
  101f85:	83 c4 10             	add    $0x10,%esp
    }
}
  101f88:	90                   	nop
  101f89:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101f8c:	c9                   	leave  
  101f8d:	c3                   	ret    

00101f8e <print_regs>:

void
print_regs(struct pushregs *regs) {
  101f8e:	55                   	push   %ebp
  101f8f:	89 e5                	mov    %esp,%ebp
  101f91:	53                   	push   %ebx
  101f92:	83 ec 04             	sub    $0x4,%esp
  101f95:	e8 f6 e2 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  101f9a:	81 c3 b6 d9 00 00    	add    $0xd9b6,%ebx
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  101fa3:	8b 00                	mov    (%eax),%eax
  101fa5:	83 ec 08             	sub    $0x8,%esp
  101fa8:	50                   	push   %eax
  101fa9:	8d 83 f7 45 ff ff    	lea    -0xba09(%ebx),%eax
  101faf:	50                   	push   %eax
  101fb0:	e8 4e e3 ff ff       	call   100303 <cprintf>
  101fb5:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  101fbb:	8b 40 04             	mov    0x4(%eax),%eax
  101fbe:	83 ec 08             	sub    $0x8,%esp
  101fc1:	50                   	push   %eax
  101fc2:	8d 83 06 46 ff ff    	lea    -0xb9fa(%ebx),%eax
  101fc8:	50                   	push   %eax
  101fc9:	e8 35 e3 ff ff       	call   100303 <cprintf>
  101fce:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  101fd4:	8b 40 08             	mov    0x8(%eax),%eax
  101fd7:	83 ec 08             	sub    $0x8,%esp
  101fda:	50                   	push   %eax
  101fdb:	8d 83 15 46 ff ff    	lea    -0xb9eb(%ebx),%eax
  101fe1:	50                   	push   %eax
  101fe2:	e8 1c e3 ff ff       	call   100303 <cprintf>
  101fe7:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101fea:	8b 45 08             	mov    0x8(%ebp),%eax
  101fed:	8b 40 0c             	mov    0xc(%eax),%eax
  101ff0:	83 ec 08             	sub    $0x8,%esp
  101ff3:	50                   	push   %eax
  101ff4:	8d 83 24 46 ff ff    	lea    -0xb9dc(%ebx),%eax
  101ffa:	50                   	push   %eax
  101ffb:	e8 03 e3 ff ff       	call   100303 <cprintf>
  102000:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  102003:	8b 45 08             	mov    0x8(%ebp),%eax
  102006:	8b 40 10             	mov    0x10(%eax),%eax
  102009:	83 ec 08             	sub    $0x8,%esp
  10200c:	50                   	push   %eax
  10200d:	8d 83 33 46 ff ff    	lea    -0xb9cd(%ebx),%eax
  102013:	50                   	push   %eax
  102014:	e8 ea e2 ff ff       	call   100303 <cprintf>
  102019:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  10201c:	8b 45 08             	mov    0x8(%ebp),%eax
  10201f:	8b 40 14             	mov    0x14(%eax),%eax
  102022:	83 ec 08             	sub    $0x8,%esp
  102025:	50                   	push   %eax
  102026:	8d 83 42 46 ff ff    	lea    -0xb9be(%ebx),%eax
  10202c:	50                   	push   %eax
  10202d:	e8 d1 e2 ff ff       	call   100303 <cprintf>
  102032:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  102035:	8b 45 08             	mov    0x8(%ebp),%eax
  102038:	8b 40 18             	mov    0x18(%eax),%eax
  10203b:	83 ec 08             	sub    $0x8,%esp
  10203e:	50                   	push   %eax
  10203f:	8d 83 51 46 ff ff    	lea    -0xb9af(%ebx),%eax
  102045:	50                   	push   %eax
  102046:	e8 b8 e2 ff ff       	call   100303 <cprintf>
  10204b:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  10204e:	8b 45 08             	mov    0x8(%ebp),%eax
  102051:	8b 40 1c             	mov    0x1c(%eax),%eax
  102054:	83 ec 08             	sub    $0x8,%esp
  102057:	50                   	push   %eax
  102058:	8d 83 60 46 ff ff    	lea    -0xb9a0(%ebx),%eax
  10205e:	50                   	push   %eax
  10205f:	e8 9f e2 ff ff       	call   100303 <cprintf>
  102064:	83 c4 10             	add    $0x10,%esp
}
  102067:	90                   	nop
  102068:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10206b:	c9                   	leave  
  10206c:	c3                   	ret    

0010206d <trap_dispatch>:
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  10206d:	55                   	push   %ebp
  10206e:	89 e5                	mov    %esp,%ebp
  102070:	57                   	push   %edi
  102071:	56                   	push   %esi
  102072:	53                   	push   %ebx
  102073:	83 ec 1c             	sub    $0x1c,%esp
  102076:	e8 15 e2 ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  10207b:	81 c3 d5 d8 00 00    	add    $0xd8d5,%ebx
    char c;

    switch (tf->tf_trapno) {
  102081:	8b 45 08             	mov    0x8(%ebp),%eax
  102084:	8b 40 30             	mov    0x30(%eax),%eax
  102087:	83 f8 2f             	cmp    $0x2f,%eax
  10208a:	77 21                	ja     1020ad <trap_dispatch+0x40>
  10208c:	83 f8 2e             	cmp    $0x2e,%eax
  10208f:	0f 83 3b 02 00 00    	jae    1022d0 <trap_dispatch+0x263>
  102095:	83 f8 21             	cmp    $0x21,%eax
  102098:	0f 84 91 00 00 00    	je     10212f <trap_dispatch+0xc2>
  10209e:	83 f8 24             	cmp    $0x24,%eax
  1020a1:	74 63                	je     102106 <trap_dispatch+0x99>
  1020a3:	83 f8 20             	cmp    $0x20,%eax
  1020a6:	74 1c                	je     1020c4 <trap_dispatch+0x57>
  1020a8:	e9 e9 01 00 00       	jmp    102296 <trap_dispatch+0x229>
  1020ad:	83 f8 78             	cmp    $0x78,%eax
  1020b0:	0f 84 a2 00 00 00    	je     102158 <trap_dispatch+0xeb>
  1020b6:	83 f8 79             	cmp    $0x79,%eax
  1020b9:	0f 84 57 01 00 00    	je     102216 <trap_dispatch+0x1a9>
  1020bf:	e9 d2 01 00 00       	jmp    102296 <trap_dispatch+0x229>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
  1020c4:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  1020ca:	8b 00                	mov    (%eax),%eax
  1020cc:	8d 50 01             	lea    0x1(%eax),%edx
  1020cf:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  1020d5:	89 10                	mov    %edx,(%eax)
        if (ticks % TICK_NUM == 0) {
  1020d7:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  1020dd:	8b 08                	mov    (%eax),%ecx
  1020df:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  1020e4:	89 c8                	mov    %ecx,%eax
  1020e6:	f7 e2                	mul    %edx
  1020e8:	89 d0                	mov    %edx,%eax
  1020ea:	c1 e8 05             	shr    $0x5,%eax
  1020ed:	6b c0 64             	imul   $0x64,%eax,%eax
  1020f0:	29 c1                	sub    %eax,%ecx
  1020f2:	89 c8                	mov    %ecx,%eax
  1020f4:	85 c0                	test   %eax,%eax
  1020f6:	0f 85 d7 01 00 00    	jne    1022d3 <trap_dispatch+0x266>
            print_ticks();
  1020fc:	e8 64 fa ff ff       	call   101b65 <print_ticks>
        }
        break;
  102101:	e9 cd 01 00 00       	jmp    1022d3 <trap_dispatch+0x266>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  102106:	e8 de f7 ff ff       	call   1018e9 <cons_getc>
  10210b:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  10210e:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  102112:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  102116:	83 ec 04             	sub    $0x4,%esp
  102119:	52                   	push   %edx
  10211a:	50                   	push   %eax
  10211b:	8d 83 6f 46 ff ff    	lea    -0xb991(%ebx),%eax
  102121:	50                   	push   %eax
  102122:	e8 dc e1 ff ff       	call   100303 <cprintf>
  102127:	83 c4 10             	add    $0x10,%esp
        break;
  10212a:	e9 ab 01 00 00       	jmp    1022da <trap_dispatch+0x26d>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  10212f:	e8 b5 f7 ff ff       	call   1018e9 <cons_getc>
  102134:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  102137:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  10213b:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  10213f:	83 ec 04             	sub    $0x4,%esp
  102142:	52                   	push   %edx
  102143:	50                   	push   %eax
  102144:	8d 83 81 46 ff ff    	lea    -0xb97f(%ebx),%eax
  10214a:	50                   	push   %eax
  10214b:	e8 b3 e1 ff ff       	call   100303 <cprintf>
  102150:	83 c4 10             	add    $0x10,%esp
        break;
  102153:	e9 82 01 00 00       	jmp    1022da <trap_dispatch+0x26d>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  102158:	8b 45 08             	mov    0x8(%ebp),%eax
  10215b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  10215f:	66 83 f8 1b          	cmp    $0x1b,%ax
  102163:	0f 84 6d 01 00 00    	je     1022d6 <trap_dispatch+0x269>
            switchk2u = *tf;
  102169:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  10216f:	8b 55 08             	mov    0x8(%ebp),%edx
  102172:	89 d6                	mov    %edx,%esi
  102174:	ba 4c 00 00 00       	mov    $0x4c,%edx
  102179:	8b 0e                	mov    (%esi),%ecx
  10217b:	89 08                	mov    %ecx,(%eax)
  10217d:	8b 4c 16 fc          	mov    -0x4(%esi,%edx,1),%ecx
  102181:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
  102185:	8d 78 04             	lea    0x4(%eax),%edi
  102188:	83 e7 fc             	and    $0xfffffffc,%edi
  10218b:	29 f8                	sub    %edi,%eax
  10218d:	29 c6                	sub    %eax,%esi
  10218f:	01 c2                	add    %eax,%edx
  102191:	83 e2 fc             	and    $0xfffffffc,%edx
  102194:	89 d0                	mov    %edx,%eax
  102196:	c1 e8 02             	shr    $0x2,%eax
  102199:	89 c1                	mov    %eax,%ecx
  10219b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            switchk2u.tf_cs = USER_CS;
  10219d:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021a3:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  1021a9:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021af:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  1021b5:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021bb:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  1021bf:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021c5:	66 89 50 28          	mov    %dx,0x28(%eax)
  1021c9:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021cf:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  1021d3:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021d9:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  1021dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1021e0:	8d 50 44             	lea    0x44(%eax),%edx
  1021e3:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021e9:	89 50 44             	mov    %edx,0x44(%eax)
		
            // set eflags, make sure ucore can use io under user mode.
            // if CPL > IOPL, then cpu will generate a general protection.
            switchk2u.tf_eflags |= FL_IOPL_MASK;
  1021ec:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021f2:	8b 40 40             	mov    0x40(%eax),%eax
  1021f5:	80 cc 30             	or     $0x30,%ah
  1021f8:	89 c2                	mov    %eax,%edx
  1021fa:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  102200:	89 50 40             	mov    %edx,0x40(%eax)
		
            // set temporary stack
            // then iret will jump to the right stack
            *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  102203:	8b 45 08             	mov    0x8(%ebp),%eax
  102206:	83 e8 04             	sub    $0x4,%eax
  102209:	c7 c2 c0 09 11 00    	mov    $0x1109c0,%edx
  10220f:	89 10                	mov    %edx,(%eax)
        }
        break;
  102211:	e9 c0 00 00 00       	jmp    1022d6 <trap_dispatch+0x269>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  102216:	8b 45 08             	mov    0x8(%ebp),%eax
  102219:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  10221d:	66 83 f8 08          	cmp    $0x8,%ax
  102221:	0f 84 b2 00 00 00    	je     1022d9 <trap_dispatch+0x26c>
            tf->tf_cs = KERNEL_CS;
  102227:	8b 45 08             	mov    0x8(%ebp),%eax
  10222a:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  102230:	8b 45 08             	mov    0x8(%ebp),%eax
  102233:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  102239:	8b 45 08             	mov    0x8(%ebp),%eax
  10223c:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  102240:	8b 45 08             	mov    0x8(%ebp),%eax
  102243:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  102247:	8b 45 08             	mov    0x8(%ebp),%eax
  10224a:	8b 40 40             	mov    0x40(%eax),%eax
  10224d:	80 e4 cf             	and    $0xcf,%ah
  102250:	89 c2                	mov    %eax,%edx
  102252:	8b 45 08             	mov    0x8(%ebp),%eax
  102255:	89 50 40             	mov    %edx,0x40(%eax)
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  102258:	8b 45 08             	mov    0x8(%ebp),%eax
  10225b:	8b 40 44             	mov    0x44(%eax),%eax
  10225e:	83 e8 44             	sub    $0x44,%eax
  102261:	89 c2                	mov    %eax,%edx
  102263:	c7 c0 0c 0a 11 00    	mov    $0x110a0c,%eax
  102269:	89 10                	mov    %edx,(%eax)
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  10226b:	c7 c0 0c 0a 11 00    	mov    $0x110a0c,%eax
  102271:	8b 00                	mov    (%eax),%eax
  102273:	83 ec 04             	sub    $0x4,%esp
  102276:	6a 44                	push   $0x44
  102278:	ff 75 08             	pushl  0x8(%ebp)
  10227b:	50                   	push   %eax
  10227c:	e8 60 10 00 00       	call   1032e1 <memmove>
  102281:	83 c4 10             	add    $0x10,%esp
            *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  102284:	c7 c0 0c 0a 11 00    	mov    $0x110a0c,%eax
  10228a:	8b 10                	mov    (%eax),%edx
  10228c:	8b 45 08             	mov    0x8(%ebp),%eax
  10228f:	83 e8 04             	sub    $0x4,%eax
  102292:	89 10                	mov    %edx,(%eax)
        }
        break;
  102294:	eb 43                	jmp    1022d9 <trap_dispatch+0x26c>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  102296:	8b 45 08             	mov    0x8(%ebp),%eax
  102299:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  10229d:	0f b7 c0             	movzwl %ax,%eax
  1022a0:	83 e0 03             	and    $0x3,%eax
  1022a3:	85 c0                	test   %eax,%eax
  1022a5:	75 33                	jne    1022da <trap_dispatch+0x26d>
            print_trapframe(tf);
  1022a7:	83 ec 0c             	sub    $0xc,%esp
  1022aa:	ff 75 08             	pushl  0x8(%ebp)
  1022ad:	e8 d6 fa ff ff       	call   101d88 <print_trapframe>
  1022b2:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  1022b5:	83 ec 04             	sub    $0x4,%esp
  1022b8:	8d 83 90 46 ff ff    	lea    -0xb970(%ebx),%eax
  1022be:	50                   	push   %eax
  1022bf:	68 d2 00 00 00       	push   $0xd2
  1022c4:	8d 83 ac 46 ff ff    	lea    -0xb954(%ebx),%eax
  1022ca:	50                   	push   %eax
  1022cb:	e8 e3 e1 ff ff       	call   1004b3 <__panic>
        break;
  1022d0:	90                   	nop
  1022d1:	eb 07                	jmp    1022da <trap_dispatch+0x26d>
        break;
  1022d3:	90                   	nop
  1022d4:	eb 04                	jmp    1022da <trap_dispatch+0x26d>
        break;
  1022d6:	90                   	nop
  1022d7:	eb 01                	jmp    1022da <trap_dispatch+0x26d>
        break;
  1022d9:	90                   	nop
        }
    }
}
  1022da:	90                   	nop
  1022db:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1022de:	5b                   	pop    %ebx
  1022df:	5e                   	pop    %esi
  1022e0:	5f                   	pop    %edi
  1022e1:	5d                   	pop    %ebp
  1022e2:	c3                   	ret    

001022e3 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  1022e3:	55                   	push   %ebp
  1022e4:	89 e5                	mov    %esp,%ebp
  1022e6:	83 ec 08             	sub    $0x8,%esp
  1022e9:	e8 9e df ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1022ee:	05 62 d6 00 00       	add    $0xd662,%eax
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  1022f3:	83 ec 0c             	sub    $0xc,%esp
  1022f6:	ff 75 08             	pushl  0x8(%ebp)
  1022f9:	e8 6f fd ff ff       	call   10206d <trap_dispatch>
  1022fe:	83 c4 10             	add    $0x10,%esp
}
  102301:	90                   	nop
  102302:	c9                   	leave  
  102303:	c3                   	ret    

00102304 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  102304:	6a 00                	push   $0x0
  pushl $0
  102306:	6a 00                	push   $0x0
  jmp __alltraps
  102308:	e9 67 0a 00 00       	jmp    102d74 <__alltraps>

0010230d <vector1>:
.globl vector1
vector1:
  pushl $0
  10230d:	6a 00                	push   $0x0
  pushl $1
  10230f:	6a 01                	push   $0x1
  jmp __alltraps
  102311:	e9 5e 0a 00 00       	jmp    102d74 <__alltraps>

00102316 <vector2>:
.globl vector2
vector2:
  pushl $0
  102316:	6a 00                	push   $0x0
  pushl $2
  102318:	6a 02                	push   $0x2
  jmp __alltraps
  10231a:	e9 55 0a 00 00       	jmp    102d74 <__alltraps>

0010231f <vector3>:
.globl vector3
vector3:
  pushl $0
  10231f:	6a 00                	push   $0x0
  pushl $3
  102321:	6a 03                	push   $0x3
  jmp __alltraps
  102323:	e9 4c 0a 00 00       	jmp    102d74 <__alltraps>

00102328 <vector4>:
.globl vector4
vector4:
  pushl $0
  102328:	6a 00                	push   $0x0
  pushl $4
  10232a:	6a 04                	push   $0x4
  jmp __alltraps
  10232c:	e9 43 0a 00 00       	jmp    102d74 <__alltraps>

00102331 <vector5>:
.globl vector5
vector5:
  pushl $0
  102331:	6a 00                	push   $0x0
  pushl $5
  102333:	6a 05                	push   $0x5
  jmp __alltraps
  102335:	e9 3a 0a 00 00       	jmp    102d74 <__alltraps>

0010233a <vector6>:
.globl vector6
vector6:
  pushl $0
  10233a:	6a 00                	push   $0x0
  pushl $6
  10233c:	6a 06                	push   $0x6
  jmp __alltraps
  10233e:	e9 31 0a 00 00       	jmp    102d74 <__alltraps>

00102343 <vector7>:
.globl vector7
vector7:
  pushl $0
  102343:	6a 00                	push   $0x0
  pushl $7
  102345:	6a 07                	push   $0x7
  jmp __alltraps
  102347:	e9 28 0a 00 00       	jmp    102d74 <__alltraps>

0010234c <vector8>:
.globl vector8
vector8:
  pushl $8
  10234c:	6a 08                	push   $0x8
  jmp __alltraps
  10234e:	e9 21 0a 00 00       	jmp    102d74 <__alltraps>

00102353 <vector9>:
.globl vector9
vector9:
  pushl $9
  102353:	6a 09                	push   $0x9
  jmp __alltraps
  102355:	e9 1a 0a 00 00       	jmp    102d74 <__alltraps>

0010235a <vector10>:
.globl vector10
vector10:
  pushl $10
  10235a:	6a 0a                	push   $0xa
  jmp __alltraps
  10235c:	e9 13 0a 00 00       	jmp    102d74 <__alltraps>

00102361 <vector11>:
.globl vector11
vector11:
  pushl $11
  102361:	6a 0b                	push   $0xb
  jmp __alltraps
  102363:	e9 0c 0a 00 00       	jmp    102d74 <__alltraps>

00102368 <vector12>:
.globl vector12
vector12:
  pushl $12
  102368:	6a 0c                	push   $0xc
  jmp __alltraps
  10236a:	e9 05 0a 00 00       	jmp    102d74 <__alltraps>

0010236f <vector13>:
.globl vector13
vector13:
  pushl $13
  10236f:	6a 0d                	push   $0xd
  jmp __alltraps
  102371:	e9 fe 09 00 00       	jmp    102d74 <__alltraps>

00102376 <vector14>:
.globl vector14
vector14:
  pushl $14
  102376:	6a 0e                	push   $0xe
  jmp __alltraps
  102378:	e9 f7 09 00 00       	jmp    102d74 <__alltraps>

0010237d <vector15>:
.globl vector15
vector15:
  pushl $0
  10237d:	6a 00                	push   $0x0
  pushl $15
  10237f:	6a 0f                	push   $0xf
  jmp __alltraps
  102381:	e9 ee 09 00 00       	jmp    102d74 <__alltraps>

00102386 <vector16>:
.globl vector16
vector16:
  pushl $0
  102386:	6a 00                	push   $0x0
  pushl $16
  102388:	6a 10                	push   $0x10
  jmp __alltraps
  10238a:	e9 e5 09 00 00       	jmp    102d74 <__alltraps>

0010238f <vector17>:
.globl vector17
vector17:
  pushl $17
  10238f:	6a 11                	push   $0x11
  jmp __alltraps
  102391:	e9 de 09 00 00       	jmp    102d74 <__alltraps>

00102396 <vector18>:
.globl vector18
vector18:
  pushl $0
  102396:	6a 00                	push   $0x0
  pushl $18
  102398:	6a 12                	push   $0x12
  jmp __alltraps
  10239a:	e9 d5 09 00 00       	jmp    102d74 <__alltraps>

0010239f <vector19>:
.globl vector19
vector19:
  pushl $0
  10239f:	6a 00                	push   $0x0
  pushl $19
  1023a1:	6a 13                	push   $0x13
  jmp __alltraps
  1023a3:	e9 cc 09 00 00       	jmp    102d74 <__alltraps>

001023a8 <vector20>:
.globl vector20
vector20:
  pushl $0
  1023a8:	6a 00                	push   $0x0
  pushl $20
  1023aa:	6a 14                	push   $0x14
  jmp __alltraps
  1023ac:	e9 c3 09 00 00       	jmp    102d74 <__alltraps>

001023b1 <vector21>:
.globl vector21
vector21:
  pushl $0
  1023b1:	6a 00                	push   $0x0
  pushl $21
  1023b3:	6a 15                	push   $0x15
  jmp __alltraps
  1023b5:	e9 ba 09 00 00       	jmp    102d74 <__alltraps>

001023ba <vector22>:
.globl vector22
vector22:
  pushl $0
  1023ba:	6a 00                	push   $0x0
  pushl $22
  1023bc:	6a 16                	push   $0x16
  jmp __alltraps
  1023be:	e9 b1 09 00 00       	jmp    102d74 <__alltraps>

001023c3 <vector23>:
.globl vector23
vector23:
  pushl $0
  1023c3:	6a 00                	push   $0x0
  pushl $23
  1023c5:	6a 17                	push   $0x17
  jmp __alltraps
  1023c7:	e9 a8 09 00 00       	jmp    102d74 <__alltraps>

001023cc <vector24>:
.globl vector24
vector24:
  pushl $0
  1023cc:	6a 00                	push   $0x0
  pushl $24
  1023ce:	6a 18                	push   $0x18
  jmp __alltraps
  1023d0:	e9 9f 09 00 00       	jmp    102d74 <__alltraps>

001023d5 <vector25>:
.globl vector25
vector25:
  pushl $0
  1023d5:	6a 00                	push   $0x0
  pushl $25
  1023d7:	6a 19                	push   $0x19
  jmp __alltraps
  1023d9:	e9 96 09 00 00       	jmp    102d74 <__alltraps>

001023de <vector26>:
.globl vector26
vector26:
  pushl $0
  1023de:	6a 00                	push   $0x0
  pushl $26
  1023e0:	6a 1a                	push   $0x1a
  jmp __alltraps
  1023e2:	e9 8d 09 00 00       	jmp    102d74 <__alltraps>

001023e7 <vector27>:
.globl vector27
vector27:
  pushl $0
  1023e7:	6a 00                	push   $0x0
  pushl $27
  1023e9:	6a 1b                	push   $0x1b
  jmp __alltraps
  1023eb:	e9 84 09 00 00       	jmp    102d74 <__alltraps>

001023f0 <vector28>:
.globl vector28
vector28:
  pushl $0
  1023f0:	6a 00                	push   $0x0
  pushl $28
  1023f2:	6a 1c                	push   $0x1c
  jmp __alltraps
  1023f4:	e9 7b 09 00 00       	jmp    102d74 <__alltraps>

001023f9 <vector29>:
.globl vector29
vector29:
  pushl $0
  1023f9:	6a 00                	push   $0x0
  pushl $29
  1023fb:	6a 1d                	push   $0x1d
  jmp __alltraps
  1023fd:	e9 72 09 00 00       	jmp    102d74 <__alltraps>

00102402 <vector30>:
.globl vector30
vector30:
  pushl $0
  102402:	6a 00                	push   $0x0
  pushl $30
  102404:	6a 1e                	push   $0x1e
  jmp __alltraps
  102406:	e9 69 09 00 00       	jmp    102d74 <__alltraps>

0010240b <vector31>:
.globl vector31
vector31:
  pushl $0
  10240b:	6a 00                	push   $0x0
  pushl $31
  10240d:	6a 1f                	push   $0x1f
  jmp __alltraps
  10240f:	e9 60 09 00 00       	jmp    102d74 <__alltraps>

00102414 <vector32>:
.globl vector32
vector32:
  pushl $0
  102414:	6a 00                	push   $0x0
  pushl $32
  102416:	6a 20                	push   $0x20
  jmp __alltraps
  102418:	e9 57 09 00 00       	jmp    102d74 <__alltraps>

0010241d <vector33>:
.globl vector33
vector33:
  pushl $0
  10241d:	6a 00                	push   $0x0
  pushl $33
  10241f:	6a 21                	push   $0x21
  jmp __alltraps
  102421:	e9 4e 09 00 00       	jmp    102d74 <__alltraps>

00102426 <vector34>:
.globl vector34
vector34:
  pushl $0
  102426:	6a 00                	push   $0x0
  pushl $34
  102428:	6a 22                	push   $0x22
  jmp __alltraps
  10242a:	e9 45 09 00 00       	jmp    102d74 <__alltraps>

0010242f <vector35>:
.globl vector35
vector35:
  pushl $0
  10242f:	6a 00                	push   $0x0
  pushl $35
  102431:	6a 23                	push   $0x23
  jmp __alltraps
  102433:	e9 3c 09 00 00       	jmp    102d74 <__alltraps>

00102438 <vector36>:
.globl vector36
vector36:
  pushl $0
  102438:	6a 00                	push   $0x0
  pushl $36
  10243a:	6a 24                	push   $0x24
  jmp __alltraps
  10243c:	e9 33 09 00 00       	jmp    102d74 <__alltraps>

00102441 <vector37>:
.globl vector37
vector37:
  pushl $0
  102441:	6a 00                	push   $0x0
  pushl $37
  102443:	6a 25                	push   $0x25
  jmp __alltraps
  102445:	e9 2a 09 00 00       	jmp    102d74 <__alltraps>

0010244a <vector38>:
.globl vector38
vector38:
  pushl $0
  10244a:	6a 00                	push   $0x0
  pushl $38
  10244c:	6a 26                	push   $0x26
  jmp __alltraps
  10244e:	e9 21 09 00 00       	jmp    102d74 <__alltraps>

00102453 <vector39>:
.globl vector39
vector39:
  pushl $0
  102453:	6a 00                	push   $0x0
  pushl $39
  102455:	6a 27                	push   $0x27
  jmp __alltraps
  102457:	e9 18 09 00 00       	jmp    102d74 <__alltraps>

0010245c <vector40>:
.globl vector40
vector40:
  pushl $0
  10245c:	6a 00                	push   $0x0
  pushl $40
  10245e:	6a 28                	push   $0x28
  jmp __alltraps
  102460:	e9 0f 09 00 00       	jmp    102d74 <__alltraps>

00102465 <vector41>:
.globl vector41
vector41:
  pushl $0
  102465:	6a 00                	push   $0x0
  pushl $41
  102467:	6a 29                	push   $0x29
  jmp __alltraps
  102469:	e9 06 09 00 00       	jmp    102d74 <__alltraps>

0010246e <vector42>:
.globl vector42
vector42:
  pushl $0
  10246e:	6a 00                	push   $0x0
  pushl $42
  102470:	6a 2a                	push   $0x2a
  jmp __alltraps
  102472:	e9 fd 08 00 00       	jmp    102d74 <__alltraps>

00102477 <vector43>:
.globl vector43
vector43:
  pushl $0
  102477:	6a 00                	push   $0x0
  pushl $43
  102479:	6a 2b                	push   $0x2b
  jmp __alltraps
  10247b:	e9 f4 08 00 00       	jmp    102d74 <__alltraps>

00102480 <vector44>:
.globl vector44
vector44:
  pushl $0
  102480:	6a 00                	push   $0x0
  pushl $44
  102482:	6a 2c                	push   $0x2c
  jmp __alltraps
  102484:	e9 eb 08 00 00       	jmp    102d74 <__alltraps>

00102489 <vector45>:
.globl vector45
vector45:
  pushl $0
  102489:	6a 00                	push   $0x0
  pushl $45
  10248b:	6a 2d                	push   $0x2d
  jmp __alltraps
  10248d:	e9 e2 08 00 00       	jmp    102d74 <__alltraps>

00102492 <vector46>:
.globl vector46
vector46:
  pushl $0
  102492:	6a 00                	push   $0x0
  pushl $46
  102494:	6a 2e                	push   $0x2e
  jmp __alltraps
  102496:	e9 d9 08 00 00       	jmp    102d74 <__alltraps>

0010249b <vector47>:
.globl vector47
vector47:
  pushl $0
  10249b:	6a 00                	push   $0x0
  pushl $47
  10249d:	6a 2f                	push   $0x2f
  jmp __alltraps
  10249f:	e9 d0 08 00 00       	jmp    102d74 <__alltraps>

001024a4 <vector48>:
.globl vector48
vector48:
  pushl $0
  1024a4:	6a 00                	push   $0x0
  pushl $48
  1024a6:	6a 30                	push   $0x30
  jmp __alltraps
  1024a8:	e9 c7 08 00 00       	jmp    102d74 <__alltraps>

001024ad <vector49>:
.globl vector49
vector49:
  pushl $0
  1024ad:	6a 00                	push   $0x0
  pushl $49
  1024af:	6a 31                	push   $0x31
  jmp __alltraps
  1024b1:	e9 be 08 00 00       	jmp    102d74 <__alltraps>

001024b6 <vector50>:
.globl vector50
vector50:
  pushl $0
  1024b6:	6a 00                	push   $0x0
  pushl $50
  1024b8:	6a 32                	push   $0x32
  jmp __alltraps
  1024ba:	e9 b5 08 00 00       	jmp    102d74 <__alltraps>

001024bf <vector51>:
.globl vector51
vector51:
  pushl $0
  1024bf:	6a 00                	push   $0x0
  pushl $51
  1024c1:	6a 33                	push   $0x33
  jmp __alltraps
  1024c3:	e9 ac 08 00 00       	jmp    102d74 <__alltraps>

001024c8 <vector52>:
.globl vector52
vector52:
  pushl $0
  1024c8:	6a 00                	push   $0x0
  pushl $52
  1024ca:	6a 34                	push   $0x34
  jmp __alltraps
  1024cc:	e9 a3 08 00 00       	jmp    102d74 <__alltraps>

001024d1 <vector53>:
.globl vector53
vector53:
  pushl $0
  1024d1:	6a 00                	push   $0x0
  pushl $53
  1024d3:	6a 35                	push   $0x35
  jmp __alltraps
  1024d5:	e9 9a 08 00 00       	jmp    102d74 <__alltraps>

001024da <vector54>:
.globl vector54
vector54:
  pushl $0
  1024da:	6a 00                	push   $0x0
  pushl $54
  1024dc:	6a 36                	push   $0x36
  jmp __alltraps
  1024de:	e9 91 08 00 00       	jmp    102d74 <__alltraps>

001024e3 <vector55>:
.globl vector55
vector55:
  pushl $0
  1024e3:	6a 00                	push   $0x0
  pushl $55
  1024e5:	6a 37                	push   $0x37
  jmp __alltraps
  1024e7:	e9 88 08 00 00       	jmp    102d74 <__alltraps>

001024ec <vector56>:
.globl vector56
vector56:
  pushl $0
  1024ec:	6a 00                	push   $0x0
  pushl $56
  1024ee:	6a 38                	push   $0x38
  jmp __alltraps
  1024f0:	e9 7f 08 00 00       	jmp    102d74 <__alltraps>

001024f5 <vector57>:
.globl vector57
vector57:
  pushl $0
  1024f5:	6a 00                	push   $0x0
  pushl $57
  1024f7:	6a 39                	push   $0x39
  jmp __alltraps
  1024f9:	e9 76 08 00 00       	jmp    102d74 <__alltraps>

001024fe <vector58>:
.globl vector58
vector58:
  pushl $0
  1024fe:	6a 00                	push   $0x0
  pushl $58
  102500:	6a 3a                	push   $0x3a
  jmp __alltraps
  102502:	e9 6d 08 00 00       	jmp    102d74 <__alltraps>

00102507 <vector59>:
.globl vector59
vector59:
  pushl $0
  102507:	6a 00                	push   $0x0
  pushl $59
  102509:	6a 3b                	push   $0x3b
  jmp __alltraps
  10250b:	e9 64 08 00 00       	jmp    102d74 <__alltraps>

00102510 <vector60>:
.globl vector60
vector60:
  pushl $0
  102510:	6a 00                	push   $0x0
  pushl $60
  102512:	6a 3c                	push   $0x3c
  jmp __alltraps
  102514:	e9 5b 08 00 00       	jmp    102d74 <__alltraps>

00102519 <vector61>:
.globl vector61
vector61:
  pushl $0
  102519:	6a 00                	push   $0x0
  pushl $61
  10251b:	6a 3d                	push   $0x3d
  jmp __alltraps
  10251d:	e9 52 08 00 00       	jmp    102d74 <__alltraps>

00102522 <vector62>:
.globl vector62
vector62:
  pushl $0
  102522:	6a 00                	push   $0x0
  pushl $62
  102524:	6a 3e                	push   $0x3e
  jmp __alltraps
  102526:	e9 49 08 00 00       	jmp    102d74 <__alltraps>

0010252b <vector63>:
.globl vector63
vector63:
  pushl $0
  10252b:	6a 00                	push   $0x0
  pushl $63
  10252d:	6a 3f                	push   $0x3f
  jmp __alltraps
  10252f:	e9 40 08 00 00       	jmp    102d74 <__alltraps>

00102534 <vector64>:
.globl vector64
vector64:
  pushl $0
  102534:	6a 00                	push   $0x0
  pushl $64
  102536:	6a 40                	push   $0x40
  jmp __alltraps
  102538:	e9 37 08 00 00       	jmp    102d74 <__alltraps>

0010253d <vector65>:
.globl vector65
vector65:
  pushl $0
  10253d:	6a 00                	push   $0x0
  pushl $65
  10253f:	6a 41                	push   $0x41
  jmp __alltraps
  102541:	e9 2e 08 00 00       	jmp    102d74 <__alltraps>

00102546 <vector66>:
.globl vector66
vector66:
  pushl $0
  102546:	6a 00                	push   $0x0
  pushl $66
  102548:	6a 42                	push   $0x42
  jmp __alltraps
  10254a:	e9 25 08 00 00       	jmp    102d74 <__alltraps>

0010254f <vector67>:
.globl vector67
vector67:
  pushl $0
  10254f:	6a 00                	push   $0x0
  pushl $67
  102551:	6a 43                	push   $0x43
  jmp __alltraps
  102553:	e9 1c 08 00 00       	jmp    102d74 <__alltraps>

00102558 <vector68>:
.globl vector68
vector68:
  pushl $0
  102558:	6a 00                	push   $0x0
  pushl $68
  10255a:	6a 44                	push   $0x44
  jmp __alltraps
  10255c:	e9 13 08 00 00       	jmp    102d74 <__alltraps>

00102561 <vector69>:
.globl vector69
vector69:
  pushl $0
  102561:	6a 00                	push   $0x0
  pushl $69
  102563:	6a 45                	push   $0x45
  jmp __alltraps
  102565:	e9 0a 08 00 00       	jmp    102d74 <__alltraps>

0010256a <vector70>:
.globl vector70
vector70:
  pushl $0
  10256a:	6a 00                	push   $0x0
  pushl $70
  10256c:	6a 46                	push   $0x46
  jmp __alltraps
  10256e:	e9 01 08 00 00       	jmp    102d74 <__alltraps>

00102573 <vector71>:
.globl vector71
vector71:
  pushl $0
  102573:	6a 00                	push   $0x0
  pushl $71
  102575:	6a 47                	push   $0x47
  jmp __alltraps
  102577:	e9 f8 07 00 00       	jmp    102d74 <__alltraps>

0010257c <vector72>:
.globl vector72
vector72:
  pushl $0
  10257c:	6a 00                	push   $0x0
  pushl $72
  10257e:	6a 48                	push   $0x48
  jmp __alltraps
  102580:	e9 ef 07 00 00       	jmp    102d74 <__alltraps>

00102585 <vector73>:
.globl vector73
vector73:
  pushl $0
  102585:	6a 00                	push   $0x0
  pushl $73
  102587:	6a 49                	push   $0x49
  jmp __alltraps
  102589:	e9 e6 07 00 00       	jmp    102d74 <__alltraps>

0010258e <vector74>:
.globl vector74
vector74:
  pushl $0
  10258e:	6a 00                	push   $0x0
  pushl $74
  102590:	6a 4a                	push   $0x4a
  jmp __alltraps
  102592:	e9 dd 07 00 00       	jmp    102d74 <__alltraps>

00102597 <vector75>:
.globl vector75
vector75:
  pushl $0
  102597:	6a 00                	push   $0x0
  pushl $75
  102599:	6a 4b                	push   $0x4b
  jmp __alltraps
  10259b:	e9 d4 07 00 00       	jmp    102d74 <__alltraps>

001025a0 <vector76>:
.globl vector76
vector76:
  pushl $0
  1025a0:	6a 00                	push   $0x0
  pushl $76
  1025a2:	6a 4c                	push   $0x4c
  jmp __alltraps
  1025a4:	e9 cb 07 00 00       	jmp    102d74 <__alltraps>

001025a9 <vector77>:
.globl vector77
vector77:
  pushl $0
  1025a9:	6a 00                	push   $0x0
  pushl $77
  1025ab:	6a 4d                	push   $0x4d
  jmp __alltraps
  1025ad:	e9 c2 07 00 00       	jmp    102d74 <__alltraps>

001025b2 <vector78>:
.globl vector78
vector78:
  pushl $0
  1025b2:	6a 00                	push   $0x0
  pushl $78
  1025b4:	6a 4e                	push   $0x4e
  jmp __alltraps
  1025b6:	e9 b9 07 00 00       	jmp    102d74 <__alltraps>

001025bb <vector79>:
.globl vector79
vector79:
  pushl $0
  1025bb:	6a 00                	push   $0x0
  pushl $79
  1025bd:	6a 4f                	push   $0x4f
  jmp __alltraps
  1025bf:	e9 b0 07 00 00       	jmp    102d74 <__alltraps>

001025c4 <vector80>:
.globl vector80
vector80:
  pushl $0
  1025c4:	6a 00                	push   $0x0
  pushl $80
  1025c6:	6a 50                	push   $0x50
  jmp __alltraps
  1025c8:	e9 a7 07 00 00       	jmp    102d74 <__alltraps>

001025cd <vector81>:
.globl vector81
vector81:
  pushl $0
  1025cd:	6a 00                	push   $0x0
  pushl $81
  1025cf:	6a 51                	push   $0x51
  jmp __alltraps
  1025d1:	e9 9e 07 00 00       	jmp    102d74 <__alltraps>

001025d6 <vector82>:
.globl vector82
vector82:
  pushl $0
  1025d6:	6a 00                	push   $0x0
  pushl $82
  1025d8:	6a 52                	push   $0x52
  jmp __alltraps
  1025da:	e9 95 07 00 00       	jmp    102d74 <__alltraps>

001025df <vector83>:
.globl vector83
vector83:
  pushl $0
  1025df:	6a 00                	push   $0x0
  pushl $83
  1025e1:	6a 53                	push   $0x53
  jmp __alltraps
  1025e3:	e9 8c 07 00 00       	jmp    102d74 <__alltraps>

001025e8 <vector84>:
.globl vector84
vector84:
  pushl $0
  1025e8:	6a 00                	push   $0x0
  pushl $84
  1025ea:	6a 54                	push   $0x54
  jmp __alltraps
  1025ec:	e9 83 07 00 00       	jmp    102d74 <__alltraps>

001025f1 <vector85>:
.globl vector85
vector85:
  pushl $0
  1025f1:	6a 00                	push   $0x0
  pushl $85
  1025f3:	6a 55                	push   $0x55
  jmp __alltraps
  1025f5:	e9 7a 07 00 00       	jmp    102d74 <__alltraps>

001025fa <vector86>:
.globl vector86
vector86:
  pushl $0
  1025fa:	6a 00                	push   $0x0
  pushl $86
  1025fc:	6a 56                	push   $0x56
  jmp __alltraps
  1025fe:	e9 71 07 00 00       	jmp    102d74 <__alltraps>

00102603 <vector87>:
.globl vector87
vector87:
  pushl $0
  102603:	6a 00                	push   $0x0
  pushl $87
  102605:	6a 57                	push   $0x57
  jmp __alltraps
  102607:	e9 68 07 00 00       	jmp    102d74 <__alltraps>

0010260c <vector88>:
.globl vector88
vector88:
  pushl $0
  10260c:	6a 00                	push   $0x0
  pushl $88
  10260e:	6a 58                	push   $0x58
  jmp __alltraps
  102610:	e9 5f 07 00 00       	jmp    102d74 <__alltraps>

00102615 <vector89>:
.globl vector89
vector89:
  pushl $0
  102615:	6a 00                	push   $0x0
  pushl $89
  102617:	6a 59                	push   $0x59
  jmp __alltraps
  102619:	e9 56 07 00 00       	jmp    102d74 <__alltraps>

0010261e <vector90>:
.globl vector90
vector90:
  pushl $0
  10261e:	6a 00                	push   $0x0
  pushl $90
  102620:	6a 5a                	push   $0x5a
  jmp __alltraps
  102622:	e9 4d 07 00 00       	jmp    102d74 <__alltraps>

00102627 <vector91>:
.globl vector91
vector91:
  pushl $0
  102627:	6a 00                	push   $0x0
  pushl $91
  102629:	6a 5b                	push   $0x5b
  jmp __alltraps
  10262b:	e9 44 07 00 00       	jmp    102d74 <__alltraps>

00102630 <vector92>:
.globl vector92
vector92:
  pushl $0
  102630:	6a 00                	push   $0x0
  pushl $92
  102632:	6a 5c                	push   $0x5c
  jmp __alltraps
  102634:	e9 3b 07 00 00       	jmp    102d74 <__alltraps>

00102639 <vector93>:
.globl vector93
vector93:
  pushl $0
  102639:	6a 00                	push   $0x0
  pushl $93
  10263b:	6a 5d                	push   $0x5d
  jmp __alltraps
  10263d:	e9 32 07 00 00       	jmp    102d74 <__alltraps>

00102642 <vector94>:
.globl vector94
vector94:
  pushl $0
  102642:	6a 00                	push   $0x0
  pushl $94
  102644:	6a 5e                	push   $0x5e
  jmp __alltraps
  102646:	e9 29 07 00 00       	jmp    102d74 <__alltraps>

0010264b <vector95>:
.globl vector95
vector95:
  pushl $0
  10264b:	6a 00                	push   $0x0
  pushl $95
  10264d:	6a 5f                	push   $0x5f
  jmp __alltraps
  10264f:	e9 20 07 00 00       	jmp    102d74 <__alltraps>

00102654 <vector96>:
.globl vector96
vector96:
  pushl $0
  102654:	6a 00                	push   $0x0
  pushl $96
  102656:	6a 60                	push   $0x60
  jmp __alltraps
  102658:	e9 17 07 00 00       	jmp    102d74 <__alltraps>

0010265d <vector97>:
.globl vector97
vector97:
  pushl $0
  10265d:	6a 00                	push   $0x0
  pushl $97
  10265f:	6a 61                	push   $0x61
  jmp __alltraps
  102661:	e9 0e 07 00 00       	jmp    102d74 <__alltraps>

00102666 <vector98>:
.globl vector98
vector98:
  pushl $0
  102666:	6a 00                	push   $0x0
  pushl $98
  102668:	6a 62                	push   $0x62
  jmp __alltraps
  10266a:	e9 05 07 00 00       	jmp    102d74 <__alltraps>

0010266f <vector99>:
.globl vector99
vector99:
  pushl $0
  10266f:	6a 00                	push   $0x0
  pushl $99
  102671:	6a 63                	push   $0x63
  jmp __alltraps
  102673:	e9 fc 06 00 00       	jmp    102d74 <__alltraps>

00102678 <vector100>:
.globl vector100
vector100:
  pushl $0
  102678:	6a 00                	push   $0x0
  pushl $100
  10267a:	6a 64                	push   $0x64
  jmp __alltraps
  10267c:	e9 f3 06 00 00       	jmp    102d74 <__alltraps>

00102681 <vector101>:
.globl vector101
vector101:
  pushl $0
  102681:	6a 00                	push   $0x0
  pushl $101
  102683:	6a 65                	push   $0x65
  jmp __alltraps
  102685:	e9 ea 06 00 00       	jmp    102d74 <__alltraps>

0010268a <vector102>:
.globl vector102
vector102:
  pushl $0
  10268a:	6a 00                	push   $0x0
  pushl $102
  10268c:	6a 66                	push   $0x66
  jmp __alltraps
  10268e:	e9 e1 06 00 00       	jmp    102d74 <__alltraps>

00102693 <vector103>:
.globl vector103
vector103:
  pushl $0
  102693:	6a 00                	push   $0x0
  pushl $103
  102695:	6a 67                	push   $0x67
  jmp __alltraps
  102697:	e9 d8 06 00 00       	jmp    102d74 <__alltraps>

0010269c <vector104>:
.globl vector104
vector104:
  pushl $0
  10269c:	6a 00                	push   $0x0
  pushl $104
  10269e:	6a 68                	push   $0x68
  jmp __alltraps
  1026a0:	e9 cf 06 00 00       	jmp    102d74 <__alltraps>

001026a5 <vector105>:
.globl vector105
vector105:
  pushl $0
  1026a5:	6a 00                	push   $0x0
  pushl $105
  1026a7:	6a 69                	push   $0x69
  jmp __alltraps
  1026a9:	e9 c6 06 00 00       	jmp    102d74 <__alltraps>

001026ae <vector106>:
.globl vector106
vector106:
  pushl $0
  1026ae:	6a 00                	push   $0x0
  pushl $106
  1026b0:	6a 6a                	push   $0x6a
  jmp __alltraps
  1026b2:	e9 bd 06 00 00       	jmp    102d74 <__alltraps>

001026b7 <vector107>:
.globl vector107
vector107:
  pushl $0
  1026b7:	6a 00                	push   $0x0
  pushl $107
  1026b9:	6a 6b                	push   $0x6b
  jmp __alltraps
  1026bb:	e9 b4 06 00 00       	jmp    102d74 <__alltraps>

001026c0 <vector108>:
.globl vector108
vector108:
  pushl $0
  1026c0:	6a 00                	push   $0x0
  pushl $108
  1026c2:	6a 6c                	push   $0x6c
  jmp __alltraps
  1026c4:	e9 ab 06 00 00       	jmp    102d74 <__alltraps>

001026c9 <vector109>:
.globl vector109
vector109:
  pushl $0
  1026c9:	6a 00                	push   $0x0
  pushl $109
  1026cb:	6a 6d                	push   $0x6d
  jmp __alltraps
  1026cd:	e9 a2 06 00 00       	jmp    102d74 <__alltraps>

001026d2 <vector110>:
.globl vector110
vector110:
  pushl $0
  1026d2:	6a 00                	push   $0x0
  pushl $110
  1026d4:	6a 6e                	push   $0x6e
  jmp __alltraps
  1026d6:	e9 99 06 00 00       	jmp    102d74 <__alltraps>

001026db <vector111>:
.globl vector111
vector111:
  pushl $0
  1026db:	6a 00                	push   $0x0
  pushl $111
  1026dd:	6a 6f                	push   $0x6f
  jmp __alltraps
  1026df:	e9 90 06 00 00       	jmp    102d74 <__alltraps>

001026e4 <vector112>:
.globl vector112
vector112:
  pushl $0
  1026e4:	6a 00                	push   $0x0
  pushl $112
  1026e6:	6a 70                	push   $0x70
  jmp __alltraps
  1026e8:	e9 87 06 00 00       	jmp    102d74 <__alltraps>

001026ed <vector113>:
.globl vector113
vector113:
  pushl $0
  1026ed:	6a 00                	push   $0x0
  pushl $113
  1026ef:	6a 71                	push   $0x71
  jmp __alltraps
  1026f1:	e9 7e 06 00 00       	jmp    102d74 <__alltraps>

001026f6 <vector114>:
.globl vector114
vector114:
  pushl $0
  1026f6:	6a 00                	push   $0x0
  pushl $114
  1026f8:	6a 72                	push   $0x72
  jmp __alltraps
  1026fa:	e9 75 06 00 00       	jmp    102d74 <__alltraps>

001026ff <vector115>:
.globl vector115
vector115:
  pushl $0
  1026ff:	6a 00                	push   $0x0
  pushl $115
  102701:	6a 73                	push   $0x73
  jmp __alltraps
  102703:	e9 6c 06 00 00       	jmp    102d74 <__alltraps>

00102708 <vector116>:
.globl vector116
vector116:
  pushl $0
  102708:	6a 00                	push   $0x0
  pushl $116
  10270a:	6a 74                	push   $0x74
  jmp __alltraps
  10270c:	e9 63 06 00 00       	jmp    102d74 <__alltraps>

00102711 <vector117>:
.globl vector117
vector117:
  pushl $0
  102711:	6a 00                	push   $0x0
  pushl $117
  102713:	6a 75                	push   $0x75
  jmp __alltraps
  102715:	e9 5a 06 00 00       	jmp    102d74 <__alltraps>

0010271a <vector118>:
.globl vector118
vector118:
  pushl $0
  10271a:	6a 00                	push   $0x0
  pushl $118
  10271c:	6a 76                	push   $0x76
  jmp __alltraps
  10271e:	e9 51 06 00 00       	jmp    102d74 <__alltraps>

00102723 <vector119>:
.globl vector119
vector119:
  pushl $0
  102723:	6a 00                	push   $0x0
  pushl $119
  102725:	6a 77                	push   $0x77
  jmp __alltraps
  102727:	e9 48 06 00 00       	jmp    102d74 <__alltraps>

0010272c <vector120>:
.globl vector120
vector120:
  pushl $0
  10272c:	6a 00                	push   $0x0
  pushl $120
  10272e:	6a 78                	push   $0x78
  jmp __alltraps
  102730:	e9 3f 06 00 00       	jmp    102d74 <__alltraps>

00102735 <vector121>:
.globl vector121
vector121:
  pushl $0
  102735:	6a 00                	push   $0x0
  pushl $121
  102737:	6a 79                	push   $0x79
  jmp __alltraps
  102739:	e9 36 06 00 00       	jmp    102d74 <__alltraps>

0010273e <vector122>:
.globl vector122
vector122:
  pushl $0
  10273e:	6a 00                	push   $0x0
  pushl $122
  102740:	6a 7a                	push   $0x7a
  jmp __alltraps
  102742:	e9 2d 06 00 00       	jmp    102d74 <__alltraps>

00102747 <vector123>:
.globl vector123
vector123:
  pushl $0
  102747:	6a 00                	push   $0x0
  pushl $123
  102749:	6a 7b                	push   $0x7b
  jmp __alltraps
  10274b:	e9 24 06 00 00       	jmp    102d74 <__alltraps>

00102750 <vector124>:
.globl vector124
vector124:
  pushl $0
  102750:	6a 00                	push   $0x0
  pushl $124
  102752:	6a 7c                	push   $0x7c
  jmp __alltraps
  102754:	e9 1b 06 00 00       	jmp    102d74 <__alltraps>

00102759 <vector125>:
.globl vector125
vector125:
  pushl $0
  102759:	6a 00                	push   $0x0
  pushl $125
  10275b:	6a 7d                	push   $0x7d
  jmp __alltraps
  10275d:	e9 12 06 00 00       	jmp    102d74 <__alltraps>

00102762 <vector126>:
.globl vector126
vector126:
  pushl $0
  102762:	6a 00                	push   $0x0
  pushl $126
  102764:	6a 7e                	push   $0x7e
  jmp __alltraps
  102766:	e9 09 06 00 00       	jmp    102d74 <__alltraps>

0010276b <vector127>:
.globl vector127
vector127:
  pushl $0
  10276b:	6a 00                	push   $0x0
  pushl $127
  10276d:	6a 7f                	push   $0x7f
  jmp __alltraps
  10276f:	e9 00 06 00 00       	jmp    102d74 <__alltraps>

00102774 <vector128>:
.globl vector128
vector128:
  pushl $0
  102774:	6a 00                	push   $0x0
  pushl $128
  102776:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10277b:	e9 f4 05 00 00       	jmp    102d74 <__alltraps>

00102780 <vector129>:
.globl vector129
vector129:
  pushl $0
  102780:	6a 00                	push   $0x0
  pushl $129
  102782:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102787:	e9 e8 05 00 00       	jmp    102d74 <__alltraps>

0010278c <vector130>:
.globl vector130
vector130:
  pushl $0
  10278c:	6a 00                	push   $0x0
  pushl $130
  10278e:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102793:	e9 dc 05 00 00       	jmp    102d74 <__alltraps>

00102798 <vector131>:
.globl vector131
vector131:
  pushl $0
  102798:	6a 00                	push   $0x0
  pushl $131
  10279a:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  10279f:	e9 d0 05 00 00       	jmp    102d74 <__alltraps>

001027a4 <vector132>:
.globl vector132
vector132:
  pushl $0
  1027a4:	6a 00                	push   $0x0
  pushl $132
  1027a6:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  1027ab:	e9 c4 05 00 00       	jmp    102d74 <__alltraps>

001027b0 <vector133>:
.globl vector133
vector133:
  pushl $0
  1027b0:	6a 00                	push   $0x0
  pushl $133
  1027b2:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  1027b7:	e9 b8 05 00 00       	jmp    102d74 <__alltraps>

001027bc <vector134>:
.globl vector134
vector134:
  pushl $0
  1027bc:	6a 00                	push   $0x0
  pushl $134
  1027be:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  1027c3:	e9 ac 05 00 00       	jmp    102d74 <__alltraps>

001027c8 <vector135>:
.globl vector135
vector135:
  pushl $0
  1027c8:	6a 00                	push   $0x0
  pushl $135
  1027ca:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1027cf:	e9 a0 05 00 00       	jmp    102d74 <__alltraps>

001027d4 <vector136>:
.globl vector136
vector136:
  pushl $0
  1027d4:	6a 00                	push   $0x0
  pushl $136
  1027d6:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1027db:	e9 94 05 00 00       	jmp    102d74 <__alltraps>

001027e0 <vector137>:
.globl vector137
vector137:
  pushl $0
  1027e0:	6a 00                	push   $0x0
  pushl $137
  1027e2:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1027e7:	e9 88 05 00 00       	jmp    102d74 <__alltraps>

001027ec <vector138>:
.globl vector138
vector138:
  pushl $0
  1027ec:	6a 00                	push   $0x0
  pushl $138
  1027ee:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1027f3:	e9 7c 05 00 00       	jmp    102d74 <__alltraps>

001027f8 <vector139>:
.globl vector139
vector139:
  pushl $0
  1027f8:	6a 00                	push   $0x0
  pushl $139
  1027fa:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1027ff:	e9 70 05 00 00       	jmp    102d74 <__alltraps>

00102804 <vector140>:
.globl vector140
vector140:
  pushl $0
  102804:	6a 00                	push   $0x0
  pushl $140
  102806:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  10280b:	e9 64 05 00 00       	jmp    102d74 <__alltraps>

00102810 <vector141>:
.globl vector141
vector141:
  pushl $0
  102810:	6a 00                	push   $0x0
  pushl $141
  102812:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  102817:	e9 58 05 00 00       	jmp    102d74 <__alltraps>

0010281c <vector142>:
.globl vector142
vector142:
  pushl $0
  10281c:	6a 00                	push   $0x0
  pushl $142
  10281e:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102823:	e9 4c 05 00 00       	jmp    102d74 <__alltraps>

00102828 <vector143>:
.globl vector143
vector143:
  pushl $0
  102828:	6a 00                	push   $0x0
  pushl $143
  10282a:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  10282f:	e9 40 05 00 00       	jmp    102d74 <__alltraps>

00102834 <vector144>:
.globl vector144
vector144:
  pushl $0
  102834:	6a 00                	push   $0x0
  pushl $144
  102836:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10283b:	e9 34 05 00 00       	jmp    102d74 <__alltraps>

00102840 <vector145>:
.globl vector145
vector145:
  pushl $0
  102840:	6a 00                	push   $0x0
  pushl $145
  102842:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102847:	e9 28 05 00 00       	jmp    102d74 <__alltraps>

0010284c <vector146>:
.globl vector146
vector146:
  pushl $0
  10284c:	6a 00                	push   $0x0
  pushl $146
  10284e:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102853:	e9 1c 05 00 00       	jmp    102d74 <__alltraps>

00102858 <vector147>:
.globl vector147
vector147:
  pushl $0
  102858:	6a 00                	push   $0x0
  pushl $147
  10285a:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  10285f:	e9 10 05 00 00       	jmp    102d74 <__alltraps>

00102864 <vector148>:
.globl vector148
vector148:
  pushl $0
  102864:	6a 00                	push   $0x0
  pushl $148
  102866:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10286b:	e9 04 05 00 00       	jmp    102d74 <__alltraps>

00102870 <vector149>:
.globl vector149
vector149:
  pushl $0
  102870:	6a 00                	push   $0x0
  pushl $149
  102872:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102877:	e9 f8 04 00 00       	jmp    102d74 <__alltraps>

0010287c <vector150>:
.globl vector150
vector150:
  pushl $0
  10287c:	6a 00                	push   $0x0
  pushl $150
  10287e:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102883:	e9 ec 04 00 00       	jmp    102d74 <__alltraps>

00102888 <vector151>:
.globl vector151
vector151:
  pushl $0
  102888:	6a 00                	push   $0x0
  pushl $151
  10288a:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10288f:	e9 e0 04 00 00       	jmp    102d74 <__alltraps>

00102894 <vector152>:
.globl vector152
vector152:
  pushl $0
  102894:	6a 00                	push   $0x0
  pushl $152
  102896:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10289b:	e9 d4 04 00 00       	jmp    102d74 <__alltraps>

001028a0 <vector153>:
.globl vector153
vector153:
  pushl $0
  1028a0:	6a 00                	push   $0x0
  pushl $153
  1028a2:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1028a7:	e9 c8 04 00 00       	jmp    102d74 <__alltraps>

001028ac <vector154>:
.globl vector154
vector154:
  pushl $0
  1028ac:	6a 00                	push   $0x0
  pushl $154
  1028ae:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1028b3:	e9 bc 04 00 00       	jmp    102d74 <__alltraps>

001028b8 <vector155>:
.globl vector155
vector155:
  pushl $0
  1028b8:	6a 00                	push   $0x0
  pushl $155
  1028ba:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1028bf:	e9 b0 04 00 00       	jmp    102d74 <__alltraps>

001028c4 <vector156>:
.globl vector156
vector156:
  pushl $0
  1028c4:	6a 00                	push   $0x0
  pushl $156
  1028c6:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1028cb:	e9 a4 04 00 00       	jmp    102d74 <__alltraps>

001028d0 <vector157>:
.globl vector157
vector157:
  pushl $0
  1028d0:	6a 00                	push   $0x0
  pushl $157
  1028d2:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1028d7:	e9 98 04 00 00       	jmp    102d74 <__alltraps>

001028dc <vector158>:
.globl vector158
vector158:
  pushl $0
  1028dc:	6a 00                	push   $0x0
  pushl $158
  1028de:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1028e3:	e9 8c 04 00 00       	jmp    102d74 <__alltraps>

001028e8 <vector159>:
.globl vector159
vector159:
  pushl $0
  1028e8:	6a 00                	push   $0x0
  pushl $159
  1028ea:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1028ef:	e9 80 04 00 00       	jmp    102d74 <__alltraps>

001028f4 <vector160>:
.globl vector160
vector160:
  pushl $0
  1028f4:	6a 00                	push   $0x0
  pushl $160
  1028f6:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1028fb:	e9 74 04 00 00       	jmp    102d74 <__alltraps>

00102900 <vector161>:
.globl vector161
vector161:
  pushl $0
  102900:	6a 00                	push   $0x0
  pushl $161
  102902:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  102907:	e9 68 04 00 00       	jmp    102d74 <__alltraps>

0010290c <vector162>:
.globl vector162
vector162:
  pushl $0
  10290c:	6a 00                	push   $0x0
  pushl $162
  10290e:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102913:	e9 5c 04 00 00       	jmp    102d74 <__alltraps>

00102918 <vector163>:
.globl vector163
vector163:
  pushl $0
  102918:	6a 00                	push   $0x0
  pushl $163
  10291a:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  10291f:	e9 50 04 00 00       	jmp    102d74 <__alltraps>

00102924 <vector164>:
.globl vector164
vector164:
  pushl $0
  102924:	6a 00                	push   $0x0
  pushl $164
  102926:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  10292b:	e9 44 04 00 00       	jmp    102d74 <__alltraps>

00102930 <vector165>:
.globl vector165
vector165:
  pushl $0
  102930:	6a 00                	push   $0x0
  pushl $165
  102932:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102937:	e9 38 04 00 00       	jmp    102d74 <__alltraps>

0010293c <vector166>:
.globl vector166
vector166:
  pushl $0
  10293c:	6a 00                	push   $0x0
  pushl $166
  10293e:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102943:	e9 2c 04 00 00       	jmp    102d74 <__alltraps>

00102948 <vector167>:
.globl vector167
vector167:
  pushl $0
  102948:	6a 00                	push   $0x0
  pushl $167
  10294a:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  10294f:	e9 20 04 00 00       	jmp    102d74 <__alltraps>

00102954 <vector168>:
.globl vector168
vector168:
  pushl $0
  102954:	6a 00                	push   $0x0
  pushl $168
  102956:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10295b:	e9 14 04 00 00       	jmp    102d74 <__alltraps>

00102960 <vector169>:
.globl vector169
vector169:
  pushl $0
  102960:	6a 00                	push   $0x0
  pushl $169
  102962:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102967:	e9 08 04 00 00       	jmp    102d74 <__alltraps>

0010296c <vector170>:
.globl vector170
vector170:
  pushl $0
  10296c:	6a 00                	push   $0x0
  pushl $170
  10296e:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102973:	e9 fc 03 00 00       	jmp    102d74 <__alltraps>

00102978 <vector171>:
.globl vector171
vector171:
  pushl $0
  102978:	6a 00                	push   $0x0
  pushl $171
  10297a:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10297f:	e9 f0 03 00 00       	jmp    102d74 <__alltraps>

00102984 <vector172>:
.globl vector172
vector172:
  pushl $0
  102984:	6a 00                	push   $0x0
  pushl $172
  102986:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10298b:	e9 e4 03 00 00       	jmp    102d74 <__alltraps>

00102990 <vector173>:
.globl vector173
vector173:
  pushl $0
  102990:	6a 00                	push   $0x0
  pushl $173
  102992:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102997:	e9 d8 03 00 00       	jmp    102d74 <__alltraps>

0010299c <vector174>:
.globl vector174
vector174:
  pushl $0
  10299c:	6a 00                	push   $0x0
  pushl $174
  10299e:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1029a3:	e9 cc 03 00 00       	jmp    102d74 <__alltraps>

001029a8 <vector175>:
.globl vector175
vector175:
  pushl $0
  1029a8:	6a 00                	push   $0x0
  pushl $175
  1029aa:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1029af:	e9 c0 03 00 00       	jmp    102d74 <__alltraps>

001029b4 <vector176>:
.globl vector176
vector176:
  pushl $0
  1029b4:	6a 00                	push   $0x0
  pushl $176
  1029b6:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1029bb:	e9 b4 03 00 00       	jmp    102d74 <__alltraps>

001029c0 <vector177>:
.globl vector177
vector177:
  pushl $0
  1029c0:	6a 00                	push   $0x0
  pushl $177
  1029c2:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1029c7:	e9 a8 03 00 00       	jmp    102d74 <__alltraps>

001029cc <vector178>:
.globl vector178
vector178:
  pushl $0
  1029cc:	6a 00                	push   $0x0
  pushl $178
  1029ce:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1029d3:	e9 9c 03 00 00       	jmp    102d74 <__alltraps>

001029d8 <vector179>:
.globl vector179
vector179:
  pushl $0
  1029d8:	6a 00                	push   $0x0
  pushl $179
  1029da:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1029df:	e9 90 03 00 00       	jmp    102d74 <__alltraps>

001029e4 <vector180>:
.globl vector180
vector180:
  pushl $0
  1029e4:	6a 00                	push   $0x0
  pushl $180
  1029e6:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1029eb:	e9 84 03 00 00       	jmp    102d74 <__alltraps>

001029f0 <vector181>:
.globl vector181
vector181:
  pushl $0
  1029f0:	6a 00                	push   $0x0
  pushl $181
  1029f2:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1029f7:	e9 78 03 00 00       	jmp    102d74 <__alltraps>

001029fc <vector182>:
.globl vector182
vector182:
  pushl $0
  1029fc:	6a 00                	push   $0x0
  pushl $182
  1029fe:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102a03:	e9 6c 03 00 00       	jmp    102d74 <__alltraps>

00102a08 <vector183>:
.globl vector183
vector183:
  pushl $0
  102a08:	6a 00                	push   $0x0
  pushl $183
  102a0a:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102a0f:	e9 60 03 00 00       	jmp    102d74 <__alltraps>

00102a14 <vector184>:
.globl vector184
vector184:
  pushl $0
  102a14:	6a 00                	push   $0x0
  pushl $184
  102a16:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102a1b:	e9 54 03 00 00       	jmp    102d74 <__alltraps>

00102a20 <vector185>:
.globl vector185
vector185:
  pushl $0
  102a20:	6a 00                	push   $0x0
  pushl $185
  102a22:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  102a27:	e9 48 03 00 00       	jmp    102d74 <__alltraps>

00102a2c <vector186>:
.globl vector186
vector186:
  pushl $0
  102a2c:	6a 00                	push   $0x0
  pushl $186
  102a2e:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102a33:	e9 3c 03 00 00       	jmp    102d74 <__alltraps>

00102a38 <vector187>:
.globl vector187
vector187:
  pushl $0
  102a38:	6a 00                	push   $0x0
  pushl $187
  102a3a:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102a3f:	e9 30 03 00 00       	jmp    102d74 <__alltraps>

00102a44 <vector188>:
.globl vector188
vector188:
  pushl $0
  102a44:	6a 00                	push   $0x0
  pushl $188
  102a46:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102a4b:	e9 24 03 00 00       	jmp    102d74 <__alltraps>

00102a50 <vector189>:
.globl vector189
vector189:
  pushl $0
  102a50:	6a 00                	push   $0x0
  pushl $189
  102a52:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102a57:	e9 18 03 00 00       	jmp    102d74 <__alltraps>

00102a5c <vector190>:
.globl vector190
vector190:
  pushl $0
  102a5c:	6a 00                	push   $0x0
  pushl $190
  102a5e:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102a63:	e9 0c 03 00 00       	jmp    102d74 <__alltraps>

00102a68 <vector191>:
.globl vector191
vector191:
  pushl $0
  102a68:	6a 00                	push   $0x0
  pushl $191
  102a6a:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102a6f:	e9 00 03 00 00       	jmp    102d74 <__alltraps>

00102a74 <vector192>:
.globl vector192
vector192:
  pushl $0
  102a74:	6a 00                	push   $0x0
  pushl $192
  102a76:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102a7b:	e9 f4 02 00 00       	jmp    102d74 <__alltraps>

00102a80 <vector193>:
.globl vector193
vector193:
  pushl $0
  102a80:	6a 00                	push   $0x0
  pushl $193
  102a82:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102a87:	e9 e8 02 00 00       	jmp    102d74 <__alltraps>

00102a8c <vector194>:
.globl vector194
vector194:
  pushl $0
  102a8c:	6a 00                	push   $0x0
  pushl $194
  102a8e:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102a93:	e9 dc 02 00 00       	jmp    102d74 <__alltraps>

00102a98 <vector195>:
.globl vector195
vector195:
  pushl $0
  102a98:	6a 00                	push   $0x0
  pushl $195
  102a9a:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102a9f:	e9 d0 02 00 00       	jmp    102d74 <__alltraps>

00102aa4 <vector196>:
.globl vector196
vector196:
  pushl $0
  102aa4:	6a 00                	push   $0x0
  pushl $196
  102aa6:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102aab:	e9 c4 02 00 00       	jmp    102d74 <__alltraps>

00102ab0 <vector197>:
.globl vector197
vector197:
  pushl $0
  102ab0:	6a 00                	push   $0x0
  pushl $197
  102ab2:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102ab7:	e9 b8 02 00 00       	jmp    102d74 <__alltraps>

00102abc <vector198>:
.globl vector198
vector198:
  pushl $0
  102abc:	6a 00                	push   $0x0
  pushl $198
  102abe:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102ac3:	e9 ac 02 00 00       	jmp    102d74 <__alltraps>

00102ac8 <vector199>:
.globl vector199
vector199:
  pushl $0
  102ac8:	6a 00                	push   $0x0
  pushl $199
  102aca:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102acf:	e9 a0 02 00 00       	jmp    102d74 <__alltraps>

00102ad4 <vector200>:
.globl vector200
vector200:
  pushl $0
  102ad4:	6a 00                	push   $0x0
  pushl $200
  102ad6:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102adb:	e9 94 02 00 00       	jmp    102d74 <__alltraps>

00102ae0 <vector201>:
.globl vector201
vector201:
  pushl $0
  102ae0:	6a 00                	push   $0x0
  pushl $201
  102ae2:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102ae7:	e9 88 02 00 00       	jmp    102d74 <__alltraps>

00102aec <vector202>:
.globl vector202
vector202:
  pushl $0
  102aec:	6a 00                	push   $0x0
  pushl $202
  102aee:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102af3:	e9 7c 02 00 00       	jmp    102d74 <__alltraps>

00102af8 <vector203>:
.globl vector203
vector203:
  pushl $0
  102af8:	6a 00                	push   $0x0
  pushl $203
  102afa:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102aff:	e9 70 02 00 00       	jmp    102d74 <__alltraps>

00102b04 <vector204>:
.globl vector204
vector204:
  pushl $0
  102b04:	6a 00                	push   $0x0
  pushl $204
  102b06:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102b0b:	e9 64 02 00 00       	jmp    102d74 <__alltraps>

00102b10 <vector205>:
.globl vector205
vector205:
  pushl $0
  102b10:	6a 00                	push   $0x0
  pushl $205
  102b12:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  102b17:	e9 58 02 00 00       	jmp    102d74 <__alltraps>

00102b1c <vector206>:
.globl vector206
vector206:
  pushl $0
  102b1c:	6a 00                	push   $0x0
  pushl $206
  102b1e:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102b23:	e9 4c 02 00 00       	jmp    102d74 <__alltraps>

00102b28 <vector207>:
.globl vector207
vector207:
  pushl $0
  102b28:	6a 00                	push   $0x0
  pushl $207
  102b2a:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102b2f:	e9 40 02 00 00       	jmp    102d74 <__alltraps>

00102b34 <vector208>:
.globl vector208
vector208:
  pushl $0
  102b34:	6a 00                	push   $0x0
  pushl $208
  102b36:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102b3b:	e9 34 02 00 00       	jmp    102d74 <__alltraps>

00102b40 <vector209>:
.globl vector209
vector209:
  pushl $0
  102b40:	6a 00                	push   $0x0
  pushl $209
  102b42:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102b47:	e9 28 02 00 00       	jmp    102d74 <__alltraps>

00102b4c <vector210>:
.globl vector210
vector210:
  pushl $0
  102b4c:	6a 00                	push   $0x0
  pushl $210
  102b4e:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102b53:	e9 1c 02 00 00       	jmp    102d74 <__alltraps>

00102b58 <vector211>:
.globl vector211
vector211:
  pushl $0
  102b58:	6a 00                	push   $0x0
  pushl $211
  102b5a:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102b5f:	e9 10 02 00 00       	jmp    102d74 <__alltraps>

00102b64 <vector212>:
.globl vector212
vector212:
  pushl $0
  102b64:	6a 00                	push   $0x0
  pushl $212
  102b66:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102b6b:	e9 04 02 00 00       	jmp    102d74 <__alltraps>

00102b70 <vector213>:
.globl vector213
vector213:
  pushl $0
  102b70:	6a 00                	push   $0x0
  pushl $213
  102b72:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102b77:	e9 f8 01 00 00       	jmp    102d74 <__alltraps>

00102b7c <vector214>:
.globl vector214
vector214:
  pushl $0
  102b7c:	6a 00                	push   $0x0
  pushl $214
  102b7e:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102b83:	e9 ec 01 00 00       	jmp    102d74 <__alltraps>

00102b88 <vector215>:
.globl vector215
vector215:
  pushl $0
  102b88:	6a 00                	push   $0x0
  pushl $215
  102b8a:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102b8f:	e9 e0 01 00 00       	jmp    102d74 <__alltraps>

00102b94 <vector216>:
.globl vector216
vector216:
  pushl $0
  102b94:	6a 00                	push   $0x0
  pushl $216
  102b96:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102b9b:	e9 d4 01 00 00       	jmp    102d74 <__alltraps>

00102ba0 <vector217>:
.globl vector217
vector217:
  pushl $0
  102ba0:	6a 00                	push   $0x0
  pushl $217
  102ba2:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102ba7:	e9 c8 01 00 00       	jmp    102d74 <__alltraps>

00102bac <vector218>:
.globl vector218
vector218:
  pushl $0
  102bac:	6a 00                	push   $0x0
  pushl $218
  102bae:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102bb3:	e9 bc 01 00 00       	jmp    102d74 <__alltraps>

00102bb8 <vector219>:
.globl vector219
vector219:
  pushl $0
  102bb8:	6a 00                	push   $0x0
  pushl $219
  102bba:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102bbf:	e9 b0 01 00 00       	jmp    102d74 <__alltraps>

00102bc4 <vector220>:
.globl vector220
vector220:
  pushl $0
  102bc4:	6a 00                	push   $0x0
  pushl $220
  102bc6:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102bcb:	e9 a4 01 00 00       	jmp    102d74 <__alltraps>

00102bd0 <vector221>:
.globl vector221
vector221:
  pushl $0
  102bd0:	6a 00                	push   $0x0
  pushl $221
  102bd2:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102bd7:	e9 98 01 00 00       	jmp    102d74 <__alltraps>

00102bdc <vector222>:
.globl vector222
vector222:
  pushl $0
  102bdc:	6a 00                	push   $0x0
  pushl $222
  102bde:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102be3:	e9 8c 01 00 00       	jmp    102d74 <__alltraps>

00102be8 <vector223>:
.globl vector223
vector223:
  pushl $0
  102be8:	6a 00                	push   $0x0
  pushl $223
  102bea:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102bef:	e9 80 01 00 00       	jmp    102d74 <__alltraps>

00102bf4 <vector224>:
.globl vector224
vector224:
  pushl $0
  102bf4:	6a 00                	push   $0x0
  pushl $224
  102bf6:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102bfb:	e9 74 01 00 00       	jmp    102d74 <__alltraps>

00102c00 <vector225>:
.globl vector225
vector225:
  pushl $0
  102c00:	6a 00                	push   $0x0
  pushl $225
  102c02:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102c07:	e9 68 01 00 00       	jmp    102d74 <__alltraps>

00102c0c <vector226>:
.globl vector226
vector226:
  pushl $0
  102c0c:	6a 00                	push   $0x0
  pushl $226
  102c0e:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102c13:	e9 5c 01 00 00       	jmp    102d74 <__alltraps>

00102c18 <vector227>:
.globl vector227
vector227:
  pushl $0
  102c18:	6a 00                	push   $0x0
  pushl $227
  102c1a:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102c1f:	e9 50 01 00 00       	jmp    102d74 <__alltraps>

00102c24 <vector228>:
.globl vector228
vector228:
  pushl $0
  102c24:	6a 00                	push   $0x0
  pushl $228
  102c26:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102c2b:	e9 44 01 00 00       	jmp    102d74 <__alltraps>

00102c30 <vector229>:
.globl vector229
vector229:
  pushl $0
  102c30:	6a 00                	push   $0x0
  pushl $229
  102c32:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102c37:	e9 38 01 00 00       	jmp    102d74 <__alltraps>

00102c3c <vector230>:
.globl vector230
vector230:
  pushl $0
  102c3c:	6a 00                	push   $0x0
  pushl $230
  102c3e:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102c43:	e9 2c 01 00 00       	jmp    102d74 <__alltraps>

00102c48 <vector231>:
.globl vector231
vector231:
  pushl $0
  102c48:	6a 00                	push   $0x0
  pushl $231
  102c4a:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102c4f:	e9 20 01 00 00       	jmp    102d74 <__alltraps>

00102c54 <vector232>:
.globl vector232
vector232:
  pushl $0
  102c54:	6a 00                	push   $0x0
  pushl $232
  102c56:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102c5b:	e9 14 01 00 00       	jmp    102d74 <__alltraps>

00102c60 <vector233>:
.globl vector233
vector233:
  pushl $0
  102c60:	6a 00                	push   $0x0
  pushl $233
  102c62:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102c67:	e9 08 01 00 00       	jmp    102d74 <__alltraps>

00102c6c <vector234>:
.globl vector234
vector234:
  pushl $0
  102c6c:	6a 00                	push   $0x0
  pushl $234
  102c6e:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102c73:	e9 fc 00 00 00       	jmp    102d74 <__alltraps>

00102c78 <vector235>:
.globl vector235
vector235:
  pushl $0
  102c78:	6a 00                	push   $0x0
  pushl $235
  102c7a:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102c7f:	e9 f0 00 00 00       	jmp    102d74 <__alltraps>

00102c84 <vector236>:
.globl vector236
vector236:
  pushl $0
  102c84:	6a 00                	push   $0x0
  pushl $236
  102c86:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102c8b:	e9 e4 00 00 00       	jmp    102d74 <__alltraps>

00102c90 <vector237>:
.globl vector237
vector237:
  pushl $0
  102c90:	6a 00                	push   $0x0
  pushl $237
  102c92:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102c97:	e9 d8 00 00 00       	jmp    102d74 <__alltraps>

00102c9c <vector238>:
.globl vector238
vector238:
  pushl $0
  102c9c:	6a 00                	push   $0x0
  pushl $238
  102c9e:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102ca3:	e9 cc 00 00 00       	jmp    102d74 <__alltraps>

00102ca8 <vector239>:
.globl vector239
vector239:
  pushl $0
  102ca8:	6a 00                	push   $0x0
  pushl $239
  102caa:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102caf:	e9 c0 00 00 00       	jmp    102d74 <__alltraps>

00102cb4 <vector240>:
.globl vector240
vector240:
  pushl $0
  102cb4:	6a 00                	push   $0x0
  pushl $240
  102cb6:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102cbb:	e9 b4 00 00 00       	jmp    102d74 <__alltraps>

00102cc0 <vector241>:
.globl vector241
vector241:
  pushl $0
  102cc0:	6a 00                	push   $0x0
  pushl $241
  102cc2:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102cc7:	e9 a8 00 00 00       	jmp    102d74 <__alltraps>

00102ccc <vector242>:
.globl vector242
vector242:
  pushl $0
  102ccc:	6a 00                	push   $0x0
  pushl $242
  102cce:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102cd3:	e9 9c 00 00 00       	jmp    102d74 <__alltraps>

00102cd8 <vector243>:
.globl vector243
vector243:
  pushl $0
  102cd8:	6a 00                	push   $0x0
  pushl $243
  102cda:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102cdf:	e9 90 00 00 00       	jmp    102d74 <__alltraps>

00102ce4 <vector244>:
.globl vector244
vector244:
  pushl $0
  102ce4:	6a 00                	push   $0x0
  pushl $244
  102ce6:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102ceb:	e9 84 00 00 00       	jmp    102d74 <__alltraps>

00102cf0 <vector245>:
.globl vector245
vector245:
  pushl $0
  102cf0:	6a 00                	push   $0x0
  pushl $245
  102cf2:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102cf7:	e9 78 00 00 00       	jmp    102d74 <__alltraps>

00102cfc <vector246>:
.globl vector246
vector246:
  pushl $0
  102cfc:	6a 00                	push   $0x0
  pushl $246
  102cfe:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102d03:	e9 6c 00 00 00       	jmp    102d74 <__alltraps>

00102d08 <vector247>:
.globl vector247
vector247:
  pushl $0
  102d08:	6a 00                	push   $0x0
  pushl $247
  102d0a:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102d0f:	e9 60 00 00 00       	jmp    102d74 <__alltraps>

00102d14 <vector248>:
.globl vector248
vector248:
  pushl $0
  102d14:	6a 00                	push   $0x0
  pushl $248
  102d16:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102d1b:	e9 54 00 00 00       	jmp    102d74 <__alltraps>

00102d20 <vector249>:
.globl vector249
vector249:
  pushl $0
  102d20:	6a 00                	push   $0x0
  pushl $249
  102d22:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102d27:	e9 48 00 00 00       	jmp    102d74 <__alltraps>

00102d2c <vector250>:
.globl vector250
vector250:
  pushl $0
  102d2c:	6a 00                	push   $0x0
  pushl $250
  102d2e:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102d33:	e9 3c 00 00 00       	jmp    102d74 <__alltraps>

00102d38 <vector251>:
.globl vector251
vector251:
  pushl $0
  102d38:	6a 00                	push   $0x0
  pushl $251
  102d3a:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102d3f:	e9 30 00 00 00       	jmp    102d74 <__alltraps>

00102d44 <vector252>:
.globl vector252
vector252:
  pushl $0
  102d44:	6a 00                	push   $0x0
  pushl $252
  102d46:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102d4b:	e9 24 00 00 00       	jmp    102d74 <__alltraps>

00102d50 <vector253>:
.globl vector253
vector253:
  pushl $0
  102d50:	6a 00                	push   $0x0
  pushl $253
  102d52:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102d57:	e9 18 00 00 00       	jmp    102d74 <__alltraps>

00102d5c <vector254>:
.globl vector254
vector254:
  pushl $0
  102d5c:	6a 00                	push   $0x0
  pushl $254
  102d5e:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102d63:	e9 0c 00 00 00       	jmp    102d74 <__alltraps>

00102d68 <vector255>:
.globl vector255
vector255:
  pushl $0
  102d68:	6a 00                	push   $0x0
  pushl $255
  102d6a:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102d6f:	e9 00 00 00 00       	jmp    102d74 <__alltraps>

00102d74 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102d74:	1e                   	push   %ds
    pushl %es
  102d75:	06                   	push   %es
    pushl %fs
  102d76:	0f a0                	push   %fs
    pushl %gs
  102d78:	0f a8                	push   %gs
    pushal
  102d7a:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102d7b:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102d80:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102d82:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102d84:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102d85:	e8 59 f5 ff ff       	call   1022e3 <trap>

    # pop the pushed stack pointer
    popl %esp
  102d8a:	5c                   	pop    %esp

00102d8b <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102d8b:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102d8c:	0f a9                	pop    %gs
    popl %fs
  102d8e:	0f a1                	pop    %fs
    popl %es
  102d90:	07                   	pop    %es
    popl %ds
  102d91:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102d92:	83 c4 08             	add    $0x8,%esp
    iret
  102d95:	cf                   	iret   

00102d96 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102d96:	55                   	push   %ebp
  102d97:	89 e5                	mov    %esp,%ebp
  102d99:	e8 ee d4 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  102d9e:	05 b2 cb 00 00       	add    $0xcbb2,%eax
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102da3:	8b 45 08             	mov    0x8(%ebp),%eax
  102da6:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102da9:	b8 23 00 00 00       	mov    $0x23,%eax
  102dae:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102db0:	b8 23 00 00 00       	mov    $0x23,%eax
  102db5:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102db7:	b8 10 00 00 00       	mov    $0x10,%eax
  102dbc:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102dbe:	b8 10 00 00 00       	mov    $0x10,%eax
  102dc3:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102dc5:	b8 10 00 00 00       	mov    $0x10,%eax
  102dca:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102dcc:	ea d3 2d 10 00 08 00 	ljmp   $0x8,$0x102dd3
}
  102dd3:	90                   	nop
  102dd4:	5d                   	pop    %ebp
  102dd5:	c3                   	ret    

00102dd6 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102dd6:	55                   	push   %ebp
  102dd7:	89 e5                	mov    %esp,%ebp
  102dd9:	83 ec 10             	sub    $0x10,%esp
  102ddc:	e8 ab d4 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  102de1:	05 6f cb 00 00       	add    $0xcb6f,%eax
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102de6:	c7 c2 20 0a 11 00    	mov    $0x110a20,%edx
  102dec:	81 c2 00 04 00 00    	add    $0x400,%edx
  102df2:	89 90 f4 0f 00 00    	mov    %edx,0xff4(%eax)
    ts.ts_ss0 = KERNEL_DS;
  102df8:	66 c7 80 f8 0f 00 00 	movw   $0x10,0xff8(%eax)
  102dff:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102e01:	66 c7 80 f8 ff ff ff 	movw   $0x68,-0x8(%eax)
  102e08:	68 00 
  102e0a:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102e10:	66 89 90 fa ff ff ff 	mov    %dx,-0x6(%eax)
  102e17:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102e1d:	c1 ea 10             	shr    $0x10,%edx
  102e20:	88 90 fc ff ff ff    	mov    %dl,-0x4(%eax)
  102e26:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e2d:	83 e2 f0             	and    $0xfffffff0,%edx
  102e30:	83 ca 09             	or     $0x9,%edx
  102e33:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e39:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e40:	83 ca 10             	or     $0x10,%edx
  102e43:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e49:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e50:	83 e2 9f             	and    $0xffffff9f,%edx
  102e53:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e59:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e60:	83 ca 80             	or     $0xffffff80,%edx
  102e63:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e69:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e70:	83 e2 f0             	and    $0xfffffff0,%edx
  102e73:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e79:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e80:	83 e2 ef             	and    $0xffffffef,%edx
  102e83:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e89:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e90:	83 e2 df             	and    $0xffffffdf,%edx
  102e93:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e99:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102ea0:	83 ca 40             	or     $0x40,%edx
  102ea3:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102ea9:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102eb0:	83 e2 7f             	and    $0x7f,%edx
  102eb3:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102eb9:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102ebf:	c1 ea 18             	shr    $0x18,%edx
  102ec2:	88 90 ff ff ff ff    	mov    %dl,-0x1(%eax)
    gdt[SEG_TSS].sd_s = 0;
  102ec8:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102ecf:	83 e2 ef             	and    $0xffffffef,%edx
  102ed2:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)

    // reload all segment registers
    lgdt(&gdt_pd);
  102ed8:	8d 80 d0 00 00 00    	lea    0xd0(%eax),%eax
  102ede:	50                   	push   %eax
  102edf:	e8 b2 fe ff ff       	call   102d96 <lgdt>
  102ee4:	83 c4 04             	add    $0x4,%esp
  102ee7:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102eed:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102ef1:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102ef4:	90                   	nop
  102ef5:	c9                   	leave  
  102ef6:	c3                   	ret    

00102ef7 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102ef7:	55                   	push   %ebp
  102ef8:	89 e5                	mov    %esp,%ebp
  102efa:	e8 8d d3 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  102eff:	05 51 ca 00 00       	add    $0xca51,%eax
    gdt_init();
  102f04:	e8 cd fe ff ff       	call   102dd6 <gdt_init>
}
  102f09:	90                   	nop
  102f0a:	5d                   	pop    %ebp
  102f0b:	c3                   	ret    

00102f0c <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102f0c:	55                   	push   %ebp
  102f0d:	89 e5                	mov    %esp,%ebp
  102f0f:	83 ec 10             	sub    $0x10,%esp
  102f12:	e8 75 d3 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  102f17:	05 39 ca 00 00       	add    $0xca39,%eax
    size_t cnt = 0;
  102f1c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102f23:	eb 04                	jmp    102f29 <strlen+0x1d>
        cnt ++;
  102f25:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102f29:	8b 45 08             	mov    0x8(%ebp),%eax
  102f2c:	8d 50 01             	lea    0x1(%eax),%edx
  102f2f:	89 55 08             	mov    %edx,0x8(%ebp)
  102f32:	0f b6 00             	movzbl (%eax),%eax
  102f35:	84 c0                	test   %al,%al
  102f37:	75 ec                	jne    102f25 <strlen+0x19>
    }
    return cnt;
  102f39:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102f3c:	c9                   	leave  
  102f3d:	c3                   	ret    

00102f3e <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102f3e:	55                   	push   %ebp
  102f3f:	89 e5                	mov    %esp,%ebp
  102f41:	83 ec 10             	sub    $0x10,%esp
  102f44:	e8 43 d3 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  102f49:	05 07 ca 00 00       	add    $0xca07,%eax
    size_t cnt = 0;
  102f4e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102f55:	eb 04                	jmp    102f5b <strnlen+0x1d>
        cnt ++;
  102f57:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102f5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f5e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102f61:	73 10                	jae    102f73 <strnlen+0x35>
  102f63:	8b 45 08             	mov    0x8(%ebp),%eax
  102f66:	8d 50 01             	lea    0x1(%eax),%edx
  102f69:	89 55 08             	mov    %edx,0x8(%ebp)
  102f6c:	0f b6 00             	movzbl (%eax),%eax
  102f6f:	84 c0                	test   %al,%al
  102f71:	75 e4                	jne    102f57 <strnlen+0x19>
    }
    return cnt;
  102f73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102f76:	c9                   	leave  
  102f77:	c3                   	ret    

00102f78 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102f78:	55                   	push   %ebp
  102f79:	89 e5                	mov    %esp,%ebp
  102f7b:	57                   	push   %edi
  102f7c:	56                   	push   %esi
  102f7d:	83 ec 20             	sub    $0x20,%esp
  102f80:	e8 07 d3 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  102f85:	05 cb c9 00 00       	add    $0xc9cb,%eax
  102f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  102f8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f93:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102f96:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f9c:	89 d1                	mov    %edx,%ecx
  102f9e:	89 c2                	mov    %eax,%edx
  102fa0:	89 ce                	mov    %ecx,%esi
  102fa2:	89 d7                	mov    %edx,%edi
  102fa4:	ac                   	lods   %ds:(%esi),%al
  102fa5:	aa                   	stos   %al,%es:(%edi)
  102fa6:	84 c0                	test   %al,%al
  102fa8:	75 fa                	jne    102fa4 <strcpy+0x2c>
  102faa:	89 fa                	mov    %edi,%edx
  102fac:	89 f1                	mov    %esi,%ecx
  102fae:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102fb1:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102fb4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  102fba:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102fbb:	83 c4 20             	add    $0x20,%esp
  102fbe:	5e                   	pop    %esi
  102fbf:	5f                   	pop    %edi
  102fc0:	5d                   	pop    %ebp
  102fc1:	c3                   	ret    

00102fc2 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102fc2:	55                   	push   %ebp
  102fc3:	89 e5                	mov    %esp,%ebp
  102fc5:	83 ec 10             	sub    $0x10,%esp
  102fc8:	e8 bf d2 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  102fcd:	05 83 c9 00 00       	add    $0xc983,%eax
    char *p = dst;
  102fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  102fd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102fd8:	eb 21                	jmp    102ffb <strncpy+0x39>
        if ((*p = *src) != '\0') {
  102fda:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fdd:	0f b6 10             	movzbl (%eax),%edx
  102fe0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fe3:	88 10                	mov    %dl,(%eax)
  102fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fe8:	0f b6 00             	movzbl (%eax),%eax
  102feb:	84 c0                	test   %al,%al
  102fed:	74 04                	je     102ff3 <strncpy+0x31>
            src ++;
  102fef:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102ff3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102ff7:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102ffb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102fff:	75 d9                	jne    102fda <strncpy+0x18>
    }
    return dst;
  103001:	8b 45 08             	mov    0x8(%ebp),%eax
}
  103004:	c9                   	leave  
  103005:	c3                   	ret    

00103006 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  103006:	55                   	push   %ebp
  103007:	89 e5                	mov    %esp,%ebp
  103009:	57                   	push   %edi
  10300a:	56                   	push   %esi
  10300b:	83 ec 20             	sub    $0x20,%esp
  10300e:	e8 79 d2 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  103013:	05 3d c9 00 00       	add    $0xc93d,%eax
  103018:	8b 45 08             	mov    0x8(%ebp),%eax
  10301b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10301e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103021:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  103024:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103027:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10302a:	89 d1                	mov    %edx,%ecx
  10302c:	89 c2                	mov    %eax,%edx
  10302e:	89 ce                	mov    %ecx,%esi
  103030:	89 d7                	mov    %edx,%edi
  103032:	ac                   	lods   %ds:(%esi),%al
  103033:	ae                   	scas   %es:(%edi),%al
  103034:	75 08                	jne    10303e <strcmp+0x38>
  103036:	84 c0                	test   %al,%al
  103038:	75 f8                	jne    103032 <strcmp+0x2c>
  10303a:	31 c0                	xor    %eax,%eax
  10303c:	eb 04                	jmp    103042 <strcmp+0x3c>
  10303e:	19 c0                	sbb    %eax,%eax
  103040:	0c 01                	or     $0x1,%al
  103042:	89 fa                	mov    %edi,%edx
  103044:	89 f1                	mov    %esi,%ecx
  103046:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103049:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10304c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  10304f:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  103052:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  103053:	83 c4 20             	add    $0x20,%esp
  103056:	5e                   	pop    %esi
  103057:	5f                   	pop    %edi
  103058:	5d                   	pop    %ebp
  103059:	c3                   	ret    

0010305a <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  10305a:	55                   	push   %ebp
  10305b:	89 e5                	mov    %esp,%ebp
  10305d:	e8 2a d2 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  103062:	05 ee c8 00 00       	add    $0xc8ee,%eax
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  103067:	eb 0c                	jmp    103075 <strncmp+0x1b>
        n --, s1 ++, s2 ++;
  103069:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10306d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103071:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  103075:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103079:	74 1a                	je     103095 <strncmp+0x3b>
  10307b:	8b 45 08             	mov    0x8(%ebp),%eax
  10307e:	0f b6 00             	movzbl (%eax),%eax
  103081:	84 c0                	test   %al,%al
  103083:	74 10                	je     103095 <strncmp+0x3b>
  103085:	8b 45 08             	mov    0x8(%ebp),%eax
  103088:	0f b6 10             	movzbl (%eax),%edx
  10308b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10308e:	0f b6 00             	movzbl (%eax),%eax
  103091:	38 c2                	cmp    %al,%dl
  103093:	74 d4                	je     103069 <strncmp+0xf>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  103095:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103099:	74 18                	je     1030b3 <strncmp+0x59>
  10309b:	8b 45 08             	mov    0x8(%ebp),%eax
  10309e:	0f b6 00             	movzbl (%eax),%eax
  1030a1:	0f b6 d0             	movzbl %al,%edx
  1030a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030a7:	0f b6 00             	movzbl (%eax),%eax
  1030aa:	0f b6 c0             	movzbl %al,%eax
  1030ad:	29 c2                	sub    %eax,%edx
  1030af:	89 d0                	mov    %edx,%eax
  1030b1:	eb 05                	jmp    1030b8 <strncmp+0x5e>
  1030b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1030b8:	5d                   	pop    %ebp
  1030b9:	c3                   	ret    

001030ba <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  1030ba:	55                   	push   %ebp
  1030bb:	89 e5                	mov    %esp,%ebp
  1030bd:	83 ec 04             	sub    $0x4,%esp
  1030c0:	e8 c7 d1 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1030c5:	05 8b c8 00 00       	add    $0xc88b,%eax
  1030ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030cd:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1030d0:	eb 14                	jmp    1030e6 <strchr+0x2c>
        if (*s == c) {
  1030d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d5:	0f b6 00             	movzbl (%eax),%eax
  1030d8:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1030db:	75 05                	jne    1030e2 <strchr+0x28>
            return (char *)s;
  1030dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e0:	eb 13                	jmp    1030f5 <strchr+0x3b>
        }
        s ++;
  1030e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  1030e6:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e9:	0f b6 00             	movzbl (%eax),%eax
  1030ec:	84 c0                	test   %al,%al
  1030ee:	75 e2                	jne    1030d2 <strchr+0x18>
    }
    return NULL;
  1030f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1030f5:	c9                   	leave  
  1030f6:	c3                   	ret    

001030f7 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  1030f7:	55                   	push   %ebp
  1030f8:	89 e5                	mov    %esp,%ebp
  1030fa:	83 ec 04             	sub    $0x4,%esp
  1030fd:	e8 8a d1 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  103102:	05 4e c8 00 00       	add    $0xc84e,%eax
  103107:	8b 45 0c             	mov    0xc(%ebp),%eax
  10310a:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10310d:	eb 0f                	jmp    10311e <strfind+0x27>
        if (*s == c) {
  10310f:	8b 45 08             	mov    0x8(%ebp),%eax
  103112:	0f b6 00             	movzbl (%eax),%eax
  103115:	38 45 fc             	cmp    %al,-0x4(%ebp)
  103118:	74 10                	je     10312a <strfind+0x33>
            break;
        }
        s ++;
  10311a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  10311e:	8b 45 08             	mov    0x8(%ebp),%eax
  103121:	0f b6 00             	movzbl (%eax),%eax
  103124:	84 c0                	test   %al,%al
  103126:	75 e7                	jne    10310f <strfind+0x18>
  103128:	eb 01                	jmp    10312b <strfind+0x34>
            break;
  10312a:	90                   	nop
    }
    return (char *)s;
  10312b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  10312e:	c9                   	leave  
  10312f:	c3                   	ret    

00103130 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  103130:	55                   	push   %ebp
  103131:	89 e5                	mov    %esp,%ebp
  103133:	83 ec 10             	sub    $0x10,%esp
  103136:	e8 51 d1 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  10313b:	05 15 c8 00 00       	add    $0xc815,%eax
    int neg = 0;
  103140:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  103147:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  10314e:	eb 04                	jmp    103154 <strtol+0x24>
        s ++;
  103150:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  103154:	8b 45 08             	mov    0x8(%ebp),%eax
  103157:	0f b6 00             	movzbl (%eax),%eax
  10315a:	3c 20                	cmp    $0x20,%al
  10315c:	74 f2                	je     103150 <strtol+0x20>
  10315e:	8b 45 08             	mov    0x8(%ebp),%eax
  103161:	0f b6 00             	movzbl (%eax),%eax
  103164:	3c 09                	cmp    $0x9,%al
  103166:	74 e8                	je     103150 <strtol+0x20>
    }

    // plus/minus sign
    if (*s == '+') {
  103168:	8b 45 08             	mov    0x8(%ebp),%eax
  10316b:	0f b6 00             	movzbl (%eax),%eax
  10316e:	3c 2b                	cmp    $0x2b,%al
  103170:	75 06                	jne    103178 <strtol+0x48>
        s ++;
  103172:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103176:	eb 15                	jmp    10318d <strtol+0x5d>
    }
    else if (*s == '-') {
  103178:	8b 45 08             	mov    0x8(%ebp),%eax
  10317b:	0f b6 00             	movzbl (%eax),%eax
  10317e:	3c 2d                	cmp    $0x2d,%al
  103180:	75 0b                	jne    10318d <strtol+0x5d>
        s ++, neg = 1;
  103182:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103186:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  10318d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103191:	74 06                	je     103199 <strtol+0x69>
  103193:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  103197:	75 24                	jne    1031bd <strtol+0x8d>
  103199:	8b 45 08             	mov    0x8(%ebp),%eax
  10319c:	0f b6 00             	movzbl (%eax),%eax
  10319f:	3c 30                	cmp    $0x30,%al
  1031a1:	75 1a                	jne    1031bd <strtol+0x8d>
  1031a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1031a6:	83 c0 01             	add    $0x1,%eax
  1031a9:	0f b6 00             	movzbl (%eax),%eax
  1031ac:	3c 78                	cmp    $0x78,%al
  1031ae:	75 0d                	jne    1031bd <strtol+0x8d>
        s += 2, base = 16;
  1031b0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  1031b4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  1031bb:	eb 2a                	jmp    1031e7 <strtol+0xb7>
    }
    else if (base == 0 && s[0] == '0') {
  1031bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1031c1:	75 17                	jne    1031da <strtol+0xaa>
  1031c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1031c6:	0f b6 00             	movzbl (%eax),%eax
  1031c9:	3c 30                	cmp    $0x30,%al
  1031cb:	75 0d                	jne    1031da <strtol+0xaa>
        s ++, base = 8;
  1031cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1031d1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  1031d8:	eb 0d                	jmp    1031e7 <strtol+0xb7>
    }
    else if (base == 0) {
  1031da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1031de:	75 07                	jne    1031e7 <strtol+0xb7>
        base = 10;
  1031e0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  1031e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1031ea:	0f b6 00             	movzbl (%eax),%eax
  1031ed:	3c 2f                	cmp    $0x2f,%al
  1031ef:	7e 1b                	jle    10320c <strtol+0xdc>
  1031f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1031f4:	0f b6 00             	movzbl (%eax),%eax
  1031f7:	3c 39                	cmp    $0x39,%al
  1031f9:	7f 11                	jg     10320c <strtol+0xdc>
            dig = *s - '0';
  1031fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1031fe:	0f b6 00             	movzbl (%eax),%eax
  103201:	0f be c0             	movsbl %al,%eax
  103204:	83 e8 30             	sub    $0x30,%eax
  103207:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10320a:	eb 48                	jmp    103254 <strtol+0x124>
        }
        else if (*s >= 'a' && *s <= 'z') {
  10320c:	8b 45 08             	mov    0x8(%ebp),%eax
  10320f:	0f b6 00             	movzbl (%eax),%eax
  103212:	3c 60                	cmp    $0x60,%al
  103214:	7e 1b                	jle    103231 <strtol+0x101>
  103216:	8b 45 08             	mov    0x8(%ebp),%eax
  103219:	0f b6 00             	movzbl (%eax),%eax
  10321c:	3c 7a                	cmp    $0x7a,%al
  10321e:	7f 11                	jg     103231 <strtol+0x101>
            dig = *s - 'a' + 10;
  103220:	8b 45 08             	mov    0x8(%ebp),%eax
  103223:	0f b6 00             	movzbl (%eax),%eax
  103226:	0f be c0             	movsbl %al,%eax
  103229:	83 e8 57             	sub    $0x57,%eax
  10322c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10322f:	eb 23                	jmp    103254 <strtol+0x124>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  103231:	8b 45 08             	mov    0x8(%ebp),%eax
  103234:	0f b6 00             	movzbl (%eax),%eax
  103237:	3c 40                	cmp    $0x40,%al
  103239:	7e 3c                	jle    103277 <strtol+0x147>
  10323b:	8b 45 08             	mov    0x8(%ebp),%eax
  10323e:	0f b6 00             	movzbl (%eax),%eax
  103241:	3c 5a                	cmp    $0x5a,%al
  103243:	7f 32                	jg     103277 <strtol+0x147>
            dig = *s - 'A' + 10;
  103245:	8b 45 08             	mov    0x8(%ebp),%eax
  103248:	0f b6 00             	movzbl (%eax),%eax
  10324b:	0f be c0             	movsbl %al,%eax
  10324e:	83 e8 37             	sub    $0x37,%eax
  103251:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  103254:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103257:	3b 45 10             	cmp    0x10(%ebp),%eax
  10325a:	7d 1a                	jge    103276 <strtol+0x146>
            break;
        }
        s ++, val = (val * base) + dig;
  10325c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103260:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103263:	0f af 45 10          	imul   0x10(%ebp),%eax
  103267:	89 c2                	mov    %eax,%edx
  103269:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10326c:	01 d0                	add    %edx,%eax
  10326e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  103271:	e9 71 ff ff ff       	jmp    1031e7 <strtol+0xb7>
            break;
  103276:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  103277:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10327b:	74 08                	je     103285 <strtol+0x155>
        *endptr = (char *) s;
  10327d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103280:	8b 55 08             	mov    0x8(%ebp),%edx
  103283:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103285:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103289:	74 07                	je     103292 <strtol+0x162>
  10328b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10328e:	f7 d8                	neg    %eax
  103290:	eb 03                	jmp    103295 <strtol+0x165>
  103292:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103295:	c9                   	leave  
  103296:	c3                   	ret    

00103297 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  103297:	55                   	push   %ebp
  103298:	89 e5                	mov    %esp,%ebp
  10329a:	57                   	push   %edi
  10329b:	83 ec 24             	sub    $0x24,%esp
  10329e:	e8 e9 cf ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1032a3:	05 ad c6 00 00       	add    $0xc6ad,%eax
  1032a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032ab:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  1032ae:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  1032b2:	8b 55 08             	mov    0x8(%ebp),%edx
  1032b5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  1032b8:	88 45 f7             	mov    %al,-0x9(%ebp)
  1032bb:	8b 45 10             	mov    0x10(%ebp),%eax
  1032be:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  1032c1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  1032c4:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  1032c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1032cb:	89 d7                	mov    %edx,%edi
  1032cd:	f3 aa                	rep stos %al,%es:(%edi)
  1032cf:	89 fa                	mov    %edi,%edx
  1032d1:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  1032d4:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  1032d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032da:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  1032db:	83 c4 24             	add    $0x24,%esp
  1032de:	5f                   	pop    %edi
  1032df:	5d                   	pop    %ebp
  1032e0:	c3                   	ret    

001032e1 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  1032e1:	55                   	push   %ebp
  1032e2:	89 e5                	mov    %esp,%ebp
  1032e4:	57                   	push   %edi
  1032e5:	56                   	push   %esi
  1032e6:	53                   	push   %ebx
  1032e7:	83 ec 30             	sub    $0x30,%esp
  1032ea:	e8 9d cf ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1032ef:	05 61 c6 00 00       	add    $0xc661,%eax
  1032f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1032f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1032fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103300:	8b 45 10             	mov    0x10(%ebp),%eax
  103303:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  103306:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103309:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10330c:	73 42                	jae    103350 <memmove+0x6f>
  10330e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103311:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103314:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103317:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10331a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10331d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103320:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103323:	c1 e8 02             	shr    $0x2,%eax
  103326:	89 c1                	mov    %eax,%ecx
    asm volatile (
  103328:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10332b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10332e:	89 d7                	mov    %edx,%edi
  103330:	89 c6                	mov    %eax,%esi
  103332:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103334:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  103337:	83 e1 03             	and    $0x3,%ecx
  10333a:	74 02                	je     10333e <memmove+0x5d>
  10333c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10333e:	89 f0                	mov    %esi,%eax
  103340:	89 fa                	mov    %edi,%edx
  103342:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103345:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  103348:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  10334b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  10334e:	eb 36                	jmp    103386 <memmove+0xa5>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  103350:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103353:	8d 50 ff             	lea    -0x1(%eax),%edx
  103356:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103359:	01 c2                	add    %eax,%edx
  10335b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10335e:	8d 48 ff             	lea    -0x1(%eax),%ecx
  103361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103364:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  103367:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10336a:	89 c1                	mov    %eax,%ecx
  10336c:	89 d8                	mov    %ebx,%eax
  10336e:	89 d6                	mov    %edx,%esi
  103370:	89 c7                	mov    %eax,%edi
  103372:	fd                   	std    
  103373:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103375:	fc                   	cld    
  103376:	89 f8                	mov    %edi,%eax
  103378:	89 f2                	mov    %esi,%edx
  10337a:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  10337d:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103380:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  103383:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  103386:	83 c4 30             	add    $0x30,%esp
  103389:	5b                   	pop    %ebx
  10338a:	5e                   	pop    %esi
  10338b:	5f                   	pop    %edi
  10338c:	5d                   	pop    %ebp
  10338d:	c3                   	ret    

0010338e <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  10338e:	55                   	push   %ebp
  10338f:	89 e5                	mov    %esp,%ebp
  103391:	57                   	push   %edi
  103392:	56                   	push   %esi
  103393:	83 ec 20             	sub    $0x20,%esp
  103396:	e8 f1 ce ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  10339b:	05 b5 c5 00 00       	add    $0xc5b5,%eax
  1033a0:	8b 45 08             	mov    0x8(%ebp),%eax
  1033a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1033a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033ac:	8b 45 10             	mov    0x10(%ebp),%eax
  1033af:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1033b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1033b5:	c1 e8 02             	shr    $0x2,%eax
  1033b8:	89 c1                	mov    %eax,%ecx
    asm volatile (
  1033ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033c0:	89 d7                	mov    %edx,%edi
  1033c2:	89 c6                	mov    %eax,%esi
  1033c4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1033c6:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  1033c9:	83 e1 03             	and    $0x3,%ecx
  1033cc:	74 02                	je     1033d0 <memcpy+0x42>
  1033ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1033d0:	89 f0                	mov    %esi,%eax
  1033d2:	89 fa                	mov    %edi,%edx
  1033d4:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1033d7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1033da:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  1033dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  1033e0:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  1033e1:	83 c4 20             	add    $0x20,%esp
  1033e4:	5e                   	pop    %esi
  1033e5:	5f                   	pop    %edi
  1033e6:	5d                   	pop    %ebp
  1033e7:	c3                   	ret    

001033e8 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  1033e8:	55                   	push   %ebp
  1033e9:	89 e5                	mov    %esp,%ebp
  1033eb:	83 ec 10             	sub    $0x10,%esp
  1033ee:	e8 99 ce ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1033f3:	05 5d c5 00 00       	add    $0xc55d,%eax
    const char *s1 = (const char *)v1;
  1033f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1033fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  1033fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  103401:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  103404:	eb 30                	jmp    103436 <memcmp+0x4e>
        if (*s1 != *s2) {
  103406:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103409:	0f b6 10             	movzbl (%eax),%edx
  10340c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10340f:	0f b6 00             	movzbl (%eax),%eax
  103412:	38 c2                	cmp    %al,%dl
  103414:	74 18                	je     10342e <memcmp+0x46>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  103416:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103419:	0f b6 00             	movzbl (%eax),%eax
  10341c:	0f b6 d0             	movzbl %al,%edx
  10341f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103422:	0f b6 00             	movzbl (%eax),%eax
  103425:	0f b6 c0             	movzbl %al,%eax
  103428:	29 c2                	sub    %eax,%edx
  10342a:	89 d0                	mov    %edx,%eax
  10342c:	eb 1a                	jmp    103448 <memcmp+0x60>
        }
        s1 ++, s2 ++;
  10342e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  103432:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  103436:	8b 45 10             	mov    0x10(%ebp),%eax
  103439:	8d 50 ff             	lea    -0x1(%eax),%edx
  10343c:	89 55 10             	mov    %edx,0x10(%ebp)
  10343f:	85 c0                	test   %eax,%eax
  103441:	75 c3                	jne    103406 <memcmp+0x1e>
    }
    return 0;
  103443:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103448:	c9                   	leave  
  103449:	c3                   	ret    

0010344a <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  10344a:	55                   	push   %ebp
  10344b:	89 e5                	mov    %esp,%ebp
  10344d:	53                   	push   %ebx
  10344e:	83 ec 34             	sub    $0x34,%esp
  103451:	e8 3a ce ff ff       	call   100290 <__x86.get_pc_thunk.bx>
  103456:	81 c3 fa c4 00 00    	add    $0xc4fa,%ebx
  10345c:	8b 45 10             	mov    0x10(%ebp),%eax
  10345f:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103462:	8b 45 14             	mov    0x14(%ebp),%eax
  103465:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  103468:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10346b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10346e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103471:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  103474:	8b 45 18             	mov    0x18(%ebp),%eax
  103477:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10347a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10347d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103480:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103483:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103486:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103489:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10348c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103490:	74 1c                	je     1034ae <printnum+0x64>
  103492:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103495:	ba 00 00 00 00       	mov    $0x0,%edx
  10349a:	f7 75 e4             	divl   -0x1c(%ebp)
  10349d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1034a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034a3:	ba 00 00 00 00       	mov    $0x0,%edx
  1034a8:	f7 75 e4             	divl   -0x1c(%ebp)
  1034ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034b4:	f7 75 e4             	divl   -0x1c(%ebp)
  1034b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1034ba:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1034bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1034c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1034c6:	89 55 ec             	mov    %edx,-0x14(%ebp)
  1034c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1034cc:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  1034cf:	8b 45 18             	mov    0x18(%ebp),%eax
  1034d2:	ba 00 00 00 00       	mov    $0x0,%edx
  1034d7:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  1034da:	72 41                	jb     10351d <printnum+0xd3>
  1034dc:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  1034df:	77 05                	ja     1034e6 <printnum+0x9c>
  1034e1:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1034e4:	72 37                	jb     10351d <printnum+0xd3>
        printnum(putch, putdat, result, base, width - 1, padc);
  1034e6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1034e9:	83 e8 01             	sub    $0x1,%eax
  1034ec:	83 ec 04             	sub    $0x4,%esp
  1034ef:	ff 75 20             	pushl  0x20(%ebp)
  1034f2:	50                   	push   %eax
  1034f3:	ff 75 18             	pushl  0x18(%ebp)
  1034f6:	ff 75 ec             	pushl  -0x14(%ebp)
  1034f9:	ff 75 e8             	pushl  -0x18(%ebp)
  1034fc:	ff 75 0c             	pushl  0xc(%ebp)
  1034ff:	ff 75 08             	pushl  0x8(%ebp)
  103502:	e8 43 ff ff ff       	call   10344a <printnum>
  103507:	83 c4 20             	add    $0x20,%esp
  10350a:	eb 1b                	jmp    103527 <printnum+0xdd>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  10350c:	83 ec 08             	sub    $0x8,%esp
  10350f:	ff 75 0c             	pushl  0xc(%ebp)
  103512:	ff 75 20             	pushl  0x20(%ebp)
  103515:	8b 45 08             	mov    0x8(%ebp),%eax
  103518:	ff d0                	call   *%eax
  10351a:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  10351d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  103521:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  103525:	7f e5                	jg     10350c <printnum+0xc2>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  103527:	8d 93 62 48 ff ff    	lea    -0xb79e(%ebx),%edx
  10352d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  103530:	01 d0                	add    %edx,%eax
  103532:	0f b6 00             	movzbl (%eax),%eax
  103535:	0f be c0             	movsbl %al,%eax
  103538:	83 ec 08             	sub    $0x8,%esp
  10353b:	ff 75 0c             	pushl  0xc(%ebp)
  10353e:	50                   	push   %eax
  10353f:	8b 45 08             	mov    0x8(%ebp),%eax
  103542:	ff d0                	call   *%eax
  103544:	83 c4 10             	add    $0x10,%esp
}
  103547:	90                   	nop
  103548:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10354b:	c9                   	leave  
  10354c:	c3                   	ret    

0010354d <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10354d:	55                   	push   %ebp
  10354e:	89 e5                	mov    %esp,%ebp
  103550:	e8 37 cd ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  103555:	05 fb c3 00 00       	add    $0xc3fb,%eax
    if (lflag >= 2) {
  10355a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10355e:	7e 14                	jle    103574 <getuint+0x27>
        return va_arg(*ap, unsigned long long);
  103560:	8b 45 08             	mov    0x8(%ebp),%eax
  103563:	8b 00                	mov    (%eax),%eax
  103565:	8d 48 08             	lea    0x8(%eax),%ecx
  103568:	8b 55 08             	mov    0x8(%ebp),%edx
  10356b:	89 0a                	mov    %ecx,(%edx)
  10356d:	8b 50 04             	mov    0x4(%eax),%edx
  103570:	8b 00                	mov    (%eax),%eax
  103572:	eb 30                	jmp    1035a4 <getuint+0x57>
    }
    else if (lflag) {
  103574:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103578:	74 16                	je     103590 <getuint+0x43>
        return va_arg(*ap, unsigned long);
  10357a:	8b 45 08             	mov    0x8(%ebp),%eax
  10357d:	8b 00                	mov    (%eax),%eax
  10357f:	8d 48 04             	lea    0x4(%eax),%ecx
  103582:	8b 55 08             	mov    0x8(%ebp),%edx
  103585:	89 0a                	mov    %ecx,(%edx)
  103587:	8b 00                	mov    (%eax),%eax
  103589:	ba 00 00 00 00       	mov    $0x0,%edx
  10358e:	eb 14                	jmp    1035a4 <getuint+0x57>
    }
    else {
        return va_arg(*ap, unsigned int);
  103590:	8b 45 08             	mov    0x8(%ebp),%eax
  103593:	8b 00                	mov    (%eax),%eax
  103595:	8d 48 04             	lea    0x4(%eax),%ecx
  103598:	8b 55 08             	mov    0x8(%ebp),%edx
  10359b:	89 0a                	mov    %ecx,(%edx)
  10359d:	8b 00                	mov    (%eax),%eax
  10359f:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  1035a4:	5d                   	pop    %ebp
  1035a5:	c3                   	ret    

001035a6 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  1035a6:	55                   	push   %ebp
  1035a7:	89 e5                	mov    %esp,%ebp
  1035a9:	e8 de cc ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1035ae:	05 a2 c3 00 00       	add    $0xc3a2,%eax
    if (lflag >= 2) {
  1035b3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1035b7:	7e 14                	jle    1035cd <getint+0x27>
        return va_arg(*ap, long long);
  1035b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1035bc:	8b 00                	mov    (%eax),%eax
  1035be:	8d 48 08             	lea    0x8(%eax),%ecx
  1035c1:	8b 55 08             	mov    0x8(%ebp),%edx
  1035c4:	89 0a                	mov    %ecx,(%edx)
  1035c6:	8b 50 04             	mov    0x4(%eax),%edx
  1035c9:	8b 00                	mov    (%eax),%eax
  1035cb:	eb 28                	jmp    1035f5 <getint+0x4f>
    }
    else if (lflag) {
  1035cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1035d1:	74 12                	je     1035e5 <getint+0x3f>
        return va_arg(*ap, long);
  1035d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1035d6:	8b 00                	mov    (%eax),%eax
  1035d8:	8d 48 04             	lea    0x4(%eax),%ecx
  1035db:	8b 55 08             	mov    0x8(%ebp),%edx
  1035de:	89 0a                	mov    %ecx,(%edx)
  1035e0:	8b 00                	mov    (%eax),%eax
  1035e2:	99                   	cltd   
  1035e3:	eb 10                	jmp    1035f5 <getint+0x4f>
    }
    else {
        return va_arg(*ap, int);
  1035e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1035e8:	8b 00                	mov    (%eax),%eax
  1035ea:	8d 48 04             	lea    0x4(%eax),%ecx
  1035ed:	8b 55 08             	mov    0x8(%ebp),%edx
  1035f0:	89 0a                	mov    %ecx,(%edx)
  1035f2:	8b 00                	mov    (%eax),%eax
  1035f4:	99                   	cltd   
    }
}
  1035f5:	5d                   	pop    %ebp
  1035f6:	c3                   	ret    

001035f7 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1035f7:	55                   	push   %ebp
  1035f8:	89 e5                	mov    %esp,%ebp
  1035fa:	83 ec 18             	sub    $0x18,%esp
  1035fd:	e8 8a cc ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  103602:	05 4e c3 00 00       	add    $0xc34e,%eax
    va_list ap;

    va_start(ap, fmt);
  103607:	8d 45 14             	lea    0x14(%ebp),%eax
  10360a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  10360d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103610:	50                   	push   %eax
  103611:	ff 75 10             	pushl  0x10(%ebp)
  103614:	ff 75 0c             	pushl  0xc(%ebp)
  103617:	ff 75 08             	pushl  0x8(%ebp)
  10361a:	e8 06 00 00 00       	call   103625 <vprintfmt>
  10361f:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  103622:	90                   	nop
  103623:	c9                   	leave  
  103624:	c3                   	ret    

00103625 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  103625:	55                   	push   %ebp
  103626:	89 e5                	mov    %esp,%ebp
  103628:	57                   	push   %edi
  103629:	56                   	push   %esi
  10362a:	53                   	push   %ebx
  10362b:	83 ec 2c             	sub    $0x2c,%esp
  10362e:	e8 8c 04 00 00       	call   103abf <__x86.get_pc_thunk.di>
  103633:	81 c7 1d c3 00 00    	add    $0xc31d,%edi
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103639:	eb 17                	jmp    103652 <vprintfmt+0x2d>
            if (ch == '\0') {
  10363b:	85 db                	test   %ebx,%ebx
  10363d:	0f 84 9a 03 00 00    	je     1039dd <.L24+0x2d>
                return;
            }
            putch(ch, putdat);
  103643:	83 ec 08             	sub    $0x8,%esp
  103646:	ff 75 0c             	pushl  0xc(%ebp)
  103649:	53                   	push   %ebx
  10364a:	8b 45 08             	mov    0x8(%ebp),%eax
  10364d:	ff d0                	call   *%eax
  10364f:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103652:	8b 45 10             	mov    0x10(%ebp),%eax
  103655:	8d 50 01             	lea    0x1(%eax),%edx
  103658:	89 55 10             	mov    %edx,0x10(%ebp)
  10365b:	0f b6 00             	movzbl (%eax),%eax
  10365e:	0f b6 d8             	movzbl %al,%ebx
  103661:	83 fb 25             	cmp    $0x25,%ebx
  103664:	75 d5                	jne    10363b <vprintfmt+0x16>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103666:	c6 45 cb 20          	movb   $0x20,-0x35(%ebp)
        width = precision = -1;
  10366a:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  103671:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103674:	89 45 d8             	mov    %eax,-0x28(%ebp)
        lflag = altflag = 0;
  103677:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  10367e:	8b 45 cc             	mov    -0x34(%ebp),%eax
  103681:	89 45 d0             	mov    %eax,-0x30(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103684:	8b 45 10             	mov    0x10(%ebp),%eax
  103687:	8d 50 01             	lea    0x1(%eax),%edx
  10368a:	89 55 10             	mov    %edx,0x10(%ebp)
  10368d:	0f b6 00             	movzbl (%eax),%eax
  103690:	0f b6 d8             	movzbl %al,%ebx
  103693:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103696:	83 f8 55             	cmp    $0x55,%eax
  103699:	0f 87 11 03 00 00    	ja     1039b0 <.L24>
  10369f:	c1 e0 02             	shl    $0x2,%eax
  1036a2:	8b 84 38 88 48 ff ff 	mov    -0xb778(%eax,%edi,1),%eax
  1036a9:	01 f8                	add    %edi,%eax
  1036ab:	ff e0                	jmp    *%eax

001036ad <.L29>:

        // flag to pad on the right
        case '-':
            padc = '-';
  1036ad:	c6 45 cb 2d          	movb   $0x2d,-0x35(%ebp)
            goto reswitch;
  1036b1:	eb d1                	jmp    103684 <vprintfmt+0x5f>

001036b3 <.L31>:

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1036b3:	c6 45 cb 30          	movb   $0x30,-0x35(%ebp)
            goto reswitch;
  1036b7:	eb cb                	jmp    103684 <vprintfmt+0x5f>

001036b9 <.L32>:

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1036b9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
                precision = precision * 10 + ch - '0';
  1036c0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1036c3:	89 d0                	mov    %edx,%eax
  1036c5:	c1 e0 02             	shl    $0x2,%eax
  1036c8:	01 d0                	add    %edx,%eax
  1036ca:	01 c0                	add    %eax,%eax
  1036cc:	01 d8                	add    %ebx,%eax
  1036ce:	83 e8 30             	sub    $0x30,%eax
  1036d1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                ch = *fmt;
  1036d4:	8b 45 10             	mov    0x10(%ebp),%eax
  1036d7:	0f b6 00             	movzbl (%eax),%eax
  1036da:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1036dd:	83 fb 2f             	cmp    $0x2f,%ebx
  1036e0:	7e 39                	jle    10371b <.L25+0xc>
  1036e2:	83 fb 39             	cmp    $0x39,%ebx
  1036e5:	7f 34                	jg     10371b <.L25+0xc>
            for (precision = 0; ; ++ fmt) {
  1036e7:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1036eb:	eb d3                	jmp    1036c0 <.L32+0x7>

001036ed <.L28>:
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1036ed:	8b 45 14             	mov    0x14(%ebp),%eax
  1036f0:	8d 50 04             	lea    0x4(%eax),%edx
  1036f3:	89 55 14             	mov    %edx,0x14(%ebp)
  1036f6:	8b 00                	mov    (%eax),%eax
  1036f8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            goto process_precision;
  1036fb:	eb 1f                	jmp    10371c <.L25+0xd>

001036fd <.L30>:

        case '.':
            if (width < 0)
  1036fd:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  103701:	79 81                	jns    103684 <vprintfmt+0x5f>
                width = 0;
  103703:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
            goto reswitch;
  10370a:	e9 75 ff ff ff       	jmp    103684 <vprintfmt+0x5f>

0010370f <.L25>:

        case '#':
            altflag = 1;
  10370f:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
            goto reswitch;
  103716:	e9 69 ff ff ff       	jmp    103684 <vprintfmt+0x5f>
            goto process_precision;
  10371b:	90                   	nop

        process_precision:
            if (width < 0)
  10371c:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  103720:	0f 89 5e ff ff ff    	jns    103684 <vprintfmt+0x5f>
                width = precision, precision = -1;
  103726:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103729:	89 45 d8             	mov    %eax,-0x28(%ebp)
  10372c:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
            goto reswitch;
  103733:	e9 4c ff ff ff       	jmp    103684 <vprintfmt+0x5f>

00103738 <.L36>:

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  103738:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
            goto reswitch;
  10373c:	e9 43 ff ff ff       	jmp    103684 <vprintfmt+0x5f>

00103741 <.L33>:

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  103741:	8b 45 14             	mov    0x14(%ebp),%eax
  103744:	8d 50 04             	lea    0x4(%eax),%edx
  103747:	89 55 14             	mov    %edx,0x14(%ebp)
  10374a:	8b 00                	mov    (%eax),%eax
  10374c:	83 ec 08             	sub    $0x8,%esp
  10374f:	ff 75 0c             	pushl  0xc(%ebp)
  103752:	50                   	push   %eax
  103753:	8b 45 08             	mov    0x8(%ebp),%eax
  103756:	ff d0                	call   *%eax
  103758:	83 c4 10             	add    $0x10,%esp
            break;
  10375b:	e9 78 02 00 00       	jmp    1039d8 <.L24+0x28>

00103760 <.L35>:

        // error message
        case 'e':
            err = va_arg(ap, int);
  103760:	8b 45 14             	mov    0x14(%ebp),%eax
  103763:	8d 50 04             	lea    0x4(%eax),%edx
  103766:	89 55 14             	mov    %edx,0x14(%ebp)
  103769:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  10376b:	85 db                	test   %ebx,%ebx
  10376d:	79 02                	jns    103771 <.L35+0x11>
                err = -err;
  10376f:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  103771:	83 fb 06             	cmp    $0x6,%ebx
  103774:	7f 0b                	jg     103781 <.L35+0x21>
  103776:	8b b4 9f 40 01 00 00 	mov    0x140(%edi,%ebx,4),%esi
  10377d:	85 f6                	test   %esi,%esi
  10377f:	75 1b                	jne    10379c <.L35+0x3c>
                printfmt(putch, putdat, "error %d", err);
  103781:	53                   	push   %ebx
  103782:	8d 87 73 48 ff ff    	lea    -0xb78d(%edi),%eax
  103788:	50                   	push   %eax
  103789:	ff 75 0c             	pushl  0xc(%ebp)
  10378c:	ff 75 08             	pushl  0x8(%ebp)
  10378f:	e8 63 fe ff ff       	call   1035f7 <printfmt>
  103794:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103797:	e9 3c 02 00 00       	jmp    1039d8 <.L24+0x28>
                printfmt(putch, putdat, "%s", p);
  10379c:	56                   	push   %esi
  10379d:	8d 87 7c 48 ff ff    	lea    -0xb784(%edi),%eax
  1037a3:	50                   	push   %eax
  1037a4:	ff 75 0c             	pushl  0xc(%ebp)
  1037a7:	ff 75 08             	pushl  0x8(%ebp)
  1037aa:	e8 48 fe ff ff       	call   1035f7 <printfmt>
  1037af:	83 c4 10             	add    $0x10,%esp
            break;
  1037b2:	e9 21 02 00 00       	jmp    1039d8 <.L24+0x28>

001037b7 <.L39>:

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1037b7:	8b 45 14             	mov    0x14(%ebp),%eax
  1037ba:	8d 50 04             	lea    0x4(%eax),%edx
  1037bd:	89 55 14             	mov    %edx,0x14(%ebp)
  1037c0:	8b 30                	mov    (%eax),%esi
  1037c2:	85 f6                	test   %esi,%esi
  1037c4:	75 06                	jne    1037cc <.L39+0x15>
                p = "(null)";
  1037c6:	8d b7 7f 48 ff ff    	lea    -0xb781(%edi),%esi
            }
            if (width > 0 && padc != '-') {
  1037cc:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1037d0:	7e 78                	jle    10384a <.L39+0x93>
  1037d2:	80 7d cb 2d          	cmpb   $0x2d,-0x35(%ebp)
  1037d6:	74 72                	je     10384a <.L39+0x93>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1037d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1037db:	83 ec 08             	sub    $0x8,%esp
  1037de:	50                   	push   %eax
  1037df:	56                   	push   %esi
  1037e0:	89 fb                	mov    %edi,%ebx
  1037e2:	e8 57 f7 ff ff       	call   102f3e <strnlen>
  1037e7:	83 c4 10             	add    $0x10,%esp
  1037ea:	89 c2                	mov    %eax,%edx
  1037ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1037ef:	29 d0                	sub    %edx,%eax
  1037f1:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1037f4:	eb 17                	jmp    10380d <.L39+0x56>
                    putch(padc, putdat);
  1037f6:	0f be 45 cb          	movsbl -0x35(%ebp),%eax
  1037fa:	83 ec 08             	sub    $0x8,%esp
  1037fd:	ff 75 0c             	pushl  0xc(%ebp)
  103800:	50                   	push   %eax
  103801:	8b 45 08             	mov    0x8(%ebp),%eax
  103804:	ff d0                	call   *%eax
  103806:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  103809:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  10380d:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  103811:	7f e3                	jg     1037f6 <.L39+0x3f>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103813:	eb 35                	jmp    10384a <.L39+0x93>
                if (altflag && (ch < ' ' || ch > '~')) {
  103815:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  103819:	74 1c                	je     103837 <.L39+0x80>
  10381b:	83 fb 1f             	cmp    $0x1f,%ebx
  10381e:	7e 05                	jle    103825 <.L39+0x6e>
  103820:	83 fb 7e             	cmp    $0x7e,%ebx
  103823:	7e 12                	jle    103837 <.L39+0x80>
                    putch('?', putdat);
  103825:	83 ec 08             	sub    $0x8,%esp
  103828:	ff 75 0c             	pushl  0xc(%ebp)
  10382b:	6a 3f                	push   $0x3f
  10382d:	8b 45 08             	mov    0x8(%ebp),%eax
  103830:	ff d0                	call   *%eax
  103832:	83 c4 10             	add    $0x10,%esp
  103835:	eb 0f                	jmp    103846 <.L39+0x8f>
                }
                else {
                    putch(ch, putdat);
  103837:	83 ec 08             	sub    $0x8,%esp
  10383a:	ff 75 0c             	pushl  0xc(%ebp)
  10383d:	53                   	push   %ebx
  10383e:	8b 45 08             	mov    0x8(%ebp),%eax
  103841:	ff d0                	call   *%eax
  103843:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103846:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  10384a:	89 f0                	mov    %esi,%eax
  10384c:	8d 70 01             	lea    0x1(%eax),%esi
  10384f:	0f b6 00             	movzbl (%eax),%eax
  103852:	0f be d8             	movsbl %al,%ebx
  103855:	85 db                	test   %ebx,%ebx
  103857:	74 26                	je     10387f <.L39+0xc8>
  103859:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  10385d:	78 b6                	js     103815 <.L39+0x5e>
  10385f:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
  103863:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  103867:	79 ac                	jns    103815 <.L39+0x5e>
                }
            }
            for (; width > 0; width --) {
  103869:	eb 14                	jmp    10387f <.L39+0xc8>
                putch(' ', putdat);
  10386b:	83 ec 08             	sub    $0x8,%esp
  10386e:	ff 75 0c             	pushl  0xc(%ebp)
  103871:	6a 20                	push   $0x20
  103873:	8b 45 08             	mov    0x8(%ebp),%eax
  103876:	ff d0                	call   *%eax
  103878:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  10387b:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  10387f:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  103883:	7f e6                	jg     10386b <.L39+0xb4>
            }
            break;
  103885:	e9 4e 01 00 00       	jmp    1039d8 <.L24+0x28>

0010388a <.L34>:

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  10388a:	83 ec 08             	sub    $0x8,%esp
  10388d:	ff 75 d0             	pushl  -0x30(%ebp)
  103890:	8d 45 14             	lea    0x14(%ebp),%eax
  103893:	50                   	push   %eax
  103894:	e8 0d fd ff ff       	call   1035a6 <getint>
  103899:	83 c4 10             	add    $0x10,%esp
  10389c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10389f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            if ((long long)num < 0) {
  1038a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1038a5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1038a8:	85 d2                	test   %edx,%edx
  1038aa:	79 23                	jns    1038cf <.L34+0x45>
                putch('-', putdat);
  1038ac:	83 ec 08             	sub    $0x8,%esp
  1038af:	ff 75 0c             	pushl  0xc(%ebp)
  1038b2:	6a 2d                	push   $0x2d
  1038b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1038b7:	ff d0                	call   *%eax
  1038b9:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  1038bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1038bf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1038c2:	f7 d8                	neg    %eax
  1038c4:	83 d2 00             	adc    $0x0,%edx
  1038c7:	f7 da                	neg    %edx
  1038c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1038cc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            }
            base = 10;
  1038cf:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  1038d6:	e9 9f 00 00 00       	jmp    10397a <.L41+0x1f>

001038db <.L40>:

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1038db:	83 ec 08             	sub    $0x8,%esp
  1038de:	ff 75 d0             	pushl  -0x30(%ebp)
  1038e1:	8d 45 14             	lea    0x14(%ebp),%eax
  1038e4:	50                   	push   %eax
  1038e5:	e8 63 fc ff ff       	call   10354d <getuint>
  1038ea:	83 c4 10             	add    $0x10,%esp
  1038ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1038f0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 10;
  1038f3:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  1038fa:	eb 7e                	jmp    10397a <.L41+0x1f>

001038fc <.L37>:

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1038fc:	83 ec 08             	sub    $0x8,%esp
  1038ff:	ff 75 d0             	pushl  -0x30(%ebp)
  103902:	8d 45 14             	lea    0x14(%ebp),%eax
  103905:	50                   	push   %eax
  103906:	e8 42 fc ff ff       	call   10354d <getuint>
  10390b:	83 c4 10             	add    $0x10,%esp
  10390e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103911:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 8;
  103914:	c7 45 dc 08 00 00 00 	movl   $0x8,-0x24(%ebp)
            goto number;
  10391b:	eb 5d                	jmp    10397a <.L41+0x1f>

0010391d <.L38>:

        // pointer
        case 'p':
            putch('0', putdat);
  10391d:	83 ec 08             	sub    $0x8,%esp
  103920:	ff 75 0c             	pushl  0xc(%ebp)
  103923:	6a 30                	push   $0x30
  103925:	8b 45 08             	mov    0x8(%ebp),%eax
  103928:	ff d0                	call   *%eax
  10392a:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  10392d:	83 ec 08             	sub    $0x8,%esp
  103930:	ff 75 0c             	pushl  0xc(%ebp)
  103933:	6a 78                	push   $0x78
  103935:	8b 45 08             	mov    0x8(%ebp),%eax
  103938:	ff d0                	call   *%eax
  10393a:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  10393d:	8b 45 14             	mov    0x14(%ebp),%eax
  103940:	8d 50 04             	lea    0x4(%eax),%edx
  103943:	89 55 14             	mov    %edx,0x14(%ebp)
  103946:	8b 00                	mov    (%eax),%eax
  103948:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10394b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
            base = 16;
  103952:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
            goto number;
  103959:	eb 1f                	jmp    10397a <.L41+0x1f>

0010395b <.L41>:

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10395b:	83 ec 08             	sub    $0x8,%esp
  10395e:	ff 75 d0             	pushl  -0x30(%ebp)
  103961:	8d 45 14             	lea    0x14(%ebp),%eax
  103964:	50                   	push   %eax
  103965:	e8 e3 fb ff ff       	call   10354d <getuint>
  10396a:	83 c4 10             	add    $0x10,%esp
  10396d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103970:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 16;
  103973:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10397a:	0f be 55 cb          	movsbl -0x35(%ebp),%edx
  10397e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103981:	83 ec 04             	sub    $0x4,%esp
  103984:	52                   	push   %edx
  103985:	ff 75 d8             	pushl  -0x28(%ebp)
  103988:	50                   	push   %eax
  103989:	ff 75 e4             	pushl  -0x1c(%ebp)
  10398c:	ff 75 e0             	pushl  -0x20(%ebp)
  10398f:	ff 75 0c             	pushl  0xc(%ebp)
  103992:	ff 75 08             	pushl  0x8(%ebp)
  103995:	e8 b0 fa ff ff       	call   10344a <printnum>
  10399a:	83 c4 20             	add    $0x20,%esp
            break;
  10399d:	eb 39                	jmp    1039d8 <.L24+0x28>

0010399f <.L27>:

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  10399f:	83 ec 08             	sub    $0x8,%esp
  1039a2:	ff 75 0c             	pushl  0xc(%ebp)
  1039a5:	53                   	push   %ebx
  1039a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1039a9:	ff d0                	call   *%eax
  1039ab:	83 c4 10             	add    $0x10,%esp
            break;
  1039ae:	eb 28                	jmp    1039d8 <.L24+0x28>

001039b0 <.L24>:

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1039b0:	83 ec 08             	sub    $0x8,%esp
  1039b3:	ff 75 0c             	pushl  0xc(%ebp)
  1039b6:	6a 25                	push   $0x25
  1039b8:	8b 45 08             	mov    0x8(%ebp),%eax
  1039bb:	ff d0                	call   *%eax
  1039bd:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  1039c0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1039c4:	eb 04                	jmp    1039ca <.L24+0x1a>
  1039c6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1039ca:	8b 45 10             	mov    0x10(%ebp),%eax
  1039cd:	83 e8 01             	sub    $0x1,%eax
  1039d0:	0f b6 00             	movzbl (%eax),%eax
  1039d3:	3c 25                	cmp    $0x25,%al
  1039d5:	75 ef                	jne    1039c6 <.L24+0x16>
                /* do nothing */;
            break;
  1039d7:	90                   	nop
    while (1) {
  1039d8:	e9 5c fc ff ff       	jmp    103639 <vprintfmt+0x14>
                return;
  1039dd:	90                   	nop
        }
    }
}
  1039de:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1039e1:	5b                   	pop    %ebx
  1039e2:	5e                   	pop    %esi
  1039e3:	5f                   	pop    %edi
  1039e4:	5d                   	pop    %ebp
  1039e5:	c3                   	ret    

001039e6 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1039e6:	55                   	push   %ebp
  1039e7:	89 e5                	mov    %esp,%ebp
  1039e9:	e8 9e c8 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  1039ee:	05 62 bf 00 00       	add    $0xbf62,%eax
    b->cnt ++;
  1039f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1039f6:	8b 40 08             	mov    0x8(%eax),%eax
  1039f9:	8d 50 01             	lea    0x1(%eax),%edx
  1039fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1039ff:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103a02:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a05:	8b 10                	mov    (%eax),%edx
  103a07:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a0a:	8b 40 04             	mov    0x4(%eax),%eax
  103a0d:	39 c2                	cmp    %eax,%edx
  103a0f:	73 12                	jae    103a23 <sprintputch+0x3d>
        *b->buf ++ = ch;
  103a11:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a14:	8b 00                	mov    (%eax),%eax
  103a16:	8d 48 01             	lea    0x1(%eax),%ecx
  103a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  103a1c:	89 0a                	mov    %ecx,(%edx)
  103a1e:	8b 55 08             	mov    0x8(%ebp),%edx
  103a21:	88 10                	mov    %dl,(%eax)
    }
}
  103a23:	90                   	nop
  103a24:	5d                   	pop    %ebp
  103a25:	c3                   	ret    

00103a26 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103a26:	55                   	push   %ebp
  103a27:	89 e5                	mov    %esp,%ebp
  103a29:	83 ec 18             	sub    $0x18,%esp
  103a2c:	e8 5b c8 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  103a31:	05 1f bf 00 00       	add    $0xbf1f,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103a36:	8d 45 14             	lea    0x14(%ebp),%eax
  103a39:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a3f:	50                   	push   %eax
  103a40:	ff 75 10             	pushl  0x10(%ebp)
  103a43:	ff 75 0c             	pushl  0xc(%ebp)
  103a46:	ff 75 08             	pushl  0x8(%ebp)
  103a49:	e8 0b 00 00 00       	call   103a59 <vsnprintf>
  103a4e:	83 c4 10             	add    $0x10,%esp
  103a51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103a57:	c9                   	leave  
  103a58:	c3                   	ret    

00103a59 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103a59:	55                   	push   %ebp
  103a5a:	89 e5                	mov    %esp,%ebp
  103a5c:	83 ec 18             	sub    $0x18,%esp
  103a5f:	e8 28 c8 ff ff       	call   10028c <__x86.get_pc_thunk.ax>
  103a64:	05 ec be 00 00       	add    $0xbeec,%eax
    struct sprintbuf b = {str, str + size - 1, 0};
  103a69:	8b 55 08             	mov    0x8(%ebp),%edx
  103a6c:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103a6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  103a72:	8d 4a ff             	lea    -0x1(%edx),%ecx
  103a75:	8b 55 08             	mov    0x8(%ebp),%edx
  103a78:	01 ca                	add    %ecx,%edx
  103a7a:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103a7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103a84:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103a88:	74 0a                	je     103a94 <vsnprintf+0x3b>
  103a8a:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103a8d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103a90:	39 d1                	cmp    %edx,%ecx
  103a92:	76 07                	jbe    103a9b <vsnprintf+0x42>
        return -E_INVAL;
  103a94:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103a99:	eb 22                	jmp    103abd <vsnprintf+0x64>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103a9b:	ff 75 14             	pushl  0x14(%ebp)
  103a9e:	ff 75 10             	pushl  0x10(%ebp)
  103aa1:	8d 55 ec             	lea    -0x14(%ebp),%edx
  103aa4:	52                   	push   %edx
  103aa5:	8d 80 96 40 ff ff    	lea    -0xbf6a(%eax),%eax
  103aab:	50                   	push   %eax
  103aac:	e8 74 fb ff ff       	call   103625 <vprintfmt>
  103ab1:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  103ab4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103ab7:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  103aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103abd:	c9                   	leave  
  103abe:	c3                   	ret    

00103abf <__x86.get_pc_thunk.di>:
  103abf:	8b 3c 24             	mov    (%esp),%edi
  103ac2:	c3                   	ret    
