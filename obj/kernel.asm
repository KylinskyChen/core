
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:

/*
 * 函数功能：内核入口；
 */
void
kern_init(void){
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	53                   	push   %ebx
  100004:	83 ec 04             	sub    $0x4,%esp
  100007:	e8 57 02 00 00       	call   100263 <__x86.get_pc_thunk.bx>
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
  100031:	e8 34 32 00 00       	call   10326a <memset>
  100036:	83 c4 10             	add    $0x10,%esp

    // 初始化控制台（控制显卡交互）；
    // 只有设置好了对显卡的控制后，std_out 输出的信息（例如 cprintf）才能显示在控制台中；
    cons_init();
  100039:	e8 01 18 00 00       	call   10183f <cons_init>
    // print_kerninfo();

    // grade_backtrace();

    // 初始化物理内存管理器；
    pmm_init();
  10003e:	e8 87 2e 00 00       	call   102eca <pmm_init>

    // 初始化中断控制器；
    pic_init();                
  100043:	e8 86 19 00 00       	call   1019ce <pic_init>
    // 初始化中断描述符表；
    idt_init();
  100048:	e8 18 1b 00 00       	call   101b65 <idt_init>

    // 初始化定时芯片；
    clock_init();
  10004d:	e8 e9 0e 00 00       	call   100f3b <clock_init>
    // 开中断；
    intr_enable();              
  100052:	e8 bf 1a 00 00       	call   101b16 <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    // lab1_switch_test();

    // 阻塞，避免内核程序退出。通过监听中断事件进行服务；
    while (1);
  100057:	eb fe                	jmp    100057 <kern_init+0x57>

00100059 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100059:	55                   	push   %ebp
  10005a:	89 e5                	mov    %esp,%ebp
  10005c:	53                   	push   %ebx
  10005d:	83 ec 04             	sub    $0x4,%esp
  100060:	e8 fa 01 00 00       	call   10025f <__x86.get_pc_thunk.ax>
  100065:	05 eb f8 00 00       	add    $0xf8eb,%eax
    mon_backtrace(0, NULL, NULL);
  10006a:	83 ec 04             	sub    $0x4,%esp
  10006d:	6a 00                	push   $0x0
  10006f:	6a 00                	push   $0x0
  100071:	6a 00                	push   $0x0
  100073:	89 c3                	mov    %eax,%ebx
  100075:	e8 9e 0e 00 00       	call   100f18 <mon_backtrace>
  10007a:	83 c4 10             	add    $0x10,%esp
}
  10007d:	90                   	nop
  10007e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100081:	c9                   	leave  
  100082:	c3                   	ret    

00100083 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100083:	55                   	push   %ebp
  100084:	89 e5                	mov    %esp,%ebp
  100086:	53                   	push   %ebx
  100087:	83 ec 04             	sub    $0x4,%esp
  10008a:	e8 d0 01 00 00       	call   10025f <__x86.get_pc_thunk.ax>
  10008f:	05 c1 f8 00 00       	add    $0xf8c1,%eax
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  100094:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  100097:	8b 55 0c             	mov    0xc(%ebp),%edx
  10009a:	8d 5d 08             	lea    0x8(%ebp),%ebx
  10009d:	8b 45 08             	mov    0x8(%ebp),%eax
  1000a0:	51                   	push   %ecx
  1000a1:	52                   	push   %edx
  1000a2:	53                   	push   %ebx
  1000a3:	50                   	push   %eax
  1000a4:	e8 b0 ff ff ff       	call   100059 <grade_backtrace2>
  1000a9:	83 c4 10             	add    $0x10,%esp
}
  1000ac:	90                   	nop
  1000ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000b0:	c9                   	leave  
  1000b1:	c3                   	ret    

001000b2 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000b2:	55                   	push   %ebp
  1000b3:	89 e5                	mov    %esp,%ebp
  1000b5:	83 ec 08             	sub    $0x8,%esp
  1000b8:	e8 a2 01 00 00       	call   10025f <__x86.get_pc_thunk.ax>
  1000bd:	05 93 f8 00 00       	add    $0xf893,%eax
    grade_backtrace1(arg0, arg2);
  1000c2:	83 ec 08             	sub    $0x8,%esp
  1000c5:	ff 75 10             	pushl  0x10(%ebp)
  1000c8:	ff 75 08             	pushl  0x8(%ebp)
  1000cb:	e8 b3 ff ff ff       	call   100083 <grade_backtrace1>
  1000d0:	83 c4 10             	add    $0x10,%esp
}
  1000d3:	90                   	nop
  1000d4:	c9                   	leave  
  1000d5:	c3                   	ret    

001000d6 <grade_backtrace>:

void
grade_backtrace(void) {
  1000d6:	55                   	push   %ebp
  1000d7:	89 e5                	mov    %esp,%ebp
  1000d9:	83 ec 08             	sub    $0x8,%esp
  1000dc:	e8 7e 01 00 00       	call   10025f <__x86.get_pc_thunk.ax>
  1000e1:	05 6f f8 00 00       	add    $0xf86f,%eax
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e6:	8d 80 b0 06 ff ff    	lea    -0xf950(%eax),%eax
  1000ec:	83 ec 04             	sub    $0x4,%esp
  1000ef:	68 00 00 ff ff       	push   $0xffff0000
  1000f4:	50                   	push   %eax
  1000f5:	6a 00                	push   $0x0
  1000f7:	e8 b6 ff ff ff       	call   1000b2 <grade_backtrace0>
  1000fc:	83 c4 10             	add    $0x10,%esp
}
  1000ff:	90                   	nop
  100100:	c9                   	leave  
  100101:	c3                   	ret    

00100102 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100102:	55                   	push   %ebp
  100103:	89 e5                	mov    %esp,%ebp
  100105:	53                   	push   %ebx
  100106:	83 ec 14             	sub    $0x14,%esp
  100109:	e8 55 01 00 00       	call   100263 <__x86.get_pc_thunk.bx>
  10010e:	81 c3 42 f8 00 00    	add    $0xf842,%ebx
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100114:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100117:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10011a:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10011d:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100120:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100124:	0f b7 c0             	movzwl %ax,%eax
  100127:	83 e0 03             	and    $0x3,%eax
  10012a:	89 c2                	mov    %eax,%edx
  10012c:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100132:	83 ec 04             	sub    $0x4,%esp
  100135:	52                   	push   %edx
  100136:	50                   	push   %eax
  100137:	8d 83 48 41 ff ff    	lea    -0xbeb8(%ebx),%eax
  10013d:	50                   	push   %eax
  10013e:	e8 93 01 00 00       	call   1002d6 <cprintf>
  100143:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  100146:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10014a:	0f b7 d0             	movzwl %ax,%edx
  10014d:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100153:	83 ec 04             	sub    $0x4,%esp
  100156:	52                   	push   %edx
  100157:	50                   	push   %eax
  100158:	8d 83 56 41 ff ff    	lea    -0xbeaa(%ebx),%eax
  10015e:	50                   	push   %eax
  10015f:	e8 72 01 00 00       	call   1002d6 <cprintf>
  100164:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  100167:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10016b:	0f b7 d0             	movzwl %ax,%edx
  10016e:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100174:	83 ec 04             	sub    $0x4,%esp
  100177:	52                   	push   %edx
  100178:	50                   	push   %eax
  100179:	8d 83 64 41 ff ff    	lea    -0xbe9c(%ebx),%eax
  10017f:	50                   	push   %eax
  100180:	e8 51 01 00 00       	call   1002d6 <cprintf>
  100185:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  100188:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10018c:	0f b7 d0             	movzwl %ax,%edx
  10018f:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  100195:	83 ec 04             	sub    $0x4,%esp
  100198:	52                   	push   %edx
  100199:	50                   	push   %eax
  10019a:	8d 83 72 41 ff ff    	lea    -0xbe8e(%ebx),%eax
  1001a0:	50                   	push   %eax
  1001a1:	e8 30 01 00 00       	call   1002d6 <cprintf>
  1001a6:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  1001a9:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001ad:	0f b7 d0             	movzwl %ax,%edx
  1001b0:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001b6:	83 ec 04             	sub    $0x4,%esp
  1001b9:	52                   	push   %edx
  1001ba:	50                   	push   %eax
  1001bb:	8d 83 80 41 ff ff    	lea    -0xbe80(%ebx),%eax
  1001c1:	50                   	push   %eax
  1001c2:	e8 0f 01 00 00       	call   1002d6 <cprintf>
  1001c7:	83 c4 10             	add    $0x10,%esp
    round ++;
  1001ca:	8b 83 70 01 00 00    	mov    0x170(%ebx),%eax
  1001d0:	83 c0 01             	add    $0x1,%eax
  1001d3:	89 83 70 01 00 00    	mov    %eax,0x170(%ebx)
}
  1001d9:	90                   	nop
  1001da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1001dd:	c9                   	leave  
  1001de:	c3                   	ret    

001001df <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001df:	55                   	push   %ebp
  1001e0:	89 e5                	mov    %esp,%ebp
  1001e2:	e8 78 00 00 00       	call   10025f <__x86.get_pc_thunk.ax>
  1001e7:	05 69 f7 00 00       	add    $0xf769,%eax
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
  1001ec:	83 ec 08             	sub    $0x8,%esp
  1001ef:	cd 78                	int    $0x78
  1001f1:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
}
  1001f3:	90                   	nop
  1001f4:	5d                   	pop    %ebp
  1001f5:	c3                   	ret    

001001f6 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001f6:	55                   	push   %ebp
  1001f7:	89 e5                	mov    %esp,%ebp
  1001f9:	e8 61 00 00 00       	call   10025f <__x86.get_pc_thunk.ax>
  1001fe:	05 52 f7 00 00       	add    $0xf752,%eax
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
  100203:	cd 79                	int    $0x79
  100205:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp \n"
	    : 
	    : "i"(T_SWITCH_TOK)
	);
}
  100207:	90                   	nop
  100208:	5d                   	pop    %ebp
  100209:	c3                   	ret    

0010020a <lab1_switch_test>:

static void
lab1_switch_test(void) {
  10020a:	55                   	push   %ebp
  10020b:	89 e5                	mov    %esp,%ebp
  10020d:	53                   	push   %ebx
  10020e:	83 ec 04             	sub    $0x4,%esp
  100211:	e8 4d 00 00 00       	call   100263 <__x86.get_pc_thunk.bx>
  100216:	81 c3 3a f7 00 00    	add    $0xf73a,%ebx
    lab1_print_cur_status();
  10021c:	e8 e1 fe ff ff       	call   100102 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100221:	83 ec 0c             	sub    $0xc,%esp
  100224:	8d 83 90 41 ff ff    	lea    -0xbe70(%ebx),%eax
  10022a:	50                   	push   %eax
  10022b:	e8 a6 00 00 00       	call   1002d6 <cprintf>
  100230:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  100233:	e8 a7 ff ff ff       	call   1001df <lab1_switch_to_user>
    lab1_print_cur_status();
  100238:	e8 c5 fe ff ff       	call   100102 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10023d:	83 ec 0c             	sub    $0xc,%esp
  100240:	8d 83 b0 41 ff ff    	lea    -0xbe50(%ebx),%eax
  100246:	50                   	push   %eax
  100247:	e8 8a 00 00 00       	call   1002d6 <cprintf>
  10024c:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  10024f:	e8 a2 ff ff ff       	call   1001f6 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100254:	e8 a9 fe ff ff       	call   100102 <lab1_print_cur_status>
}
  100259:	90                   	nop
  10025a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10025d:	c9                   	leave  
  10025e:	c3                   	ret    

0010025f <__x86.get_pc_thunk.ax>:
  10025f:	8b 04 24             	mov    (%esp),%eax
  100262:	c3                   	ret    

00100263 <__x86.get_pc_thunk.bx>:
  100263:	8b 1c 24             	mov    (%esp),%ebx
  100266:	c3                   	ret    

00100267 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100267:	55                   	push   %ebp
  100268:	89 e5                	mov    %esp,%ebp
  10026a:	53                   	push   %ebx
  10026b:	83 ec 04             	sub    $0x4,%esp
  10026e:	e8 ec ff ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100273:	05 dd f6 00 00       	add    $0xf6dd,%eax
    cons_putc(c);
  100278:	83 ec 0c             	sub    $0xc,%esp
  10027b:	ff 75 08             	pushl  0x8(%ebp)
  10027e:	89 c3                	mov    %eax,%ebx
  100280:	e8 fd 15 00 00       	call   101882 <cons_putc>
  100285:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  100288:	8b 45 0c             	mov    0xc(%ebp),%eax
  10028b:	8b 00                	mov    (%eax),%eax
  10028d:	8d 50 01             	lea    0x1(%eax),%edx
  100290:	8b 45 0c             	mov    0xc(%ebp),%eax
  100293:	89 10                	mov    %edx,(%eax)
}
  100295:	90                   	nop
  100296:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100299:	c9                   	leave  
  10029a:	c3                   	ret    

0010029b <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  10029b:	55                   	push   %ebp
  10029c:	89 e5                	mov    %esp,%ebp
  10029e:	53                   	push   %ebx
  10029f:	83 ec 14             	sub    $0x14,%esp
  1002a2:	e8 b8 ff ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1002a7:	05 a9 f6 00 00       	add    $0xf6a9,%eax
    int cnt = 0;
  1002ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002b3:	ff 75 0c             	pushl  0xc(%ebp)
  1002b6:	ff 75 08             	pushl  0x8(%ebp)
  1002b9:	8d 55 f4             	lea    -0xc(%ebp),%edx
  1002bc:	52                   	push   %edx
  1002bd:	8d 90 17 09 ff ff    	lea    -0xf6e9(%eax),%edx
  1002c3:	52                   	push   %edx
  1002c4:	89 c3                	mov    %eax,%ebx
  1002c6:	e8 2d 33 00 00       	call   1035f8 <vprintfmt>
  1002cb:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1002ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1002d4:	c9                   	leave  
  1002d5:	c3                   	ret    

001002d6 <cprintf>:
/* 
 * 函数功能：格式化一个字符串同时将它写入标准输出；
 * 备注信息：返回值为将要写入标准输出的字符数；
 */
int
cprintf(const char *fmt, ...) {
  1002d6:	55                   	push   %ebp
  1002d7:	89 e5                	mov    %esp,%ebp
  1002d9:	83 ec 18             	sub    $0x18,%esp
  1002dc:	e8 7e ff ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1002e1:	05 6f f6 00 00       	add    $0xf66f,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);          // 预处理可变长参数；
  1002e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  1002e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  1002ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002ef:	83 ec 08             	sub    $0x8,%esp
  1002f2:	50                   	push   %eax
  1002f3:	ff 75 08             	pushl  0x8(%ebp)
  1002f6:	e8 a0 ff ff ff       	call   10029b <vcprintf>
  1002fb:	83 c4 10             	add    $0x10,%esp
  1002fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100301:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100304:	c9                   	leave  
  100305:	c3                   	ret    

00100306 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100306:	55                   	push   %ebp
  100307:	89 e5                	mov    %esp,%ebp
  100309:	53                   	push   %ebx
  10030a:	83 ec 04             	sub    $0x4,%esp
  10030d:	e8 4d ff ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100312:	05 3e f6 00 00       	add    $0xf63e,%eax
    cons_putc(c);
  100317:	83 ec 0c             	sub    $0xc,%esp
  10031a:	ff 75 08             	pushl  0x8(%ebp)
  10031d:	89 c3                	mov    %eax,%ebx
  10031f:	e8 5e 15 00 00       	call   101882 <cons_putc>
  100324:	83 c4 10             	add    $0x10,%esp
}
  100327:	90                   	nop
  100328:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10032b:	c9                   	leave  
  10032c:	c3                   	ret    

0010032d <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10032d:	55                   	push   %ebp
  10032e:	89 e5                	mov    %esp,%ebp
  100330:	83 ec 18             	sub    $0x18,%esp
  100333:	e8 27 ff ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100338:	05 18 f6 00 00       	add    $0xf618,%eax
    int cnt = 0;
  10033d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100344:	eb 14                	jmp    10035a <cputs+0x2d>
        cputch(c, &cnt);
  100346:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10034a:	83 ec 08             	sub    $0x8,%esp
  10034d:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100350:	52                   	push   %edx
  100351:	50                   	push   %eax
  100352:	e8 10 ff ff ff       	call   100267 <cputch>
  100357:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  10035a:	8b 45 08             	mov    0x8(%ebp),%eax
  10035d:	8d 50 01             	lea    0x1(%eax),%edx
  100360:	89 55 08             	mov    %edx,0x8(%ebp)
  100363:	0f b6 00             	movzbl (%eax),%eax
  100366:	88 45 f7             	mov    %al,-0x9(%ebp)
  100369:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  10036d:	75 d7                	jne    100346 <cputs+0x19>
    }
    cputch('\n', &cnt);
  10036f:	83 ec 08             	sub    $0x8,%esp
  100372:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100375:	50                   	push   %eax
  100376:	6a 0a                	push   $0xa
  100378:	e8 ea fe ff ff       	call   100267 <cputch>
  10037d:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100380:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100383:	c9                   	leave  
  100384:	c3                   	ret    

00100385 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100385:	55                   	push   %ebp
  100386:	89 e5                	mov    %esp,%ebp
  100388:	53                   	push   %ebx
  100389:	83 ec 14             	sub    $0x14,%esp
  10038c:	e8 d2 fe ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100391:	81 c3 bf f5 00 00    	add    $0xf5bf,%ebx
    int c;
    while ((c = cons_getc()) == 0)
  100397:	e8 20 15 00 00       	call   1018bc <cons_getc>
  10039c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10039f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003a3:	74 f2                	je     100397 <getchar+0x12>
        /* do nothing */;
    return c;
  1003a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003a8:	83 c4 14             	add    $0x14,%esp
  1003ab:	5b                   	pop    %ebx
  1003ac:	5d                   	pop    %ebp
  1003ad:	c3                   	ret    

001003ae <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  1003ae:	55                   	push   %ebp
  1003af:	89 e5                	mov    %esp,%ebp
  1003b1:	53                   	push   %ebx
  1003b2:	83 ec 14             	sub    $0x14,%esp
  1003b5:	e8 a9 fe ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  1003ba:	81 c3 96 f5 00 00    	add    $0xf596,%ebx
    if (prompt != NULL) {
  1003c0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1003c4:	74 15                	je     1003db <readline+0x2d>
        cprintf("%s", prompt);
  1003c6:	83 ec 08             	sub    $0x8,%esp
  1003c9:	ff 75 08             	pushl  0x8(%ebp)
  1003cc:	8d 83 cf 41 ff ff    	lea    -0xbe31(%ebx),%eax
  1003d2:	50                   	push   %eax
  1003d3:	e8 fe fe ff ff       	call   1002d6 <cprintf>
  1003d8:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  1003db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  1003e2:	e8 9e ff ff ff       	call   100385 <getchar>
  1003e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  1003ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1003ee:	79 0a                	jns    1003fa <readline+0x4c>
            return NULL;
  1003f0:	b8 00 00 00 00       	mov    $0x0,%eax
  1003f5:	e9 87 00 00 00       	jmp    100481 <readline+0xd3>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  1003fa:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  1003fe:	7e 2c                	jle    10042c <readline+0x7e>
  100400:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100407:	7f 23                	jg     10042c <readline+0x7e>
            cputchar(c);
  100409:	83 ec 0c             	sub    $0xc,%esp
  10040c:	ff 75 f0             	pushl  -0x10(%ebp)
  10040f:	e8 f2 fe ff ff       	call   100306 <cputchar>
  100414:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  100417:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10041a:	8d 50 01             	lea    0x1(%eax),%edx
  10041d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100420:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100423:	88 94 03 90 01 00 00 	mov    %dl,0x190(%ebx,%eax,1)
  10042a:	eb 50                	jmp    10047c <readline+0xce>
        }
        else if (c == '\b' && i > 0) {
  10042c:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100430:	75 1a                	jne    10044c <readline+0x9e>
  100432:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100436:	7e 14                	jle    10044c <readline+0x9e>
            cputchar(c);
  100438:	83 ec 0c             	sub    $0xc,%esp
  10043b:	ff 75 f0             	pushl  -0x10(%ebp)
  10043e:	e8 c3 fe ff ff       	call   100306 <cputchar>
  100443:	83 c4 10             	add    $0x10,%esp
            i --;
  100446:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10044a:	eb 30                	jmp    10047c <readline+0xce>
        }
        else if (c == '\n' || c == '\r') {
  10044c:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100450:	74 06                	je     100458 <readline+0xaa>
  100452:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  100456:	75 8a                	jne    1003e2 <readline+0x34>
            cputchar(c);
  100458:	83 ec 0c             	sub    $0xc,%esp
  10045b:	ff 75 f0             	pushl  -0x10(%ebp)
  10045e:	e8 a3 fe ff ff       	call   100306 <cputchar>
  100463:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  100466:	8d 93 90 01 00 00    	lea    0x190(%ebx),%edx
  10046c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10046f:	01 d0                	add    %edx,%eax
  100471:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  100474:	8d 83 90 01 00 00    	lea    0x190(%ebx),%eax
  10047a:	eb 05                	jmp    100481 <readline+0xd3>
        c = getchar();
  10047c:	e9 61 ff ff ff       	jmp    1003e2 <readline+0x34>
        }
    }
}
  100481:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100484:	c9                   	leave  
  100485:	c3                   	ret    

00100486 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100486:	55                   	push   %ebp
  100487:	89 e5                	mov    %esp,%ebp
  100489:	53                   	push   %ebx
  10048a:	83 ec 14             	sub    $0x14,%esp
  10048d:	e8 d1 fd ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100492:	81 c3 be f4 00 00    	add    $0xf4be,%ebx
    if (is_panic) {
  100498:	8b 83 90 05 00 00    	mov    0x590(%ebx),%eax
  10049e:	85 c0                	test   %eax,%eax
  1004a0:	75 4e                	jne    1004f0 <__panic+0x6a>
        goto panic_dead;
    }
    is_panic = 1;
  1004a2:	c7 83 90 05 00 00 01 	movl   $0x1,0x590(%ebx)
  1004a9:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1004ac:	8d 45 14             	lea    0x14(%ebp),%eax
  1004af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1004b2:	83 ec 04             	sub    $0x4,%esp
  1004b5:	ff 75 0c             	pushl  0xc(%ebp)
  1004b8:	ff 75 08             	pushl  0x8(%ebp)
  1004bb:	8d 83 d2 41 ff ff    	lea    -0xbe2e(%ebx),%eax
  1004c1:	50                   	push   %eax
  1004c2:	e8 0f fe ff ff       	call   1002d6 <cprintf>
  1004c7:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  1004ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004cd:	83 ec 08             	sub    $0x8,%esp
  1004d0:	50                   	push   %eax
  1004d1:	ff 75 10             	pushl  0x10(%ebp)
  1004d4:	e8 c2 fd ff ff       	call   10029b <vcprintf>
  1004d9:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1004dc:	83 ec 0c             	sub    $0xc,%esp
  1004df:	8d 83 ee 41 ff ff    	lea    -0xbe12(%ebx),%eax
  1004e5:	50                   	push   %eax
  1004e6:	e8 eb fd ff ff       	call   1002d6 <cprintf>
  1004eb:	83 c4 10             	add    $0x10,%esp
  1004ee:	eb 01                	jmp    1004f1 <__panic+0x6b>
        goto panic_dead;
  1004f0:	90                   	nop
    va_end(ap);

panic_dead:
    intr_disable();
  1004f1:	e8 31 16 00 00       	call   101b27 <intr_disable>
    while (1) {
        kmonitor(NULL);
  1004f6:	83 ec 0c             	sub    $0xc,%esp
  1004f9:	6a 00                	push   $0x0
  1004fb:	e8 fe 08 00 00       	call   100dfe <kmonitor>
  100500:	83 c4 10             	add    $0x10,%esp
  100503:	eb f1                	jmp    1004f6 <__panic+0x70>

00100505 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100505:	55                   	push   %ebp
  100506:	89 e5                	mov    %esp,%ebp
  100508:	53                   	push   %ebx
  100509:	83 ec 14             	sub    $0x14,%esp
  10050c:	e8 52 fd ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100511:	81 c3 3f f4 00 00    	add    $0xf43f,%ebx
    va_list ap;
    va_start(ap, fmt);
  100517:	8d 45 14             	lea    0x14(%ebp),%eax
  10051a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10051d:	83 ec 04             	sub    $0x4,%esp
  100520:	ff 75 0c             	pushl  0xc(%ebp)
  100523:	ff 75 08             	pushl  0x8(%ebp)
  100526:	8d 83 f0 41 ff ff    	lea    -0xbe10(%ebx),%eax
  10052c:	50                   	push   %eax
  10052d:	e8 a4 fd ff ff       	call   1002d6 <cprintf>
  100532:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100535:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100538:	83 ec 08             	sub    $0x8,%esp
  10053b:	50                   	push   %eax
  10053c:	ff 75 10             	pushl  0x10(%ebp)
  10053f:	e8 57 fd ff ff       	call   10029b <vcprintf>
  100544:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  100547:	83 ec 0c             	sub    $0xc,%esp
  10054a:	8d 83 ee 41 ff ff    	lea    -0xbe12(%ebx),%eax
  100550:	50                   	push   %eax
  100551:	e8 80 fd ff ff       	call   1002d6 <cprintf>
  100556:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  100559:	90                   	nop
  10055a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10055d:	c9                   	leave  
  10055e:	c3                   	ret    

0010055f <is_kernel_panic>:

bool
is_kernel_panic(void) {
  10055f:	55                   	push   %ebp
  100560:	89 e5                	mov    %esp,%ebp
  100562:	e8 f8 fc ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100567:	05 e9 f3 00 00       	add    $0xf3e9,%eax
    return is_panic;
  10056c:	8b 80 90 05 00 00    	mov    0x590(%eax),%eax
}
  100572:	5d                   	pop    %ebp
  100573:	c3                   	ret    

00100574 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  100574:	55                   	push   %ebp
  100575:	89 e5                	mov    %esp,%ebp
  100577:	83 ec 20             	sub    $0x20,%esp
  10057a:	e8 e0 fc ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  10057f:	05 d1 f3 00 00       	add    $0xf3d1,%eax
    int l = *region_left, r = *region_right, any_matches = 0;
  100584:	8b 45 0c             	mov    0xc(%ebp),%eax
  100587:	8b 00                	mov    (%eax),%eax
  100589:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10058c:	8b 45 10             	mov    0x10(%ebp),%eax
  10058f:	8b 00                	mov    (%eax),%eax
  100591:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100594:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  10059b:	e9 d2 00 00 00       	jmp    100672 <stab_binsearch+0xfe>
        int true_m = (l + r) / 2, m = true_m;
  1005a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1005a6:	01 d0                	add    %edx,%eax
  1005a8:	89 c2                	mov    %eax,%edx
  1005aa:	c1 ea 1f             	shr    $0x1f,%edx
  1005ad:	01 d0                	add    %edx,%eax
  1005af:	d1 f8                	sar    %eax
  1005b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1005b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1005b7:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1005ba:	eb 04                	jmp    1005c0 <stab_binsearch+0x4c>
            m --;
  1005bc:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1005c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005c3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1005c6:	7c 1f                	jl     1005e7 <stab_binsearch+0x73>
  1005c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005cb:	89 d0                	mov    %edx,%eax
  1005cd:	01 c0                	add    %eax,%eax
  1005cf:	01 d0                	add    %edx,%eax
  1005d1:	c1 e0 02             	shl    $0x2,%eax
  1005d4:	89 c2                	mov    %eax,%edx
  1005d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1005d9:	01 d0                	add    %edx,%eax
  1005db:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1005df:	0f b6 c0             	movzbl %al,%eax
  1005e2:	39 45 14             	cmp    %eax,0x14(%ebp)
  1005e5:	75 d5                	jne    1005bc <stab_binsearch+0x48>
        }
        if (m < l) {    // no match in [l, m]
  1005e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005ea:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1005ed:	7d 0b                	jge    1005fa <stab_binsearch+0x86>
            l = true_m + 1;
  1005ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1005f2:	83 c0 01             	add    $0x1,%eax
  1005f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  1005f8:	eb 78                	jmp    100672 <stab_binsearch+0xfe>
        }

        // actual binary search
        any_matches = 1;
  1005fa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100601:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100604:	89 d0                	mov    %edx,%eax
  100606:	01 c0                	add    %eax,%eax
  100608:	01 d0                	add    %edx,%eax
  10060a:	c1 e0 02             	shl    $0x2,%eax
  10060d:	89 c2                	mov    %eax,%edx
  10060f:	8b 45 08             	mov    0x8(%ebp),%eax
  100612:	01 d0                	add    %edx,%eax
  100614:	8b 40 08             	mov    0x8(%eax),%eax
  100617:	39 45 18             	cmp    %eax,0x18(%ebp)
  10061a:	76 13                	jbe    10062f <stab_binsearch+0xbb>
            *region_left = m;
  10061c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10061f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100622:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100624:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100627:	83 c0 01             	add    $0x1,%eax
  10062a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10062d:	eb 43                	jmp    100672 <stab_binsearch+0xfe>
        } else if (stabs[m].n_value > addr) {
  10062f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100632:	89 d0                	mov    %edx,%eax
  100634:	01 c0                	add    %eax,%eax
  100636:	01 d0                	add    %edx,%eax
  100638:	c1 e0 02             	shl    $0x2,%eax
  10063b:	89 c2                	mov    %eax,%edx
  10063d:	8b 45 08             	mov    0x8(%ebp),%eax
  100640:	01 d0                	add    %edx,%eax
  100642:	8b 40 08             	mov    0x8(%eax),%eax
  100645:	39 45 18             	cmp    %eax,0x18(%ebp)
  100648:	73 16                	jae    100660 <stab_binsearch+0xec>
            *region_right = m - 1;
  10064a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10064d:	8d 50 ff             	lea    -0x1(%eax),%edx
  100650:	8b 45 10             	mov    0x10(%ebp),%eax
  100653:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  100655:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100658:	83 e8 01             	sub    $0x1,%eax
  10065b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10065e:	eb 12                	jmp    100672 <stab_binsearch+0xfe>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100660:	8b 45 0c             	mov    0xc(%ebp),%eax
  100663:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100666:	89 10                	mov    %edx,(%eax)
            l = m;
  100668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10066b:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  10066e:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  100672:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100675:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100678:	0f 8e 22 ff ff ff    	jle    1005a0 <stab_binsearch+0x2c>
        }
    }

    if (!any_matches) {
  10067e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100682:	75 0f                	jne    100693 <stab_binsearch+0x11f>
        *region_right = *region_left - 1;
  100684:	8b 45 0c             	mov    0xc(%ebp),%eax
  100687:	8b 00                	mov    (%eax),%eax
  100689:	8d 50 ff             	lea    -0x1(%eax),%edx
  10068c:	8b 45 10             	mov    0x10(%ebp),%eax
  10068f:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  100691:	eb 3f                	jmp    1006d2 <stab_binsearch+0x15e>
        l = *region_right;
  100693:	8b 45 10             	mov    0x10(%ebp),%eax
  100696:	8b 00                	mov    (%eax),%eax
  100698:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  10069b:	eb 04                	jmp    1006a1 <stab_binsearch+0x12d>
  10069d:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1006a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006a4:	8b 00                	mov    (%eax),%eax
  1006a6:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1006a9:	7e 1f                	jle    1006ca <stab_binsearch+0x156>
  1006ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1006ae:	89 d0                	mov    %edx,%eax
  1006b0:	01 c0                	add    %eax,%eax
  1006b2:	01 d0                	add    %edx,%eax
  1006b4:	c1 e0 02             	shl    $0x2,%eax
  1006b7:	89 c2                	mov    %eax,%edx
  1006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1006bc:	01 d0                	add    %edx,%eax
  1006be:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1006c2:	0f b6 c0             	movzbl %al,%eax
  1006c5:	39 45 14             	cmp    %eax,0x14(%ebp)
  1006c8:	75 d3                	jne    10069d <stab_binsearch+0x129>
        *region_left = l;
  1006ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1006d0:	89 10                	mov    %edx,(%eax)
}
  1006d2:	90                   	nop
  1006d3:	c9                   	leave  
  1006d4:	c3                   	ret    

001006d5 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  1006d5:	55                   	push   %ebp
  1006d6:	89 e5                	mov    %esp,%ebp
  1006d8:	53                   	push   %ebx
  1006d9:	83 ec 34             	sub    $0x34,%esp
  1006dc:	e8 82 fb ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  1006e1:	81 c3 6f f2 00 00    	add    $0xf26f,%ebx
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  1006e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006ea:	8d 93 10 42 ff ff    	lea    -0xbdf0(%ebx),%edx
  1006f0:	89 10                	mov    %edx,(%eax)
    info->eip_line = 0;
  1006f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006f5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  1006fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006ff:	8d 93 10 42 ff ff    	lea    -0xbdf0(%ebx),%edx
  100705:	89 50 08             	mov    %edx,0x8(%eax)
    info->eip_fn_namelen = 9;
  100708:	8b 45 0c             	mov    0xc(%ebp),%eax
  10070b:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100712:	8b 45 0c             	mov    0xc(%ebp),%eax
  100715:	8b 55 08             	mov    0x8(%ebp),%edx
  100718:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10071b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10071e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100725:	c7 c0 e4 42 10 00    	mov    $0x1042e4,%eax
  10072b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    stab_end = __STAB_END__;
  10072e:	c7 c0 24 c0 10 00    	mov    $0x10c024,%eax
  100734:	89 45 f0             	mov    %eax,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100737:	c7 c0 25 c0 10 00    	mov    $0x10c025,%eax
  10073d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100740:	c7 c0 02 e1 10 00    	mov    $0x10e102,%eax
  100746:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100749:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10074c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10074f:	76 0d                	jbe    10075e <debuginfo_eip+0x89>
  100751:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100754:	83 e8 01             	sub    $0x1,%eax
  100757:	0f b6 00             	movzbl (%eax),%eax
  10075a:	84 c0                	test   %al,%al
  10075c:	74 0a                	je     100768 <debuginfo_eip+0x93>
        return -1;
  10075e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100763:	e9 91 02 00 00       	jmp    1009f9 <debuginfo_eip+0x324>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100768:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10076f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100772:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100775:	29 c2                	sub    %eax,%edx
  100777:	89 d0                	mov    %edx,%eax
  100779:	c1 f8 02             	sar    $0x2,%eax
  10077c:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  100782:	83 e8 01             	sub    $0x1,%eax
  100785:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  100788:	ff 75 08             	pushl  0x8(%ebp)
  10078b:	6a 64                	push   $0x64
  10078d:	8d 45 e0             	lea    -0x20(%ebp),%eax
  100790:	50                   	push   %eax
  100791:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  100794:	50                   	push   %eax
  100795:	ff 75 f4             	pushl  -0xc(%ebp)
  100798:	e8 d7 fd ff ff       	call   100574 <stab_binsearch>
  10079d:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  1007a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007a3:	85 c0                	test   %eax,%eax
  1007a5:	75 0a                	jne    1007b1 <debuginfo_eip+0xdc>
        return -1;
  1007a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007ac:	e9 48 02 00 00       	jmp    1009f9 <debuginfo_eip+0x324>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1007b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1007b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1007bd:	ff 75 08             	pushl  0x8(%ebp)
  1007c0:	6a 24                	push   $0x24
  1007c2:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1007c5:	50                   	push   %eax
  1007c6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1007c9:	50                   	push   %eax
  1007ca:	ff 75 f4             	pushl  -0xc(%ebp)
  1007cd:	e8 a2 fd ff ff       	call   100574 <stab_binsearch>
  1007d2:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  1007d5:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007d8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007db:	39 c2                	cmp    %eax,%edx
  1007dd:	7f 7c                	jg     10085b <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  1007df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007e2:	89 c2                	mov    %eax,%edx
  1007e4:	89 d0                	mov    %edx,%eax
  1007e6:	01 c0                	add    %eax,%eax
  1007e8:	01 d0                	add    %edx,%eax
  1007ea:	c1 e0 02             	shl    $0x2,%eax
  1007ed:	89 c2                	mov    %eax,%edx
  1007ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007f2:	01 d0                	add    %edx,%eax
  1007f4:	8b 00                	mov    (%eax),%eax
  1007f6:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1007fc:	29 d1                	sub    %edx,%ecx
  1007fe:	89 ca                	mov    %ecx,%edx
  100800:	39 d0                	cmp    %edx,%eax
  100802:	73 22                	jae    100826 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100804:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100807:	89 c2                	mov    %eax,%edx
  100809:	89 d0                	mov    %edx,%eax
  10080b:	01 c0                	add    %eax,%eax
  10080d:	01 d0                	add    %edx,%eax
  10080f:	c1 e0 02             	shl    $0x2,%eax
  100812:	89 c2                	mov    %eax,%edx
  100814:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100817:	01 d0                	add    %edx,%eax
  100819:	8b 10                	mov    (%eax),%edx
  10081b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10081e:	01 c2                	add    %eax,%edx
  100820:	8b 45 0c             	mov    0xc(%ebp),%eax
  100823:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100826:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100829:	89 c2                	mov    %eax,%edx
  10082b:	89 d0                	mov    %edx,%eax
  10082d:	01 c0                	add    %eax,%eax
  10082f:	01 d0                	add    %edx,%eax
  100831:	c1 e0 02             	shl    $0x2,%eax
  100834:	89 c2                	mov    %eax,%edx
  100836:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100839:	01 d0                	add    %edx,%eax
  10083b:	8b 50 08             	mov    0x8(%eax),%edx
  10083e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100841:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100844:	8b 45 0c             	mov    0xc(%ebp),%eax
  100847:	8b 40 10             	mov    0x10(%eax),%eax
  10084a:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10084d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100850:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100853:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100856:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100859:	eb 15                	jmp    100870 <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10085b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10085e:	8b 55 08             	mov    0x8(%ebp),%edx
  100861:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100864:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100867:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  10086a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10086d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  100870:	8b 45 0c             	mov    0xc(%ebp),%eax
  100873:	8b 40 08             	mov    0x8(%eax),%eax
  100876:	83 ec 08             	sub    $0x8,%esp
  100879:	6a 3a                	push   $0x3a
  10087b:	50                   	push   %eax
  10087c:	e8 49 28 00 00       	call   1030ca <strfind>
  100881:	83 c4 10             	add    $0x10,%esp
  100884:	89 c2                	mov    %eax,%edx
  100886:	8b 45 0c             	mov    0xc(%ebp),%eax
  100889:	8b 40 08             	mov    0x8(%eax),%eax
  10088c:	29 c2                	sub    %eax,%edx
  10088e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100891:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  100894:	83 ec 0c             	sub    $0xc,%esp
  100897:	ff 75 08             	pushl  0x8(%ebp)
  10089a:	6a 44                	push   $0x44
  10089c:	8d 45 d0             	lea    -0x30(%ebp),%eax
  10089f:	50                   	push   %eax
  1008a0:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1008a3:	50                   	push   %eax
  1008a4:	ff 75 f4             	pushl  -0xc(%ebp)
  1008a7:	e8 c8 fc ff ff       	call   100574 <stab_binsearch>
  1008ac:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  1008af:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008b5:	39 c2                	cmp    %eax,%edx
  1008b7:	7f 24                	jg     1008dd <debuginfo_eip+0x208>
        info->eip_line = stabs[rline].n_desc;
  1008b9:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1008bc:	89 c2                	mov    %eax,%edx
  1008be:	89 d0                	mov    %edx,%eax
  1008c0:	01 c0                	add    %eax,%eax
  1008c2:	01 d0                	add    %edx,%eax
  1008c4:	c1 e0 02             	shl    $0x2,%eax
  1008c7:	89 c2                	mov    %eax,%edx
  1008c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008cc:	01 d0                	add    %edx,%eax
  1008ce:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  1008d2:	0f b7 d0             	movzwl %ax,%edx
  1008d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008d8:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  1008db:	eb 13                	jmp    1008f0 <debuginfo_eip+0x21b>
        return -1;
  1008dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1008e2:	e9 12 01 00 00       	jmp    1009f9 <debuginfo_eip+0x324>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  1008e7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008ea:	83 e8 01             	sub    $0x1,%eax
  1008ed:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  1008f0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008f6:	39 c2                	cmp    %eax,%edx
  1008f8:	7c 56                	jl     100950 <debuginfo_eip+0x27b>
           && stabs[lline].n_type != N_SOL
  1008fa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008fd:	89 c2                	mov    %eax,%edx
  1008ff:	89 d0                	mov    %edx,%eax
  100901:	01 c0                	add    %eax,%eax
  100903:	01 d0                	add    %edx,%eax
  100905:	c1 e0 02             	shl    $0x2,%eax
  100908:	89 c2                	mov    %eax,%edx
  10090a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10090d:	01 d0                	add    %edx,%eax
  10090f:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100913:	3c 84                	cmp    $0x84,%al
  100915:	74 39                	je     100950 <debuginfo_eip+0x27b>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100917:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10091a:	89 c2                	mov    %eax,%edx
  10091c:	89 d0                	mov    %edx,%eax
  10091e:	01 c0                	add    %eax,%eax
  100920:	01 d0                	add    %edx,%eax
  100922:	c1 e0 02             	shl    $0x2,%eax
  100925:	89 c2                	mov    %eax,%edx
  100927:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10092a:	01 d0                	add    %edx,%eax
  10092c:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100930:	3c 64                	cmp    $0x64,%al
  100932:	75 b3                	jne    1008e7 <debuginfo_eip+0x212>
  100934:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100937:	89 c2                	mov    %eax,%edx
  100939:	89 d0                	mov    %edx,%eax
  10093b:	01 c0                	add    %eax,%eax
  10093d:	01 d0                	add    %edx,%eax
  10093f:	c1 e0 02             	shl    $0x2,%eax
  100942:	89 c2                	mov    %eax,%edx
  100944:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100947:	01 d0                	add    %edx,%eax
  100949:	8b 40 08             	mov    0x8(%eax),%eax
  10094c:	85 c0                	test   %eax,%eax
  10094e:	74 97                	je     1008e7 <debuginfo_eip+0x212>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  100950:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100953:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100956:	39 c2                	cmp    %eax,%edx
  100958:	7c 46                	jl     1009a0 <debuginfo_eip+0x2cb>
  10095a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10095d:	89 c2                	mov    %eax,%edx
  10095f:	89 d0                	mov    %edx,%eax
  100961:	01 c0                	add    %eax,%eax
  100963:	01 d0                	add    %edx,%eax
  100965:	c1 e0 02             	shl    $0x2,%eax
  100968:	89 c2                	mov    %eax,%edx
  10096a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10096d:	01 d0                	add    %edx,%eax
  10096f:	8b 00                	mov    (%eax),%eax
  100971:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100974:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100977:	29 d1                	sub    %edx,%ecx
  100979:	89 ca                	mov    %ecx,%edx
  10097b:	39 d0                	cmp    %edx,%eax
  10097d:	73 21                	jae    1009a0 <debuginfo_eip+0x2cb>
        info->eip_file = stabstr + stabs[lline].n_strx;
  10097f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100982:	89 c2                	mov    %eax,%edx
  100984:	89 d0                	mov    %edx,%eax
  100986:	01 c0                	add    %eax,%eax
  100988:	01 d0                	add    %edx,%eax
  10098a:	c1 e0 02             	shl    $0x2,%eax
  10098d:	89 c2                	mov    %eax,%edx
  10098f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100992:	01 d0                	add    %edx,%eax
  100994:	8b 10                	mov    (%eax),%edx
  100996:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100999:	01 c2                	add    %eax,%edx
  10099b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10099e:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1009a0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1009a3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1009a6:	39 c2                	cmp    %eax,%edx
  1009a8:	7d 4a                	jge    1009f4 <debuginfo_eip+0x31f>
        for (lline = lfun + 1;
  1009aa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1009ad:	83 c0 01             	add    $0x1,%eax
  1009b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1009b3:	eb 18                	jmp    1009cd <debuginfo_eip+0x2f8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1009b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009b8:	8b 40 14             	mov    0x14(%eax),%eax
  1009bb:	8d 50 01             	lea    0x1(%eax),%edx
  1009be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1009c1:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1009c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009c7:	83 c0 01             	add    $0x1,%eax
  1009ca:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1009cd:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1009d0:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  1009d3:	39 c2                	cmp    %eax,%edx
  1009d5:	7d 1d                	jge    1009f4 <debuginfo_eip+0x31f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1009d7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1009da:	89 c2                	mov    %eax,%edx
  1009dc:	89 d0                	mov    %edx,%eax
  1009de:	01 c0                	add    %eax,%eax
  1009e0:	01 d0                	add    %edx,%eax
  1009e2:	c1 e0 02             	shl    $0x2,%eax
  1009e5:	89 c2                	mov    %eax,%edx
  1009e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009ea:	01 d0                	add    %edx,%eax
  1009ec:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1009f0:	3c a0                	cmp    $0xa0,%al
  1009f2:	74 c1                	je     1009b5 <debuginfo_eip+0x2e0>
        }
    }
    return 0;
  1009f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1009f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1009fc:	c9                   	leave  
  1009fd:	c3                   	ret    

001009fe <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  1009fe:	55                   	push   %ebp
  1009ff:	89 e5                	mov    %esp,%ebp
  100a01:	53                   	push   %ebx
  100a02:	83 ec 04             	sub    $0x4,%esp
  100a05:	e8 59 f8 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100a0a:	81 c3 46 ef 00 00    	add    $0xef46,%ebx
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100a10:	83 ec 0c             	sub    $0xc,%esp
  100a13:	8d 83 1a 42 ff ff    	lea    -0xbde6(%ebx),%eax
  100a19:	50                   	push   %eax
  100a1a:	e8 b7 f8 ff ff       	call   1002d6 <cprintf>
  100a1f:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100a22:	83 ec 08             	sub    $0x8,%esp
  100a25:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100a2b:	50                   	push   %eax
  100a2c:	8d 83 33 42 ff ff    	lea    -0xbdcd(%ebx),%eax
  100a32:	50                   	push   %eax
  100a33:	e8 9e f8 ff ff       	call   1002d6 <cprintf>
  100a38:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100a3b:	83 ec 08             	sub    $0x8,%esp
  100a3e:	c7 c0 96 3a 10 00    	mov    $0x103a96,%eax
  100a44:	50                   	push   %eax
  100a45:	8d 83 4b 42 ff ff    	lea    -0xbdb5(%ebx),%eax
  100a4b:	50                   	push   %eax
  100a4c:	e8 85 f8 ff ff       	call   1002d6 <cprintf>
  100a51:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  100a54:	83 ec 08             	sub    $0x8,%esp
  100a57:	c7 c0 50 f9 10 00    	mov    $0x10f950,%eax
  100a5d:	50                   	push   %eax
  100a5e:	8d 83 63 42 ff ff    	lea    -0xbd9d(%ebx),%eax
  100a64:	50                   	push   %eax
  100a65:	e8 6c f8 ff ff       	call   1002d6 <cprintf>
  100a6a:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  100a6d:	83 ec 08             	sub    $0x8,%esp
  100a70:	c7 c0 20 0e 11 00    	mov    $0x110e20,%eax
  100a76:	50                   	push   %eax
  100a77:	8d 83 7b 42 ff ff    	lea    -0xbd85(%ebx),%eax
  100a7d:	50                   	push   %eax
  100a7e:	e8 53 f8 ff ff       	call   1002d6 <cprintf>
  100a83:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100a86:	c7 c0 20 0e 11 00    	mov    $0x110e20,%eax
  100a8c:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100a92:	c7 c0 00 00 10 00    	mov    $0x100000,%eax
  100a98:	29 c2                	sub    %eax,%edx
  100a9a:	89 d0                	mov    %edx,%eax
  100a9c:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100aa2:	85 c0                	test   %eax,%eax
  100aa4:	0f 48 c2             	cmovs  %edx,%eax
  100aa7:	c1 f8 0a             	sar    $0xa,%eax
  100aaa:	83 ec 08             	sub    $0x8,%esp
  100aad:	50                   	push   %eax
  100aae:	8d 83 94 42 ff ff    	lea    -0xbd6c(%ebx),%eax
  100ab4:	50                   	push   %eax
  100ab5:	e8 1c f8 ff ff       	call   1002d6 <cprintf>
  100aba:	83 c4 10             	add    $0x10,%esp
}
  100abd:	90                   	nop
  100abe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100ac1:	c9                   	leave  
  100ac2:	c3                   	ret    

00100ac3 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100ac3:	55                   	push   %ebp
  100ac4:	89 e5                	mov    %esp,%ebp
  100ac6:	53                   	push   %ebx
  100ac7:	81 ec 24 01 00 00    	sub    $0x124,%esp
  100acd:	e8 91 f7 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100ad2:	81 c3 7e ee 00 00    	add    $0xee7e,%ebx
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100ad8:	83 ec 08             	sub    $0x8,%esp
  100adb:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100ade:	50                   	push   %eax
  100adf:	ff 75 08             	pushl  0x8(%ebp)
  100ae2:	e8 ee fb ff ff       	call   1006d5 <debuginfo_eip>
  100ae7:	83 c4 10             	add    $0x10,%esp
  100aea:	85 c0                	test   %eax,%eax
  100aec:	74 17                	je     100b05 <print_debuginfo+0x42>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100aee:	83 ec 08             	sub    $0x8,%esp
  100af1:	ff 75 08             	pushl  0x8(%ebp)
  100af4:	8d 83 be 42 ff ff    	lea    -0xbd42(%ebx),%eax
  100afa:	50                   	push   %eax
  100afb:	e8 d6 f7 ff ff       	call   1002d6 <cprintf>
  100b00:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100b03:	eb 67                	jmp    100b6c <print_debuginfo+0xa9>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b05:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b0c:	eb 1c                	jmp    100b2a <print_debuginfo+0x67>
            fnname[j] = info.eip_fn_name[j];
  100b0e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b14:	01 d0                	add    %edx,%eax
  100b16:	0f b6 00             	movzbl (%eax),%eax
  100b19:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b22:	01 ca                	add    %ecx,%edx
  100b24:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100b26:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b2a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b2d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100b30:	7c dc                	jl     100b0e <print_debuginfo+0x4b>
        fnname[j] = '\0';
  100b32:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b3b:	01 d0                	add    %edx,%eax
  100b3d:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100b40:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100b43:	8b 55 08             	mov    0x8(%ebp),%edx
  100b46:	89 d1                	mov    %edx,%ecx
  100b48:	29 c1                	sub    %eax,%ecx
  100b4a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100b4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100b50:	83 ec 0c             	sub    $0xc,%esp
  100b53:	51                   	push   %ecx
  100b54:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100b5a:	51                   	push   %ecx
  100b5b:	52                   	push   %edx
  100b5c:	50                   	push   %eax
  100b5d:	8d 83 da 42 ff ff    	lea    -0xbd26(%ebx),%eax
  100b63:	50                   	push   %eax
  100b64:	e8 6d f7 ff ff       	call   1002d6 <cprintf>
  100b69:	83 c4 20             	add    $0x20,%esp
}
  100b6c:	90                   	nop
  100b6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100b70:	c9                   	leave  
  100b71:	c3                   	ret    

00100b72 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100b72:	55                   	push   %ebp
  100b73:	89 e5                	mov    %esp,%ebp
  100b75:	83 ec 10             	sub    $0x10,%esp
  100b78:	e8 e2 f6 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100b7d:	05 d3 ed 00 00       	add    $0xedd3,%eax
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100b82:	8b 45 04             	mov    0x4(%ebp),%eax
  100b85:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100b88:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100b8b:	c9                   	leave  
  100b8c:	c3                   	ret    

00100b8d <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100b8d:	55                   	push   %ebp
  100b8e:	89 e5                	mov    %esp,%ebp
  100b90:	53                   	push   %ebx
  100b91:	83 ec 24             	sub    $0x24,%esp
  100b94:	e8 ca f6 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100b99:	81 c3 b7 ed 00 00    	add    $0xedb7,%ebx
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100b9f:	89 e8                	mov    %ebp,%eax
  100ba1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100ba4:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();
  100ba7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100baa:	e8 c3 ff ff ff       	call   100b72 <read_eip>
  100baf:	89 45 f0             	mov    %eax,-0x10(%ebp)

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  100bb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100bb9:	e9 93 00 00 00       	jmp    100c51 <print_stackframe+0xc4>
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
  100bbe:	83 ec 04             	sub    $0x4,%esp
  100bc1:	ff 75 f0             	pushl  -0x10(%ebp)
  100bc4:	ff 75 f4             	pushl  -0xc(%ebp)
  100bc7:	8d 83 ec 42 ff ff    	lea    -0xbd14(%ebx),%eax
  100bcd:	50                   	push   %eax
  100bce:	e8 03 f7 ff ff       	call   1002d6 <cprintf>
  100bd3:	83 c4 10             	add    $0x10,%esp
        uint32_t *args = (uint32_t *)ebp + 2;
  100bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bd9:	83 c0 08             	add    $0x8,%eax
  100bdc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < 4; j ++) {
  100bdf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100be6:	eb 28                	jmp    100c10 <print_stackframe+0x83>
            cprintf("0x%08x ", args[j]);
  100be8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100beb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bf2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100bf5:	01 d0                	add    %edx,%eax
  100bf7:	8b 00                	mov    (%eax),%eax
  100bf9:	83 ec 08             	sub    $0x8,%esp
  100bfc:	50                   	push   %eax
  100bfd:	8d 83 08 43 ff ff    	lea    -0xbcf8(%ebx),%eax
  100c03:	50                   	push   %eax
  100c04:	e8 cd f6 ff ff       	call   1002d6 <cprintf>
  100c09:	83 c4 10             	add    $0x10,%esp
        for (j = 0; j < 4; j ++) {
  100c0c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100c10:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100c14:	7e d2                	jle    100be8 <print_stackframe+0x5b>
        }
        cprintf("\n");
  100c16:	83 ec 0c             	sub    $0xc,%esp
  100c19:	8d 83 10 43 ff ff    	lea    -0xbcf0(%ebx),%eax
  100c1f:	50                   	push   %eax
  100c20:	e8 b1 f6 ff ff       	call   1002d6 <cprintf>
  100c25:	83 c4 10             	add    $0x10,%esp
        print_debuginfo(eip - 1);
  100c28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100c2b:	83 e8 01             	sub    $0x1,%eax
  100c2e:	83 ec 0c             	sub    $0xc,%esp
  100c31:	50                   	push   %eax
  100c32:	e8 8c fe ff ff       	call   100ac3 <print_debuginfo>
  100c37:	83 c4 10             	add    $0x10,%esp
        eip = ((uint32_t *)ebp)[1];
  100c3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c3d:	83 c0 04             	add    $0x4,%eax
  100c40:	8b 00                	mov    (%eax),%eax
  100c42:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = ((uint32_t *)ebp)[0];
  100c45:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c48:	8b 00                	mov    (%eax),%eax
  100c4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  100c4d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100c51:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c55:	74 0a                	je     100c61 <print_stackframe+0xd4>
  100c57:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100c5b:	0f 8e 5d ff ff ff    	jle    100bbe <print_stackframe+0x31>
    }
}
  100c61:	90                   	nop
  100c62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100c65:	c9                   	leave  
  100c66:	c3                   	ret    

00100c67 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100c67:	55                   	push   %ebp
  100c68:	89 e5                	mov    %esp,%ebp
  100c6a:	53                   	push   %ebx
  100c6b:	83 ec 14             	sub    $0x14,%esp
  100c6e:	e8 f0 f5 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100c73:	81 c3 dd ec 00 00    	add    $0xecdd,%ebx
    int argc = 0;
  100c79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c80:	eb 0c                	jmp    100c8e <parse+0x27>
            *buf ++ = '\0';
  100c82:	8b 45 08             	mov    0x8(%ebp),%eax
  100c85:	8d 50 01             	lea    0x1(%eax),%edx
  100c88:	89 55 08             	mov    %edx,0x8(%ebp)
  100c8b:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  100c91:	0f b6 00             	movzbl (%eax),%eax
  100c94:	84 c0                	test   %al,%al
  100c96:	74 20                	je     100cb8 <parse+0x51>
  100c98:	8b 45 08             	mov    0x8(%ebp),%eax
  100c9b:	0f b6 00             	movzbl (%eax),%eax
  100c9e:	0f be c0             	movsbl %al,%eax
  100ca1:	83 ec 08             	sub    $0x8,%esp
  100ca4:	50                   	push   %eax
  100ca5:	8d 83 94 43 ff ff    	lea    -0xbc6c(%ebx),%eax
  100cab:	50                   	push   %eax
  100cac:	e8 dc 23 00 00       	call   10308d <strchr>
  100cb1:	83 c4 10             	add    $0x10,%esp
  100cb4:	85 c0                	test   %eax,%eax
  100cb6:	75 ca                	jne    100c82 <parse+0x1b>
        }
        if (*buf == '\0') {
  100cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  100cbb:	0f b6 00             	movzbl (%eax),%eax
  100cbe:	84 c0                	test   %al,%al
  100cc0:	74 69                	je     100d2b <parse+0xc4>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100cc2:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100cc6:	75 14                	jne    100cdc <parse+0x75>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100cc8:	83 ec 08             	sub    $0x8,%esp
  100ccb:	6a 10                	push   $0x10
  100ccd:	8d 83 99 43 ff ff    	lea    -0xbc67(%ebx),%eax
  100cd3:	50                   	push   %eax
  100cd4:	e8 fd f5 ff ff       	call   1002d6 <cprintf>
  100cd9:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100cdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cdf:	8d 50 01             	lea    0x1(%eax),%edx
  100ce2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100ce5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100cec:	8b 45 0c             	mov    0xc(%ebp),%eax
  100cef:	01 c2                	add    %eax,%edx
  100cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  100cf4:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100cf6:	eb 04                	jmp    100cfc <parse+0x95>
            buf ++;
  100cf8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  100cff:	0f b6 00             	movzbl (%eax),%eax
  100d02:	84 c0                	test   %al,%al
  100d04:	74 88                	je     100c8e <parse+0x27>
  100d06:	8b 45 08             	mov    0x8(%ebp),%eax
  100d09:	0f b6 00             	movzbl (%eax),%eax
  100d0c:	0f be c0             	movsbl %al,%eax
  100d0f:	83 ec 08             	sub    $0x8,%esp
  100d12:	50                   	push   %eax
  100d13:	8d 83 94 43 ff ff    	lea    -0xbc6c(%ebx),%eax
  100d19:	50                   	push   %eax
  100d1a:	e8 6e 23 00 00       	call   10308d <strchr>
  100d1f:	83 c4 10             	add    $0x10,%esp
  100d22:	85 c0                	test   %eax,%eax
  100d24:	74 d2                	je     100cf8 <parse+0x91>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100d26:	e9 63 ff ff ff       	jmp    100c8e <parse+0x27>
            break;
  100d2b:	90                   	nop
        }
    }
    return argc;
  100d2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100d2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100d32:	c9                   	leave  
  100d33:	c3                   	ret    

00100d34 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100d34:	55                   	push   %ebp
  100d35:	89 e5                	mov    %esp,%ebp
  100d37:	56                   	push   %esi
  100d38:	53                   	push   %ebx
  100d39:	83 ec 50             	sub    $0x50,%esp
  100d3c:	e8 22 f5 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100d41:	81 c3 0f ec 00 00    	add    $0xec0f,%ebx
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100d47:	83 ec 08             	sub    $0x8,%esp
  100d4a:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100d4d:	50                   	push   %eax
  100d4e:	ff 75 08             	pushl  0x8(%ebp)
  100d51:	e8 11 ff ff ff       	call   100c67 <parse>
  100d56:	83 c4 10             	add    $0x10,%esp
  100d59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100d5c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100d60:	75 0a                	jne    100d6c <runcmd+0x38>
        return 0;
  100d62:	b8 00 00 00 00       	mov    $0x0,%eax
  100d67:	e9 8b 00 00 00       	jmp    100df7 <runcmd+0xc3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d73:	eb 5f                	jmp    100dd4 <runcmd+0xa0>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100d75:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100d78:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d7b:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100d81:	89 d0                	mov    %edx,%eax
  100d83:	01 c0                	add    %eax,%eax
  100d85:	01 d0                	add    %edx,%eax
  100d87:	c1 e0 02             	shl    $0x2,%eax
  100d8a:	01 f0                	add    %esi,%eax
  100d8c:	8b 00                	mov    (%eax),%eax
  100d8e:	83 ec 08             	sub    $0x8,%esp
  100d91:	51                   	push   %ecx
  100d92:	50                   	push   %eax
  100d93:	e8 41 22 00 00       	call   102fd9 <strcmp>
  100d98:	83 c4 10             	add    $0x10,%esp
  100d9b:	85 c0                	test   %eax,%eax
  100d9d:	75 31                	jne    100dd0 <runcmd+0x9c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100d9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100da2:	8d 8b 18 00 00 00    	lea    0x18(%ebx),%ecx
  100da8:	89 d0                	mov    %edx,%eax
  100daa:	01 c0                	add    %eax,%eax
  100dac:	01 d0                	add    %edx,%eax
  100dae:	c1 e0 02             	shl    $0x2,%eax
  100db1:	01 c8                	add    %ecx,%eax
  100db3:	8b 10                	mov    (%eax),%edx
  100db5:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100db8:	83 c0 04             	add    $0x4,%eax
  100dbb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100dbe:	83 e9 01             	sub    $0x1,%ecx
  100dc1:	83 ec 04             	sub    $0x4,%esp
  100dc4:	ff 75 0c             	pushl  0xc(%ebp)
  100dc7:	50                   	push   %eax
  100dc8:	51                   	push   %ecx
  100dc9:	ff d2                	call   *%edx
  100dcb:	83 c4 10             	add    $0x10,%esp
  100dce:	eb 27                	jmp    100df7 <runcmd+0xc3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100dd0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100dd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dd7:	83 f8 02             	cmp    $0x2,%eax
  100dda:	76 99                	jbe    100d75 <runcmd+0x41>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100ddc:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100ddf:	83 ec 08             	sub    $0x8,%esp
  100de2:	50                   	push   %eax
  100de3:	8d 83 b7 43 ff ff    	lea    -0xbc49(%ebx),%eax
  100de9:	50                   	push   %eax
  100dea:	e8 e7 f4 ff ff       	call   1002d6 <cprintf>
  100def:	83 c4 10             	add    $0x10,%esp
    return 0;
  100df2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100df7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100dfa:	5b                   	pop    %ebx
  100dfb:	5e                   	pop    %esi
  100dfc:	5d                   	pop    %ebp
  100dfd:	c3                   	ret    

00100dfe <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100dfe:	55                   	push   %ebp
  100dff:	89 e5                	mov    %esp,%ebp
  100e01:	53                   	push   %ebx
  100e02:	83 ec 14             	sub    $0x14,%esp
  100e05:	e8 59 f4 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100e0a:	81 c3 46 eb 00 00    	add    $0xeb46,%ebx
    cprintf("Welcome to the kernel debug monitor!!\n");
  100e10:	83 ec 0c             	sub    $0xc,%esp
  100e13:	8d 83 d0 43 ff ff    	lea    -0xbc30(%ebx),%eax
  100e19:	50                   	push   %eax
  100e1a:	e8 b7 f4 ff ff       	call   1002d6 <cprintf>
  100e1f:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100e22:	83 ec 0c             	sub    $0xc,%esp
  100e25:	8d 83 f8 43 ff ff    	lea    -0xbc08(%ebx),%eax
  100e2b:	50                   	push   %eax
  100e2c:	e8 a5 f4 ff ff       	call   1002d6 <cprintf>
  100e31:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100e34:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100e38:	74 0e                	je     100e48 <kmonitor+0x4a>
        print_trapframe(tf);
  100e3a:	83 ec 0c             	sub    $0xc,%esp
  100e3d:	ff 75 08             	pushl  0x8(%ebp)
  100e40:	e8 16 0f 00 00       	call   101d5b <print_trapframe>
  100e45:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100e48:	83 ec 0c             	sub    $0xc,%esp
  100e4b:	8d 83 1d 44 ff ff    	lea    -0xbbe3(%ebx),%eax
  100e51:	50                   	push   %eax
  100e52:	e8 57 f5 ff ff       	call   1003ae <readline>
  100e57:	83 c4 10             	add    $0x10,%esp
  100e5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100e5d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100e61:	74 e5                	je     100e48 <kmonitor+0x4a>
            if (runcmd(buf, tf) < 0) {
  100e63:	83 ec 08             	sub    $0x8,%esp
  100e66:	ff 75 08             	pushl  0x8(%ebp)
  100e69:	ff 75 f4             	pushl  -0xc(%ebp)
  100e6c:	e8 c3 fe ff ff       	call   100d34 <runcmd>
  100e71:	83 c4 10             	add    $0x10,%esp
  100e74:	85 c0                	test   %eax,%eax
  100e76:	78 02                	js     100e7a <kmonitor+0x7c>
        if ((buf = readline("K> ")) != NULL) {
  100e78:	eb ce                	jmp    100e48 <kmonitor+0x4a>
                break;
  100e7a:	90                   	nop
            }
        }
    }
}
  100e7b:	90                   	nop
  100e7c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100e7f:	c9                   	leave  
  100e80:	c3                   	ret    

00100e81 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100e81:	55                   	push   %ebp
  100e82:	89 e5                	mov    %esp,%ebp
  100e84:	56                   	push   %esi
  100e85:	53                   	push   %ebx
  100e86:	83 ec 10             	sub    $0x10,%esp
  100e89:	e8 d5 f3 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100e8e:	81 c3 c2 ea 00 00    	add    $0xeac2,%ebx
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100e94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100e9b:	eb 44                	jmp    100ee1 <mon_help+0x60>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100e9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ea0:	8d 8b 14 00 00 00    	lea    0x14(%ebx),%ecx
  100ea6:	89 d0                	mov    %edx,%eax
  100ea8:	01 c0                	add    %eax,%eax
  100eaa:	01 d0                	add    %edx,%eax
  100eac:	c1 e0 02             	shl    $0x2,%eax
  100eaf:	01 c8                	add    %ecx,%eax
  100eb1:	8b 08                	mov    (%eax),%ecx
  100eb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100eb6:	8d b3 10 00 00 00    	lea    0x10(%ebx),%esi
  100ebc:	89 d0                	mov    %edx,%eax
  100ebe:	01 c0                	add    %eax,%eax
  100ec0:	01 d0                	add    %edx,%eax
  100ec2:	c1 e0 02             	shl    $0x2,%eax
  100ec5:	01 f0                	add    %esi,%eax
  100ec7:	8b 00                	mov    (%eax),%eax
  100ec9:	83 ec 04             	sub    $0x4,%esp
  100ecc:	51                   	push   %ecx
  100ecd:	50                   	push   %eax
  100ece:	8d 83 21 44 ff ff    	lea    -0xbbdf(%ebx),%eax
  100ed4:	50                   	push   %eax
  100ed5:	e8 fc f3 ff ff       	call   1002d6 <cprintf>
  100eda:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100edd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100ee1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ee4:	83 f8 02             	cmp    $0x2,%eax
  100ee7:	76 b4                	jbe    100e9d <mon_help+0x1c>
    }
    return 0;
  100ee9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100eee:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100ef1:	5b                   	pop    %ebx
  100ef2:	5e                   	pop    %esi
  100ef3:	5d                   	pop    %ebp
  100ef4:	c3                   	ret    

00100ef5 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100ef5:	55                   	push   %ebp
  100ef6:	89 e5                	mov    %esp,%ebp
  100ef8:	53                   	push   %ebx
  100ef9:	83 ec 04             	sub    $0x4,%esp
  100efc:	e8 5e f3 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100f01:	05 4f ea 00 00       	add    $0xea4f,%eax
    print_kerninfo();
  100f06:	89 c3                	mov    %eax,%ebx
  100f08:	e8 f1 fa ff ff       	call   1009fe <print_kerninfo>
    return 0;
  100f0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f12:	83 c4 04             	add    $0x4,%esp
  100f15:	5b                   	pop    %ebx
  100f16:	5d                   	pop    %ebp
  100f17:	c3                   	ret    

00100f18 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100f18:	55                   	push   %ebp
  100f19:	89 e5                	mov    %esp,%ebp
  100f1b:	53                   	push   %ebx
  100f1c:	83 ec 04             	sub    $0x4,%esp
  100f1f:	e8 3b f3 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100f24:	05 2c ea 00 00       	add    $0xea2c,%eax
    print_stackframe();
  100f29:	89 c3                	mov    %eax,%ebx
  100f2b:	e8 5d fc ff ff       	call   100b8d <print_stackframe>
    return 0;
  100f30:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100f35:	83 c4 04             	add    $0x4,%esp
  100f38:	5b                   	pop    %ebx
  100f39:	5d                   	pop    %ebp
  100f3a:	c3                   	ret    

00100f3b <clock_init>:

/*
 * 函数功能：初始化 8253 时钟每秒产生 100 次中断，是能 IRQ_TIMER；
 */
void
clock_init(void) {
  100f3b:	55                   	push   %ebp
  100f3c:	89 e5                	mov    %esp,%ebp
  100f3e:	53                   	push   %ebx
  100f3f:	83 ec 14             	sub    $0x14,%esp
  100f42:	e8 1c f3 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  100f47:	81 c3 09 ea 00 00    	add    $0xea09,%ebx
  100f4d:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100f53:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f57:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f5b:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f5f:	ee                   	out    %al,(%dx)
  100f60:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100f66:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100f6a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f6e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f72:	ee                   	out    %al,(%dx)
  100f73:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100f79:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
  100f7d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f81:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f85:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100f86:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  100f8c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("++ setup timer interrupts\n");
  100f92:	83 ec 0c             	sub    $0xc,%esp
  100f95:	8d 83 2a 44 ff ff    	lea    -0xbbd6(%ebx),%eax
  100f9b:	50                   	push   %eax
  100f9c:	e8 35 f3 ff ff       	call   1002d6 <cprintf>
  100fa1:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100fa4:	83 ec 0c             	sub    $0xc,%esp
  100fa7:	6a 00                	push   $0x0
  100fa9:	e8 e7 09 00 00       	call   101995 <pic_enable>
  100fae:	83 c4 10             	add    $0x10,%esp
}
  100fb1:	90                   	nop
  100fb2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100fb5:	c9                   	leave  
  100fb6:	c3                   	ret    

00100fb7 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100fb7:	55                   	push   %ebp
  100fb8:	89 e5                	mov    %esp,%ebp
  100fba:	83 ec 10             	sub    $0x10,%esp
  100fbd:	e8 9d f2 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  100fc2:	05 8e e9 00 00       	add    $0xe98e,%eax
  100fc7:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fcd:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100fd1:	89 c2                	mov    %eax,%edx
  100fd3:	ec                   	in     (%dx),%al
  100fd4:	88 45 f1             	mov    %al,-0xf(%ebp)
  100fd7:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100fdd:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100fe1:	89 c2                	mov    %eax,%edx
  100fe3:	ec                   	in     (%dx),%al
  100fe4:	88 45 f5             	mov    %al,-0xb(%ebp)
  100fe7:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100fed:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100ff1:	89 c2                	mov    %eax,%edx
  100ff3:	ec                   	in     (%dx),%al
  100ff4:	88 45 f9             	mov    %al,-0x7(%ebp)
  100ff7:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100ffd:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  101001:	89 c2                	mov    %eax,%edx
  101003:	ec                   	in     (%dx),%al
  101004:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  101007:	90                   	nop
  101008:	c9                   	leave  
  101009:	c3                   	ret    

0010100a <cga_init>:
static uint16_t crt_pos;
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  10100a:	55                   	push   %ebp
  10100b:	89 e5                	mov    %esp,%ebp
  10100d:	83 ec 20             	sub    $0x20,%esp
  101010:	e8 17 09 00 00       	call   10192c <__x86.get_pc_thunk.cx>
  101015:	81 c1 3b e9 00 00    	add    $0xe93b,%ecx
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  10101b:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  101022:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101025:	0f b7 00             	movzwl (%eax),%eax
  101028:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  10102c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10102f:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  101034:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101037:	0f b7 00             	movzwl (%eax),%eax
  10103a:	66 3d 5a a5          	cmp    $0xa55a,%ax
  10103e:	74 12                	je     101052 <cga_init+0x48>
        cp = (uint16_t*)MONO_BUF;
  101040:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  101047:	66 c7 81 b6 05 00 00 	movw   $0x3b4,0x5b6(%ecx)
  10104e:	b4 03 
  101050:	eb 13                	jmp    101065 <cga_init+0x5b>
    } else {
        *cp = was;
  101052:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101055:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101059:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  10105c:	66 c7 81 b6 05 00 00 	movw   $0x3d4,0x5b6(%ecx)
  101063:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  101065:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  10106c:	0f b7 c0             	movzwl %ax,%eax
  10106f:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101073:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101077:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10107b:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10107f:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  101080:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  101087:	83 c0 01             	add    $0x1,%eax
  10108a:	0f b7 c0             	movzwl %ax,%eax
  10108d:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101091:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  101095:	89 c2                	mov    %eax,%edx
  101097:	ec                   	in     (%dx),%al
  101098:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  10109b:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10109f:	0f b6 c0             	movzbl %al,%eax
  1010a2:	c1 e0 08             	shl    $0x8,%eax
  1010a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  1010a8:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010af:	0f b7 c0             	movzwl %ax,%eax
  1010b2:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1010b6:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010ba:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010be:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010c2:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  1010c3:	0f b7 81 b6 05 00 00 	movzwl 0x5b6(%ecx),%eax
  1010ca:	83 c0 01             	add    $0x1,%eax
  1010cd:	0f b7 c0             	movzwl %ax,%eax
  1010d0:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1010d4:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1010d8:	89 c2                	mov    %eax,%edx
  1010da:	ec                   	in     (%dx),%al
  1010db:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  1010de:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010e2:	0f b6 c0             	movzbl %al,%eax
  1010e5:	09 45 f4             	or     %eax,-0xc(%ebp)

    // 虚拟地址空间中显示 BUFFER 的地址；
    // 这个 BUFFER 可能是 CGA_BUF 或 MONO_BUF，取决于一个 volatile 类型的指针 cp；
    crt_buf = (uint16_t*) cp;
  1010e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1010eb:	89 81 b0 05 00 00    	mov    %eax,0x5b0(%ecx)
    crt_pos = pos;
  1010f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1010f4:	66 89 81 b4 05 00 00 	mov    %ax,0x5b4(%ecx)
}
  1010fb:	90                   	nop
  1010fc:	c9                   	leave  
  1010fd:	c3                   	ret    

001010fe <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  1010fe:	55                   	push   %ebp
  1010ff:	89 e5                	mov    %esp,%ebp
  101101:	53                   	push   %ebx
  101102:	83 ec 34             	sub    $0x34,%esp
  101105:	e8 22 08 00 00       	call   10192c <__x86.get_pc_thunk.cx>
  10110a:	81 c1 46 e8 00 00    	add    $0xe846,%ecx
  101110:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  101116:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10111a:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  10111e:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101122:	ee                   	out    %al,(%dx)
  101123:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  101129:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
  10112d:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101131:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101135:	ee                   	out    %al,(%dx)
  101136:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  10113c:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
  101140:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101144:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101148:	ee                   	out    %al,(%dx)
  101149:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  10114f:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
  101153:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101157:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10115b:	ee                   	out    %al,(%dx)
  10115c:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  101162:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
  101166:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10116a:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10116e:	ee                   	out    %al,(%dx)
  10116f:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  101175:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
  101179:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10117d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101181:	ee                   	out    %al,(%dx)
  101182:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  101188:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
  10118c:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101190:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101194:	ee                   	out    %al,(%dx)
  101195:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10119b:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  10119f:	89 c2                	mov    %eax,%edx
  1011a1:	ec                   	in     (%dx),%al
  1011a2:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  1011a5:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  1011a9:	3c ff                	cmp    $0xff,%al
  1011ab:	0f 95 c0             	setne  %al
  1011ae:	0f b6 c0             	movzbl %al,%eax
  1011b1:	89 81 b8 05 00 00    	mov    %eax,0x5b8(%ecx)
  1011b7:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011bd:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1011c1:	89 c2                	mov    %eax,%edx
  1011c3:	ec                   	in     (%dx),%al
  1011c4:	88 45 f1             	mov    %al,-0xf(%ebp)
  1011c7:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1011cd:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1011d1:	89 c2                	mov    %eax,%edx
  1011d3:	ec                   	in     (%dx),%al
  1011d4:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  1011d7:	8b 81 b8 05 00 00    	mov    0x5b8(%ecx),%eax
  1011dd:	85 c0                	test   %eax,%eax
  1011df:	74 0f                	je     1011f0 <serial_init+0xf2>
        pic_enable(IRQ_COM1);
  1011e1:	83 ec 0c             	sub    $0xc,%esp
  1011e4:	6a 04                	push   $0x4
  1011e6:	89 cb                	mov    %ecx,%ebx
  1011e8:	e8 a8 07 00 00       	call   101995 <pic_enable>
  1011ed:	83 c4 10             	add    $0x10,%esp
    }
}
  1011f0:	90                   	nop
  1011f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1011f4:	c9                   	leave  
  1011f5:	c3                   	ret    

001011f6 <lpt_putc_sub>:

/*
 * 函数功能：打印字符串到并行端口；
 */
static void
lpt_putc_sub(int c) {
  1011f6:	55                   	push   %ebp
  1011f7:	89 e5                	mov    %esp,%ebp
  1011f9:	83 ec 20             	sub    $0x20,%esp
  1011fc:	e8 5e f0 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101201:	05 4f e7 00 00       	add    $0xe74f,%eax
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101206:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10120d:	eb 09                	jmp    101218 <lpt_putc_sub+0x22>
        delay();
  10120f:	e8 a3 fd ff ff       	call   100fb7 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101214:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101218:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10121e:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101222:	89 c2                	mov    %eax,%edx
  101224:	ec                   	in     (%dx),%al
  101225:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101228:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10122c:	84 c0                	test   %al,%al
  10122e:	78 09                	js     101239 <lpt_putc_sub+0x43>
  101230:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101237:	7e d6                	jle    10120f <lpt_putc_sub+0x19>
    }
    outb(LPTPORT + 0, c);
  101239:	8b 45 08             	mov    0x8(%ebp),%eax
  10123c:	0f b6 c0             	movzbl %al,%eax
  10123f:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101245:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101248:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10124c:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101250:	ee                   	out    %al,(%dx)
  101251:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101257:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  10125b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10125f:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101263:	ee                   	out    %al,(%dx)
  101264:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  10126a:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
  10126e:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101272:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101276:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101277:	90                   	nop
  101278:	c9                   	leave  
  101279:	c3                   	ret    

0010127a <lpt_putc>:

/*
 * 函数功能：打印字符串到并行端口；
 */
static void
lpt_putc(int c) {
  10127a:	55                   	push   %ebp
  10127b:	89 e5                	mov    %esp,%ebp
  10127d:	e8 dd ef ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101282:	05 ce e6 00 00       	add    $0xe6ce,%eax
    if (c != '\b') {
  101287:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10128b:	74 0d                	je     10129a <lpt_putc+0x20>
        lpt_putc_sub(c);
  10128d:	ff 75 08             	pushl  0x8(%ebp)
  101290:	e8 61 ff ff ff       	call   1011f6 <lpt_putc_sub>
  101295:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  101298:	eb 1e                	jmp    1012b8 <lpt_putc+0x3e>
        lpt_putc_sub('\b');
  10129a:	6a 08                	push   $0x8
  10129c:	e8 55 ff ff ff       	call   1011f6 <lpt_putc_sub>
  1012a1:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  1012a4:	6a 20                	push   $0x20
  1012a6:	e8 4b ff ff ff       	call   1011f6 <lpt_putc_sub>
  1012ab:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  1012ae:	6a 08                	push   $0x8
  1012b0:	e8 41 ff ff ff       	call   1011f6 <lpt_putc_sub>
  1012b5:	83 c4 04             	add    $0x4,%esp
}
  1012b8:	90                   	nop
  1012b9:	c9                   	leave  
  1012ba:	c3                   	ret    

001012bb <cga_putc>:

/*
 * 函数功能：打印字符串到显示器上；
 */ 
static void
cga_putc(int c) {
  1012bb:	55                   	push   %ebp
  1012bc:	89 e5                	mov    %esp,%ebp
  1012be:	56                   	push   %esi
  1012bf:	53                   	push   %ebx
  1012c0:	83 ec 20             	sub    $0x20,%esp
  1012c3:	e8 9b ef ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  1012c8:	81 c3 88 e6 00 00    	add    $0xe688,%ebx
    // c 的低 16 位的高 8 位是颜色，低 16 位的低 8 位为字符；
    // CGA 假设字符都是 ASCII 字符；
    // 处理它依赖于平台（编译器）的实现，在 inc/stdarg.h 中；

    // 判断输入的字符是否有颜色属性，否则使用白底黑字；
    if (!(c & ~0xFF)) {
  1012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1012d1:	b0 00                	mov    $0x0,%al
  1012d3:	85 c0                	test   %eax,%eax
  1012d5:	75 07                	jne    1012de <cga_putc+0x23>
        c |= 0x0700;
  1012d7:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) { // 判断字符类型，对换行，退格等字符将调整 cga 显示位置 pos；
  1012de:	8b 45 08             	mov    0x8(%ebp),%eax
  1012e1:	0f b6 c0             	movzbl %al,%eax
  1012e4:	83 f8 0a             	cmp    $0xa,%eax
  1012e7:	74 54                	je     10133d <cga_putc+0x82>
  1012e9:	83 f8 0d             	cmp    $0xd,%eax
  1012ec:	74 60                	je     10134e <cga_putc+0x93>
  1012ee:	83 f8 08             	cmp    $0x8,%eax
  1012f1:	0f 85 92 00 00 00    	jne    101389 <cga_putc+0xce>
        case '\b':      // 退格；
            if (crt_pos > 0) {
  1012f7:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1012fe:	66 85 c0             	test   %ax,%ax
  101301:	0f 84 a8 00 00 00    	je     1013af <cga_putc+0xf4>
                crt_pos --;
  101307:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10130e:	83 e8 01             	sub    $0x1,%eax
  101311:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
                crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101318:	8b 45 08             	mov    0x8(%ebp),%eax
  10131b:	b0 00                	mov    $0x0,%al
  10131d:	83 c8 20             	or     $0x20,%eax
  101320:	89 c1                	mov    %eax,%ecx
  101322:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  101328:	0f b7 93 b4 05 00 00 	movzwl 0x5b4(%ebx),%edx
  10132f:	0f b7 d2             	movzwl %dx,%edx
  101332:	01 d2                	add    %edx,%edx
  101334:	01 d0                	add    %edx,%eax
  101336:	89 ca                	mov    %ecx,%edx
  101338:	66 89 10             	mov    %dx,(%eax)
            }
            break;
  10133b:	eb 72                	jmp    1013af <cga_putc+0xf4>
        case '\n':
            crt_pos += CRT_COLS;
  10133d:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101344:	83 c0 50             	add    $0x50,%eax
  101347:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
        case '\r':
            crt_pos -= (crt_pos % CRT_COLS);
  10134e:	0f b7 b3 b4 05 00 00 	movzwl 0x5b4(%ebx),%esi
  101355:	0f b7 8b b4 05 00 00 	movzwl 0x5b4(%ebx),%ecx
  10135c:	0f b7 c1             	movzwl %cx,%eax
  10135f:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  101365:	c1 e8 10             	shr    $0x10,%eax
  101368:	89 c2                	mov    %eax,%edx
  10136a:	66 c1 ea 06          	shr    $0x6,%dx
  10136e:	89 d0                	mov    %edx,%eax
  101370:	c1 e0 02             	shl    $0x2,%eax
  101373:	01 d0                	add    %edx,%eax
  101375:	c1 e0 04             	shl    $0x4,%eax
  101378:	29 c1                	sub    %eax,%ecx
  10137a:	89 ca                	mov    %ecx,%edx
  10137c:	89 f0                	mov    %esi,%eax
  10137e:	29 d0                	sub    %edx,%eax
  101380:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
            break;
  101387:	eb 27                	jmp    1013b0 <cga_putc+0xf5>
        default:
            crt_buf[crt_pos ++] = c;     // write the character
  101389:	8b 8b b0 05 00 00    	mov    0x5b0(%ebx),%ecx
  10138f:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101396:	8d 50 01             	lea    0x1(%eax),%edx
  101399:	66 89 93 b4 05 00 00 	mov    %dx,0x5b4(%ebx)
  1013a0:	0f b7 c0             	movzwl %ax,%eax
  1013a3:	01 c0                	add    %eax,%eax
  1013a5:	01 c8                	add    %ecx,%eax
  1013a7:	8b 55 08             	mov    0x8(%ebp),%edx
  1013aa:	66 89 10             	mov    %dx,(%eax)
            break;
  1013ad:	eb 01                	jmp    1013b0 <cga_putc+0xf5>
            break;
  1013af:	90                   	nop

    // 所有的字符写入一个 char 数组称为 crt_buf[]；
    //  crt_buf 是一个全局静态变量，是一个 uint_16t 的指针；

    // 如果当前屏幕 (80 * 24) 输入满了，将会把第 2-24 行都上移一行，覆盖第一行，清空第 24 行，pos 置为 24 行首；
    if (crt_pos >= CRT_SIZE) {
  1013b0:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  1013b7:	66 3d cf 07          	cmp    $0x7cf,%ax
  1013bb:	76 5d                	jbe    10141a <cga_putc+0x15f>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1013bd:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013c3:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1013c9:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013cf:	83 ec 04             	sub    $0x4,%esp
  1013d2:	68 00 0f 00 00       	push   $0xf00
  1013d7:	52                   	push   %edx
  1013d8:	50                   	push   %eax
  1013d9:	e8 d6 1e 00 00       	call   1032b4 <memmove>
  1013de:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1013e1:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1013e8:	eb 16                	jmp    101400 <cga_putc+0x145>
            crt_buf[i] = 0x0700 | ' ';
  1013ea:	8b 83 b0 05 00 00    	mov    0x5b0(%ebx),%eax
  1013f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013f3:	01 d2                	add    %edx,%edx
  1013f5:	01 d0                	add    %edx,%eax
  1013f7:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1013fc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101400:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101407:	7e e1                	jle    1013ea <cga_putc+0x12f>
        }
        crt_pos -= CRT_COLS;
  101409:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101410:	83 e8 50             	sub    $0x50,%eax
  101413:	66 89 83 b4 05 00 00 	mov    %ax,0x5b4(%ebx)
    }

    // 移开光标；
    outb(addr_6845, 14);
  10141a:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  101421:	0f b7 c0             	movzwl %ax,%eax
  101424:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101428:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
  10142c:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101430:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101434:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101435:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  10143c:	66 c1 e8 08          	shr    $0x8,%ax
  101440:	0f b6 c0             	movzbl %al,%eax
  101443:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  10144a:	83 c2 01             	add    $0x1,%edx
  10144d:	0f b7 d2             	movzwl %dx,%edx
  101450:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101454:	88 45 e9             	mov    %al,-0x17(%ebp)
  101457:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10145b:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10145f:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101460:	0f b7 83 b6 05 00 00 	movzwl 0x5b6(%ebx),%eax
  101467:	0f b7 c0             	movzwl %ax,%eax
  10146a:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  10146e:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
  101472:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101476:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10147a:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  10147b:	0f b7 83 b4 05 00 00 	movzwl 0x5b4(%ebx),%eax
  101482:	0f b6 c0             	movzbl %al,%eax
  101485:	0f b7 93 b6 05 00 00 	movzwl 0x5b6(%ebx),%edx
  10148c:	83 c2 01             	add    $0x1,%edx
  10148f:	0f b7 d2             	movzwl %dx,%edx
  101492:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  101496:	88 45 f1             	mov    %al,-0xf(%ebp)
  101499:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10149d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1014a1:	ee                   	out    %al,(%dx)
}
  1014a2:	90                   	nop
  1014a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1014a6:	5b                   	pop    %ebx
  1014a7:	5e                   	pop    %esi
  1014a8:	5d                   	pop    %ebp
  1014a9:	c3                   	ret    

001014aa <serial_putc_sub>:

/*
 * 函数功能：使用串口打印字符信息；
 */
static void
serial_putc_sub(int c) {
  1014aa:	55                   	push   %ebp
  1014ab:	89 e5                	mov    %esp,%ebp
  1014ad:	83 ec 10             	sub    $0x10,%esp
  1014b0:	e8 aa ed ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1014b5:	05 9b e4 00 00       	add    $0xe49b,%eax
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1014ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1014c1:	eb 09                	jmp    1014cc <serial_putc_sub+0x22>
        delay();
  1014c3:	e8 ef fa ff ff       	call   100fb7 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1014c8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1014cc:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014d2:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1014d6:	89 c2                	mov    %eax,%edx
  1014d8:	ec                   	in     (%dx),%al
  1014d9:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1014dc:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1014e0:	0f b6 c0             	movzbl %al,%eax
  1014e3:	83 e0 20             	and    $0x20,%eax
  1014e6:	85 c0                	test   %eax,%eax
  1014e8:	75 09                	jne    1014f3 <serial_putc_sub+0x49>
  1014ea:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1014f1:	7e d0                	jle    1014c3 <serial_putc_sub+0x19>
    }
    outb(COM1 + COM_TX, c);
  1014f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1014f6:	0f b6 c0             	movzbl %al,%eax
  1014f9:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1014ff:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101502:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101506:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10150a:	ee                   	out    %al,(%dx)
}
  10150b:	90                   	nop
  10150c:	c9                   	leave  
  10150d:	c3                   	ret    

0010150e <serial_putc>:

/*
 * 函数功能：使用串口打印字符信息；
 */
static void
serial_putc(int c) {
  10150e:	55                   	push   %ebp
  10150f:	89 e5                	mov    %esp,%ebp
  101511:	e8 49 ed ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101516:	05 3a e4 00 00       	add    $0xe43a,%eax
    if (c != '\b') {
  10151b:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10151f:	74 0d                	je     10152e <serial_putc+0x20>
        serial_putc_sub(c);
  101521:	ff 75 08             	pushl  0x8(%ebp)
  101524:	e8 81 ff ff ff       	call   1014aa <serial_putc_sub>
  101529:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  10152c:	eb 1e                	jmp    10154c <serial_putc+0x3e>
        serial_putc_sub('\b');
  10152e:	6a 08                	push   $0x8
  101530:	e8 75 ff ff ff       	call   1014aa <serial_putc_sub>
  101535:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  101538:	6a 20                	push   $0x20
  10153a:	e8 6b ff ff ff       	call   1014aa <serial_putc_sub>
  10153f:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  101542:	6a 08                	push   $0x8
  101544:	e8 61 ff ff ff       	call   1014aa <serial_putc_sub>
  101549:	83 c4 04             	add    $0x4,%esp
}
  10154c:	90                   	nop
  10154d:	c9                   	leave  
  10154e:	c3                   	ret    

0010154f <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10154f:	55                   	push   %ebp
  101550:	89 e5                	mov    %esp,%ebp
  101552:	53                   	push   %ebx
  101553:	83 ec 14             	sub    $0x14,%esp
  101556:	e8 08 ed ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  10155b:	81 c3 f5 e3 00 00    	add    $0xe3f5,%ebx
    int c;
    while ((c = (*proc)()) != -1) {
  101561:	eb 36                	jmp    101599 <cons_intr+0x4a>
        if (c != 0) {
  101563:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101567:	74 30                	je     101599 <cons_intr+0x4a>
            cons.buf[cons.wpos ++] = c;
  101569:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  10156f:	8d 50 01             	lea    0x1(%eax),%edx
  101572:	89 93 d4 07 00 00    	mov    %edx,0x7d4(%ebx)
  101578:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10157b:	88 94 03 d0 05 00 00 	mov    %dl,0x5d0(%ebx,%eax,1)
            if (cons.wpos == CONSBUFSIZE) {
  101582:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  101588:	3d 00 02 00 00       	cmp    $0x200,%eax
  10158d:	75 0a                	jne    101599 <cons_intr+0x4a>
                cons.wpos = 0;
  10158f:	c7 83 d4 07 00 00 00 	movl   $0x0,0x7d4(%ebx)
  101596:	00 00 00 
    while ((c = (*proc)()) != -1) {
  101599:	8b 45 08             	mov    0x8(%ebp),%eax
  10159c:	ff d0                	call   *%eax
  10159e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1015a1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1015a5:	75 bc                	jne    101563 <cons_intr+0x14>
            }
        }
    }
}
  1015a7:	90                   	nop
  1015a8:	83 c4 14             	add    $0x14,%esp
  1015ab:	5b                   	pop    %ebx
  1015ac:	5d                   	pop    %ebp
  1015ad:	c3                   	ret    

001015ae <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1015ae:	55                   	push   %ebp
  1015af:	89 e5                	mov    %esp,%ebp
  1015b1:	83 ec 10             	sub    $0x10,%esp
  1015b4:	e8 a6 ec ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1015b9:	05 97 e3 00 00       	add    $0xe397,%eax
  1015be:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1015c4:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1015c8:	89 c2                	mov    %eax,%edx
  1015ca:	ec                   	in     (%dx),%al
  1015cb:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1015ce:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1015d2:	0f b6 c0             	movzbl %al,%eax
  1015d5:	83 e0 01             	and    $0x1,%eax
  1015d8:	85 c0                	test   %eax,%eax
  1015da:	75 07                	jne    1015e3 <serial_proc_data+0x35>
        return -1;
  1015dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1015e1:	eb 2a                	jmp    10160d <serial_proc_data+0x5f>
  1015e3:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1015e9:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1015ed:	89 c2                	mov    %eax,%edx
  1015ef:	ec                   	in     (%dx),%al
  1015f0:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1015f3:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1015f7:	0f b6 c0             	movzbl %al,%eax
  1015fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1015fd:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101601:	75 07                	jne    10160a <serial_proc_data+0x5c>
        c = '\b';
  101603:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10160a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10160d:	c9                   	leave  
  10160e:	c3                   	ret    

0010160f <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10160f:	55                   	push   %ebp
  101610:	89 e5                	mov    %esp,%ebp
  101612:	83 ec 08             	sub    $0x8,%esp
  101615:	e8 45 ec ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  10161a:	05 36 e3 00 00       	add    $0xe336,%eax
    if (serial_exists) {
  10161f:	8b 90 b8 05 00 00    	mov    0x5b8(%eax),%edx
  101625:	85 d2                	test   %edx,%edx
  101627:	74 12                	je     10163b <serial_intr+0x2c>
        cons_intr(serial_proc_data);
  101629:	83 ec 0c             	sub    $0xc,%esp
  10162c:	8d 80 5e 1c ff ff    	lea    -0xe3a2(%eax),%eax
  101632:	50                   	push   %eax
  101633:	e8 17 ff ff ff       	call   10154f <cons_intr>
  101638:	83 c4 10             	add    $0x10,%esp
    }
}
  10163b:	90                   	nop
  10163c:	c9                   	leave  
  10163d:	c3                   	ret    

0010163e <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10163e:	55                   	push   %ebp
  10163f:	89 e5                	mov    %esp,%ebp
  101641:	53                   	push   %ebx
  101642:	83 ec 24             	sub    $0x24,%esp
  101645:	e8 e2 02 00 00       	call   10192c <__x86.get_pc_thunk.cx>
  10164a:	81 c1 06 e3 00 00    	add    $0xe306,%ecx
  101650:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101656:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10165a:	89 c2                	mov    %eax,%edx
  10165c:	ec                   	in     (%dx),%al
  10165d:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101660:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101664:	0f b6 c0             	movzbl %al,%eax
  101667:	83 e0 01             	and    $0x1,%eax
  10166a:	85 c0                	test   %eax,%eax
  10166c:	75 0a                	jne    101678 <kbd_proc_data+0x3a>
        return -1;
  10166e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101673:	e9 73 01 00 00       	jmp    1017eb <kbd_proc_data+0x1ad>
  101678:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10167e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101682:	89 c2                	mov    %eax,%edx
  101684:	ec                   	in     (%dx),%al
  101685:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  101688:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  10168c:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  10168f:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101693:	75 19                	jne    1016ae <kbd_proc_data+0x70>
        // E0 escape character
        shift |= E0ESC;
  101695:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  10169b:	83 c8 40             	or     $0x40,%eax
  10169e:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1016a4:	b8 00 00 00 00       	mov    $0x0,%eax
  1016a9:	e9 3d 01 00 00       	jmp    1017eb <kbd_proc_data+0x1ad>
    } else if (data & 0x80) {
  1016ae:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016b2:	84 c0                	test   %al,%al
  1016b4:	79 4b                	jns    101701 <kbd_proc_data+0xc3>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1016b6:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016bc:	83 e0 40             	and    $0x40,%eax
  1016bf:	85 c0                	test   %eax,%eax
  1016c1:	75 09                	jne    1016cc <kbd_proc_data+0x8e>
  1016c3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016c7:	83 e0 7f             	and    $0x7f,%eax
  1016ca:	eb 04                	jmp    1016d0 <kbd_proc_data+0x92>
  1016cc:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016d0:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1016d3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1016d7:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  1016de:	ff 
  1016df:	83 c8 40             	or     $0x40,%eax
  1016e2:	0f b6 c0             	movzbl %al,%eax
  1016e5:	f7 d0                	not    %eax
  1016e7:	89 c2                	mov    %eax,%edx
  1016e9:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1016ef:	21 d0                	and    %edx,%eax
  1016f1:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
        return 0;
  1016f7:	b8 00 00 00 00       	mov    $0x0,%eax
  1016fc:	e9 ea 00 00 00       	jmp    1017eb <kbd_proc_data+0x1ad>
    } else if (shift & E0ESC) {
  101701:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101707:	83 e0 40             	and    $0x40,%eax
  10170a:	85 c0                	test   %eax,%eax
  10170c:	74 13                	je     101721 <kbd_proc_data+0xe3>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10170e:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101712:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101718:	83 e0 bf             	and    $0xffffffbf,%eax
  10171b:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    }

    shift |= shiftcode[data];
  101721:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101725:	0f b6 84 01 b0 f6 ff 	movzbl -0x950(%ecx,%eax,1),%eax
  10172c:	ff 
  10172d:	0f b6 d0             	movzbl %al,%edx
  101730:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101736:	09 d0                	or     %edx,%eax
  101738:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)
    shift ^= togglecode[data];
  10173e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101742:	0f b6 84 01 b0 f7 ff 	movzbl -0x850(%ecx,%eax,1),%eax
  101749:	ff 
  10174a:	0f b6 d0             	movzbl %al,%edx
  10174d:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101753:	31 d0                	xor    %edx,%eax
  101755:	89 81 d8 07 00 00    	mov    %eax,0x7d8(%ecx)

    c = charcode[shift & (CTL | SHIFT)][data];
  10175b:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101761:	83 e0 03             	and    $0x3,%eax
  101764:	8b 94 81 34 00 00 00 	mov    0x34(%ecx,%eax,4),%edx
  10176b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10176f:	01 d0                	add    %edx,%eax
  101771:	0f b6 00             	movzbl (%eax),%eax
  101774:	0f b6 c0             	movzbl %al,%eax
  101777:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  10177a:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  101780:	83 e0 08             	and    $0x8,%eax
  101783:	85 c0                	test   %eax,%eax
  101785:	74 22                	je     1017a9 <kbd_proc_data+0x16b>
        if ('a' <= c && c <= 'z')
  101787:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  10178b:	7e 0c                	jle    101799 <kbd_proc_data+0x15b>
  10178d:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101791:	7f 06                	jg     101799 <kbd_proc_data+0x15b>
            c += 'A' - 'a';
  101793:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  101797:	eb 10                	jmp    1017a9 <kbd_proc_data+0x16b>
        else if ('A' <= c && c <= 'Z')
  101799:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  10179d:	7e 0a                	jle    1017a9 <kbd_proc_data+0x16b>
  10179f:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1017a3:	7f 04                	jg     1017a9 <kbd_proc_data+0x16b>
            c += 'a' - 'A';
  1017a5:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1017a9:	8b 81 d8 07 00 00    	mov    0x7d8(%ecx),%eax
  1017af:	f7 d0                	not    %eax
  1017b1:	83 e0 06             	and    $0x6,%eax
  1017b4:	85 c0                	test   %eax,%eax
  1017b6:	75 30                	jne    1017e8 <kbd_proc_data+0x1aa>
  1017b8:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1017bf:	75 27                	jne    1017e8 <kbd_proc_data+0x1aa>
        cprintf("Rebooting!\n");
  1017c1:	83 ec 0c             	sub    $0xc,%esp
  1017c4:	8d 81 45 44 ff ff    	lea    -0xbbbb(%ecx),%eax
  1017ca:	50                   	push   %eax
  1017cb:	89 cb                	mov    %ecx,%ebx
  1017cd:	e8 04 eb ff ff       	call   1002d6 <cprintf>
  1017d2:	83 c4 10             	add    $0x10,%esp
  1017d5:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1017db:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1017e3:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1017e7:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1017e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1017eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1017ee:	c9                   	leave  
  1017ef:	c3                   	ret    

001017f0 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1017f0:	55                   	push   %ebp
  1017f1:	89 e5                	mov    %esp,%ebp
  1017f3:	83 ec 08             	sub    $0x8,%esp
  1017f6:	e8 64 ea ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1017fb:	05 55 e1 00 00       	add    $0xe155,%eax
    cons_intr(kbd_proc_data);
  101800:	83 ec 0c             	sub    $0xc,%esp
  101803:	8d 80 ee 1c ff ff    	lea    -0xe312(%eax),%eax
  101809:	50                   	push   %eax
  10180a:	e8 40 fd ff ff       	call   10154f <cons_intr>
  10180f:	83 c4 10             	add    $0x10,%esp
}
  101812:	90                   	nop
  101813:	c9                   	leave  
  101814:	c3                   	ret    

00101815 <kbd_init>:

static void
kbd_init(void) {
  101815:	55                   	push   %ebp
  101816:	89 e5                	mov    %esp,%ebp
  101818:	53                   	push   %ebx
  101819:	83 ec 04             	sub    $0x4,%esp
  10181c:	e8 42 ea ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  101821:	81 c3 2f e1 00 00    	add    $0xe12f,%ebx
    // drain the kbd buffer
    kbd_intr();
  101827:	e8 c4 ff ff ff       	call   1017f0 <kbd_intr>
    pic_enable(IRQ_KBD);
  10182c:	83 ec 0c             	sub    $0xc,%esp
  10182f:	6a 01                	push   $0x1
  101831:	e8 5f 01 00 00       	call   101995 <pic_enable>
  101836:	83 c4 10             	add    $0x10,%esp
}
  101839:	90                   	nop
  10183a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10183d:	c9                   	leave  
  10183e:	c3                   	ret    

0010183f <cons_init>:

/* 
 * 函数功能：初始化终端设备；
 */
void
cons_init(void) {
  10183f:	55                   	push   %ebp
  101840:	89 e5                	mov    %esp,%ebp
  101842:	53                   	push   %ebx
  101843:	83 ec 04             	sub    $0x4,%esp
  101846:	e8 18 ea ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  10184b:	81 c3 05 e1 00 00    	add    $0xe105,%ebx
    cga_init();         // 并口初始化；
  101851:	e8 b4 f7 ff ff       	call   10100a <cga_init>
    serial_init();      // 串口初始化；
  101856:	e8 a3 f8 ff ff       	call   1010fe <serial_init>
    kbd_init();         // 键盘初始化；
  10185b:	e8 b5 ff ff ff       	call   101815 <kbd_init>
    if (!serial_exists) {
  101860:	8b 83 b8 05 00 00    	mov    0x5b8(%ebx),%eax
  101866:	85 c0                	test   %eax,%eax
  101868:	75 12                	jne    10187c <cons_init+0x3d>
        cprintf("serial port does not exist!!\n");
  10186a:	83 ec 0c             	sub    $0xc,%esp
  10186d:	8d 83 51 44 ff ff    	lea    -0xbbaf(%ebx),%eax
  101873:	50                   	push   %eax
  101874:	e8 5d ea ff ff       	call   1002d6 <cprintf>
  101879:	83 c4 10             	add    $0x10,%esp
    }
}
  10187c:	90                   	nop
  10187d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101880:	c9                   	leave  
  101881:	c3                   	ret    

00101882 <cons_putc>:

/* 
 * 函数功能：打印一个单字符串 c 到终端设备中；
 */
void
cons_putc(int c) {
  101882:	55                   	push   %ebp
  101883:	89 e5                	mov    %esp,%ebp
  101885:	83 ec 08             	sub    $0x8,%esp
  101888:	e8 d2 e9 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  10188d:	05 c3 e0 00 00       	add    $0xe0c3,%eax
    lpt_putc(c);    // 打印字符串信息到并口上；
  101892:	ff 75 08             	pushl  0x8(%ebp)
  101895:	e8 e0 f9 ff ff       	call   10127a <lpt_putc>
  10189a:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);    // 打印字符串到显示器上；
  10189d:	83 ec 0c             	sub    $0xc,%esp
  1018a0:	ff 75 08             	pushl  0x8(%ebp)
  1018a3:	e8 13 fa ff ff       	call   1012bb <cga_putc>
  1018a8:	83 c4 10             	add    $0x10,%esp
    serial_putc(c); // 打印字符到串口；
  1018ab:	83 ec 0c             	sub    $0xc,%esp
  1018ae:	ff 75 08             	pushl  0x8(%ebp)
  1018b1:	e8 58 fc ff ff       	call   10150e <serial_putc>
  1018b6:	83 c4 10             	add    $0x10,%esp
}
  1018b9:	90                   	nop
  1018ba:	c9                   	leave  
  1018bb:	c3                   	ret    

001018bc <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1018bc:	55                   	push   %ebp
  1018bd:	89 e5                	mov    %esp,%ebp
  1018bf:	53                   	push   %ebx
  1018c0:	83 ec 14             	sub    $0x14,%esp
  1018c3:	e8 9b e9 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  1018c8:	81 c3 88 e0 00 00    	add    $0xe088,%ebx
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1018ce:	e8 3c fd ff ff       	call   10160f <serial_intr>
    kbd_intr();
  1018d3:	e8 18 ff ff ff       	call   1017f0 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1018d8:	8b 93 d0 07 00 00    	mov    0x7d0(%ebx),%edx
  1018de:	8b 83 d4 07 00 00    	mov    0x7d4(%ebx),%eax
  1018e4:	39 c2                	cmp    %eax,%edx
  1018e6:	74 39                	je     101921 <cons_getc+0x65>
        c = cons.buf[cons.rpos ++];
  1018e8:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  1018ee:	8d 50 01             	lea    0x1(%eax),%edx
  1018f1:	89 93 d0 07 00 00    	mov    %edx,0x7d0(%ebx)
  1018f7:	0f b6 84 03 d0 05 00 	movzbl 0x5d0(%ebx,%eax,1),%eax
  1018fe:	00 
  1018ff:	0f b6 c0             	movzbl %al,%eax
  101902:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101905:	8b 83 d0 07 00 00    	mov    0x7d0(%ebx),%eax
  10190b:	3d 00 02 00 00       	cmp    $0x200,%eax
  101910:	75 0a                	jne    10191c <cons_getc+0x60>
            cons.rpos = 0;
  101912:	c7 83 d0 07 00 00 00 	movl   $0x0,0x7d0(%ebx)
  101919:	00 00 00 
        }
        return c;
  10191c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10191f:	eb 05                	jmp    101926 <cons_getc+0x6a>
    }
    return 0;
  101921:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101926:	83 c4 14             	add    $0x14,%esp
  101929:	5b                   	pop    %ebx
  10192a:	5d                   	pop    %ebp
  10192b:	c3                   	ret    

0010192c <__x86.get_pc_thunk.cx>:
  10192c:	8b 0c 24             	mov    (%esp),%ecx
  10192f:	c3                   	ret    

00101930 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101930:	55                   	push   %ebp
  101931:	89 e5                	mov    %esp,%ebp
  101933:	83 ec 14             	sub    $0x14,%esp
  101936:	e8 24 e9 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  10193b:	05 15 e0 00 00       	add    $0xe015,%eax
  101940:	8b 55 08             	mov    0x8(%ebp),%edx
  101943:	66 89 55 ec          	mov    %dx,-0x14(%ebp)
    irq_mask = mask;
  101947:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  10194b:	66 89 90 b0 fb ff ff 	mov    %dx,-0x450(%eax)
    if (did_init) {
  101952:	8b 80 dc 07 00 00    	mov    0x7dc(%eax),%eax
  101958:	85 c0                	test   %eax,%eax
  10195a:	74 36                	je     101992 <pic_setmask+0x62>
        outb(IO_PIC1 + 1, mask);
  10195c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101960:	0f b6 c0             	movzbl %al,%eax
  101963:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101969:	88 45 f9             	mov    %al,-0x7(%ebp)
  10196c:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101970:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101974:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  101975:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101979:	66 c1 e8 08          	shr    $0x8,%ax
  10197d:	0f b6 c0             	movzbl %al,%eax
  101980:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101986:	88 45 fd             	mov    %al,-0x3(%ebp)
  101989:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10198d:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101991:	ee                   	out    %al,(%dx)
    }
}
  101992:	90                   	nop
  101993:	c9                   	leave  
  101994:	c3                   	ret    

00101995 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101995:	55                   	push   %ebp
  101996:	89 e5                	mov    %esp,%ebp
  101998:	53                   	push   %ebx
  101999:	e8 c1 e8 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  10199e:	05 b2 df 00 00       	add    $0xdfb2,%eax
    pic_setmask(irq_mask & ~(1 << irq));
  1019a3:	8b 55 08             	mov    0x8(%ebp),%edx
  1019a6:	bb 01 00 00 00       	mov    $0x1,%ebx
  1019ab:	89 d1                	mov    %edx,%ecx
  1019ad:	d3 e3                	shl    %cl,%ebx
  1019af:	89 da                	mov    %ebx,%edx
  1019b1:	f7 d2                	not    %edx
  1019b3:	0f b7 80 b0 fb ff ff 	movzwl -0x450(%eax),%eax
  1019ba:	21 d0                	and    %edx,%eax
  1019bc:	0f b7 c0             	movzwl %ax,%eax
  1019bf:	50                   	push   %eax
  1019c0:	e8 6b ff ff ff       	call   101930 <pic_setmask>
  1019c5:	83 c4 04             	add    $0x4,%esp
}
  1019c8:	90                   	nop
  1019c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1019cc:	c9                   	leave  
  1019cd:	c3                   	ret    

001019ce <pic_init>:

/*
 * 函数功能：初始化 8259A 中断控制器；
 */
void
pic_init(void) {
  1019ce:	55                   	push   %ebp
  1019cf:	89 e5                	mov    %esp,%ebp
  1019d1:	83 ec 40             	sub    $0x40,%esp
  1019d4:	e8 53 ff ff ff       	call   10192c <__x86.get_pc_thunk.cx>
  1019d9:	81 c1 77 df 00 00    	add    $0xdf77,%ecx
    did_init = 1;
  1019df:	c7 81 dc 07 00 00 01 	movl   $0x1,0x7dc(%ecx)
  1019e6:	00 00 00 
  1019e9:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1019ef:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
  1019f3:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1019f7:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1019fb:	ee                   	out    %al,(%dx)
  1019fc:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  101a02:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
  101a06:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  101a0a:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101a0e:	ee                   	out    %al,(%dx)
  101a0f:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101a15:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
  101a19:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  101a1d:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101a21:	ee                   	out    %al,(%dx)
  101a22:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  101a28:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
  101a2c:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101a30:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101a34:	ee                   	out    %al,(%dx)
  101a35:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101a3b:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
  101a3f:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101a43:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101a47:	ee                   	out    %al,(%dx)
  101a48:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101a4e:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
  101a52:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101a56:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101a5a:	ee                   	out    %al,(%dx)
  101a5b:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101a61:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
  101a65:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101a69:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101a6d:	ee                   	out    %al,(%dx)
  101a6e:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101a74:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
  101a78:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101a7c:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101a80:	ee                   	out    %al,(%dx)
  101a81:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101a87:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
  101a8b:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101a8f:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101a93:	ee                   	out    %al,(%dx)
  101a94:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101a9a:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
  101a9e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101aa2:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101aa6:	ee                   	out    %al,(%dx)
  101aa7:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101aad:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
  101ab1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101ab5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101ab9:	ee                   	out    %al,(%dx)
  101aba:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101ac0:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
  101ac4:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101ac8:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101acc:	ee                   	out    %al,(%dx)
  101acd:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  101ad3:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
  101ad7:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101adb:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101adf:	ee                   	out    %al,(%dx)
  101ae0:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  101ae6:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
  101aea:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101aee:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101af2:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101af3:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101afa:	66 83 f8 ff          	cmp    $0xffff,%ax
  101afe:	74 13                	je     101b13 <pic_init+0x145>
        pic_setmask(irq_mask);
  101b00:	0f b7 81 b0 fb ff ff 	movzwl -0x450(%ecx),%eax
  101b07:	0f b7 c0             	movzwl %ax,%eax
  101b0a:	50                   	push   %eax
  101b0b:	e8 20 fe ff ff       	call   101930 <pic_setmask>
  101b10:	83 c4 04             	add    $0x4,%esp
    }
}
  101b13:	90                   	nop
  101b14:	c9                   	leave  
  101b15:	c3                   	ret    

00101b16 <intr_enable>:

/*
 * 函数功能：使能 irq 中断；
 */
void
intr_enable(void) {
  101b16:	55                   	push   %ebp
  101b17:	89 e5                	mov    %esp,%ebp
  101b19:	e8 41 e7 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101b1e:	05 32 de 00 00       	add    $0xde32,%eax
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101b23:	fb                   	sti    
    sti();
}
  101b24:	90                   	nop
  101b25:	5d                   	pop    %ebp
  101b26:	c3                   	ret    

00101b27 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101b27:	55                   	push   %ebp
  101b28:	89 e5                	mov    %esp,%ebp
  101b2a:	e8 30 e7 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101b2f:	05 21 de 00 00       	add    $0xde21,%eax
}

static inline void
cli(void) {
    asm volatile ("cli");
  101b34:	fa                   	cli    
    cli();
}
  101b35:	90                   	nop
  101b36:	5d                   	pop    %ebp
  101b37:	c3                   	ret    

00101b38 <print_ticks>:
#include <console.h>
#include <kdebug.h>
#include <string.h>
#define TICK_NUM 100

static void print_ticks() {
  101b38:	55                   	push   %ebp
  101b39:	89 e5                	mov    %esp,%ebp
  101b3b:	53                   	push   %ebx
  101b3c:	83 ec 04             	sub    $0x4,%esp
  101b3f:	e8 1b e7 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101b44:	05 0c de 00 00       	add    $0xde0c,%eax
    cprintf("%d ticks\n",TICK_NUM);
  101b49:	83 ec 08             	sub    $0x8,%esp
  101b4c:	6a 64                	push   $0x64
  101b4e:	8d 90 6f 44 ff ff    	lea    -0xbb91(%eax),%edx
  101b54:	52                   	push   %edx
  101b55:	89 c3                	mov    %eax,%ebx
  101b57:	e8 7a e7 ff ff       	call   1002d6 <cprintf>
  101b5c:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101b5f:	90                   	nop
  101b60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101b63:	c9                   	leave  
  101b64:	c3                   	ret    

00101b65 <idt_init>:

/*
 * 函数功能：将 IDT 中断描述符表初始化为 kern/trap/vectors.S 中的每一个入口点；
 */
void
idt_init(void) {
  101b65:	55                   	push   %ebp
  101b66:	89 e5                	mov    %esp,%ebp
  101b68:	83 ec 10             	sub    $0x10,%esp
  101b6b:	e8 ef e6 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101b70:	05 e0 dd 00 00       	add    $0xdde0,%eax
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101b75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101b7c:	e9 c7 00 00 00       	jmp    101c48 <idt_init+0xe3>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101b81:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101b87:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101b8a:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101b8d:	89 d1                	mov    %edx,%ecx
  101b8f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101b92:	66 89 8c d0 f0 07 00 	mov    %cx,0x7f0(%eax,%edx,8)
  101b99:	00 
  101b9a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101b9d:	66 c7 84 d0 f2 07 00 	movw   $0x8,0x7f2(%eax,%edx,8)
  101ba4:	00 08 00 
  101ba7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101baa:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101bb1:	00 
  101bb2:	83 e1 e0             	and    $0xffffffe0,%ecx
  101bb5:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101bbc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bbf:	0f b6 8c d0 f4 07 00 	movzbl 0x7f4(%eax,%edx,8),%ecx
  101bc6:	00 
  101bc7:	83 e1 1f             	and    $0x1f,%ecx
  101bca:	88 8c d0 f4 07 00 00 	mov    %cl,0x7f4(%eax,%edx,8)
  101bd1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bd4:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101bdb:	00 
  101bdc:	83 e1 f0             	and    $0xfffffff0,%ecx
  101bdf:	83 c9 0e             	or     $0xe,%ecx
  101be2:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101be9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101bec:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101bf3:	00 
  101bf4:	83 e1 ef             	and    $0xffffffef,%ecx
  101bf7:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101bfe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c01:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c08:	00 
  101c09:	83 e1 9f             	and    $0xffffff9f,%ecx
  101c0c:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c13:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c16:	0f b6 8c d0 f5 07 00 	movzbl 0x7f5(%eax,%edx,8),%ecx
  101c1d:	00 
  101c1e:	83 c9 80             	or     $0xffffff80,%ecx
  101c21:	88 8c d0 f5 07 00 00 	mov    %cl,0x7f5(%eax,%edx,8)
  101c28:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101c2e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  101c31:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
  101c34:	c1 ea 10             	shr    $0x10,%edx
  101c37:	89 d1                	mov    %edx,%ecx
  101c39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c3c:	66 89 8c d0 f6 07 00 	mov    %cx,0x7f6(%eax,%edx,8)
  101c43:	00 
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101c44:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101c48:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101c4b:	81 fa ff 00 00 00    	cmp    $0xff,%edx
  101c51:	0f 86 2a ff ff ff    	jbe    101b81 <idt_init+0x1c>
    }
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101c57:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101c5d:	8b 92 e4 01 00 00    	mov    0x1e4(%edx),%edx
  101c63:	66 89 90 b8 0b 00 00 	mov    %dx,0xbb8(%eax)
  101c6a:	66 c7 80 ba 0b 00 00 	movw   $0x8,0xbba(%eax)
  101c71:	08 00 
  101c73:	0f b6 90 bc 0b 00 00 	movzbl 0xbbc(%eax),%edx
  101c7a:	83 e2 e0             	and    $0xffffffe0,%edx
  101c7d:	88 90 bc 0b 00 00    	mov    %dl,0xbbc(%eax)
  101c83:	0f b6 90 bc 0b 00 00 	movzbl 0xbbc(%eax),%edx
  101c8a:	83 e2 1f             	and    $0x1f,%edx
  101c8d:	88 90 bc 0b 00 00    	mov    %dl,0xbbc(%eax)
  101c93:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101c9a:	83 e2 f0             	and    $0xfffffff0,%edx
  101c9d:	83 ca 0e             	or     $0xe,%edx
  101ca0:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101ca6:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101cad:	83 e2 ef             	and    $0xffffffef,%edx
  101cb0:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101cb6:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101cbd:	83 ca 60             	or     $0x60,%edx
  101cc0:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101cc6:	0f b6 90 bd 0b 00 00 	movzbl 0xbbd(%eax),%edx
  101ccd:	83 ca 80             	or     $0xffffff80,%edx
  101cd0:	88 90 bd 0b 00 00    	mov    %dl,0xbbd(%eax)
  101cd6:	c7 c2 02 f5 10 00    	mov    $0x10f502,%edx
  101cdc:	8b 92 e4 01 00 00    	mov    0x1e4(%edx),%edx
  101ce2:	c1 ea 10             	shr    $0x10,%edx
  101ce5:	66 89 90 be 0b 00 00 	mov    %dx,0xbbe(%eax)
  101cec:	8d 80 50 00 00 00    	lea    0x50(%eax),%eax
  101cf2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101cf5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101cf8:	0f 01 18             	lidtl  (%eax)
	// load the IDT
    lidt(&idt_pd);
}
  101cfb:	90                   	nop
  101cfc:	c9                   	leave  
  101cfd:	c3                   	ret    

00101cfe <trapname>:

static const char *
trapname(int trapno) {
  101cfe:	55                   	push   %ebp
  101cff:	89 e5                	mov    %esp,%ebp
  101d01:	e8 59 e5 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101d06:	05 4a dc 00 00       	add    $0xdc4a,%eax
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101d0b:	8b 55 08             	mov    0x8(%ebp),%edx
  101d0e:	83 fa 13             	cmp    $0x13,%edx
  101d11:	77 0c                	ja     101d1f <trapname+0x21>
        return excnames[trapno];
  101d13:	8b 55 08             	mov    0x8(%ebp),%edx
  101d16:	8b 84 90 f0 00 00 00 	mov    0xf0(%eax,%edx,4),%eax
  101d1d:	eb 1a                	jmp    101d39 <trapname+0x3b>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101d1f:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101d23:	7e 0e                	jle    101d33 <trapname+0x35>
  101d25:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101d29:	7f 08                	jg     101d33 <trapname+0x35>
        return "Hardware Interrupt";
  101d2b:	8d 80 79 44 ff ff    	lea    -0xbb87(%eax),%eax
  101d31:	eb 06                	jmp    101d39 <trapname+0x3b>
    }
    return "(unknown trap)";
  101d33:	8d 80 8c 44 ff ff    	lea    -0xbb74(%eax),%eax
}
  101d39:	5d                   	pop    %ebp
  101d3a:	c3                   	ret    

00101d3b <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101d3b:	55                   	push   %ebp
  101d3c:	89 e5                	mov    %esp,%ebp
  101d3e:	e8 1c e5 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  101d43:	05 0d dc 00 00       	add    $0xdc0d,%eax
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101d48:	8b 45 08             	mov    0x8(%ebp),%eax
  101d4b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d4f:	66 83 f8 08          	cmp    $0x8,%ax
  101d53:	0f 94 c0             	sete   %al
  101d56:	0f b6 c0             	movzbl %al,%eax
}
  101d59:	5d                   	pop    %ebp
  101d5a:	c3                   	ret    

00101d5b <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101d5b:	55                   	push   %ebp
  101d5c:	89 e5                	mov    %esp,%ebp
  101d5e:	53                   	push   %ebx
  101d5f:	83 ec 14             	sub    $0x14,%esp
  101d62:	e8 fc e4 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  101d67:	81 c3 e9 db 00 00    	add    $0xdbe9,%ebx
    cprintf("trapframe at %p\n", tf);
  101d6d:	83 ec 08             	sub    $0x8,%esp
  101d70:	ff 75 08             	pushl  0x8(%ebp)
  101d73:	8d 83 cd 44 ff ff    	lea    -0xbb33(%ebx),%eax
  101d79:	50                   	push   %eax
  101d7a:	e8 57 e5 ff ff       	call   1002d6 <cprintf>
  101d7f:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101d82:	8b 45 08             	mov    0x8(%ebp),%eax
  101d85:	83 ec 0c             	sub    $0xc,%esp
  101d88:	50                   	push   %eax
  101d89:	e8 d3 01 00 00       	call   101f61 <print_regs>
  101d8e:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101d91:	8b 45 08             	mov    0x8(%ebp),%eax
  101d94:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101d98:	0f b7 c0             	movzwl %ax,%eax
  101d9b:	83 ec 08             	sub    $0x8,%esp
  101d9e:	50                   	push   %eax
  101d9f:	8d 83 de 44 ff ff    	lea    -0xbb22(%ebx),%eax
  101da5:	50                   	push   %eax
  101da6:	e8 2b e5 ff ff       	call   1002d6 <cprintf>
  101dab:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101dae:	8b 45 08             	mov    0x8(%ebp),%eax
  101db1:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101db5:	0f b7 c0             	movzwl %ax,%eax
  101db8:	83 ec 08             	sub    $0x8,%esp
  101dbb:	50                   	push   %eax
  101dbc:	8d 83 f1 44 ff ff    	lea    -0xbb0f(%ebx),%eax
  101dc2:	50                   	push   %eax
  101dc3:	e8 0e e5 ff ff       	call   1002d6 <cprintf>
  101dc8:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  101dce:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101dd2:	0f b7 c0             	movzwl %ax,%eax
  101dd5:	83 ec 08             	sub    $0x8,%esp
  101dd8:	50                   	push   %eax
  101dd9:	8d 83 04 45 ff ff    	lea    -0xbafc(%ebx),%eax
  101ddf:	50                   	push   %eax
  101de0:	e8 f1 e4 ff ff       	call   1002d6 <cprintf>
  101de5:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101de8:	8b 45 08             	mov    0x8(%ebp),%eax
  101deb:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101def:	0f b7 c0             	movzwl %ax,%eax
  101df2:	83 ec 08             	sub    $0x8,%esp
  101df5:	50                   	push   %eax
  101df6:	8d 83 17 45 ff ff    	lea    -0xbae9(%ebx),%eax
  101dfc:	50                   	push   %eax
  101dfd:	e8 d4 e4 ff ff       	call   1002d6 <cprintf>
  101e02:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101e05:	8b 45 08             	mov    0x8(%ebp),%eax
  101e08:	8b 40 30             	mov    0x30(%eax),%eax
  101e0b:	83 ec 0c             	sub    $0xc,%esp
  101e0e:	50                   	push   %eax
  101e0f:	e8 ea fe ff ff       	call   101cfe <trapname>
  101e14:	83 c4 10             	add    $0x10,%esp
  101e17:	89 c2                	mov    %eax,%edx
  101e19:	8b 45 08             	mov    0x8(%ebp),%eax
  101e1c:	8b 40 30             	mov    0x30(%eax),%eax
  101e1f:	83 ec 04             	sub    $0x4,%esp
  101e22:	52                   	push   %edx
  101e23:	50                   	push   %eax
  101e24:	8d 83 2a 45 ff ff    	lea    -0xbad6(%ebx),%eax
  101e2a:	50                   	push   %eax
  101e2b:	e8 a6 e4 ff ff       	call   1002d6 <cprintf>
  101e30:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101e33:	8b 45 08             	mov    0x8(%ebp),%eax
  101e36:	8b 40 34             	mov    0x34(%eax),%eax
  101e39:	83 ec 08             	sub    $0x8,%esp
  101e3c:	50                   	push   %eax
  101e3d:	8d 83 3c 45 ff ff    	lea    -0xbac4(%ebx),%eax
  101e43:	50                   	push   %eax
  101e44:	e8 8d e4 ff ff       	call   1002d6 <cprintf>
  101e49:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4f:	8b 40 38             	mov    0x38(%eax),%eax
  101e52:	83 ec 08             	sub    $0x8,%esp
  101e55:	50                   	push   %eax
  101e56:	8d 83 4b 45 ff ff    	lea    -0xbab5(%ebx),%eax
  101e5c:	50                   	push   %eax
  101e5d:	e8 74 e4 ff ff       	call   1002d6 <cprintf>
  101e62:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101e65:	8b 45 08             	mov    0x8(%ebp),%eax
  101e68:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e6c:	0f b7 c0             	movzwl %ax,%eax
  101e6f:	83 ec 08             	sub    $0x8,%esp
  101e72:	50                   	push   %eax
  101e73:	8d 83 5a 45 ff ff    	lea    -0xbaa6(%ebx),%eax
  101e79:	50                   	push   %eax
  101e7a:	e8 57 e4 ff ff       	call   1002d6 <cprintf>
  101e7f:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101e82:	8b 45 08             	mov    0x8(%ebp),%eax
  101e85:	8b 40 40             	mov    0x40(%eax),%eax
  101e88:	83 ec 08             	sub    $0x8,%esp
  101e8b:	50                   	push   %eax
  101e8c:	8d 83 6d 45 ff ff    	lea    -0xba93(%ebx),%eax
  101e92:	50                   	push   %eax
  101e93:	e8 3e e4 ff ff       	call   1002d6 <cprintf>
  101e98:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101e9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101ea2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101ea9:	eb 41                	jmp    101eec <print_trapframe+0x191>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101eab:	8b 45 08             	mov    0x8(%ebp),%eax
  101eae:	8b 50 40             	mov    0x40(%eax),%edx
  101eb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101eb4:	21 d0                	and    %edx,%eax
  101eb6:	85 c0                	test   %eax,%eax
  101eb8:	74 2b                	je     101ee5 <print_trapframe+0x18a>
  101eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ebd:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101ec4:	85 c0                	test   %eax,%eax
  101ec6:	74 1d                	je     101ee5 <print_trapframe+0x18a>
            cprintf("%s,", IA32flags[i]);
  101ec8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ecb:	8b 84 83 70 00 00 00 	mov    0x70(%ebx,%eax,4),%eax
  101ed2:	83 ec 08             	sub    $0x8,%esp
  101ed5:	50                   	push   %eax
  101ed6:	8d 83 7c 45 ff ff    	lea    -0xba84(%ebx),%eax
  101edc:	50                   	push   %eax
  101edd:	e8 f4 e3 ff ff       	call   1002d6 <cprintf>
  101ee2:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101ee5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101ee9:	d1 65 f0             	shll   -0x10(%ebp)
  101eec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101eef:	83 f8 17             	cmp    $0x17,%eax
  101ef2:	76 b7                	jbe    101eab <print_trapframe+0x150>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef7:	8b 40 40             	mov    0x40(%eax),%eax
  101efa:	c1 e8 0c             	shr    $0xc,%eax
  101efd:	83 e0 03             	and    $0x3,%eax
  101f00:	83 ec 08             	sub    $0x8,%esp
  101f03:	50                   	push   %eax
  101f04:	8d 83 80 45 ff ff    	lea    -0xba80(%ebx),%eax
  101f0a:	50                   	push   %eax
  101f0b:	e8 c6 e3 ff ff       	call   1002d6 <cprintf>
  101f10:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101f13:	83 ec 0c             	sub    $0xc,%esp
  101f16:	ff 75 08             	pushl  0x8(%ebp)
  101f19:	e8 1d fe ff ff       	call   101d3b <trap_in_kernel>
  101f1e:	83 c4 10             	add    $0x10,%esp
  101f21:	85 c0                	test   %eax,%eax
  101f23:	75 36                	jne    101f5b <print_trapframe+0x200>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101f25:	8b 45 08             	mov    0x8(%ebp),%eax
  101f28:	8b 40 44             	mov    0x44(%eax),%eax
  101f2b:	83 ec 08             	sub    $0x8,%esp
  101f2e:	50                   	push   %eax
  101f2f:	8d 83 89 45 ff ff    	lea    -0xba77(%ebx),%eax
  101f35:	50                   	push   %eax
  101f36:	e8 9b e3 ff ff       	call   1002d6 <cprintf>
  101f3b:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101f41:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101f45:	0f b7 c0             	movzwl %ax,%eax
  101f48:	83 ec 08             	sub    $0x8,%esp
  101f4b:	50                   	push   %eax
  101f4c:	8d 83 98 45 ff ff    	lea    -0xba68(%ebx),%eax
  101f52:	50                   	push   %eax
  101f53:	e8 7e e3 ff ff       	call   1002d6 <cprintf>
  101f58:	83 c4 10             	add    $0x10,%esp
    }
}
  101f5b:	90                   	nop
  101f5c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101f5f:	c9                   	leave  
  101f60:	c3                   	ret    

00101f61 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101f61:	55                   	push   %ebp
  101f62:	89 e5                	mov    %esp,%ebp
  101f64:	53                   	push   %ebx
  101f65:	83 ec 04             	sub    $0x4,%esp
  101f68:	e8 f6 e2 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  101f6d:	81 c3 e3 d9 00 00    	add    $0xd9e3,%ebx
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101f73:	8b 45 08             	mov    0x8(%ebp),%eax
  101f76:	8b 00                	mov    (%eax),%eax
  101f78:	83 ec 08             	sub    $0x8,%esp
  101f7b:	50                   	push   %eax
  101f7c:	8d 83 ab 45 ff ff    	lea    -0xba55(%ebx),%eax
  101f82:	50                   	push   %eax
  101f83:	e8 4e e3 ff ff       	call   1002d6 <cprintf>
  101f88:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f8e:	8b 40 04             	mov    0x4(%eax),%eax
  101f91:	83 ec 08             	sub    $0x8,%esp
  101f94:	50                   	push   %eax
  101f95:	8d 83 ba 45 ff ff    	lea    -0xba46(%ebx),%eax
  101f9b:	50                   	push   %eax
  101f9c:	e8 35 e3 ff ff       	call   1002d6 <cprintf>
  101fa1:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  101fa7:	8b 40 08             	mov    0x8(%eax),%eax
  101faa:	83 ec 08             	sub    $0x8,%esp
  101fad:	50                   	push   %eax
  101fae:	8d 83 c9 45 ff ff    	lea    -0xba37(%ebx),%eax
  101fb4:	50                   	push   %eax
  101fb5:	e8 1c e3 ff ff       	call   1002d6 <cprintf>
  101fba:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  101fc0:	8b 40 0c             	mov    0xc(%eax),%eax
  101fc3:	83 ec 08             	sub    $0x8,%esp
  101fc6:	50                   	push   %eax
  101fc7:	8d 83 d8 45 ff ff    	lea    -0xba28(%ebx),%eax
  101fcd:	50                   	push   %eax
  101fce:	e8 03 e3 ff ff       	call   1002d6 <cprintf>
  101fd3:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  101fd9:	8b 40 10             	mov    0x10(%eax),%eax
  101fdc:	83 ec 08             	sub    $0x8,%esp
  101fdf:	50                   	push   %eax
  101fe0:	8d 83 e7 45 ff ff    	lea    -0xba19(%ebx),%eax
  101fe6:	50                   	push   %eax
  101fe7:	e8 ea e2 ff ff       	call   1002d6 <cprintf>
  101fec:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101fef:	8b 45 08             	mov    0x8(%ebp),%eax
  101ff2:	8b 40 14             	mov    0x14(%eax),%eax
  101ff5:	83 ec 08             	sub    $0x8,%esp
  101ff8:	50                   	push   %eax
  101ff9:	8d 83 f6 45 ff ff    	lea    -0xba0a(%ebx),%eax
  101fff:	50                   	push   %eax
  102000:	e8 d1 e2 ff ff       	call   1002d6 <cprintf>
  102005:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  102008:	8b 45 08             	mov    0x8(%ebp),%eax
  10200b:	8b 40 18             	mov    0x18(%eax),%eax
  10200e:	83 ec 08             	sub    $0x8,%esp
  102011:	50                   	push   %eax
  102012:	8d 83 05 46 ff ff    	lea    -0xb9fb(%ebx),%eax
  102018:	50                   	push   %eax
  102019:	e8 b8 e2 ff ff       	call   1002d6 <cprintf>
  10201e:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  102021:	8b 45 08             	mov    0x8(%ebp),%eax
  102024:	8b 40 1c             	mov    0x1c(%eax),%eax
  102027:	83 ec 08             	sub    $0x8,%esp
  10202a:	50                   	push   %eax
  10202b:	8d 83 14 46 ff ff    	lea    -0xb9ec(%ebx),%eax
  102031:	50                   	push   %eax
  102032:	e8 9f e2 ff ff       	call   1002d6 <cprintf>
  102037:	83 c4 10             	add    $0x10,%esp
}
  10203a:	90                   	nop
  10203b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10203e:	c9                   	leave  
  10203f:	c3                   	ret    

00102040 <trap_dispatch>:
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  102040:	55                   	push   %ebp
  102041:	89 e5                	mov    %esp,%ebp
  102043:	57                   	push   %edi
  102044:	56                   	push   %esi
  102045:	53                   	push   %ebx
  102046:	83 ec 1c             	sub    $0x1c,%esp
  102049:	e8 15 e2 ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  10204e:	81 c3 02 d9 00 00    	add    $0xd902,%ebx
    char c;

    switch (tf->tf_trapno) {
  102054:	8b 45 08             	mov    0x8(%ebp),%eax
  102057:	8b 40 30             	mov    0x30(%eax),%eax
  10205a:	83 f8 2f             	cmp    $0x2f,%eax
  10205d:	77 21                	ja     102080 <trap_dispatch+0x40>
  10205f:	83 f8 2e             	cmp    $0x2e,%eax
  102062:	0f 83 3b 02 00 00    	jae    1022a3 <trap_dispatch+0x263>
  102068:	83 f8 21             	cmp    $0x21,%eax
  10206b:	0f 84 91 00 00 00    	je     102102 <trap_dispatch+0xc2>
  102071:	83 f8 24             	cmp    $0x24,%eax
  102074:	74 63                	je     1020d9 <trap_dispatch+0x99>
  102076:	83 f8 20             	cmp    $0x20,%eax
  102079:	74 1c                	je     102097 <trap_dispatch+0x57>
  10207b:	e9 e9 01 00 00       	jmp    102269 <trap_dispatch+0x229>
  102080:	83 f8 78             	cmp    $0x78,%eax
  102083:	0f 84 a2 00 00 00    	je     10212b <trap_dispatch+0xeb>
  102089:	83 f8 79             	cmp    $0x79,%eax
  10208c:	0f 84 57 01 00 00    	je     1021e9 <trap_dispatch+0x1a9>
  102092:	e9 d2 01 00 00       	jmp    102269 <trap_dispatch+0x229>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
  102097:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  10209d:	8b 00                	mov    (%eax),%eax
  10209f:	8d 50 01             	lea    0x1(%eax),%edx
  1020a2:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  1020a8:	89 10                	mov    %edx,(%eax)
        if (ticks % TICK_NUM == 0) {
  1020aa:	c7 c0 a8 09 11 00    	mov    $0x1109a8,%eax
  1020b0:	8b 08                	mov    (%eax),%ecx
  1020b2:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  1020b7:	89 c8                	mov    %ecx,%eax
  1020b9:	f7 e2                	mul    %edx
  1020bb:	89 d0                	mov    %edx,%eax
  1020bd:	c1 e8 05             	shr    $0x5,%eax
  1020c0:	6b c0 64             	imul   $0x64,%eax,%eax
  1020c3:	29 c1                	sub    %eax,%ecx
  1020c5:	89 c8                	mov    %ecx,%eax
  1020c7:	85 c0                	test   %eax,%eax
  1020c9:	0f 85 d7 01 00 00    	jne    1022a6 <trap_dispatch+0x266>
            print_ticks();
  1020cf:	e8 64 fa ff ff       	call   101b38 <print_ticks>
        }
        break;
  1020d4:	e9 cd 01 00 00       	jmp    1022a6 <trap_dispatch+0x266>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  1020d9:	e8 de f7 ff ff       	call   1018bc <cons_getc>
  1020de:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  1020e1:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  1020e5:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  1020e9:	83 ec 04             	sub    $0x4,%esp
  1020ec:	52                   	push   %edx
  1020ed:	50                   	push   %eax
  1020ee:	8d 83 23 46 ff ff    	lea    -0xb9dd(%ebx),%eax
  1020f4:	50                   	push   %eax
  1020f5:	e8 dc e1 ff ff       	call   1002d6 <cprintf>
  1020fa:	83 c4 10             	add    $0x10,%esp
        break;
  1020fd:	e9 ab 01 00 00       	jmp    1022ad <trap_dispatch+0x26d>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  102102:	e8 b5 f7 ff ff       	call   1018bc <cons_getc>
  102107:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  10210a:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  10210e:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  102112:	83 ec 04             	sub    $0x4,%esp
  102115:	52                   	push   %edx
  102116:	50                   	push   %eax
  102117:	8d 83 35 46 ff ff    	lea    -0xb9cb(%ebx),%eax
  10211d:	50                   	push   %eax
  10211e:	e8 b3 e1 ff ff       	call   1002d6 <cprintf>
  102123:	83 c4 10             	add    $0x10,%esp
        break;
  102126:	e9 82 01 00 00       	jmp    1022ad <trap_dispatch+0x26d>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  10212b:	8b 45 08             	mov    0x8(%ebp),%eax
  10212e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  102132:	66 83 f8 1b          	cmp    $0x1b,%ax
  102136:	0f 84 6d 01 00 00    	je     1022a9 <trap_dispatch+0x269>
            switchk2u = *tf;
  10213c:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  102142:	8b 55 08             	mov    0x8(%ebp),%edx
  102145:	89 d6                	mov    %edx,%esi
  102147:	ba 4c 00 00 00       	mov    $0x4c,%edx
  10214c:	8b 0e                	mov    (%esi),%ecx
  10214e:	89 08                	mov    %ecx,(%eax)
  102150:	8b 4c 16 fc          	mov    -0x4(%esi,%edx,1),%ecx
  102154:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
  102158:	8d 78 04             	lea    0x4(%eax),%edi
  10215b:	83 e7 fc             	and    $0xfffffffc,%edi
  10215e:	29 f8                	sub    %edi,%eax
  102160:	29 c6                	sub    %eax,%esi
  102162:	01 c2                	add    %eax,%edx
  102164:	83 e2 fc             	and    $0xfffffffc,%edx
  102167:	89 d0                	mov    %edx,%eax
  102169:	c1 e8 02             	shr    $0x2,%eax
  10216c:	89 c1                	mov    %eax,%ecx
  10216e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            switchk2u.tf_cs = USER_CS;
  102170:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  102176:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  10217c:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  102182:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  102188:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  10218e:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  102192:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  102198:	66 89 50 28          	mov    %dx,0x28(%eax)
  10219c:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021a2:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  1021a6:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021ac:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  1021b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1021b3:	8d 50 44             	lea    0x44(%eax),%edx
  1021b6:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021bc:	89 50 44             	mov    %edx,0x44(%eax)
		
            // set eflags, make sure ucore can use io under user mode.
            // if CPL > IOPL, then cpu will generate a general protection.
            switchk2u.tf_eflags |= FL_IOPL_MASK;
  1021bf:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021c5:	8b 40 40             	mov    0x40(%eax),%eax
  1021c8:	80 cc 30             	or     $0x30,%ah
  1021cb:	89 c2                	mov    %eax,%edx
  1021cd:	c7 c0 c0 09 11 00    	mov    $0x1109c0,%eax
  1021d3:	89 50 40             	mov    %edx,0x40(%eax)
		
            // set temporary stack
            // then iret will jump to the right stack
            *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  1021d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1021d9:	83 e8 04             	sub    $0x4,%eax
  1021dc:	c7 c2 c0 09 11 00    	mov    $0x1109c0,%edx
  1021e2:	89 10                	mov    %edx,(%eax)
        }
        break;
  1021e4:	e9 c0 00 00 00       	jmp    1022a9 <trap_dispatch+0x269>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  1021e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1021ec:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  1021f0:	66 83 f8 08          	cmp    $0x8,%ax
  1021f4:	0f 84 b2 00 00 00    	je     1022ac <trap_dispatch+0x26c>
            tf->tf_cs = KERNEL_CS;
  1021fa:	8b 45 08             	mov    0x8(%ebp),%eax
  1021fd:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  102203:	8b 45 08             	mov    0x8(%ebp),%eax
  102206:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  10220c:	8b 45 08             	mov    0x8(%ebp),%eax
  10220f:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  102213:	8b 45 08             	mov    0x8(%ebp),%eax
  102216:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  10221a:	8b 45 08             	mov    0x8(%ebp),%eax
  10221d:	8b 40 40             	mov    0x40(%eax),%eax
  102220:	80 e4 cf             	and    $0xcf,%ah
  102223:	89 c2                	mov    %eax,%edx
  102225:	8b 45 08             	mov    0x8(%ebp),%eax
  102228:	89 50 40             	mov    %edx,0x40(%eax)
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  10222b:	8b 45 08             	mov    0x8(%ebp),%eax
  10222e:	8b 40 44             	mov    0x44(%eax),%eax
  102231:	83 e8 44             	sub    $0x44,%eax
  102234:	89 c2                	mov    %eax,%edx
  102236:	c7 c0 0c 0a 11 00    	mov    $0x110a0c,%eax
  10223c:	89 10                	mov    %edx,(%eax)
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  10223e:	c7 c0 0c 0a 11 00    	mov    $0x110a0c,%eax
  102244:	8b 00                	mov    (%eax),%eax
  102246:	83 ec 04             	sub    $0x4,%esp
  102249:	6a 44                	push   $0x44
  10224b:	ff 75 08             	pushl  0x8(%ebp)
  10224e:	50                   	push   %eax
  10224f:	e8 60 10 00 00       	call   1032b4 <memmove>
  102254:	83 c4 10             	add    $0x10,%esp
            *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  102257:	c7 c0 0c 0a 11 00    	mov    $0x110a0c,%eax
  10225d:	8b 10                	mov    (%eax),%edx
  10225f:	8b 45 08             	mov    0x8(%ebp),%eax
  102262:	83 e8 04             	sub    $0x4,%eax
  102265:	89 10                	mov    %edx,(%eax)
        }
        break;
  102267:	eb 43                	jmp    1022ac <trap_dispatch+0x26c>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  102269:	8b 45 08             	mov    0x8(%ebp),%eax
  10226c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  102270:	0f b7 c0             	movzwl %ax,%eax
  102273:	83 e0 03             	and    $0x3,%eax
  102276:	85 c0                	test   %eax,%eax
  102278:	75 33                	jne    1022ad <trap_dispatch+0x26d>
            print_trapframe(tf);
  10227a:	83 ec 0c             	sub    $0xc,%esp
  10227d:	ff 75 08             	pushl  0x8(%ebp)
  102280:	e8 d6 fa ff ff       	call   101d5b <print_trapframe>
  102285:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  102288:	83 ec 04             	sub    $0x4,%esp
  10228b:	8d 83 44 46 ff ff    	lea    -0xb9bc(%ebx),%eax
  102291:	50                   	push   %eax
  102292:	68 d4 00 00 00       	push   $0xd4
  102297:	8d 83 60 46 ff ff    	lea    -0xb9a0(%ebx),%eax
  10229d:	50                   	push   %eax
  10229e:	e8 e3 e1 ff ff       	call   100486 <__panic>
        break;
  1022a3:	90                   	nop
  1022a4:	eb 07                	jmp    1022ad <trap_dispatch+0x26d>
        break;
  1022a6:	90                   	nop
  1022a7:	eb 04                	jmp    1022ad <trap_dispatch+0x26d>
        break;
  1022a9:	90                   	nop
  1022aa:	eb 01                	jmp    1022ad <trap_dispatch+0x26d>
        break;
  1022ac:	90                   	nop
        }
    }
}
  1022ad:	90                   	nop
  1022ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1022b1:	5b                   	pop    %ebx
  1022b2:	5e                   	pop    %esi
  1022b3:	5f                   	pop    %edi
  1022b4:	5d                   	pop    %ebp
  1022b5:	c3                   	ret    

001022b6 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  1022b6:	55                   	push   %ebp
  1022b7:	89 e5                	mov    %esp,%ebp
  1022b9:	83 ec 08             	sub    $0x8,%esp
  1022bc:	e8 9e df ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1022c1:	05 8f d6 00 00       	add    $0xd68f,%eax
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  1022c6:	83 ec 0c             	sub    $0xc,%esp
  1022c9:	ff 75 08             	pushl  0x8(%ebp)
  1022cc:	e8 6f fd ff ff       	call   102040 <trap_dispatch>
  1022d1:	83 c4 10             	add    $0x10,%esp
}
  1022d4:	90                   	nop
  1022d5:	c9                   	leave  
  1022d6:	c3                   	ret    

001022d7 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  1022d7:	6a 00                	push   $0x0
  pushl $0
  1022d9:	6a 00                	push   $0x0
  jmp __alltraps
  1022db:	e9 67 0a 00 00       	jmp    102d47 <__alltraps>

001022e0 <vector1>:
.globl vector1
vector1:
  pushl $0
  1022e0:	6a 00                	push   $0x0
  pushl $1
  1022e2:	6a 01                	push   $0x1
  jmp __alltraps
  1022e4:	e9 5e 0a 00 00       	jmp    102d47 <__alltraps>

001022e9 <vector2>:
.globl vector2
vector2:
  pushl $0
  1022e9:	6a 00                	push   $0x0
  pushl $2
  1022eb:	6a 02                	push   $0x2
  jmp __alltraps
  1022ed:	e9 55 0a 00 00       	jmp    102d47 <__alltraps>

001022f2 <vector3>:
.globl vector3
vector3:
  pushl $0
  1022f2:	6a 00                	push   $0x0
  pushl $3
  1022f4:	6a 03                	push   $0x3
  jmp __alltraps
  1022f6:	e9 4c 0a 00 00       	jmp    102d47 <__alltraps>

001022fb <vector4>:
.globl vector4
vector4:
  pushl $0
  1022fb:	6a 00                	push   $0x0
  pushl $4
  1022fd:	6a 04                	push   $0x4
  jmp __alltraps
  1022ff:	e9 43 0a 00 00       	jmp    102d47 <__alltraps>

00102304 <vector5>:
.globl vector5
vector5:
  pushl $0
  102304:	6a 00                	push   $0x0
  pushl $5
  102306:	6a 05                	push   $0x5
  jmp __alltraps
  102308:	e9 3a 0a 00 00       	jmp    102d47 <__alltraps>

0010230d <vector6>:
.globl vector6
vector6:
  pushl $0
  10230d:	6a 00                	push   $0x0
  pushl $6
  10230f:	6a 06                	push   $0x6
  jmp __alltraps
  102311:	e9 31 0a 00 00       	jmp    102d47 <__alltraps>

00102316 <vector7>:
.globl vector7
vector7:
  pushl $0
  102316:	6a 00                	push   $0x0
  pushl $7
  102318:	6a 07                	push   $0x7
  jmp __alltraps
  10231a:	e9 28 0a 00 00       	jmp    102d47 <__alltraps>

0010231f <vector8>:
.globl vector8
vector8:
  pushl $8
  10231f:	6a 08                	push   $0x8
  jmp __alltraps
  102321:	e9 21 0a 00 00       	jmp    102d47 <__alltraps>

00102326 <vector9>:
.globl vector9
vector9:
  pushl $9
  102326:	6a 09                	push   $0x9
  jmp __alltraps
  102328:	e9 1a 0a 00 00       	jmp    102d47 <__alltraps>

0010232d <vector10>:
.globl vector10
vector10:
  pushl $10
  10232d:	6a 0a                	push   $0xa
  jmp __alltraps
  10232f:	e9 13 0a 00 00       	jmp    102d47 <__alltraps>

00102334 <vector11>:
.globl vector11
vector11:
  pushl $11
  102334:	6a 0b                	push   $0xb
  jmp __alltraps
  102336:	e9 0c 0a 00 00       	jmp    102d47 <__alltraps>

0010233b <vector12>:
.globl vector12
vector12:
  pushl $12
  10233b:	6a 0c                	push   $0xc
  jmp __alltraps
  10233d:	e9 05 0a 00 00       	jmp    102d47 <__alltraps>

00102342 <vector13>:
.globl vector13
vector13:
  pushl $13
  102342:	6a 0d                	push   $0xd
  jmp __alltraps
  102344:	e9 fe 09 00 00       	jmp    102d47 <__alltraps>

00102349 <vector14>:
.globl vector14
vector14:
  pushl $14
  102349:	6a 0e                	push   $0xe
  jmp __alltraps
  10234b:	e9 f7 09 00 00       	jmp    102d47 <__alltraps>

00102350 <vector15>:
.globl vector15
vector15:
  pushl $0
  102350:	6a 00                	push   $0x0
  pushl $15
  102352:	6a 0f                	push   $0xf
  jmp __alltraps
  102354:	e9 ee 09 00 00       	jmp    102d47 <__alltraps>

00102359 <vector16>:
.globl vector16
vector16:
  pushl $0
  102359:	6a 00                	push   $0x0
  pushl $16
  10235b:	6a 10                	push   $0x10
  jmp __alltraps
  10235d:	e9 e5 09 00 00       	jmp    102d47 <__alltraps>

00102362 <vector17>:
.globl vector17
vector17:
  pushl $17
  102362:	6a 11                	push   $0x11
  jmp __alltraps
  102364:	e9 de 09 00 00       	jmp    102d47 <__alltraps>

00102369 <vector18>:
.globl vector18
vector18:
  pushl $0
  102369:	6a 00                	push   $0x0
  pushl $18
  10236b:	6a 12                	push   $0x12
  jmp __alltraps
  10236d:	e9 d5 09 00 00       	jmp    102d47 <__alltraps>

00102372 <vector19>:
.globl vector19
vector19:
  pushl $0
  102372:	6a 00                	push   $0x0
  pushl $19
  102374:	6a 13                	push   $0x13
  jmp __alltraps
  102376:	e9 cc 09 00 00       	jmp    102d47 <__alltraps>

0010237b <vector20>:
.globl vector20
vector20:
  pushl $0
  10237b:	6a 00                	push   $0x0
  pushl $20
  10237d:	6a 14                	push   $0x14
  jmp __alltraps
  10237f:	e9 c3 09 00 00       	jmp    102d47 <__alltraps>

00102384 <vector21>:
.globl vector21
vector21:
  pushl $0
  102384:	6a 00                	push   $0x0
  pushl $21
  102386:	6a 15                	push   $0x15
  jmp __alltraps
  102388:	e9 ba 09 00 00       	jmp    102d47 <__alltraps>

0010238d <vector22>:
.globl vector22
vector22:
  pushl $0
  10238d:	6a 00                	push   $0x0
  pushl $22
  10238f:	6a 16                	push   $0x16
  jmp __alltraps
  102391:	e9 b1 09 00 00       	jmp    102d47 <__alltraps>

00102396 <vector23>:
.globl vector23
vector23:
  pushl $0
  102396:	6a 00                	push   $0x0
  pushl $23
  102398:	6a 17                	push   $0x17
  jmp __alltraps
  10239a:	e9 a8 09 00 00       	jmp    102d47 <__alltraps>

0010239f <vector24>:
.globl vector24
vector24:
  pushl $0
  10239f:	6a 00                	push   $0x0
  pushl $24
  1023a1:	6a 18                	push   $0x18
  jmp __alltraps
  1023a3:	e9 9f 09 00 00       	jmp    102d47 <__alltraps>

001023a8 <vector25>:
.globl vector25
vector25:
  pushl $0
  1023a8:	6a 00                	push   $0x0
  pushl $25
  1023aa:	6a 19                	push   $0x19
  jmp __alltraps
  1023ac:	e9 96 09 00 00       	jmp    102d47 <__alltraps>

001023b1 <vector26>:
.globl vector26
vector26:
  pushl $0
  1023b1:	6a 00                	push   $0x0
  pushl $26
  1023b3:	6a 1a                	push   $0x1a
  jmp __alltraps
  1023b5:	e9 8d 09 00 00       	jmp    102d47 <__alltraps>

001023ba <vector27>:
.globl vector27
vector27:
  pushl $0
  1023ba:	6a 00                	push   $0x0
  pushl $27
  1023bc:	6a 1b                	push   $0x1b
  jmp __alltraps
  1023be:	e9 84 09 00 00       	jmp    102d47 <__alltraps>

001023c3 <vector28>:
.globl vector28
vector28:
  pushl $0
  1023c3:	6a 00                	push   $0x0
  pushl $28
  1023c5:	6a 1c                	push   $0x1c
  jmp __alltraps
  1023c7:	e9 7b 09 00 00       	jmp    102d47 <__alltraps>

001023cc <vector29>:
.globl vector29
vector29:
  pushl $0
  1023cc:	6a 00                	push   $0x0
  pushl $29
  1023ce:	6a 1d                	push   $0x1d
  jmp __alltraps
  1023d0:	e9 72 09 00 00       	jmp    102d47 <__alltraps>

001023d5 <vector30>:
.globl vector30
vector30:
  pushl $0
  1023d5:	6a 00                	push   $0x0
  pushl $30
  1023d7:	6a 1e                	push   $0x1e
  jmp __alltraps
  1023d9:	e9 69 09 00 00       	jmp    102d47 <__alltraps>

001023de <vector31>:
.globl vector31
vector31:
  pushl $0
  1023de:	6a 00                	push   $0x0
  pushl $31
  1023e0:	6a 1f                	push   $0x1f
  jmp __alltraps
  1023e2:	e9 60 09 00 00       	jmp    102d47 <__alltraps>

001023e7 <vector32>:
.globl vector32
vector32:
  pushl $0
  1023e7:	6a 00                	push   $0x0
  pushl $32
  1023e9:	6a 20                	push   $0x20
  jmp __alltraps
  1023eb:	e9 57 09 00 00       	jmp    102d47 <__alltraps>

001023f0 <vector33>:
.globl vector33
vector33:
  pushl $0
  1023f0:	6a 00                	push   $0x0
  pushl $33
  1023f2:	6a 21                	push   $0x21
  jmp __alltraps
  1023f4:	e9 4e 09 00 00       	jmp    102d47 <__alltraps>

001023f9 <vector34>:
.globl vector34
vector34:
  pushl $0
  1023f9:	6a 00                	push   $0x0
  pushl $34
  1023fb:	6a 22                	push   $0x22
  jmp __alltraps
  1023fd:	e9 45 09 00 00       	jmp    102d47 <__alltraps>

00102402 <vector35>:
.globl vector35
vector35:
  pushl $0
  102402:	6a 00                	push   $0x0
  pushl $35
  102404:	6a 23                	push   $0x23
  jmp __alltraps
  102406:	e9 3c 09 00 00       	jmp    102d47 <__alltraps>

0010240b <vector36>:
.globl vector36
vector36:
  pushl $0
  10240b:	6a 00                	push   $0x0
  pushl $36
  10240d:	6a 24                	push   $0x24
  jmp __alltraps
  10240f:	e9 33 09 00 00       	jmp    102d47 <__alltraps>

00102414 <vector37>:
.globl vector37
vector37:
  pushl $0
  102414:	6a 00                	push   $0x0
  pushl $37
  102416:	6a 25                	push   $0x25
  jmp __alltraps
  102418:	e9 2a 09 00 00       	jmp    102d47 <__alltraps>

0010241d <vector38>:
.globl vector38
vector38:
  pushl $0
  10241d:	6a 00                	push   $0x0
  pushl $38
  10241f:	6a 26                	push   $0x26
  jmp __alltraps
  102421:	e9 21 09 00 00       	jmp    102d47 <__alltraps>

00102426 <vector39>:
.globl vector39
vector39:
  pushl $0
  102426:	6a 00                	push   $0x0
  pushl $39
  102428:	6a 27                	push   $0x27
  jmp __alltraps
  10242a:	e9 18 09 00 00       	jmp    102d47 <__alltraps>

0010242f <vector40>:
.globl vector40
vector40:
  pushl $0
  10242f:	6a 00                	push   $0x0
  pushl $40
  102431:	6a 28                	push   $0x28
  jmp __alltraps
  102433:	e9 0f 09 00 00       	jmp    102d47 <__alltraps>

00102438 <vector41>:
.globl vector41
vector41:
  pushl $0
  102438:	6a 00                	push   $0x0
  pushl $41
  10243a:	6a 29                	push   $0x29
  jmp __alltraps
  10243c:	e9 06 09 00 00       	jmp    102d47 <__alltraps>

00102441 <vector42>:
.globl vector42
vector42:
  pushl $0
  102441:	6a 00                	push   $0x0
  pushl $42
  102443:	6a 2a                	push   $0x2a
  jmp __alltraps
  102445:	e9 fd 08 00 00       	jmp    102d47 <__alltraps>

0010244a <vector43>:
.globl vector43
vector43:
  pushl $0
  10244a:	6a 00                	push   $0x0
  pushl $43
  10244c:	6a 2b                	push   $0x2b
  jmp __alltraps
  10244e:	e9 f4 08 00 00       	jmp    102d47 <__alltraps>

00102453 <vector44>:
.globl vector44
vector44:
  pushl $0
  102453:	6a 00                	push   $0x0
  pushl $44
  102455:	6a 2c                	push   $0x2c
  jmp __alltraps
  102457:	e9 eb 08 00 00       	jmp    102d47 <__alltraps>

0010245c <vector45>:
.globl vector45
vector45:
  pushl $0
  10245c:	6a 00                	push   $0x0
  pushl $45
  10245e:	6a 2d                	push   $0x2d
  jmp __alltraps
  102460:	e9 e2 08 00 00       	jmp    102d47 <__alltraps>

00102465 <vector46>:
.globl vector46
vector46:
  pushl $0
  102465:	6a 00                	push   $0x0
  pushl $46
  102467:	6a 2e                	push   $0x2e
  jmp __alltraps
  102469:	e9 d9 08 00 00       	jmp    102d47 <__alltraps>

0010246e <vector47>:
.globl vector47
vector47:
  pushl $0
  10246e:	6a 00                	push   $0x0
  pushl $47
  102470:	6a 2f                	push   $0x2f
  jmp __alltraps
  102472:	e9 d0 08 00 00       	jmp    102d47 <__alltraps>

00102477 <vector48>:
.globl vector48
vector48:
  pushl $0
  102477:	6a 00                	push   $0x0
  pushl $48
  102479:	6a 30                	push   $0x30
  jmp __alltraps
  10247b:	e9 c7 08 00 00       	jmp    102d47 <__alltraps>

00102480 <vector49>:
.globl vector49
vector49:
  pushl $0
  102480:	6a 00                	push   $0x0
  pushl $49
  102482:	6a 31                	push   $0x31
  jmp __alltraps
  102484:	e9 be 08 00 00       	jmp    102d47 <__alltraps>

00102489 <vector50>:
.globl vector50
vector50:
  pushl $0
  102489:	6a 00                	push   $0x0
  pushl $50
  10248b:	6a 32                	push   $0x32
  jmp __alltraps
  10248d:	e9 b5 08 00 00       	jmp    102d47 <__alltraps>

00102492 <vector51>:
.globl vector51
vector51:
  pushl $0
  102492:	6a 00                	push   $0x0
  pushl $51
  102494:	6a 33                	push   $0x33
  jmp __alltraps
  102496:	e9 ac 08 00 00       	jmp    102d47 <__alltraps>

0010249b <vector52>:
.globl vector52
vector52:
  pushl $0
  10249b:	6a 00                	push   $0x0
  pushl $52
  10249d:	6a 34                	push   $0x34
  jmp __alltraps
  10249f:	e9 a3 08 00 00       	jmp    102d47 <__alltraps>

001024a4 <vector53>:
.globl vector53
vector53:
  pushl $0
  1024a4:	6a 00                	push   $0x0
  pushl $53
  1024a6:	6a 35                	push   $0x35
  jmp __alltraps
  1024a8:	e9 9a 08 00 00       	jmp    102d47 <__alltraps>

001024ad <vector54>:
.globl vector54
vector54:
  pushl $0
  1024ad:	6a 00                	push   $0x0
  pushl $54
  1024af:	6a 36                	push   $0x36
  jmp __alltraps
  1024b1:	e9 91 08 00 00       	jmp    102d47 <__alltraps>

001024b6 <vector55>:
.globl vector55
vector55:
  pushl $0
  1024b6:	6a 00                	push   $0x0
  pushl $55
  1024b8:	6a 37                	push   $0x37
  jmp __alltraps
  1024ba:	e9 88 08 00 00       	jmp    102d47 <__alltraps>

001024bf <vector56>:
.globl vector56
vector56:
  pushl $0
  1024bf:	6a 00                	push   $0x0
  pushl $56
  1024c1:	6a 38                	push   $0x38
  jmp __alltraps
  1024c3:	e9 7f 08 00 00       	jmp    102d47 <__alltraps>

001024c8 <vector57>:
.globl vector57
vector57:
  pushl $0
  1024c8:	6a 00                	push   $0x0
  pushl $57
  1024ca:	6a 39                	push   $0x39
  jmp __alltraps
  1024cc:	e9 76 08 00 00       	jmp    102d47 <__alltraps>

001024d1 <vector58>:
.globl vector58
vector58:
  pushl $0
  1024d1:	6a 00                	push   $0x0
  pushl $58
  1024d3:	6a 3a                	push   $0x3a
  jmp __alltraps
  1024d5:	e9 6d 08 00 00       	jmp    102d47 <__alltraps>

001024da <vector59>:
.globl vector59
vector59:
  pushl $0
  1024da:	6a 00                	push   $0x0
  pushl $59
  1024dc:	6a 3b                	push   $0x3b
  jmp __alltraps
  1024de:	e9 64 08 00 00       	jmp    102d47 <__alltraps>

001024e3 <vector60>:
.globl vector60
vector60:
  pushl $0
  1024e3:	6a 00                	push   $0x0
  pushl $60
  1024e5:	6a 3c                	push   $0x3c
  jmp __alltraps
  1024e7:	e9 5b 08 00 00       	jmp    102d47 <__alltraps>

001024ec <vector61>:
.globl vector61
vector61:
  pushl $0
  1024ec:	6a 00                	push   $0x0
  pushl $61
  1024ee:	6a 3d                	push   $0x3d
  jmp __alltraps
  1024f0:	e9 52 08 00 00       	jmp    102d47 <__alltraps>

001024f5 <vector62>:
.globl vector62
vector62:
  pushl $0
  1024f5:	6a 00                	push   $0x0
  pushl $62
  1024f7:	6a 3e                	push   $0x3e
  jmp __alltraps
  1024f9:	e9 49 08 00 00       	jmp    102d47 <__alltraps>

001024fe <vector63>:
.globl vector63
vector63:
  pushl $0
  1024fe:	6a 00                	push   $0x0
  pushl $63
  102500:	6a 3f                	push   $0x3f
  jmp __alltraps
  102502:	e9 40 08 00 00       	jmp    102d47 <__alltraps>

00102507 <vector64>:
.globl vector64
vector64:
  pushl $0
  102507:	6a 00                	push   $0x0
  pushl $64
  102509:	6a 40                	push   $0x40
  jmp __alltraps
  10250b:	e9 37 08 00 00       	jmp    102d47 <__alltraps>

00102510 <vector65>:
.globl vector65
vector65:
  pushl $0
  102510:	6a 00                	push   $0x0
  pushl $65
  102512:	6a 41                	push   $0x41
  jmp __alltraps
  102514:	e9 2e 08 00 00       	jmp    102d47 <__alltraps>

00102519 <vector66>:
.globl vector66
vector66:
  pushl $0
  102519:	6a 00                	push   $0x0
  pushl $66
  10251b:	6a 42                	push   $0x42
  jmp __alltraps
  10251d:	e9 25 08 00 00       	jmp    102d47 <__alltraps>

00102522 <vector67>:
.globl vector67
vector67:
  pushl $0
  102522:	6a 00                	push   $0x0
  pushl $67
  102524:	6a 43                	push   $0x43
  jmp __alltraps
  102526:	e9 1c 08 00 00       	jmp    102d47 <__alltraps>

0010252b <vector68>:
.globl vector68
vector68:
  pushl $0
  10252b:	6a 00                	push   $0x0
  pushl $68
  10252d:	6a 44                	push   $0x44
  jmp __alltraps
  10252f:	e9 13 08 00 00       	jmp    102d47 <__alltraps>

00102534 <vector69>:
.globl vector69
vector69:
  pushl $0
  102534:	6a 00                	push   $0x0
  pushl $69
  102536:	6a 45                	push   $0x45
  jmp __alltraps
  102538:	e9 0a 08 00 00       	jmp    102d47 <__alltraps>

0010253d <vector70>:
.globl vector70
vector70:
  pushl $0
  10253d:	6a 00                	push   $0x0
  pushl $70
  10253f:	6a 46                	push   $0x46
  jmp __alltraps
  102541:	e9 01 08 00 00       	jmp    102d47 <__alltraps>

00102546 <vector71>:
.globl vector71
vector71:
  pushl $0
  102546:	6a 00                	push   $0x0
  pushl $71
  102548:	6a 47                	push   $0x47
  jmp __alltraps
  10254a:	e9 f8 07 00 00       	jmp    102d47 <__alltraps>

0010254f <vector72>:
.globl vector72
vector72:
  pushl $0
  10254f:	6a 00                	push   $0x0
  pushl $72
  102551:	6a 48                	push   $0x48
  jmp __alltraps
  102553:	e9 ef 07 00 00       	jmp    102d47 <__alltraps>

00102558 <vector73>:
.globl vector73
vector73:
  pushl $0
  102558:	6a 00                	push   $0x0
  pushl $73
  10255a:	6a 49                	push   $0x49
  jmp __alltraps
  10255c:	e9 e6 07 00 00       	jmp    102d47 <__alltraps>

00102561 <vector74>:
.globl vector74
vector74:
  pushl $0
  102561:	6a 00                	push   $0x0
  pushl $74
  102563:	6a 4a                	push   $0x4a
  jmp __alltraps
  102565:	e9 dd 07 00 00       	jmp    102d47 <__alltraps>

0010256a <vector75>:
.globl vector75
vector75:
  pushl $0
  10256a:	6a 00                	push   $0x0
  pushl $75
  10256c:	6a 4b                	push   $0x4b
  jmp __alltraps
  10256e:	e9 d4 07 00 00       	jmp    102d47 <__alltraps>

00102573 <vector76>:
.globl vector76
vector76:
  pushl $0
  102573:	6a 00                	push   $0x0
  pushl $76
  102575:	6a 4c                	push   $0x4c
  jmp __alltraps
  102577:	e9 cb 07 00 00       	jmp    102d47 <__alltraps>

0010257c <vector77>:
.globl vector77
vector77:
  pushl $0
  10257c:	6a 00                	push   $0x0
  pushl $77
  10257e:	6a 4d                	push   $0x4d
  jmp __alltraps
  102580:	e9 c2 07 00 00       	jmp    102d47 <__alltraps>

00102585 <vector78>:
.globl vector78
vector78:
  pushl $0
  102585:	6a 00                	push   $0x0
  pushl $78
  102587:	6a 4e                	push   $0x4e
  jmp __alltraps
  102589:	e9 b9 07 00 00       	jmp    102d47 <__alltraps>

0010258e <vector79>:
.globl vector79
vector79:
  pushl $0
  10258e:	6a 00                	push   $0x0
  pushl $79
  102590:	6a 4f                	push   $0x4f
  jmp __alltraps
  102592:	e9 b0 07 00 00       	jmp    102d47 <__alltraps>

00102597 <vector80>:
.globl vector80
vector80:
  pushl $0
  102597:	6a 00                	push   $0x0
  pushl $80
  102599:	6a 50                	push   $0x50
  jmp __alltraps
  10259b:	e9 a7 07 00 00       	jmp    102d47 <__alltraps>

001025a0 <vector81>:
.globl vector81
vector81:
  pushl $0
  1025a0:	6a 00                	push   $0x0
  pushl $81
  1025a2:	6a 51                	push   $0x51
  jmp __alltraps
  1025a4:	e9 9e 07 00 00       	jmp    102d47 <__alltraps>

001025a9 <vector82>:
.globl vector82
vector82:
  pushl $0
  1025a9:	6a 00                	push   $0x0
  pushl $82
  1025ab:	6a 52                	push   $0x52
  jmp __alltraps
  1025ad:	e9 95 07 00 00       	jmp    102d47 <__alltraps>

001025b2 <vector83>:
.globl vector83
vector83:
  pushl $0
  1025b2:	6a 00                	push   $0x0
  pushl $83
  1025b4:	6a 53                	push   $0x53
  jmp __alltraps
  1025b6:	e9 8c 07 00 00       	jmp    102d47 <__alltraps>

001025bb <vector84>:
.globl vector84
vector84:
  pushl $0
  1025bb:	6a 00                	push   $0x0
  pushl $84
  1025bd:	6a 54                	push   $0x54
  jmp __alltraps
  1025bf:	e9 83 07 00 00       	jmp    102d47 <__alltraps>

001025c4 <vector85>:
.globl vector85
vector85:
  pushl $0
  1025c4:	6a 00                	push   $0x0
  pushl $85
  1025c6:	6a 55                	push   $0x55
  jmp __alltraps
  1025c8:	e9 7a 07 00 00       	jmp    102d47 <__alltraps>

001025cd <vector86>:
.globl vector86
vector86:
  pushl $0
  1025cd:	6a 00                	push   $0x0
  pushl $86
  1025cf:	6a 56                	push   $0x56
  jmp __alltraps
  1025d1:	e9 71 07 00 00       	jmp    102d47 <__alltraps>

001025d6 <vector87>:
.globl vector87
vector87:
  pushl $0
  1025d6:	6a 00                	push   $0x0
  pushl $87
  1025d8:	6a 57                	push   $0x57
  jmp __alltraps
  1025da:	e9 68 07 00 00       	jmp    102d47 <__alltraps>

001025df <vector88>:
.globl vector88
vector88:
  pushl $0
  1025df:	6a 00                	push   $0x0
  pushl $88
  1025e1:	6a 58                	push   $0x58
  jmp __alltraps
  1025e3:	e9 5f 07 00 00       	jmp    102d47 <__alltraps>

001025e8 <vector89>:
.globl vector89
vector89:
  pushl $0
  1025e8:	6a 00                	push   $0x0
  pushl $89
  1025ea:	6a 59                	push   $0x59
  jmp __alltraps
  1025ec:	e9 56 07 00 00       	jmp    102d47 <__alltraps>

001025f1 <vector90>:
.globl vector90
vector90:
  pushl $0
  1025f1:	6a 00                	push   $0x0
  pushl $90
  1025f3:	6a 5a                	push   $0x5a
  jmp __alltraps
  1025f5:	e9 4d 07 00 00       	jmp    102d47 <__alltraps>

001025fa <vector91>:
.globl vector91
vector91:
  pushl $0
  1025fa:	6a 00                	push   $0x0
  pushl $91
  1025fc:	6a 5b                	push   $0x5b
  jmp __alltraps
  1025fe:	e9 44 07 00 00       	jmp    102d47 <__alltraps>

00102603 <vector92>:
.globl vector92
vector92:
  pushl $0
  102603:	6a 00                	push   $0x0
  pushl $92
  102605:	6a 5c                	push   $0x5c
  jmp __alltraps
  102607:	e9 3b 07 00 00       	jmp    102d47 <__alltraps>

0010260c <vector93>:
.globl vector93
vector93:
  pushl $0
  10260c:	6a 00                	push   $0x0
  pushl $93
  10260e:	6a 5d                	push   $0x5d
  jmp __alltraps
  102610:	e9 32 07 00 00       	jmp    102d47 <__alltraps>

00102615 <vector94>:
.globl vector94
vector94:
  pushl $0
  102615:	6a 00                	push   $0x0
  pushl $94
  102617:	6a 5e                	push   $0x5e
  jmp __alltraps
  102619:	e9 29 07 00 00       	jmp    102d47 <__alltraps>

0010261e <vector95>:
.globl vector95
vector95:
  pushl $0
  10261e:	6a 00                	push   $0x0
  pushl $95
  102620:	6a 5f                	push   $0x5f
  jmp __alltraps
  102622:	e9 20 07 00 00       	jmp    102d47 <__alltraps>

00102627 <vector96>:
.globl vector96
vector96:
  pushl $0
  102627:	6a 00                	push   $0x0
  pushl $96
  102629:	6a 60                	push   $0x60
  jmp __alltraps
  10262b:	e9 17 07 00 00       	jmp    102d47 <__alltraps>

00102630 <vector97>:
.globl vector97
vector97:
  pushl $0
  102630:	6a 00                	push   $0x0
  pushl $97
  102632:	6a 61                	push   $0x61
  jmp __alltraps
  102634:	e9 0e 07 00 00       	jmp    102d47 <__alltraps>

00102639 <vector98>:
.globl vector98
vector98:
  pushl $0
  102639:	6a 00                	push   $0x0
  pushl $98
  10263b:	6a 62                	push   $0x62
  jmp __alltraps
  10263d:	e9 05 07 00 00       	jmp    102d47 <__alltraps>

00102642 <vector99>:
.globl vector99
vector99:
  pushl $0
  102642:	6a 00                	push   $0x0
  pushl $99
  102644:	6a 63                	push   $0x63
  jmp __alltraps
  102646:	e9 fc 06 00 00       	jmp    102d47 <__alltraps>

0010264b <vector100>:
.globl vector100
vector100:
  pushl $0
  10264b:	6a 00                	push   $0x0
  pushl $100
  10264d:	6a 64                	push   $0x64
  jmp __alltraps
  10264f:	e9 f3 06 00 00       	jmp    102d47 <__alltraps>

00102654 <vector101>:
.globl vector101
vector101:
  pushl $0
  102654:	6a 00                	push   $0x0
  pushl $101
  102656:	6a 65                	push   $0x65
  jmp __alltraps
  102658:	e9 ea 06 00 00       	jmp    102d47 <__alltraps>

0010265d <vector102>:
.globl vector102
vector102:
  pushl $0
  10265d:	6a 00                	push   $0x0
  pushl $102
  10265f:	6a 66                	push   $0x66
  jmp __alltraps
  102661:	e9 e1 06 00 00       	jmp    102d47 <__alltraps>

00102666 <vector103>:
.globl vector103
vector103:
  pushl $0
  102666:	6a 00                	push   $0x0
  pushl $103
  102668:	6a 67                	push   $0x67
  jmp __alltraps
  10266a:	e9 d8 06 00 00       	jmp    102d47 <__alltraps>

0010266f <vector104>:
.globl vector104
vector104:
  pushl $0
  10266f:	6a 00                	push   $0x0
  pushl $104
  102671:	6a 68                	push   $0x68
  jmp __alltraps
  102673:	e9 cf 06 00 00       	jmp    102d47 <__alltraps>

00102678 <vector105>:
.globl vector105
vector105:
  pushl $0
  102678:	6a 00                	push   $0x0
  pushl $105
  10267a:	6a 69                	push   $0x69
  jmp __alltraps
  10267c:	e9 c6 06 00 00       	jmp    102d47 <__alltraps>

00102681 <vector106>:
.globl vector106
vector106:
  pushl $0
  102681:	6a 00                	push   $0x0
  pushl $106
  102683:	6a 6a                	push   $0x6a
  jmp __alltraps
  102685:	e9 bd 06 00 00       	jmp    102d47 <__alltraps>

0010268a <vector107>:
.globl vector107
vector107:
  pushl $0
  10268a:	6a 00                	push   $0x0
  pushl $107
  10268c:	6a 6b                	push   $0x6b
  jmp __alltraps
  10268e:	e9 b4 06 00 00       	jmp    102d47 <__alltraps>

00102693 <vector108>:
.globl vector108
vector108:
  pushl $0
  102693:	6a 00                	push   $0x0
  pushl $108
  102695:	6a 6c                	push   $0x6c
  jmp __alltraps
  102697:	e9 ab 06 00 00       	jmp    102d47 <__alltraps>

0010269c <vector109>:
.globl vector109
vector109:
  pushl $0
  10269c:	6a 00                	push   $0x0
  pushl $109
  10269e:	6a 6d                	push   $0x6d
  jmp __alltraps
  1026a0:	e9 a2 06 00 00       	jmp    102d47 <__alltraps>

001026a5 <vector110>:
.globl vector110
vector110:
  pushl $0
  1026a5:	6a 00                	push   $0x0
  pushl $110
  1026a7:	6a 6e                	push   $0x6e
  jmp __alltraps
  1026a9:	e9 99 06 00 00       	jmp    102d47 <__alltraps>

001026ae <vector111>:
.globl vector111
vector111:
  pushl $0
  1026ae:	6a 00                	push   $0x0
  pushl $111
  1026b0:	6a 6f                	push   $0x6f
  jmp __alltraps
  1026b2:	e9 90 06 00 00       	jmp    102d47 <__alltraps>

001026b7 <vector112>:
.globl vector112
vector112:
  pushl $0
  1026b7:	6a 00                	push   $0x0
  pushl $112
  1026b9:	6a 70                	push   $0x70
  jmp __alltraps
  1026bb:	e9 87 06 00 00       	jmp    102d47 <__alltraps>

001026c0 <vector113>:
.globl vector113
vector113:
  pushl $0
  1026c0:	6a 00                	push   $0x0
  pushl $113
  1026c2:	6a 71                	push   $0x71
  jmp __alltraps
  1026c4:	e9 7e 06 00 00       	jmp    102d47 <__alltraps>

001026c9 <vector114>:
.globl vector114
vector114:
  pushl $0
  1026c9:	6a 00                	push   $0x0
  pushl $114
  1026cb:	6a 72                	push   $0x72
  jmp __alltraps
  1026cd:	e9 75 06 00 00       	jmp    102d47 <__alltraps>

001026d2 <vector115>:
.globl vector115
vector115:
  pushl $0
  1026d2:	6a 00                	push   $0x0
  pushl $115
  1026d4:	6a 73                	push   $0x73
  jmp __alltraps
  1026d6:	e9 6c 06 00 00       	jmp    102d47 <__alltraps>

001026db <vector116>:
.globl vector116
vector116:
  pushl $0
  1026db:	6a 00                	push   $0x0
  pushl $116
  1026dd:	6a 74                	push   $0x74
  jmp __alltraps
  1026df:	e9 63 06 00 00       	jmp    102d47 <__alltraps>

001026e4 <vector117>:
.globl vector117
vector117:
  pushl $0
  1026e4:	6a 00                	push   $0x0
  pushl $117
  1026e6:	6a 75                	push   $0x75
  jmp __alltraps
  1026e8:	e9 5a 06 00 00       	jmp    102d47 <__alltraps>

001026ed <vector118>:
.globl vector118
vector118:
  pushl $0
  1026ed:	6a 00                	push   $0x0
  pushl $118
  1026ef:	6a 76                	push   $0x76
  jmp __alltraps
  1026f1:	e9 51 06 00 00       	jmp    102d47 <__alltraps>

001026f6 <vector119>:
.globl vector119
vector119:
  pushl $0
  1026f6:	6a 00                	push   $0x0
  pushl $119
  1026f8:	6a 77                	push   $0x77
  jmp __alltraps
  1026fa:	e9 48 06 00 00       	jmp    102d47 <__alltraps>

001026ff <vector120>:
.globl vector120
vector120:
  pushl $0
  1026ff:	6a 00                	push   $0x0
  pushl $120
  102701:	6a 78                	push   $0x78
  jmp __alltraps
  102703:	e9 3f 06 00 00       	jmp    102d47 <__alltraps>

00102708 <vector121>:
.globl vector121
vector121:
  pushl $0
  102708:	6a 00                	push   $0x0
  pushl $121
  10270a:	6a 79                	push   $0x79
  jmp __alltraps
  10270c:	e9 36 06 00 00       	jmp    102d47 <__alltraps>

00102711 <vector122>:
.globl vector122
vector122:
  pushl $0
  102711:	6a 00                	push   $0x0
  pushl $122
  102713:	6a 7a                	push   $0x7a
  jmp __alltraps
  102715:	e9 2d 06 00 00       	jmp    102d47 <__alltraps>

0010271a <vector123>:
.globl vector123
vector123:
  pushl $0
  10271a:	6a 00                	push   $0x0
  pushl $123
  10271c:	6a 7b                	push   $0x7b
  jmp __alltraps
  10271e:	e9 24 06 00 00       	jmp    102d47 <__alltraps>

00102723 <vector124>:
.globl vector124
vector124:
  pushl $0
  102723:	6a 00                	push   $0x0
  pushl $124
  102725:	6a 7c                	push   $0x7c
  jmp __alltraps
  102727:	e9 1b 06 00 00       	jmp    102d47 <__alltraps>

0010272c <vector125>:
.globl vector125
vector125:
  pushl $0
  10272c:	6a 00                	push   $0x0
  pushl $125
  10272e:	6a 7d                	push   $0x7d
  jmp __alltraps
  102730:	e9 12 06 00 00       	jmp    102d47 <__alltraps>

00102735 <vector126>:
.globl vector126
vector126:
  pushl $0
  102735:	6a 00                	push   $0x0
  pushl $126
  102737:	6a 7e                	push   $0x7e
  jmp __alltraps
  102739:	e9 09 06 00 00       	jmp    102d47 <__alltraps>

0010273e <vector127>:
.globl vector127
vector127:
  pushl $0
  10273e:	6a 00                	push   $0x0
  pushl $127
  102740:	6a 7f                	push   $0x7f
  jmp __alltraps
  102742:	e9 00 06 00 00       	jmp    102d47 <__alltraps>

00102747 <vector128>:
.globl vector128
vector128:
  pushl $0
  102747:	6a 00                	push   $0x0
  pushl $128
  102749:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10274e:	e9 f4 05 00 00       	jmp    102d47 <__alltraps>

00102753 <vector129>:
.globl vector129
vector129:
  pushl $0
  102753:	6a 00                	push   $0x0
  pushl $129
  102755:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10275a:	e9 e8 05 00 00       	jmp    102d47 <__alltraps>

0010275f <vector130>:
.globl vector130
vector130:
  pushl $0
  10275f:	6a 00                	push   $0x0
  pushl $130
  102761:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102766:	e9 dc 05 00 00       	jmp    102d47 <__alltraps>

0010276b <vector131>:
.globl vector131
vector131:
  pushl $0
  10276b:	6a 00                	push   $0x0
  pushl $131
  10276d:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102772:	e9 d0 05 00 00       	jmp    102d47 <__alltraps>

00102777 <vector132>:
.globl vector132
vector132:
  pushl $0
  102777:	6a 00                	push   $0x0
  pushl $132
  102779:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10277e:	e9 c4 05 00 00       	jmp    102d47 <__alltraps>

00102783 <vector133>:
.globl vector133
vector133:
  pushl $0
  102783:	6a 00                	push   $0x0
  pushl $133
  102785:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10278a:	e9 b8 05 00 00       	jmp    102d47 <__alltraps>

0010278f <vector134>:
.globl vector134
vector134:
  pushl $0
  10278f:	6a 00                	push   $0x0
  pushl $134
  102791:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102796:	e9 ac 05 00 00       	jmp    102d47 <__alltraps>

0010279b <vector135>:
.globl vector135
vector135:
  pushl $0
  10279b:	6a 00                	push   $0x0
  pushl $135
  10279d:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1027a2:	e9 a0 05 00 00       	jmp    102d47 <__alltraps>

001027a7 <vector136>:
.globl vector136
vector136:
  pushl $0
  1027a7:	6a 00                	push   $0x0
  pushl $136
  1027a9:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1027ae:	e9 94 05 00 00       	jmp    102d47 <__alltraps>

001027b3 <vector137>:
.globl vector137
vector137:
  pushl $0
  1027b3:	6a 00                	push   $0x0
  pushl $137
  1027b5:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1027ba:	e9 88 05 00 00       	jmp    102d47 <__alltraps>

001027bf <vector138>:
.globl vector138
vector138:
  pushl $0
  1027bf:	6a 00                	push   $0x0
  pushl $138
  1027c1:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1027c6:	e9 7c 05 00 00       	jmp    102d47 <__alltraps>

001027cb <vector139>:
.globl vector139
vector139:
  pushl $0
  1027cb:	6a 00                	push   $0x0
  pushl $139
  1027cd:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1027d2:	e9 70 05 00 00       	jmp    102d47 <__alltraps>

001027d7 <vector140>:
.globl vector140
vector140:
  pushl $0
  1027d7:	6a 00                	push   $0x0
  pushl $140
  1027d9:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1027de:	e9 64 05 00 00       	jmp    102d47 <__alltraps>

001027e3 <vector141>:
.globl vector141
vector141:
  pushl $0
  1027e3:	6a 00                	push   $0x0
  pushl $141
  1027e5:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1027ea:	e9 58 05 00 00       	jmp    102d47 <__alltraps>

001027ef <vector142>:
.globl vector142
vector142:
  pushl $0
  1027ef:	6a 00                	push   $0x0
  pushl $142
  1027f1:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1027f6:	e9 4c 05 00 00       	jmp    102d47 <__alltraps>

001027fb <vector143>:
.globl vector143
vector143:
  pushl $0
  1027fb:	6a 00                	push   $0x0
  pushl $143
  1027fd:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102802:	e9 40 05 00 00       	jmp    102d47 <__alltraps>

00102807 <vector144>:
.globl vector144
vector144:
  pushl $0
  102807:	6a 00                	push   $0x0
  pushl $144
  102809:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10280e:	e9 34 05 00 00       	jmp    102d47 <__alltraps>

00102813 <vector145>:
.globl vector145
vector145:
  pushl $0
  102813:	6a 00                	push   $0x0
  pushl $145
  102815:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10281a:	e9 28 05 00 00       	jmp    102d47 <__alltraps>

0010281f <vector146>:
.globl vector146
vector146:
  pushl $0
  10281f:	6a 00                	push   $0x0
  pushl $146
  102821:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102826:	e9 1c 05 00 00       	jmp    102d47 <__alltraps>

0010282b <vector147>:
.globl vector147
vector147:
  pushl $0
  10282b:	6a 00                	push   $0x0
  pushl $147
  10282d:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102832:	e9 10 05 00 00       	jmp    102d47 <__alltraps>

00102837 <vector148>:
.globl vector148
vector148:
  pushl $0
  102837:	6a 00                	push   $0x0
  pushl $148
  102839:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10283e:	e9 04 05 00 00       	jmp    102d47 <__alltraps>

00102843 <vector149>:
.globl vector149
vector149:
  pushl $0
  102843:	6a 00                	push   $0x0
  pushl $149
  102845:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10284a:	e9 f8 04 00 00       	jmp    102d47 <__alltraps>

0010284f <vector150>:
.globl vector150
vector150:
  pushl $0
  10284f:	6a 00                	push   $0x0
  pushl $150
  102851:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102856:	e9 ec 04 00 00       	jmp    102d47 <__alltraps>

0010285b <vector151>:
.globl vector151
vector151:
  pushl $0
  10285b:	6a 00                	push   $0x0
  pushl $151
  10285d:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102862:	e9 e0 04 00 00       	jmp    102d47 <__alltraps>

00102867 <vector152>:
.globl vector152
vector152:
  pushl $0
  102867:	6a 00                	push   $0x0
  pushl $152
  102869:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10286e:	e9 d4 04 00 00       	jmp    102d47 <__alltraps>

00102873 <vector153>:
.globl vector153
vector153:
  pushl $0
  102873:	6a 00                	push   $0x0
  pushl $153
  102875:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10287a:	e9 c8 04 00 00       	jmp    102d47 <__alltraps>

0010287f <vector154>:
.globl vector154
vector154:
  pushl $0
  10287f:	6a 00                	push   $0x0
  pushl $154
  102881:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102886:	e9 bc 04 00 00       	jmp    102d47 <__alltraps>

0010288b <vector155>:
.globl vector155
vector155:
  pushl $0
  10288b:	6a 00                	push   $0x0
  pushl $155
  10288d:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102892:	e9 b0 04 00 00       	jmp    102d47 <__alltraps>

00102897 <vector156>:
.globl vector156
vector156:
  pushl $0
  102897:	6a 00                	push   $0x0
  pushl $156
  102899:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  10289e:	e9 a4 04 00 00       	jmp    102d47 <__alltraps>

001028a3 <vector157>:
.globl vector157
vector157:
  pushl $0
  1028a3:	6a 00                	push   $0x0
  pushl $157
  1028a5:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1028aa:	e9 98 04 00 00       	jmp    102d47 <__alltraps>

001028af <vector158>:
.globl vector158
vector158:
  pushl $0
  1028af:	6a 00                	push   $0x0
  pushl $158
  1028b1:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1028b6:	e9 8c 04 00 00       	jmp    102d47 <__alltraps>

001028bb <vector159>:
.globl vector159
vector159:
  pushl $0
  1028bb:	6a 00                	push   $0x0
  pushl $159
  1028bd:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1028c2:	e9 80 04 00 00       	jmp    102d47 <__alltraps>

001028c7 <vector160>:
.globl vector160
vector160:
  pushl $0
  1028c7:	6a 00                	push   $0x0
  pushl $160
  1028c9:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1028ce:	e9 74 04 00 00       	jmp    102d47 <__alltraps>

001028d3 <vector161>:
.globl vector161
vector161:
  pushl $0
  1028d3:	6a 00                	push   $0x0
  pushl $161
  1028d5:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1028da:	e9 68 04 00 00       	jmp    102d47 <__alltraps>

001028df <vector162>:
.globl vector162
vector162:
  pushl $0
  1028df:	6a 00                	push   $0x0
  pushl $162
  1028e1:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1028e6:	e9 5c 04 00 00       	jmp    102d47 <__alltraps>

001028eb <vector163>:
.globl vector163
vector163:
  pushl $0
  1028eb:	6a 00                	push   $0x0
  pushl $163
  1028ed:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1028f2:	e9 50 04 00 00       	jmp    102d47 <__alltraps>

001028f7 <vector164>:
.globl vector164
vector164:
  pushl $0
  1028f7:	6a 00                	push   $0x0
  pushl $164
  1028f9:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1028fe:	e9 44 04 00 00       	jmp    102d47 <__alltraps>

00102903 <vector165>:
.globl vector165
vector165:
  pushl $0
  102903:	6a 00                	push   $0x0
  pushl $165
  102905:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10290a:	e9 38 04 00 00       	jmp    102d47 <__alltraps>

0010290f <vector166>:
.globl vector166
vector166:
  pushl $0
  10290f:	6a 00                	push   $0x0
  pushl $166
  102911:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102916:	e9 2c 04 00 00       	jmp    102d47 <__alltraps>

0010291b <vector167>:
.globl vector167
vector167:
  pushl $0
  10291b:	6a 00                	push   $0x0
  pushl $167
  10291d:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102922:	e9 20 04 00 00       	jmp    102d47 <__alltraps>

00102927 <vector168>:
.globl vector168
vector168:
  pushl $0
  102927:	6a 00                	push   $0x0
  pushl $168
  102929:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10292e:	e9 14 04 00 00       	jmp    102d47 <__alltraps>

00102933 <vector169>:
.globl vector169
vector169:
  pushl $0
  102933:	6a 00                	push   $0x0
  pushl $169
  102935:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  10293a:	e9 08 04 00 00       	jmp    102d47 <__alltraps>

0010293f <vector170>:
.globl vector170
vector170:
  pushl $0
  10293f:	6a 00                	push   $0x0
  pushl $170
  102941:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102946:	e9 fc 03 00 00       	jmp    102d47 <__alltraps>

0010294b <vector171>:
.globl vector171
vector171:
  pushl $0
  10294b:	6a 00                	push   $0x0
  pushl $171
  10294d:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102952:	e9 f0 03 00 00       	jmp    102d47 <__alltraps>

00102957 <vector172>:
.globl vector172
vector172:
  pushl $0
  102957:	6a 00                	push   $0x0
  pushl $172
  102959:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10295e:	e9 e4 03 00 00       	jmp    102d47 <__alltraps>

00102963 <vector173>:
.globl vector173
vector173:
  pushl $0
  102963:	6a 00                	push   $0x0
  pushl $173
  102965:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10296a:	e9 d8 03 00 00       	jmp    102d47 <__alltraps>

0010296f <vector174>:
.globl vector174
vector174:
  pushl $0
  10296f:	6a 00                	push   $0x0
  pushl $174
  102971:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102976:	e9 cc 03 00 00       	jmp    102d47 <__alltraps>

0010297b <vector175>:
.globl vector175
vector175:
  pushl $0
  10297b:	6a 00                	push   $0x0
  pushl $175
  10297d:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102982:	e9 c0 03 00 00       	jmp    102d47 <__alltraps>

00102987 <vector176>:
.globl vector176
vector176:
  pushl $0
  102987:	6a 00                	push   $0x0
  pushl $176
  102989:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  10298e:	e9 b4 03 00 00       	jmp    102d47 <__alltraps>

00102993 <vector177>:
.globl vector177
vector177:
  pushl $0
  102993:	6a 00                	push   $0x0
  pushl $177
  102995:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10299a:	e9 a8 03 00 00       	jmp    102d47 <__alltraps>

0010299f <vector178>:
.globl vector178
vector178:
  pushl $0
  10299f:	6a 00                	push   $0x0
  pushl $178
  1029a1:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1029a6:	e9 9c 03 00 00       	jmp    102d47 <__alltraps>

001029ab <vector179>:
.globl vector179
vector179:
  pushl $0
  1029ab:	6a 00                	push   $0x0
  pushl $179
  1029ad:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1029b2:	e9 90 03 00 00       	jmp    102d47 <__alltraps>

001029b7 <vector180>:
.globl vector180
vector180:
  pushl $0
  1029b7:	6a 00                	push   $0x0
  pushl $180
  1029b9:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1029be:	e9 84 03 00 00       	jmp    102d47 <__alltraps>

001029c3 <vector181>:
.globl vector181
vector181:
  pushl $0
  1029c3:	6a 00                	push   $0x0
  pushl $181
  1029c5:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1029ca:	e9 78 03 00 00       	jmp    102d47 <__alltraps>

001029cf <vector182>:
.globl vector182
vector182:
  pushl $0
  1029cf:	6a 00                	push   $0x0
  pushl $182
  1029d1:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1029d6:	e9 6c 03 00 00       	jmp    102d47 <__alltraps>

001029db <vector183>:
.globl vector183
vector183:
  pushl $0
  1029db:	6a 00                	push   $0x0
  pushl $183
  1029dd:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1029e2:	e9 60 03 00 00       	jmp    102d47 <__alltraps>

001029e7 <vector184>:
.globl vector184
vector184:
  pushl $0
  1029e7:	6a 00                	push   $0x0
  pushl $184
  1029e9:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1029ee:	e9 54 03 00 00       	jmp    102d47 <__alltraps>

001029f3 <vector185>:
.globl vector185
vector185:
  pushl $0
  1029f3:	6a 00                	push   $0x0
  pushl $185
  1029f5:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1029fa:	e9 48 03 00 00       	jmp    102d47 <__alltraps>

001029ff <vector186>:
.globl vector186
vector186:
  pushl $0
  1029ff:	6a 00                	push   $0x0
  pushl $186
  102a01:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102a06:	e9 3c 03 00 00       	jmp    102d47 <__alltraps>

00102a0b <vector187>:
.globl vector187
vector187:
  pushl $0
  102a0b:	6a 00                	push   $0x0
  pushl $187
  102a0d:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102a12:	e9 30 03 00 00       	jmp    102d47 <__alltraps>

00102a17 <vector188>:
.globl vector188
vector188:
  pushl $0
  102a17:	6a 00                	push   $0x0
  pushl $188
  102a19:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102a1e:	e9 24 03 00 00       	jmp    102d47 <__alltraps>

00102a23 <vector189>:
.globl vector189
vector189:
  pushl $0
  102a23:	6a 00                	push   $0x0
  pushl $189
  102a25:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102a2a:	e9 18 03 00 00       	jmp    102d47 <__alltraps>

00102a2f <vector190>:
.globl vector190
vector190:
  pushl $0
  102a2f:	6a 00                	push   $0x0
  pushl $190
  102a31:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102a36:	e9 0c 03 00 00       	jmp    102d47 <__alltraps>

00102a3b <vector191>:
.globl vector191
vector191:
  pushl $0
  102a3b:	6a 00                	push   $0x0
  pushl $191
  102a3d:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102a42:	e9 00 03 00 00       	jmp    102d47 <__alltraps>

00102a47 <vector192>:
.globl vector192
vector192:
  pushl $0
  102a47:	6a 00                	push   $0x0
  pushl $192
  102a49:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102a4e:	e9 f4 02 00 00       	jmp    102d47 <__alltraps>

00102a53 <vector193>:
.globl vector193
vector193:
  pushl $0
  102a53:	6a 00                	push   $0x0
  pushl $193
  102a55:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102a5a:	e9 e8 02 00 00       	jmp    102d47 <__alltraps>

00102a5f <vector194>:
.globl vector194
vector194:
  pushl $0
  102a5f:	6a 00                	push   $0x0
  pushl $194
  102a61:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102a66:	e9 dc 02 00 00       	jmp    102d47 <__alltraps>

00102a6b <vector195>:
.globl vector195
vector195:
  pushl $0
  102a6b:	6a 00                	push   $0x0
  pushl $195
  102a6d:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102a72:	e9 d0 02 00 00       	jmp    102d47 <__alltraps>

00102a77 <vector196>:
.globl vector196
vector196:
  pushl $0
  102a77:	6a 00                	push   $0x0
  pushl $196
  102a79:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102a7e:	e9 c4 02 00 00       	jmp    102d47 <__alltraps>

00102a83 <vector197>:
.globl vector197
vector197:
  pushl $0
  102a83:	6a 00                	push   $0x0
  pushl $197
  102a85:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102a8a:	e9 b8 02 00 00       	jmp    102d47 <__alltraps>

00102a8f <vector198>:
.globl vector198
vector198:
  pushl $0
  102a8f:	6a 00                	push   $0x0
  pushl $198
  102a91:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102a96:	e9 ac 02 00 00       	jmp    102d47 <__alltraps>

00102a9b <vector199>:
.globl vector199
vector199:
  pushl $0
  102a9b:	6a 00                	push   $0x0
  pushl $199
  102a9d:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102aa2:	e9 a0 02 00 00       	jmp    102d47 <__alltraps>

00102aa7 <vector200>:
.globl vector200
vector200:
  pushl $0
  102aa7:	6a 00                	push   $0x0
  pushl $200
  102aa9:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102aae:	e9 94 02 00 00       	jmp    102d47 <__alltraps>

00102ab3 <vector201>:
.globl vector201
vector201:
  pushl $0
  102ab3:	6a 00                	push   $0x0
  pushl $201
  102ab5:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102aba:	e9 88 02 00 00       	jmp    102d47 <__alltraps>

00102abf <vector202>:
.globl vector202
vector202:
  pushl $0
  102abf:	6a 00                	push   $0x0
  pushl $202
  102ac1:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102ac6:	e9 7c 02 00 00       	jmp    102d47 <__alltraps>

00102acb <vector203>:
.globl vector203
vector203:
  pushl $0
  102acb:	6a 00                	push   $0x0
  pushl $203
  102acd:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102ad2:	e9 70 02 00 00       	jmp    102d47 <__alltraps>

00102ad7 <vector204>:
.globl vector204
vector204:
  pushl $0
  102ad7:	6a 00                	push   $0x0
  pushl $204
  102ad9:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102ade:	e9 64 02 00 00       	jmp    102d47 <__alltraps>

00102ae3 <vector205>:
.globl vector205
vector205:
  pushl $0
  102ae3:	6a 00                	push   $0x0
  pushl $205
  102ae5:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  102aea:	e9 58 02 00 00       	jmp    102d47 <__alltraps>

00102aef <vector206>:
.globl vector206
vector206:
  pushl $0
  102aef:	6a 00                	push   $0x0
  pushl $206
  102af1:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102af6:	e9 4c 02 00 00       	jmp    102d47 <__alltraps>

00102afb <vector207>:
.globl vector207
vector207:
  pushl $0
  102afb:	6a 00                	push   $0x0
  pushl $207
  102afd:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102b02:	e9 40 02 00 00       	jmp    102d47 <__alltraps>

00102b07 <vector208>:
.globl vector208
vector208:
  pushl $0
  102b07:	6a 00                	push   $0x0
  pushl $208
  102b09:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102b0e:	e9 34 02 00 00       	jmp    102d47 <__alltraps>

00102b13 <vector209>:
.globl vector209
vector209:
  pushl $0
  102b13:	6a 00                	push   $0x0
  pushl $209
  102b15:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102b1a:	e9 28 02 00 00       	jmp    102d47 <__alltraps>

00102b1f <vector210>:
.globl vector210
vector210:
  pushl $0
  102b1f:	6a 00                	push   $0x0
  pushl $210
  102b21:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102b26:	e9 1c 02 00 00       	jmp    102d47 <__alltraps>

00102b2b <vector211>:
.globl vector211
vector211:
  pushl $0
  102b2b:	6a 00                	push   $0x0
  pushl $211
  102b2d:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102b32:	e9 10 02 00 00       	jmp    102d47 <__alltraps>

00102b37 <vector212>:
.globl vector212
vector212:
  pushl $0
  102b37:	6a 00                	push   $0x0
  pushl $212
  102b39:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102b3e:	e9 04 02 00 00       	jmp    102d47 <__alltraps>

00102b43 <vector213>:
.globl vector213
vector213:
  pushl $0
  102b43:	6a 00                	push   $0x0
  pushl $213
  102b45:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102b4a:	e9 f8 01 00 00       	jmp    102d47 <__alltraps>

00102b4f <vector214>:
.globl vector214
vector214:
  pushl $0
  102b4f:	6a 00                	push   $0x0
  pushl $214
  102b51:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102b56:	e9 ec 01 00 00       	jmp    102d47 <__alltraps>

00102b5b <vector215>:
.globl vector215
vector215:
  pushl $0
  102b5b:	6a 00                	push   $0x0
  pushl $215
  102b5d:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102b62:	e9 e0 01 00 00       	jmp    102d47 <__alltraps>

00102b67 <vector216>:
.globl vector216
vector216:
  pushl $0
  102b67:	6a 00                	push   $0x0
  pushl $216
  102b69:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102b6e:	e9 d4 01 00 00       	jmp    102d47 <__alltraps>

00102b73 <vector217>:
.globl vector217
vector217:
  pushl $0
  102b73:	6a 00                	push   $0x0
  pushl $217
  102b75:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102b7a:	e9 c8 01 00 00       	jmp    102d47 <__alltraps>

00102b7f <vector218>:
.globl vector218
vector218:
  pushl $0
  102b7f:	6a 00                	push   $0x0
  pushl $218
  102b81:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102b86:	e9 bc 01 00 00       	jmp    102d47 <__alltraps>

00102b8b <vector219>:
.globl vector219
vector219:
  pushl $0
  102b8b:	6a 00                	push   $0x0
  pushl $219
  102b8d:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102b92:	e9 b0 01 00 00       	jmp    102d47 <__alltraps>

00102b97 <vector220>:
.globl vector220
vector220:
  pushl $0
  102b97:	6a 00                	push   $0x0
  pushl $220
  102b99:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102b9e:	e9 a4 01 00 00       	jmp    102d47 <__alltraps>

00102ba3 <vector221>:
.globl vector221
vector221:
  pushl $0
  102ba3:	6a 00                	push   $0x0
  pushl $221
  102ba5:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102baa:	e9 98 01 00 00       	jmp    102d47 <__alltraps>

00102baf <vector222>:
.globl vector222
vector222:
  pushl $0
  102baf:	6a 00                	push   $0x0
  pushl $222
  102bb1:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102bb6:	e9 8c 01 00 00       	jmp    102d47 <__alltraps>

00102bbb <vector223>:
.globl vector223
vector223:
  pushl $0
  102bbb:	6a 00                	push   $0x0
  pushl $223
  102bbd:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102bc2:	e9 80 01 00 00       	jmp    102d47 <__alltraps>

00102bc7 <vector224>:
.globl vector224
vector224:
  pushl $0
  102bc7:	6a 00                	push   $0x0
  pushl $224
  102bc9:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102bce:	e9 74 01 00 00       	jmp    102d47 <__alltraps>

00102bd3 <vector225>:
.globl vector225
vector225:
  pushl $0
  102bd3:	6a 00                	push   $0x0
  pushl $225
  102bd5:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102bda:	e9 68 01 00 00       	jmp    102d47 <__alltraps>

00102bdf <vector226>:
.globl vector226
vector226:
  pushl $0
  102bdf:	6a 00                	push   $0x0
  pushl $226
  102be1:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102be6:	e9 5c 01 00 00       	jmp    102d47 <__alltraps>

00102beb <vector227>:
.globl vector227
vector227:
  pushl $0
  102beb:	6a 00                	push   $0x0
  pushl $227
  102bed:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102bf2:	e9 50 01 00 00       	jmp    102d47 <__alltraps>

00102bf7 <vector228>:
.globl vector228
vector228:
  pushl $0
  102bf7:	6a 00                	push   $0x0
  pushl $228
  102bf9:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102bfe:	e9 44 01 00 00       	jmp    102d47 <__alltraps>

00102c03 <vector229>:
.globl vector229
vector229:
  pushl $0
  102c03:	6a 00                	push   $0x0
  pushl $229
  102c05:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102c0a:	e9 38 01 00 00       	jmp    102d47 <__alltraps>

00102c0f <vector230>:
.globl vector230
vector230:
  pushl $0
  102c0f:	6a 00                	push   $0x0
  pushl $230
  102c11:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102c16:	e9 2c 01 00 00       	jmp    102d47 <__alltraps>

00102c1b <vector231>:
.globl vector231
vector231:
  pushl $0
  102c1b:	6a 00                	push   $0x0
  pushl $231
  102c1d:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102c22:	e9 20 01 00 00       	jmp    102d47 <__alltraps>

00102c27 <vector232>:
.globl vector232
vector232:
  pushl $0
  102c27:	6a 00                	push   $0x0
  pushl $232
  102c29:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102c2e:	e9 14 01 00 00       	jmp    102d47 <__alltraps>

00102c33 <vector233>:
.globl vector233
vector233:
  pushl $0
  102c33:	6a 00                	push   $0x0
  pushl $233
  102c35:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102c3a:	e9 08 01 00 00       	jmp    102d47 <__alltraps>

00102c3f <vector234>:
.globl vector234
vector234:
  pushl $0
  102c3f:	6a 00                	push   $0x0
  pushl $234
  102c41:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102c46:	e9 fc 00 00 00       	jmp    102d47 <__alltraps>

00102c4b <vector235>:
.globl vector235
vector235:
  pushl $0
  102c4b:	6a 00                	push   $0x0
  pushl $235
  102c4d:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102c52:	e9 f0 00 00 00       	jmp    102d47 <__alltraps>

00102c57 <vector236>:
.globl vector236
vector236:
  pushl $0
  102c57:	6a 00                	push   $0x0
  pushl $236
  102c59:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102c5e:	e9 e4 00 00 00       	jmp    102d47 <__alltraps>

00102c63 <vector237>:
.globl vector237
vector237:
  pushl $0
  102c63:	6a 00                	push   $0x0
  pushl $237
  102c65:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102c6a:	e9 d8 00 00 00       	jmp    102d47 <__alltraps>

00102c6f <vector238>:
.globl vector238
vector238:
  pushl $0
  102c6f:	6a 00                	push   $0x0
  pushl $238
  102c71:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102c76:	e9 cc 00 00 00       	jmp    102d47 <__alltraps>

00102c7b <vector239>:
.globl vector239
vector239:
  pushl $0
  102c7b:	6a 00                	push   $0x0
  pushl $239
  102c7d:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102c82:	e9 c0 00 00 00       	jmp    102d47 <__alltraps>

00102c87 <vector240>:
.globl vector240
vector240:
  pushl $0
  102c87:	6a 00                	push   $0x0
  pushl $240
  102c89:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102c8e:	e9 b4 00 00 00       	jmp    102d47 <__alltraps>

00102c93 <vector241>:
.globl vector241
vector241:
  pushl $0
  102c93:	6a 00                	push   $0x0
  pushl $241
  102c95:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102c9a:	e9 a8 00 00 00       	jmp    102d47 <__alltraps>

00102c9f <vector242>:
.globl vector242
vector242:
  pushl $0
  102c9f:	6a 00                	push   $0x0
  pushl $242
  102ca1:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102ca6:	e9 9c 00 00 00       	jmp    102d47 <__alltraps>

00102cab <vector243>:
.globl vector243
vector243:
  pushl $0
  102cab:	6a 00                	push   $0x0
  pushl $243
  102cad:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102cb2:	e9 90 00 00 00       	jmp    102d47 <__alltraps>

00102cb7 <vector244>:
.globl vector244
vector244:
  pushl $0
  102cb7:	6a 00                	push   $0x0
  pushl $244
  102cb9:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102cbe:	e9 84 00 00 00       	jmp    102d47 <__alltraps>

00102cc3 <vector245>:
.globl vector245
vector245:
  pushl $0
  102cc3:	6a 00                	push   $0x0
  pushl $245
  102cc5:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102cca:	e9 78 00 00 00       	jmp    102d47 <__alltraps>

00102ccf <vector246>:
.globl vector246
vector246:
  pushl $0
  102ccf:	6a 00                	push   $0x0
  pushl $246
  102cd1:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102cd6:	e9 6c 00 00 00       	jmp    102d47 <__alltraps>

00102cdb <vector247>:
.globl vector247
vector247:
  pushl $0
  102cdb:	6a 00                	push   $0x0
  pushl $247
  102cdd:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102ce2:	e9 60 00 00 00       	jmp    102d47 <__alltraps>

00102ce7 <vector248>:
.globl vector248
vector248:
  pushl $0
  102ce7:	6a 00                	push   $0x0
  pushl $248
  102ce9:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102cee:	e9 54 00 00 00       	jmp    102d47 <__alltraps>

00102cf3 <vector249>:
.globl vector249
vector249:
  pushl $0
  102cf3:	6a 00                	push   $0x0
  pushl $249
  102cf5:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102cfa:	e9 48 00 00 00       	jmp    102d47 <__alltraps>

00102cff <vector250>:
.globl vector250
vector250:
  pushl $0
  102cff:	6a 00                	push   $0x0
  pushl $250
  102d01:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102d06:	e9 3c 00 00 00       	jmp    102d47 <__alltraps>

00102d0b <vector251>:
.globl vector251
vector251:
  pushl $0
  102d0b:	6a 00                	push   $0x0
  pushl $251
  102d0d:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102d12:	e9 30 00 00 00       	jmp    102d47 <__alltraps>

00102d17 <vector252>:
.globl vector252
vector252:
  pushl $0
  102d17:	6a 00                	push   $0x0
  pushl $252
  102d19:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102d1e:	e9 24 00 00 00       	jmp    102d47 <__alltraps>

00102d23 <vector253>:
.globl vector253
vector253:
  pushl $0
  102d23:	6a 00                	push   $0x0
  pushl $253
  102d25:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102d2a:	e9 18 00 00 00       	jmp    102d47 <__alltraps>

00102d2f <vector254>:
.globl vector254
vector254:
  pushl $0
  102d2f:	6a 00                	push   $0x0
  pushl $254
  102d31:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102d36:	e9 0c 00 00 00       	jmp    102d47 <__alltraps>

00102d3b <vector255>:
.globl vector255
vector255:
  pushl $0
  102d3b:	6a 00                	push   $0x0
  pushl $255
  102d3d:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102d42:	e9 00 00 00 00       	jmp    102d47 <__alltraps>

00102d47 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102d47:	1e                   	push   %ds
    pushl %es
  102d48:	06                   	push   %es
    pushl %fs
  102d49:	0f a0                	push   %fs
    pushl %gs
  102d4b:	0f a8                	push   %gs
    pushal
  102d4d:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102d4e:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102d53:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102d55:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102d57:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102d58:	e8 59 f5 ff ff       	call   1022b6 <trap>

    # pop the pushed stack pointer
    popl %esp
  102d5d:	5c                   	pop    %esp

00102d5e <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102d5e:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102d5f:	0f a9                	pop    %gs
    popl %fs
  102d61:	0f a1                	pop    %fs
    popl %es
  102d63:	07                   	pop    %es
    popl %ds
  102d64:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102d65:	83 c4 08             	add    $0x8,%esp
    iret
  102d68:	cf                   	iret   

00102d69 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102d69:	55                   	push   %ebp
  102d6a:	89 e5                	mov    %esp,%ebp
  102d6c:	e8 ee d4 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102d71:	05 df cb 00 00       	add    $0xcbdf,%eax
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102d76:	8b 45 08             	mov    0x8(%ebp),%eax
  102d79:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102d7c:	b8 23 00 00 00       	mov    $0x23,%eax
  102d81:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102d83:	b8 23 00 00 00       	mov    $0x23,%eax
  102d88:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102d8a:	b8 10 00 00 00       	mov    $0x10,%eax
  102d8f:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102d91:	b8 10 00 00 00       	mov    $0x10,%eax
  102d96:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102d98:	b8 10 00 00 00       	mov    $0x10,%eax
  102d9d:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102d9f:	ea a6 2d 10 00 08 00 	ljmp   $0x8,$0x102da6
}
  102da6:	90                   	nop
  102da7:	5d                   	pop    %ebp
  102da8:	c3                   	ret    

00102da9 <gdt_init>:

/*
 * 函数功能：初始化默认的 GDT 和 TSS；
 */
static void
gdt_init(void) {
  102da9:	55                   	push   %ebp
  102daa:	89 e5                	mov    %esp,%ebp
  102dac:	83 ec 10             	sub    $0x10,%esp
  102daf:	e8 ab d4 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102db4:	05 9c cb 00 00       	add    $0xcb9c,%eax
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102db9:	c7 c2 20 0a 11 00    	mov    $0x110a20,%edx
  102dbf:	81 c2 00 04 00 00    	add    $0x400,%edx
  102dc5:	89 90 f4 0f 00 00    	mov    %edx,0xff4(%eax)
    ts.ts_ss0 = KERNEL_DS;
  102dcb:	66 c7 80 f8 0f 00 00 	movw   $0x10,0xff8(%eax)
  102dd2:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102dd4:	66 c7 80 f8 ff ff ff 	movw   $0x68,-0x8(%eax)
  102ddb:	68 00 
  102ddd:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102de3:	66 89 90 fa ff ff ff 	mov    %dx,-0x6(%eax)
  102dea:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102df0:	c1 ea 10             	shr    $0x10,%edx
  102df3:	88 90 fc ff ff ff    	mov    %dl,-0x4(%eax)
  102df9:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e00:	83 e2 f0             	and    $0xfffffff0,%edx
  102e03:	83 ca 09             	or     $0x9,%edx
  102e06:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e0c:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e13:	83 ca 10             	or     $0x10,%edx
  102e16:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e1c:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e23:	83 e2 9f             	and    $0xffffff9f,%edx
  102e26:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e2c:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102e33:	83 ca 80             	or     $0xffffff80,%edx
  102e36:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)
  102e3c:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e43:	83 e2 f0             	and    $0xfffffff0,%edx
  102e46:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e4c:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e53:	83 e2 ef             	and    $0xffffffef,%edx
  102e56:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e5c:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e63:	83 e2 df             	and    $0xffffffdf,%edx
  102e66:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e6c:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e73:	83 ca 40             	or     $0x40,%edx
  102e76:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e7c:	0f b6 90 fe ff ff ff 	movzbl -0x2(%eax),%edx
  102e83:	83 e2 7f             	and    $0x7f,%edx
  102e86:	88 90 fe ff ff ff    	mov    %dl,-0x2(%eax)
  102e8c:	8d 90 f0 0f 00 00    	lea    0xff0(%eax),%edx
  102e92:	c1 ea 18             	shr    $0x18,%edx
  102e95:	88 90 ff ff ff ff    	mov    %dl,-0x1(%eax)
    gdt[SEG_TSS].sd_s = 0;
  102e9b:	0f b6 90 fd ff ff ff 	movzbl -0x3(%eax),%edx
  102ea2:	83 e2 ef             	and    $0xffffffef,%edx
  102ea5:	88 90 fd ff ff ff    	mov    %dl,-0x3(%eax)

    // reload all segment registers
    lgdt(&gdt_pd);
  102eab:	8d 80 d0 00 00 00    	lea    0xd0(%eax),%eax
  102eb1:	50                   	push   %eax
  102eb2:	e8 b2 fe ff ff       	call   102d69 <lgdt>
  102eb7:	83 c4 04             	add    $0x4,%esp
  102eba:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102ec0:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102ec4:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102ec7:	90                   	nop
  102ec8:	c9                   	leave  
  102ec9:	c3                   	ret    

00102eca <pmm_init>:

/*
 * 函数功能：初始化终端设备；
 */
void
pmm_init(void) {
  102eca:	55                   	push   %ebp
  102ecb:	89 e5                	mov    %esp,%ebp
  102ecd:	e8 8d d3 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102ed2:	05 7e ca 00 00       	add    $0xca7e,%eax
    gdt_init();
  102ed7:	e8 cd fe ff ff       	call   102da9 <gdt_init>
}
  102edc:	90                   	nop
  102edd:	5d                   	pop    %ebp
  102ede:	c3                   	ret    

00102edf <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102edf:	55                   	push   %ebp
  102ee0:	89 e5                	mov    %esp,%ebp
  102ee2:	83 ec 10             	sub    $0x10,%esp
  102ee5:	e8 75 d3 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102eea:	05 66 ca 00 00       	add    $0xca66,%eax
    size_t cnt = 0;
  102eef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102ef6:	eb 04                	jmp    102efc <strlen+0x1d>
        cnt ++;
  102ef8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102efc:	8b 45 08             	mov    0x8(%ebp),%eax
  102eff:	8d 50 01             	lea    0x1(%eax),%edx
  102f02:	89 55 08             	mov    %edx,0x8(%ebp)
  102f05:	0f b6 00             	movzbl (%eax),%eax
  102f08:	84 c0                	test   %al,%al
  102f0a:	75 ec                	jne    102ef8 <strlen+0x19>
    }
    return cnt;
  102f0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102f0f:	c9                   	leave  
  102f10:	c3                   	ret    

00102f11 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102f11:	55                   	push   %ebp
  102f12:	89 e5                	mov    %esp,%ebp
  102f14:	83 ec 10             	sub    $0x10,%esp
  102f17:	e8 43 d3 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102f1c:	05 34 ca 00 00       	add    $0xca34,%eax
    size_t cnt = 0;
  102f21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102f28:	eb 04                	jmp    102f2e <strnlen+0x1d>
        cnt ++;
  102f2a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102f2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f31:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102f34:	73 10                	jae    102f46 <strnlen+0x35>
  102f36:	8b 45 08             	mov    0x8(%ebp),%eax
  102f39:	8d 50 01             	lea    0x1(%eax),%edx
  102f3c:	89 55 08             	mov    %edx,0x8(%ebp)
  102f3f:	0f b6 00             	movzbl (%eax),%eax
  102f42:	84 c0                	test   %al,%al
  102f44:	75 e4                	jne    102f2a <strnlen+0x19>
    }
    return cnt;
  102f46:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102f49:	c9                   	leave  
  102f4a:	c3                   	ret    

00102f4b <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102f4b:	55                   	push   %ebp
  102f4c:	89 e5                	mov    %esp,%ebp
  102f4e:	57                   	push   %edi
  102f4f:	56                   	push   %esi
  102f50:	83 ec 20             	sub    $0x20,%esp
  102f53:	e8 07 d3 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102f58:	05 f8 c9 00 00       	add    $0xc9f8,%eax
  102f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f63:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f66:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102f69:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102f6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f6f:	89 d1                	mov    %edx,%ecx
  102f71:	89 c2                	mov    %eax,%edx
  102f73:	89 ce                	mov    %ecx,%esi
  102f75:	89 d7                	mov    %edx,%edi
  102f77:	ac                   	lods   %ds:(%esi),%al
  102f78:	aa                   	stos   %al,%es:(%edi)
  102f79:	84 c0                	test   %al,%al
  102f7b:	75 fa                	jne    102f77 <strcpy+0x2c>
  102f7d:	89 fa                	mov    %edi,%edx
  102f7f:	89 f1                	mov    %esi,%ecx
  102f81:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102f84:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102f87:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102f8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  102f8d:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102f8e:	83 c4 20             	add    $0x20,%esp
  102f91:	5e                   	pop    %esi
  102f92:	5f                   	pop    %edi
  102f93:	5d                   	pop    %ebp
  102f94:	c3                   	ret    

00102f95 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102f95:	55                   	push   %ebp
  102f96:	89 e5                	mov    %esp,%ebp
  102f98:	83 ec 10             	sub    $0x10,%esp
  102f9b:	e8 bf d2 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102fa0:	05 b0 c9 00 00       	add    $0xc9b0,%eax
    char *p = dst;
  102fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  102fa8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102fab:	eb 21                	jmp    102fce <strncpy+0x39>
        if ((*p = *src) != '\0') {
  102fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fb0:	0f b6 10             	movzbl (%eax),%edx
  102fb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fb6:	88 10                	mov    %dl,(%eax)
  102fb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fbb:	0f b6 00             	movzbl (%eax),%eax
  102fbe:	84 c0                	test   %al,%al
  102fc0:	74 04                	je     102fc6 <strncpy+0x31>
            src ++;
  102fc2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102fc6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102fca:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102fce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102fd2:	75 d9                	jne    102fad <strncpy+0x18>
    }
    return dst;
  102fd4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102fd7:	c9                   	leave  
  102fd8:	c3                   	ret    

00102fd9 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102fd9:	55                   	push   %ebp
  102fda:	89 e5                	mov    %esp,%ebp
  102fdc:	57                   	push   %edi
  102fdd:	56                   	push   %esi
  102fde:	83 ec 20             	sub    $0x20,%esp
  102fe1:	e8 79 d2 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  102fe6:	05 6a c9 00 00       	add    $0xc96a,%eax
  102feb:	8b 45 08             	mov    0x8(%ebp),%eax
  102fee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ff4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102ff7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ffa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ffd:	89 d1                	mov    %edx,%ecx
  102fff:	89 c2                	mov    %eax,%edx
  103001:	89 ce                	mov    %ecx,%esi
  103003:	89 d7                	mov    %edx,%edi
  103005:	ac                   	lods   %ds:(%esi),%al
  103006:	ae                   	scas   %es:(%edi),%al
  103007:	75 08                	jne    103011 <strcmp+0x38>
  103009:	84 c0                	test   %al,%al
  10300b:	75 f8                	jne    103005 <strcmp+0x2c>
  10300d:	31 c0                	xor    %eax,%eax
  10300f:	eb 04                	jmp    103015 <strcmp+0x3c>
  103011:	19 c0                	sbb    %eax,%eax
  103013:	0c 01                	or     $0x1,%al
  103015:	89 fa                	mov    %edi,%edx
  103017:	89 f1                	mov    %esi,%ecx
  103019:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10301c:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10301f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  103022:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  103025:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  103026:	83 c4 20             	add    $0x20,%esp
  103029:	5e                   	pop    %esi
  10302a:	5f                   	pop    %edi
  10302b:	5d                   	pop    %ebp
  10302c:	c3                   	ret    

0010302d <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  10302d:	55                   	push   %ebp
  10302e:	89 e5                	mov    %esp,%ebp
  103030:	e8 2a d2 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  103035:	05 1b c9 00 00       	add    $0xc91b,%eax
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10303a:	eb 0c                	jmp    103048 <strncmp+0x1b>
        n --, s1 ++, s2 ++;
  10303c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103040:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103044:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  103048:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10304c:	74 1a                	je     103068 <strncmp+0x3b>
  10304e:	8b 45 08             	mov    0x8(%ebp),%eax
  103051:	0f b6 00             	movzbl (%eax),%eax
  103054:	84 c0                	test   %al,%al
  103056:	74 10                	je     103068 <strncmp+0x3b>
  103058:	8b 45 08             	mov    0x8(%ebp),%eax
  10305b:	0f b6 10             	movzbl (%eax),%edx
  10305e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103061:	0f b6 00             	movzbl (%eax),%eax
  103064:	38 c2                	cmp    %al,%dl
  103066:	74 d4                	je     10303c <strncmp+0xf>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  103068:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10306c:	74 18                	je     103086 <strncmp+0x59>
  10306e:	8b 45 08             	mov    0x8(%ebp),%eax
  103071:	0f b6 00             	movzbl (%eax),%eax
  103074:	0f b6 d0             	movzbl %al,%edx
  103077:	8b 45 0c             	mov    0xc(%ebp),%eax
  10307a:	0f b6 00             	movzbl (%eax),%eax
  10307d:	0f b6 c0             	movzbl %al,%eax
  103080:	29 c2                	sub    %eax,%edx
  103082:	89 d0                	mov    %edx,%eax
  103084:	eb 05                	jmp    10308b <strncmp+0x5e>
  103086:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10308b:	5d                   	pop    %ebp
  10308c:	c3                   	ret    

0010308d <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  10308d:	55                   	push   %ebp
  10308e:	89 e5                	mov    %esp,%ebp
  103090:	83 ec 04             	sub    $0x4,%esp
  103093:	e8 c7 d1 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  103098:	05 b8 c8 00 00       	add    $0xc8b8,%eax
  10309d:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030a0:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1030a3:	eb 14                	jmp    1030b9 <strchr+0x2c>
        if (*s == c) {
  1030a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030a8:	0f b6 00             	movzbl (%eax),%eax
  1030ab:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1030ae:	75 05                	jne    1030b5 <strchr+0x28>
            return (char *)s;
  1030b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b3:	eb 13                	jmp    1030c8 <strchr+0x3b>
        }
        s ++;
  1030b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  1030b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1030bc:	0f b6 00             	movzbl (%eax),%eax
  1030bf:	84 c0                	test   %al,%al
  1030c1:	75 e2                	jne    1030a5 <strchr+0x18>
    }
    return NULL;
  1030c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1030c8:	c9                   	leave  
  1030c9:	c3                   	ret    

001030ca <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  1030ca:	55                   	push   %ebp
  1030cb:	89 e5                	mov    %esp,%ebp
  1030cd:	83 ec 04             	sub    $0x4,%esp
  1030d0:	e8 8a d1 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1030d5:	05 7b c8 00 00       	add    $0xc87b,%eax
  1030da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030dd:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1030e0:	eb 0f                	jmp    1030f1 <strfind+0x27>
        if (*s == c) {
  1030e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e5:	0f b6 00             	movzbl (%eax),%eax
  1030e8:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1030eb:	74 10                	je     1030fd <strfind+0x33>
            break;
        }
        s ++;
  1030ed:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  1030f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f4:	0f b6 00             	movzbl (%eax),%eax
  1030f7:	84 c0                	test   %al,%al
  1030f9:	75 e7                	jne    1030e2 <strfind+0x18>
  1030fb:	eb 01                	jmp    1030fe <strfind+0x34>
            break;
  1030fd:	90                   	nop
    }
    return (char *)s;
  1030fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  103101:	c9                   	leave  
  103102:	c3                   	ret    

00103103 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  103103:	55                   	push   %ebp
  103104:	89 e5                	mov    %esp,%ebp
  103106:	83 ec 10             	sub    $0x10,%esp
  103109:	e8 51 d1 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  10310e:	05 42 c8 00 00       	add    $0xc842,%eax
    int neg = 0;
  103113:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  10311a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  103121:	eb 04                	jmp    103127 <strtol+0x24>
        s ++;
  103123:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  103127:	8b 45 08             	mov    0x8(%ebp),%eax
  10312a:	0f b6 00             	movzbl (%eax),%eax
  10312d:	3c 20                	cmp    $0x20,%al
  10312f:	74 f2                	je     103123 <strtol+0x20>
  103131:	8b 45 08             	mov    0x8(%ebp),%eax
  103134:	0f b6 00             	movzbl (%eax),%eax
  103137:	3c 09                	cmp    $0x9,%al
  103139:	74 e8                	je     103123 <strtol+0x20>
    }

    // plus/minus sign
    if (*s == '+') {
  10313b:	8b 45 08             	mov    0x8(%ebp),%eax
  10313e:	0f b6 00             	movzbl (%eax),%eax
  103141:	3c 2b                	cmp    $0x2b,%al
  103143:	75 06                	jne    10314b <strtol+0x48>
        s ++;
  103145:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103149:	eb 15                	jmp    103160 <strtol+0x5d>
    }
    else if (*s == '-') {
  10314b:	8b 45 08             	mov    0x8(%ebp),%eax
  10314e:	0f b6 00             	movzbl (%eax),%eax
  103151:	3c 2d                	cmp    $0x2d,%al
  103153:	75 0b                	jne    103160 <strtol+0x5d>
        s ++, neg = 1;
  103155:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103159:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103160:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103164:	74 06                	je     10316c <strtol+0x69>
  103166:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  10316a:	75 24                	jne    103190 <strtol+0x8d>
  10316c:	8b 45 08             	mov    0x8(%ebp),%eax
  10316f:	0f b6 00             	movzbl (%eax),%eax
  103172:	3c 30                	cmp    $0x30,%al
  103174:	75 1a                	jne    103190 <strtol+0x8d>
  103176:	8b 45 08             	mov    0x8(%ebp),%eax
  103179:	83 c0 01             	add    $0x1,%eax
  10317c:	0f b6 00             	movzbl (%eax),%eax
  10317f:	3c 78                	cmp    $0x78,%al
  103181:	75 0d                	jne    103190 <strtol+0x8d>
        s += 2, base = 16;
  103183:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103187:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10318e:	eb 2a                	jmp    1031ba <strtol+0xb7>
    }
    else if (base == 0 && s[0] == '0') {
  103190:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103194:	75 17                	jne    1031ad <strtol+0xaa>
  103196:	8b 45 08             	mov    0x8(%ebp),%eax
  103199:	0f b6 00             	movzbl (%eax),%eax
  10319c:	3c 30                	cmp    $0x30,%al
  10319e:	75 0d                	jne    1031ad <strtol+0xaa>
        s ++, base = 8;
  1031a0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1031a4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  1031ab:	eb 0d                	jmp    1031ba <strtol+0xb7>
    }
    else if (base == 0) {
  1031ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1031b1:	75 07                	jne    1031ba <strtol+0xb7>
        base = 10;
  1031b3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  1031ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1031bd:	0f b6 00             	movzbl (%eax),%eax
  1031c0:	3c 2f                	cmp    $0x2f,%al
  1031c2:	7e 1b                	jle    1031df <strtol+0xdc>
  1031c4:	8b 45 08             	mov    0x8(%ebp),%eax
  1031c7:	0f b6 00             	movzbl (%eax),%eax
  1031ca:	3c 39                	cmp    $0x39,%al
  1031cc:	7f 11                	jg     1031df <strtol+0xdc>
            dig = *s - '0';
  1031ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1031d1:	0f b6 00             	movzbl (%eax),%eax
  1031d4:	0f be c0             	movsbl %al,%eax
  1031d7:	83 e8 30             	sub    $0x30,%eax
  1031da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1031dd:	eb 48                	jmp    103227 <strtol+0x124>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1031df:	8b 45 08             	mov    0x8(%ebp),%eax
  1031e2:	0f b6 00             	movzbl (%eax),%eax
  1031e5:	3c 60                	cmp    $0x60,%al
  1031e7:	7e 1b                	jle    103204 <strtol+0x101>
  1031e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1031ec:	0f b6 00             	movzbl (%eax),%eax
  1031ef:	3c 7a                	cmp    $0x7a,%al
  1031f1:	7f 11                	jg     103204 <strtol+0x101>
            dig = *s - 'a' + 10;
  1031f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1031f6:	0f b6 00             	movzbl (%eax),%eax
  1031f9:	0f be c0             	movsbl %al,%eax
  1031fc:	83 e8 57             	sub    $0x57,%eax
  1031ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103202:	eb 23                	jmp    103227 <strtol+0x124>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  103204:	8b 45 08             	mov    0x8(%ebp),%eax
  103207:	0f b6 00             	movzbl (%eax),%eax
  10320a:	3c 40                	cmp    $0x40,%al
  10320c:	7e 3c                	jle    10324a <strtol+0x147>
  10320e:	8b 45 08             	mov    0x8(%ebp),%eax
  103211:	0f b6 00             	movzbl (%eax),%eax
  103214:	3c 5a                	cmp    $0x5a,%al
  103216:	7f 32                	jg     10324a <strtol+0x147>
            dig = *s - 'A' + 10;
  103218:	8b 45 08             	mov    0x8(%ebp),%eax
  10321b:	0f b6 00             	movzbl (%eax),%eax
  10321e:	0f be c0             	movsbl %al,%eax
  103221:	83 e8 37             	sub    $0x37,%eax
  103224:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  103227:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10322a:	3b 45 10             	cmp    0x10(%ebp),%eax
  10322d:	7d 1a                	jge    103249 <strtol+0x146>
            break;
        }
        s ++, val = (val * base) + dig;
  10322f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103233:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103236:	0f af 45 10          	imul   0x10(%ebp),%eax
  10323a:	89 c2                	mov    %eax,%edx
  10323c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10323f:	01 d0                	add    %edx,%eax
  103241:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  103244:	e9 71 ff ff ff       	jmp    1031ba <strtol+0xb7>
            break;
  103249:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  10324a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10324e:	74 08                	je     103258 <strtol+0x155>
        *endptr = (char *) s;
  103250:	8b 45 0c             	mov    0xc(%ebp),%eax
  103253:	8b 55 08             	mov    0x8(%ebp),%edx
  103256:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103258:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  10325c:	74 07                	je     103265 <strtol+0x162>
  10325e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103261:	f7 d8                	neg    %eax
  103263:	eb 03                	jmp    103268 <strtol+0x165>
  103265:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103268:	c9                   	leave  
  103269:	c3                   	ret    

0010326a <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  10326a:	55                   	push   %ebp
  10326b:	89 e5                	mov    %esp,%ebp
  10326d:	57                   	push   %edi
  10326e:	83 ec 24             	sub    $0x24,%esp
  103271:	e8 e9 cf ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  103276:	05 da c6 00 00       	add    $0xc6da,%eax
  10327b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10327e:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103281:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  103285:	8b 55 08             	mov    0x8(%ebp),%edx
  103288:	89 55 f8             	mov    %edx,-0x8(%ebp)
  10328b:	88 45 f7             	mov    %al,-0x9(%ebp)
  10328e:	8b 45 10             	mov    0x10(%ebp),%eax
  103291:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  103294:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103297:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  10329b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  10329e:	89 d7                	mov    %edx,%edi
  1032a0:	f3 aa                	rep stos %al,%es:(%edi)
  1032a2:	89 fa                	mov    %edi,%edx
  1032a4:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  1032a7:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  1032aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032ad:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  1032ae:	83 c4 24             	add    $0x24,%esp
  1032b1:	5f                   	pop    %edi
  1032b2:	5d                   	pop    %ebp
  1032b3:	c3                   	ret    

001032b4 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  1032b4:	55                   	push   %ebp
  1032b5:	89 e5                	mov    %esp,%ebp
  1032b7:	57                   	push   %edi
  1032b8:	56                   	push   %esi
  1032b9:	53                   	push   %ebx
  1032ba:	83 ec 30             	sub    $0x30,%esp
  1032bd:	e8 9d cf ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1032c2:	05 8e c6 00 00       	add    $0xc68e,%eax
  1032c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1032ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1032cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1032d3:	8b 45 10             	mov    0x10(%ebp),%eax
  1032d6:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  1032d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1032dc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1032df:	73 42                	jae    103323 <memmove+0x6f>
  1032e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1032e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1032e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1032ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1032ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1032f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1032f3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1032f6:	c1 e8 02             	shr    $0x2,%eax
  1032f9:	89 c1                	mov    %eax,%ecx
    asm volatile (
  1032fb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1032fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103301:	89 d7                	mov    %edx,%edi
  103303:	89 c6                	mov    %eax,%esi
  103305:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103307:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  10330a:	83 e1 03             	and    $0x3,%ecx
  10330d:	74 02                	je     103311 <memmove+0x5d>
  10330f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103311:	89 f0                	mov    %esi,%eax
  103313:	89 fa                	mov    %edi,%edx
  103315:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103318:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  10331b:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  10331e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  103321:	eb 36                	jmp    103359 <memmove+0xa5>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  103323:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103326:	8d 50 ff             	lea    -0x1(%eax),%edx
  103329:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10332c:	01 c2                	add    %eax,%edx
  10332e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103331:	8d 48 ff             	lea    -0x1(%eax),%ecx
  103334:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103337:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  10333a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10333d:	89 c1                	mov    %eax,%ecx
  10333f:	89 d8                	mov    %ebx,%eax
  103341:	89 d6                	mov    %edx,%esi
  103343:	89 c7                	mov    %eax,%edi
  103345:	fd                   	std    
  103346:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103348:	fc                   	cld    
  103349:	89 f8                	mov    %edi,%eax
  10334b:	89 f2                	mov    %esi,%edx
  10334d:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103350:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103353:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  103356:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  103359:	83 c4 30             	add    $0x30,%esp
  10335c:	5b                   	pop    %ebx
  10335d:	5e                   	pop    %esi
  10335e:	5f                   	pop    %edi
  10335f:	5d                   	pop    %ebp
  103360:	c3                   	ret    

00103361 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103361:	55                   	push   %ebp
  103362:	89 e5                	mov    %esp,%ebp
  103364:	57                   	push   %edi
  103365:	56                   	push   %esi
  103366:	83 ec 20             	sub    $0x20,%esp
  103369:	e8 f1 ce ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  10336e:	05 e2 c5 00 00       	add    $0xc5e2,%eax
  103373:	8b 45 08             	mov    0x8(%ebp),%eax
  103376:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103379:	8b 45 0c             	mov    0xc(%ebp),%eax
  10337c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10337f:	8b 45 10             	mov    0x10(%ebp),%eax
  103382:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103385:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103388:	c1 e8 02             	shr    $0x2,%eax
  10338b:	89 c1                	mov    %eax,%ecx
    asm volatile (
  10338d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103390:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103393:	89 d7                	mov    %edx,%edi
  103395:	89 c6                	mov    %eax,%esi
  103397:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103399:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10339c:	83 e1 03             	and    $0x3,%ecx
  10339f:	74 02                	je     1033a3 <memcpy+0x42>
  1033a1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1033a3:	89 f0                	mov    %esi,%eax
  1033a5:	89 fa                	mov    %edi,%edx
  1033a7:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1033aa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1033ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  1033b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  1033b3:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  1033b4:	83 c4 20             	add    $0x20,%esp
  1033b7:	5e                   	pop    %esi
  1033b8:	5f                   	pop    %edi
  1033b9:	5d                   	pop    %ebp
  1033ba:	c3                   	ret    

001033bb <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  1033bb:	55                   	push   %ebp
  1033bc:	89 e5                	mov    %esp,%ebp
  1033be:	83 ec 10             	sub    $0x10,%esp
  1033c1:	e8 99 ce ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1033c6:	05 8a c5 00 00       	add    $0xc58a,%eax
    const char *s1 = (const char *)v1;
  1033cb:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  1033d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  1033d7:	eb 30                	jmp    103409 <memcmp+0x4e>
        if (*s1 != *s2) {
  1033d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1033dc:	0f b6 10             	movzbl (%eax),%edx
  1033df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1033e2:	0f b6 00             	movzbl (%eax),%eax
  1033e5:	38 c2                	cmp    %al,%dl
  1033e7:	74 18                	je     103401 <memcmp+0x46>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  1033e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1033ec:	0f b6 00             	movzbl (%eax),%eax
  1033ef:	0f b6 d0             	movzbl %al,%edx
  1033f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1033f5:	0f b6 00             	movzbl (%eax),%eax
  1033f8:	0f b6 c0             	movzbl %al,%eax
  1033fb:	29 c2                	sub    %eax,%edx
  1033fd:	89 d0                	mov    %edx,%eax
  1033ff:	eb 1a                	jmp    10341b <memcmp+0x60>
        }
        s1 ++, s2 ++;
  103401:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  103405:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  103409:	8b 45 10             	mov    0x10(%ebp),%eax
  10340c:	8d 50 ff             	lea    -0x1(%eax),%edx
  10340f:	89 55 10             	mov    %edx,0x10(%ebp)
  103412:	85 c0                	test   %eax,%eax
  103414:	75 c3                	jne    1033d9 <memcmp+0x1e>
    }
    return 0;
  103416:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10341b:	c9                   	leave  
  10341c:	c3                   	ret    

0010341d <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  10341d:	55                   	push   %ebp
  10341e:	89 e5                	mov    %esp,%ebp
  103420:	53                   	push   %ebx
  103421:	83 ec 34             	sub    $0x34,%esp
  103424:	e8 3a ce ff ff       	call   100263 <__x86.get_pc_thunk.bx>
  103429:	81 c3 27 c5 00 00    	add    $0xc527,%ebx
  10342f:	8b 45 10             	mov    0x10(%ebp),%eax
  103432:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103435:	8b 45 14             	mov    0x14(%ebp),%eax
  103438:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10343b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10343e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103441:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103444:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  103447:	8b 45 18             	mov    0x18(%ebp),%eax
  10344a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10344d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103450:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103453:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103456:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103459:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10345c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10345f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103463:	74 1c                	je     103481 <printnum+0x64>
  103465:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103468:	ba 00 00 00 00       	mov    $0x0,%edx
  10346d:	f7 75 e4             	divl   -0x1c(%ebp)
  103470:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103473:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103476:	ba 00 00 00 00       	mov    $0x0,%edx
  10347b:	f7 75 e4             	divl   -0x1c(%ebp)
  10347e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103481:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103484:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103487:	f7 75 e4             	divl   -0x1c(%ebp)
  10348a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10348d:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103490:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103493:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103496:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103499:	89 55 ec             	mov    %edx,-0x14(%ebp)
  10349c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10349f:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  1034a2:	8b 45 18             	mov    0x18(%ebp),%eax
  1034a5:	ba 00 00 00 00       	mov    $0x0,%edx
  1034aa:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  1034ad:	72 41                	jb     1034f0 <printnum+0xd3>
  1034af:	39 55 d4             	cmp    %edx,-0x2c(%ebp)
  1034b2:	77 05                	ja     1034b9 <printnum+0x9c>
  1034b4:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1034b7:	72 37                	jb     1034f0 <printnum+0xd3>
        printnum(putch, putdat, result, base, width - 1, padc);
  1034b9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1034bc:	83 e8 01             	sub    $0x1,%eax
  1034bf:	83 ec 04             	sub    $0x4,%esp
  1034c2:	ff 75 20             	pushl  0x20(%ebp)
  1034c5:	50                   	push   %eax
  1034c6:	ff 75 18             	pushl  0x18(%ebp)
  1034c9:	ff 75 ec             	pushl  -0x14(%ebp)
  1034cc:	ff 75 e8             	pushl  -0x18(%ebp)
  1034cf:	ff 75 0c             	pushl  0xc(%ebp)
  1034d2:	ff 75 08             	pushl  0x8(%ebp)
  1034d5:	e8 43 ff ff ff       	call   10341d <printnum>
  1034da:	83 c4 20             	add    $0x20,%esp
  1034dd:	eb 1b                	jmp    1034fa <printnum+0xdd>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  1034df:	83 ec 08             	sub    $0x8,%esp
  1034e2:	ff 75 0c             	pushl  0xc(%ebp)
  1034e5:	ff 75 20             	pushl  0x20(%ebp)
  1034e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1034eb:	ff d0                	call   *%eax
  1034ed:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  1034f0:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  1034f4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1034f8:	7f e5                	jg     1034df <printnum+0xc2>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1034fa:	8d 93 16 48 ff ff    	lea    -0xb7ea(%ebx),%edx
  103500:	8b 45 d8             	mov    -0x28(%ebp),%eax
  103503:	01 d0                	add    %edx,%eax
  103505:	0f b6 00             	movzbl (%eax),%eax
  103508:	0f be c0             	movsbl %al,%eax
  10350b:	83 ec 08             	sub    $0x8,%esp
  10350e:	ff 75 0c             	pushl  0xc(%ebp)
  103511:	50                   	push   %eax
  103512:	8b 45 08             	mov    0x8(%ebp),%eax
  103515:	ff d0                	call   *%eax
  103517:	83 c4 10             	add    $0x10,%esp
}
  10351a:	90                   	nop
  10351b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10351e:	c9                   	leave  
  10351f:	c3                   	ret    

00103520 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  103520:	55                   	push   %ebp
  103521:	89 e5                	mov    %esp,%ebp
  103523:	e8 37 cd ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  103528:	05 28 c4 00 00       	add    $0xc428,%eax
    if (lflag >= 2) {
  10352d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103531:	7e 14                	jle    103547 <getuint+0x27>
        return va_arg(*ap, unsigned long long);
  103533:	8b 45 08             	mov    0x8(%ebp),%eax
  103536:	8b 00                	mov    (%eax),%eax
  103538:	8d 48 08             	lea    0x8(%eax),%ecx
  10353b:	8b 55 08             	mov    0x8(%ebp),%edx
  10353e:	89 0a                	mov    %ecx,(%edx)
  103540:	8b 50 04             	mov    0x4(%eax),%edx
  103543:	8b 00                	mov    (%eax),%eax
  103545:	eb 30                	jmp    103577 <getuint+0x57>
    }
    else if (lflag) {
  103547:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10354b:	74 16                	je     103563 <getuint+0x43>
        return va_arg(*ap, unsigned long);
  10354d:	8b 45 08             	mov    0x8(%ebp),%eax
  103550:	8b 00                	mov    (%eax),%eax
  103552:	8d 48 04             	lea    0x4(%eax),%ecx
  103555:	8b 55 08             	mov    0x8(%ebp),%edx
  103558:	89 0a                	mov    %ecx,(%edx)
  10355a:	8b 00                	mov    (%eax),%eax
  10355c:	ba 00 00 00 00       	mov    $0x0,%edx
  103561:	eb 14                	jmp    103577 <getuint+0x57>
    }
    else {
        return va_arg(*ap, unsigned int);
  103563:	8b 45 08             	mov    0x8(%ebp),%eax
  103566:	8b 00                	mov    (%eax),%eax
  103568:	8d 48 04             	lea    0x4(%eax),%ecx
  10356b:	8b 55 08             	mov    0x8(%ebp),%edx
  10356e:	89 0a                	mov    %ecx,(%edx)
  103570:	8b 00                	mov    (%eax),%eax
  103572:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  103577:	5d                   	pop    %ebp
  103578:	c3                   	ret    

00103579 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  103579:	55                   	push   %ebp
  10357a:	89 e5                	mov    %esp,%ebp
  10357c:	e8 de cc ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  103581:	05 cf c3 00 00       	add    $0xc3cf,%eax
    if (lflag >= 2) {
  103586:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10358a:	7e 14                	jle    1035a0 <getint+0x27>
        return va_arg(*ap, long long);
  10358c:	8b 45 08             	mov    0x8(%ebp),%eax
  10358f:	8b 00                	mov    (%eax),%eax
  103591:	8d 48 08             	lea    0x8(%eax),%ecx
  103594:	8b 55 08             	mov    0x8(%ebp),%edx
  103597:	89 0a                	mov    %ecx,(%edx)
  103599:	8b 50 04             	mov    0x4(%eax),%edx
  10359c:	8b 00                	mov    (%eax),%eax
  10359e:	eb 28                	jmp    1035c8 <getint+0x4f>
    }
    else if (lflag) {
  1035a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1035a4:	74 12                	je     1035b8 <getint+0x3f>
        return va_arg(*ap, long);
  1035a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a9:	8b 00                	mov    (%eax),%eax
  1035ab:	8d 48 04             	lea    0x4(%eax),%ecx
  1035ae:	8b 55 08             	mov    0x8(%ebp),%edx
  1035b1:	89 0a                	mov    %ecx,(%edx)
  1035b3:	8b 00                	mov    (%eax),%eax
  1035b5:	99                   	cltd   
  1035b6:	eb 10                	jmp    1035c8 <getint+0x4f>
    }
    else {
        return va_arg(*ap, int);
  1035b8:	8b 45 08             	mov    0x8(%ebp),%eax
  1035bb:	8b 00                	mov    (%eax),%eax
  1035bd:	8d 48 04             	lea    0x4(%eax),%ecx
  1035c0:	8b 55 08             	mov    0x8(%ebp),%edx
  1035c3:	89 0a                	mov    %ecx,(%edx)
  1035c5:	8b 00                	mov    (%eax),%eax
  1035c7:	99                   	cltd   
    }
}
  1035c8:	5d                   	pop    %ebp
  1035c9:	c3                   	ret    

001035ca <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1035ca:	55                   	push   %ebp
  1035cb:	89 e5                	mov    %esp,%ebp
  1035cd:	83 ec 18             	sub    $0x18,%esp
  1035d0:	e8 8a cc ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1035d5:	05 7b c3 00 00       	add    $0xc37b,%eax
    va_list ap;

    va_start(ap, fmt);
  1035da:	8d 45 14             	lea    0x14(%ebp),%eax
  1035dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1035e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1035e3:	50                   	push   %eax
  1035e4:	ff 75 10             	pushl  0x10(%ebp)
  1035e7:	ff 75 0c             	pushl  0xc(%ebp)
  1035ea:	ff 75 08             	pushl  0x8(%ebp)
  1035ed:	e8 06 00 00 00       	call   1035f8 <vprintfmt>
  1035f2:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1035f5:	90                   	nop
  1035f6:	c9                   	leave  
  1035f7:	c3                   	ret    

001035f8 <vprintfmt>:
 * 它将根据 ANSI 标准解析字符串 fmt 的每个格式化输出字符，并解析变长参数 ap；
 * 解析的结果包括输出对齐、站位、符号、字符等，它们输出会调用 putch()；
 * 变长参数在 C 语言中使用最广泛的就是输出函数，处理它依赖于平台（编译器）的实现；
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1035f8:	55                   	push   %ebp
  1035f9:	89 e5                	mov    %esp,%ebp
  1035fb:	57                   	push   %edi
  1035fc:	56                   	push   %esi
  1035fd:	53                   	push   %ebx
  1035fe:	83 ec 2c             	sub    $0x2c,%esp
  103601:	e8 8c 04 00 00       	call   103a92 <__x86.get_pc_thunk.di>
  103606:	81 c7 4a c3 00 00    	add    $0xc34a,%edi
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10360c:	eb 17                	jmp    103625 <vprintfmt+0x2d>
            if (ch == '\0') {
  10360e:	85 db                	test   %ebx,%ebx
  103610:	0f 84 9a 03 00 00    	je     1039b0 <.L24+0x2d>
                return;
            }
            putch(ch, putdat);
  103616:	83 ec 08             	sub    $0x8,%esp
  103619:	ff 75 0c             	pushl  0xc(%ebp)
  10361c:	53                   	push   %ebx
  10361d:	8b 45 08             	mov    0x8(%ebp),%eax
  103620:	ff d0                	call   *%eax
  103622:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103625:	8b 45 10             	mov    0x10(%ebp),%eax
  103628:	8d 50 01             	lea    0x1(%eax),%edx
  10362b:	89 55 10             	mov    %edx,0x10(%ebp)
  10362e:	0f b6 00             	movzbl (%eax),%eax
  103631:	0f b6 d8             	movzbl %al,%ebx
  103634:	83 fb 25             	cmp    $0x25,%ebx
  103637:	75 d5                	jne    10360e <vprintfmt+0x16>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103639:	c6 45 cb 20          	movb   $0x20,-0x35(%ebp)
        width = precision = -1;
  10363d:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
  103644:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  103647:	89 45 d8             	mov    %eax,-0x28(%ebp)
        lflag = altflag = 0;
  10364a:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  103651:	8b 45 cc             	mov    -0x34(%ebp),%eax
  103654:	89 45 d0             	mov    %eax,-0x30(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103657:	8b 45 10             	mov    0x10(%ebp),%eax
  10365a:	8d 50 01             	lea    0x1(%eax),%edx
  10365d:	89 55 10             	mov    %edx,0x10(%ebp)
  103660:	0f b6 00             	movzbl (%eax),%eax
  103663:	0f b6 d8             	movzbl %al,%ebx
  103666:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103669:	83 f8 55             	cmp    $0x55,%eax
  10366c:	0f 87 11 03 00 00    	ja     103983 <.L24>
  103672:	c1 e0 02             	shl    $0x2,%eax
  103675:	8b 84 38 3c 48 ff ff 	mov    -0xb7c4(%eax,%edi,1),%eax
  10367c:	01 f8                	add    %edi,%eax
  10367e:	ff e0                	jmp    *%eax

00103680 <.L29>:

        // flag to pad on the right
        case '-':
            padc = '-';
  103680:	c6 45 cb 2d          	movb   $0x2d,-0x35(%ebp)
            goto reswitch;
  103684:	eb d1                	jmp    103657 <vprintfmt+0x5f>

00103686 <.L31>:

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  103686:	c6 45 cb 30          	movb   $0x30,-0x35(%ebp)
            goto reswitch;
  10368a:	eb cb                	jmp    103657 <vprintfmt+0x5f>

0010368c <.L32>:

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  10368c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
                precision = precision * 10 + ch - '0';
  103693:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103696:	89 d0                	mov    %edx,%eax
  103698:	c1 e0 02             	shl    $0x2,%eax
  10369b:	01 d0                	add    %edx,%eax
  10369d:	01 c0                	add    %eax,%eax
  10369f:	01 d8                	add    %ebx,%eax
  1036a1:	83 e8 30             	sub    $0x30,%eax
  1036a4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                ch = *fmt;
  1036a7:	8b 45 10             	mov    0x10(%ebp),%eax
  1036aa:	0f b6 00             	movzbl (%eax),%eax
  1036ad:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1036b0:	83 fb 2f             	cmp    $0x2f,%ebx
  1036b3:	7e 39                	jle    1036ee <.L25+0xc>
  1036b5:	83 fb 39             	cmp    $0x39,%ebx
  1036b8:	7f 34                	jg     1036ee <.L25+0xc>
            for (precision = 0; ; ++ fmt) {
  1036ba:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1036be:	eb d3                	jmp    103693 <.L32+0x7>

001036c0 <.L28>:
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1036c0:	8b 45 14             	mov    0x14(%ebp),%eax
  1036c3:	8d 50 04             	lea    0x4(%eax),%edx
  1036c6:	89 55 14             	mov    %edx,0x14(%ebp)
  1036c9:	8b 00                	mov    (%eax),%eax
  1036cb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            goto process_precision;
  1036ce:	eb 1f                	jmp    1036ef <.L25+0xd>

001036d0 <.L30>:

        case '.':
            if (width < 0)
  1036d0:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1036d4:	79 81                	jns    103657 <vprintfmt+0x5f>
                width = 0;
  1036d6:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
            goto reswitch;
  1036dd:	e9 75 ff ff ff       	jmp    103657 <vprintfmt+0x5f>

001036e2 <.L25>:

        case '#':
            altflag = 1;
  1036e2:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
            goto reswitch;
  1036e9:	e9 69 ff ff ff       	jmp    103657 <vprintfmt+0x5f>
            goto process_precision;
  1036ee:	90                   	nop

        process_precision:
            if (width < 0)
  1036ef:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1036f3:	0f 89 5e ff ff ff    	jns    103657 <vprintfmt+0x5f>
                width = precision, precision = -1;
  1036f9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1036fc:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1036ff:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
            goto reswitch;
  103706:	e9 4c ff ff ff       	jmp    103657 <vprintfmt+0x5f>

0010370b <.L36>:

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  10370b:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
            goto reswitch;
  10370f:	e9 43 ff ff ff       	jmp    103657 <vprintfmt+0x5f>

00103714 <.L33>:

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  103714:	8b 45 14             	mov    0x14(%ebp),%eax
  103717:	8d 50 04             	lea    0x4(%eax),%edx
  10371a:	89 55 14             	mov    %edx,0x14(%ebp)
  10371d:	8b 00                	mov    (%eax),%eax
  10371f:	83 ec 08             	sub    $0x8,%esp
  103722:	ff 75 0c             	pushl  0xc(%ebp)
  103725:	50                   	push   %eax
  103726:	8b 45 08             	mov    0x8(%ebp),%eax
  103729:	ff d0                	call   *%eax
  10372b:	83 c4 10             	add    $0x10,%esp
            break;
  10372e:	e9 78 02 00 00       	jmp    1039ab <.L24+0x28>

00103733 <.L35>:

        // error message
        case 'e':
            err = va_arg(ap, int);
  103733:	8b 45 14             	mov    0x14(%ebp),%eax
  103736:	8d 50 04             	lea    0x4(%eax),%edx
  103739:	89 55 14             	mov    %edx,0x14(%ebp)
  10373c:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  10373e:	85 db                	test   %ebx,%ebx
  103740:	79 02                	jns    103744 <.L35+0x11>
                err = -err;
  103742:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  103744:	83 fb 06             	cmp    $0x6,%ebx
  103747:	7f 0b                	jg     103754 <.L35+0x21>
  103749:	8b b4 9f 40 01 00 00 	mov    0x140(%edi,%ebx,4),%esi
  103750:	85 f6                	test   %esi,%esi
  103752:	75 1b                	jne    10376f <.L35+0x3c>
                printfmt(putch, putdat, "error %d", err);
  103754:	53                   	push   %ebx
  103755:	8d 87 27 48 ff ff    	lea    -0xb7d9(%edi),%eax
  10375b:	50                   	push   %eax
  10375c:	ff 75 0c             	pushl  0xc(%ebp)
  10375f:	ff 75 08             	pushl  0x8(%ebp)
  103762:	e8 63 fe ff ff       	call   1035ca <printfmt>
  103767:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  10376a:	e9 3c 02 00 00       	jmp    1039ab <.L24+0x28>
                printfmt(putch, putdat, "%s", p);
  10376f:	56                   	push   %esi
  103770:	8d 87 30 48 ff ff    	lea    -0xb7d0(%edi),%eax
  103776:	50                   	push   %eax
  103777:	ff 75 0c             	pushl  0xc(%ebp)
  10377a:	ff 75 08             	pushl  0x8(%ebp)
  10377d:	e8 48 fe ff ff       	call   1035ca <printfmt>
  103782:	83 c4 10             	add    $0x10,%esp
            break;
  103785:	e9 21 02 00 00       	jmp    1039ab <.L24+0x28>

0010378a <.L39>:

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  10378a:	8b 45 14             	mov    0x14(%ebp),%eax
  10378d:	8d 50 04             	lea    0x4(%eax),%edx
  103790:	89 55 14             	mov    %edx,0x14(%ebp)
  103793:	8b 30                	mov    (%eax),%esi
  103795:	85 f6                	test   %esi,%esi
  103797:	75 06                	jne    10379f <.L39+0x15>
                p = "(null)";
  103799:	8d b7 33 48 ff ff    	lea    -0xb7cd(%edi),%esi
            }
            if (width > 0 && padc != '-') {
  10379f:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1037a3:	7e 78                	jle    10381d <.L39+0x93>
  1037a5:	80 7d cb 2d          	cmpb   $0x2d,-0x35(%ebp)
  1037a9:	74 72                	je     10381d <.L39+0x93>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1037ab:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1037ae:	83 ec 08             	sub    $0x8,%esp
  1037b1:	50                   	push   %eax
  1037b2:	56                   	push   %esi
  1037b3:	89 fb                	mov    %edi,%ebx
  1037b5:	e8 57 f7 ff ff       	call   102f11 <strnlen>
  1037ba:	83 c4 10             	add    $0x10,%esp
  1037bd:	89 c2                	mov    %eax,%edx
  1037bf:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1037c2:	29 d0                	sub    %edx,%eax
  1037c4:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1037c7:	eb 17                	jmp    1037e0 <.L39+0x56>
                    putch(padc, putdat);
  1037c9:	0f be 45 cb          	movsbl -0x35(%ebp),%eax
  1037cd:	83 ec 08             	sub    $0x8,%esp
  1037d0:	ff 75 0c             	pushl  0xc(%ebp)
  1037d3:	50                   	push   %eax
  1037d4:	8b 45 08             	mov    0x8(%ebp),%eax
  1037d7:	ff d0                	call   *%eax
  1037d9:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  1037dc:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  1037e0:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  1037e4:	7f e3                	jg     1037c9 <.L39+0x3f>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1037e6:	eb 35                	jmp    10381d <.L39+0x93>
                if (altflag && (ch < ' ' || ch > '~')) {
  1037e8:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  1037ec:	74 1c                	je     10380a <.L39+0x80>
  1037ee:	83 fb 1f             	cmp    $0x1f,%ebx
  1037f1:	7e 05                	jle    1037f8 <.L39+0x6e>
  1037f3:	83 fb 7e             	cmp    $0x7e,%ebx
  1037f6:	7e 12                	jle    10380a <.L39+0x80>
                    putch('?', putdat);
  1037f8:	83 ec 08             	sub    $0x8,%esp
  1037fb:	ff 75 0c             	pushl  0xc(%ebp)
  1037fe:	6a 3f                	push   $0x3f
  103800:	8b 45 08             	mov    0x8(%ebp),%eax
  103803:	ff d0                	call   *%eax
  103805:	83 c4 10             	add    $0x10,%esp
  103808:	eb 0f                	jmp    103819 <.L39+0x8f>
                }
                else {
                    putch(ch, putdat);
  10380a:	83 ec 08             	sub    $0x8,%esp
  10380d:	ff 75 0c             	pushl  0xc(%ebp)
  103810:	53                   	push   %ebx
  103811:	8b 45 08             	mov    0x8(%ebp),%eax
  103814:	ff d0                	call   *%eax
  103816:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103819:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  10381d:	89 f0                	mov    %esi,%eax
  10381f:	8d 70 01             	lea    0x1(%eax),%esi
  103822:	0f b6 00             	movzbl (%eax),%eax
  103825:	0f be d8             	movsbl %al,%ebx
  103828:	85 db                	test   %ebx,%ebx
  10382a:	74 26                	je     103852 <.L39+0xc8>
  10382c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  103830:	78 b6                	js     1037e8 <.L39+0x5e>
  103832:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
  103836:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  10383a:	79 ac                	jns    1037e8 <.L39+0x5e>
                }
            }
            for (; width > 0; width --) {
  10383c:	eb 14                	jmp    103852 <.L39+0xc8>
                putch(' ', putdat);
  10383e:	83 ec 08             	sub    $0x8,%esp
  103841:	ff 75 0c             	pushl  0xc(%ebp)
  103844:	6a 20                	push   $0x20
  103846:	8b 45 08             	mov    0x8(%ebp),%eax
  103849:	ff d0                	call   *%eax
  10384b:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  10384e:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
  103852:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  103856:	7f e6                	jg     10383e <.L39+0xb4>
            }
            break;
  103858:	e9 4e 01 00 00       	jmp    1039ab <.L24+0x28>

0010385d <.L34>:

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  10385d:	83 ec 08             	sub    $0x8,%esp
  103860:	ff 75 d0             	pushl  -0x30(%ebp)
  103863:	8d 45 14             	lea    0x14(%ebp),%eax
  103866:	50                   	push   %eax
  103867:	e8 0d fd ff ff       	call   103579 <getint>
  10386c:	83 c4 10             	add    $0x10,%esp
  10386f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103872:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            if ((long long)num < 0) {
  103875:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103878:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10387b:	85 d2                	test   %edx,%edx
  10387d:	79 23                	jns    1038a2 <.L34+0x45>
                putch('-', putdat);
  10387f:	83 ec 08             	sub    $0x8,%esp
  103882:	ff 75 0c             	pushl  0xc(%ebp)
  103885:	6a 2d                	push   $0x2d
  103887:	8b 45 08             	mov    0x8(%ebp),%eax
  10388a:	ff d0                	call   *%eax
  10388c:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  10388f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103892:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103895:	f7 d8                	neg    %eax
  103897:	83 d2 00             	adc    $0x0,%edx
  10389a:	f7 da                	neg    %edx
  10389c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10389f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            }
            base = 10;
  1038a2:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  1038a9:	e9 9f 00 00 00       	jmp    10394d <.L41+0x1f>

001038ae <.L40>:

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1038ae:	83 ec 08             	sub    $0x8,%esp
  1038b1:	ff 75 d0             	pushl  -0x30(%ebp)
  1038b4:	8d 45 14             	lea    0x14(%ebp),%eax
  1038b7:	50                   	push   %eax
  1038b8:	e8 63 fc ff ff       	call   103520 <getuint>
  1038bd:	83 c4 10             	add    $0x10,%esp
  1038c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1038c3:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 10;
  1038c6:	c7 45 dc 0a 00 00 00 	movl   $0xa,-0x24(%ebp)
            goto number;
  1038cd:	eb 7e                	jmp    10394d <.L41+0x1f>

001038cf <.L37>:

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1038cf:	83 ec 08             	sub    $0x8,%esp
  1038d2:	ff 75 d0             	pushl  -0x30(%ebp)
  1038d5:	8d 45 14             	lea    0x14(%ebp),%eax
  1038d8:	50                   	push   %eax
  1038d9:	e8 42 fc ff ff       	call   103520 <getuint>
  1038de:	83 c4 10             	add    $0x10,%esp
  1038e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1038e4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 8;
  1038e7:	c7 45 dc 08 00 00 00 	movl   $0x8,-0x24(%ebp)
            goto number;
  1038ee:	eb 5d                	jmp    10394d <.L41+0x1f>

001038f0 <.L38>:

        // pointer
        case 'p':
            putch('0', putdat);
  1038f0:	83 ec 08             	sub    $0x8,%esp
  1038f3:	ff 75 0c             	pushl  0xc(%ebp)
  1038f6:	6a 30                	push   $0x30
  1038f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1038fb:	ff d0                	call   *%eax
  1038fd:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  103900:	83 ec 08             	sub    $0x8,%esp
  103903:	ff 75 0c             	pushl  0xc(%ebp)
  103906:	6a 78                	push   $0x78
  103908:	8b 45 08             	mov    0x8(%ebp),%eax
  10390b:	ff d0                	call   *%eax
  10390d:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103910:	8b 45 14             	mov    0x14(%ebp),%eax
  103913:	8d 50 04             	lea    0x4(%eax),%edx
  103916:	89 55 14             	mov    %edx,0x14(%ebp)
  103919:	8b 00                	mov    (%eax),%eax
  10391b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10391e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
            base = 16;
  103925:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
            goto number;
  10392c:	eb 1f                	jmp    10394d <.L41+0x1f>

0010392e <.L41>:

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10392e:	83 ec 08             	sub    $0x8,%esp
  103931:	ff 75 d0             	pushl  -0x30(%ebp)
  103934:	8d 45 14             	lea    0x14(%ebp),%eax
  103937:	50                   	push   %eax
  103938:	e8 e3 fb ff ff       	call   103520 <getuint>
  10393d:	83 c4 10             	add    $0x10,%esp
  103940:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103943:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            base = 16;
  103946:	c7 45 dc 10 00 00 00 	movl   $0x10,-0x24(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10394d:	0f be 55 cb          	movsbl -0x35(%ebp),%edx
  103951:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103954:	83 ec 04             	sub    $0x4,%esp
  103957:	52                   	push   %edx
  103958:	ff 75 d8             	pushl  -0x28(%ebp)
  10395b:	50                   	push   %eax
  10395c:	ff 75 e4             	pushl  -0x1c(%ebp)
  10395f:	ff 75 e0             	pushl  -0x20(%ebp)
  103962:	ff 75 0c             	pushl  0xc(%ebp)
  103965:	ff 75 08             	pushl  0x8(%ebp)
  103968:	e8 b0 fa ff ff       	call   10341d <printnum>
  10396d:	83 c4 20             	add    $0x20,%esp
            break;
  103970:	eb 39                	jmp    1039ab <.L24+0x28>

00103972 <.L27>:

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103972:	83 ec 08             	sub    $0x8,%esp
  103975:	ff 75 0c             	pushl  0xc(%ebp)
  103978:	53                   	push   %ebx
  103979:	8b 45 08             	mov    0x8(%ebp),%eax
  10397c:	ff d0                	call   *%eax
  10397e:	83 c4 10             	add    $0x10,%esp
            break;
  103981:	eb 28                	jmp    1039ab <.L24+0x28>

00103983 <.L24>:

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103983:	83 ec 08             	sub    $0x8,%esp
  103986:	ff 75 0c             	pushl  0xc(%ebp)
  103989:	6a 25                	push   $0x25
  10398b:	8b 45 08             	mov    0x8(%ebp),%eax
  10398e:	ff d0                	call   *%eax
  103990:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  103993:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103997:	eb 04                	jmp    10399d <.L24+0x1a>
  103999:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10399d:	8b 45 10             	mov    0x10(%ebp),%eax
  1039a0:	83 e8 01             	sub    $0x1,%eax
  1039a3:	0f b6 00             	movzbl (%eax),%eax
  1039a6:	3c 25                	cmp    $0x25,%al
  1039a8:	75 ef                	jne    103999 <.L24+0x16>
                /* do nothing */;
            break;
  1039aa:	90                   	nop
    while (1) {
  1039ab:	e9 5c fc ff ff       	jmp    10360c <vprintfmt+0x14>
                return;
  1039b0:	90                   	nop
        }
    }
}
  1039b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1039b4:	5b                   	pop    %ebx
  1039b5:	5e                   	pop    %esi
  1039b6:	5f                   	pop    %edi
  1039b7:	5d                   	pop    %ebp
  1039b8:	c3                   	ret    

001039b9 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1039b9:	55                   	push   %ebp
  1039ba:	89 e5                	mov    %esp,%ebp
  1039bc:	e8 9e c8 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  1039c1:	05 8f bf 00 00       	add    $0xbf8f,%eax
    b->cnt ++;
  1039c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1039c9:	8b 40 08             	mov    0x8(%eax),%eax
  1039cc:	8d 50 01             	lea    0x1(%eax),%edx
  1039cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1039d2:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1039d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1039d8:	8b 10                	mov    (%eax),%edx
  1039da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1039dd:	8b 40 04             	mov    0x4(%eax),%eax
  1039e0:	39 c2                	cmp    %eax,%edx
  1039e2:	73 12                	jae    1039f6 <sprintputch+0x3d>
        *b->buf ++ = ch;
  1039e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1039e7:	8b 00                	mov    (%eax),%eax
  1039e9:	8d 48 01             	lea    0x1(%eax),%ecx
  1039ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  1039ef:	89 0a                	mov    %ecx,(%edx)
  1039f1:	8b 55 08             	mov    0x8(%ebp),%edx
  1039f4:	88 10                	mov    %dl,(%eax)
    }
}
  1039f6:	90                   	nop
  1039f7:	5d                   	pop    %ebp
  1039f8:	c3                   	ret    

001039f9 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1039f9:	55                   	push   %ebp
  1039fa:	89 e5                	mov    %esp,%ebp
  1039fc:	83 ec 18             	sub    $0x18,%esp
  1039ff:	e8 5b c8 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  103a04:	05 4c bf 00 00       	add    $0xbf4c,%eax
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103a09:	8d 45 14             	lea    0x14(%ebp),%eax
  103a0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a12:	50                   	push   %eax
  103a13:	ff 75 10             	pushl  0x10(%ebp)
  103a16:	ff 75 0c             	pushl  0xc(%ebp)
  103a19:	ff 75 08             	pushl  0x8(%ebp)
  103a1c:	e8 0b 00 00 00       	call   103a2c <vsnprintf>
  103a21:	83 c4 10             	add    $0x10,%esp
  103a24:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103a2a:	c9                   	leave  
  103a2b:	c3                   	ret    

00103a2c <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103a2c:	55                   	push   %ebp
  103a2d:	89 e5                	mov    %esp,%ebp
  103a2f:	83 ec 18             	sub    $0x18,%esp
  103a32:	e8 28 c8 ff ff       	call   10025f <__x86.get_pc_thunk.ax>
  103a37:	05 19 bf 00 00       	add    $0xbf19,%eax
    struct sprintbuf b = {str, str + size - 1, 0};
  103a3c:	8b 55 08             	mov    0x8(%ebp),%edx
  103a3f:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103a42:	8b 55 0c             	mov    0xc(%ebp),%edx
  103a45:	8d 4a ff             	lea    -0x1(%edx),%ecx
  103a48:	8b 55 08             	mov    0x8(%ebp),%edx
  103a4b:	01 ca                	add    %ecx,%edx
  103a4d:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103a50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103a57:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103a5b:	74 0a                	je     103a67 <vsnprintf+0x3b>
  103a5d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103a60:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103a63:	39 d1                	cmp    %edx,%ecx
  103a65:	76 07                	jbe    103a6e <vsnprintf+0x42>
        return -E_INVAL;
  103a67:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103a6c:	eb 22                	jmp    103a90 <vsnprintf+0x64>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103a6e:	ff 75 14             	pushl  0x14(%ebp)
  103a71:	ff 75 10             	pushl  0x10(%ebp)
  103a74:	8d 55 ec             	lea    -0x14(%ebp),%edx
  103a77:	52                   	push   %edx
  103a78:	8d 80 69 40 ff ff    	lea    -0xbf97(%eax),%eax
  103a7e:	50                   	push   %eax
  103a7f:	e8 74 fb ff ff       	call   1035f8 <vprintfmt>
  103a84:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  103a87:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103a8a:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  103a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103a90:	c9                   	leave  
  103a91:	c3                   	ret    

00103a92 <__x86.get_pc_thunk.di>:
  103a92:	8b 3c 24             	mov    (%esp),%edi
  103a95:	c3                   	ret    
