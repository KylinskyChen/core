
# 一、顶层规划

1. 第 1 问：如何配置和使用 qemu 来和我们写的代码关联起来？
2. 第 2 问：ucore.img 是如何生成的？
3. 第 3 问：bootblock 是如何生成？
4. 第 4 问：上电之后，如何一步步启动了机器？
5. 第 5 问：为什么不利用 BIOS 直接加载操作系统？
6. 第 6 问：bootloader 的实现中需要关注哪些硬件知识？
7. 第 7 问：bootblock 是怎样实现的？

# 二、qemu

在系统上安装 qemu。

```bash
sudo apt install qemu
```

## 2.1 启动 qemu

[使用info/warning/error增加调试信息](https://blog.csdn.net/guozhongwei1/article/details/88693221)

编写 Makefile 文件。

1. 使用 shell 指令 `which qemu-system-i386` 来检查电脑是否支持 i386 的 qemu。
2. 指定镜像文件的路径，使用 qemu 的指令来启动虚拟机。

```makefile
# 指定 qemu 的指令名称；
QEMU := qemu-system-i386

# 指定镜像文件的路径；
UCOREIMG = ucore.img

.PHONY: qemu

# 启动 qemu；
qemu: $(UCOREIMG)
	$(V)$(QEMU) -no-reboot -parallel stdio -hda $< -serial null
```

实际运行的指令为 `qemu-system-i386 -no-reboot -parallel stdio -hda ucore.img -serial null`。

- qemu-system-i386：结合自己的电脑构架来使用；
- -no-reboot：退出而不是重新启动；
- -parallel stdio：将虚拟并口重定向到主机设备的 stdio 标准输入输出 (与串口相同的设备)；
- -hda ucore.img：指定虚拟盘为 ucore.img； 
- -serial null：用来指定串口的输出，这里不使用。

这样，qemu 就将镜像驱动，运行起来了。

## 2.2 生成 ucore.img

这里使用 `include` 导入了一个 mk 库，里面有一些工具函数可以使用。

使用 `$(call func, parm)` 来调用函数。

```makefile
include function.mk

# 指定 qemu 的指令名称；
QEMU := qemu-system-i386

# 指定 bootblock 文件的路径；
bootblock = bootblock
kernel = kernel
UCOREIMG = ucore.img

# 创建 ucore.img；
UCOREIMG	:= $(call totarget,ucore.img)

$(UCOREIMG): $(kernel) $(bootblock)
	$(V)dd if=/dev/zero of=$@ count=10000
	$(V)dd if=$(bootblock) of=$@ conv=notrunc
	$(V)dd if=$(kernel) of=$@ seek=1 conv=notrunc

$(call create_target,ucore.img)

.PHONY: qemu

# 启动 qemu；
qemu: $(UCOREIMG)
	$(V)$(QEMU) -no-reboot -parallel stdio -hda $< -serial null
```

`make` 一下即可生成 `ucore.img`，这里实际运行的指令如下。

```bash
dd if=/dev/zero of=ucore.img count=10000
dd if=bootblock of=ucore.img conv=notrunc
dd if=kernel of=ucore.img seek=1 conv=notrunc
```

使用 `dd` 用指定大小的块拷贝一个文件，并在拷贝的同时进行指定的转换。

- if=文件名：输入文件名，缺省为标准输入，即指定源文件；
- of=文件名：输出文件名，缺省为标准输出，即指定目的文件；
- count=blocks：仅拷贝 blocks 个块，块大小等于 ibs 指定的字节数；
- conv=parm：用指定的参数转换文件；
    - notrunc：不截短输出文件；
- seek=blocks：从输出文件开头跳过 blocks 个块后再开始复制。

完整的输出信息如下。

```bash
moocos-> make
dd if=/dev/zero of=ucore.img count=10000
10000+0 records in
10000+0 records out
5120000 bytes (5.1 MB) copied, 0.0227264 s, 225 MB/s
dd if=bootblock of=ucore.img conv=notrunc
1+0 records in
1+0 records out
512 bytes (512 B) copied, 0.00435675 s, 118 kB/s
dd if=kernel of=ucore.img seek=1 conv=notrunc
146+1 records in
146+1 records out
74923 bytes (75 kB) copied, 0.00449896 s, 16.7 MB/s
```

## 2.3 生成 bootblock

生成 bootblock 的 makefile 如下。

```bash
PROJ	:= challenge
EMPTY	:=
SPACE	:= $(EMPTY) $(EMPTY)
SLASH	:= /

V       := @

GCCPREFIX := 

QEMU := qemu-system-i386

# eliminate default suffix rules
# 默认的后缀列表是:.out, .a, .ln, .o, .c, .cc, .C, .p,
# .f, .F, .r, .y, .l, .s, .S, .mod, .sym, .def, .h, 
# .info, .dvi, .tex, .texinfo, .texi,
# .txinfo, .w, .ch .web, .sh, .elc, .el
.SUFFIXES: .c .S .h

# delete target files if there is an error (or make is interrupted)
.DELETE_ON_ERROR:

# define compiler and flags
HOSTCC		:= gcc
HOSTCFLAGS	:= -g -Wall -O2
CC		:= $(GCCPREFIX)gcc
CFLAGS	:= -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc $(DEFS)
CFLAGS	+= $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)

CTYPE	:= c S

LD      := $(GCCPREFIX)ld
# The result is `LDFLAGS := -m elf_i386`
LDFLAGS	:= -m $(shell $(LD) -V | grep elf_i386 2>/dev/null)
LDFLAGS	+= -nostdlib

OBJCOPY := $(GCCPREFIX)objcopy
OBJDUMP := $(GCCPREFIX)objdump

COPY	:= cp
MKDIR   := mkdir -p
MV		:= mv
RM		:= rm -f
AWK		:= awk
SED		:= sed
SH		:= sh
TR		:= tr
TOUCH	:= touch -c

OBJDIR	:= obj
BINDIR	:= bin

ALLOBJS	:=
ALLDEPS	:=
TARGETS	:=

include tools/function.mk

# $(1)目录下，满足`%.c %.S`的文件
listf_cc = $(call listf,$(1),$(CTYPE))

# for cc
add_files_cc = $(call add_files,$(1),$(CC),$(CFLAGS) $(3),$(2),$(4))
create_target_cc = $(call create_target,$(1),$(2),$(3),$(CC),$(CFLAGS))

# for hostcc
add_files_host = $(call add_files,$(1),$(HOSTCC),$(HOSTCFLAGS),$(2),$(3))
create_target_host = $(call create_target,$(1),$(2),$(3),$(HOSTCC),$(HOSTCFLAGS))

cgtype = $(patsubst %.$(2),%.$(3),$(1))
objfile = $(call toobj,$(1))
asmfile = $(call cgtype,$(call toobj,$(1)),o,asm)
outfile = $(call cgtype,$(call toobj,$(1)),o,out)
symfile = $(call cgtype,$(call toobj,$(1)),o,sym)

# for match pattern
match = $(shell echo $(2) | $(AWK) '{for(i=1;i<=NF;i++){if(match("$(1)","^"$$(i)"$$")){exit 1;}}}'; echo $$?)

INCLUDE	+= libs/

CFLAGS	+= $(addprefix -I,$(INCLUDE))

LIBDIR	+= libs

$(call add_files_cc,$(call listf_cc,$(LIBDIR)),libs,)

# -------------------------------------------------------------------

# create bootblock
bootfiles = $(call listf_cc,boot)
$(foreach f,$(bootfiles), $(call cc_compile,$(f),$(CC),$(CFLAGS) -Os -nostdinc))

bootblock = $(call totarget,bootblock)

$(bootblock): $(call toobj,$(bootfiles)) | $(call totarget,sign)
	@echo + ld $@
	$(V)$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 $^ -o $(call toobj,bootblock)
	@$(OBJDUMP) -S $(call objfile,bootblock) > $(call asmfile,bootblock)
	@$(OBJCOPY) -S -O binary $(call objfile,bootblock) $(call outfile,bootblock)
	@$(call totarget,sign) $(call outfile,bootblock) $(bootblock)

$(call create_target,bootblock)

# -------------------------------------------------------------------

# create 'sign' tools
$(call add_files_host,tools/sign.c,sign,sign)
$(call create_target_host,sign,sign)

# -------------------------------------------------------------------

$(call finish_all)

.PHONY: test

test: $(bootblock)
	$(info finished)

.PHONY: clean

clean:
	-$(RM) -r $(OBJDIR) $(BINDIR)
```

gcc 在编译 bootblock 时，需要使用 libs 中的头文件，否则会出现超过 510 字节的情况。

完整的编译输出如下。

```bash
(base) xiechen@xiechen-Ubuntu:~/14.core$ make clean && make test
rm -f -r obj bin

+ cc boot/bootasm.S
gcc -Iboot/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootasm.S -o obj/boot/bootasm.o

+ cc boot/bootmain.c
gcc -Iboot/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootmain.c -o obj/boot/bootmain.o

+ cc tools/sign.c
gcc -Itools/ -g -Wall -O2 -c tools/sign.c -o obj/sign/tools/sign.o
gcc -g -Wall -O2 obj/sign/tools/sign.o -o bin/sign

+ ld bin/bootblock
ld -m    elf_i386 -nostdlib -N -e start -Ttext 0x7C00 obj/boot/bootasm.o obj/boot/bootmain.o -o obj/bootblock.o
objdump -S obj/bootblock.o > obj/bootblock.asm
objcopy -S -O binary obj/bootblock.o obj/bootblock.out

bin/sign obj/bootblock.out bin/bootblock

'obj/bootblock.out' size: 488 bytes
build 512 bytes boot sector: 'bin/bootblock' success!

finished
```

1. 使用 gcc 将源代码 bootasm.S 和 bootmain.c 文件编译为静态库文件 bootasm.o 和 bootmain.o；
2. 生成 bootasm.o 和 bootmain.o 文件之后，通过 ld 链接生成 bootblock.o 文件；
3. 通过反汇编 objdump 生成 bootblock.asm，便于分析，通过 objcopy 复制并将 bootblock.o 文件转为二进制文件 bootblock.out；
4. 使用 sign 编译出来的程序，将 bootblock.out 转为标准格式的 bootblock 启动文件。

## 2.4 从机器启动到操作系统的运行过程

[从机器启动到操作系统运行的过程](https://objectkuan.gitbooks.io/ucore-docs/content/lab1/lab1_3_booting.html)

硬件上电后，整个机器的启动流程分为 3 步。

1. BIOS 启动；
2. bootloader 启动；
3. 操作系统启动。

### 2.4.1 BIOS 启动过程

当计算机加电后，一般不直接执行操作系统，而是执行 **系统初始化软件** 完成 `基本 IO 初始化` 和 `引导加载` 功能。

简单地说，系统初始化软件就是在操作系统内核运行之前运行的一段小软件。

通过这段小软件，我们可以 `初始化硬件设备`、`建立系统的内存空间映射图`，从而将系统的软硬件环境带到一个合适的状态，以便为最终调用操作系统内核准备好正确的环境。

最终引导加载程序把操作系统内核映像加载到 RAM 中，并将系统控制权传递给它。

操作系统和应用软件是存放在磁盘（硬盘/软盘）、光盘、EPROM、ROM、Flash等可在掉电后继续保存数据的存储介质上。

计算机启动后，CPU 一开始会到一个特定的地址开始执行指令，这个特定的地址存放了系统初始化软件，负责完成计算机基本的IO初始化，这是系统加电后运行的第一段软件代码。

对于 Intel 80386 的体系结构而言，PC 机中的系统初始化软件为 BIOS (Basic Input Output System，即基本输入、输出系统），其本质是以下 2 部分组成。

- 固化在主板 Flash/CMOS 上的软件；
- 位于软盘、硬盘引导扇区中的 OS Boot Loader（在 ucore 中的 bootasm.S 和 bootmain.c）。

BIOS 实际上是被固化在计算机 ROM（只读存储器）芯片上的一个特殊的软件，为上层软件提供最底层的、最直接的硬件控制与支持，负责访问和控制硬件。

1. Intel 80386 加电后，CPU 从物理地址 `0xFFFFFFF0`（由初始化的 `CS：EIP` 确定，此时 `CS` 和 `IP `的值分别是 `0xF000` 和 `0xFFF0`）开始执行；

2. 在 `0xFFFFFFF0` 这里只是存放了一条跳转指令，通过跳转指令跳到 `BIOS` 例行程序起始点；

3. BIOS 做完计算机硬件自检和初始化；

4. BIOS 选择一个启动设备（例如软盘、硬盘、光盘等），并且读取该设备的第一扇区（即主引导扇区或启动扇区）到内存一个特定的地址 `0x7c00` 处；

5. CPU 控制权会转移到地址 `0x7c00` 继续执行。

至此 BIOS 的初始化工作做完了，进一步的工作交给了 ucore 的 bootloader。

### 2.4.2 bootloader 启动过程

BIOS 通过读取硬盘主引导扇区到内存，并转跳到对应内存中的位置执行 bootloader。

bootloader 完成的工作包括：

- 切换到保护模式，启用分段机制；
- 读磁盘中 ELF 执行文件格式的 ucore 操作系统到内存；
- 显示字符串信息；
- 把控制权交给 ucore 操作系统。

## 2.5 Intel 80386 相关的硬件知识

### 2.5.1 保护模式

**问：为什么需要保护模式？**

Intel 80386 只有在进入 `保护模式` 后，才能充分发挥其强大的功能，提供更好的保护机制和更大的寻址空间，否则仅仅是一个快速的 8086 而已。

没有一定的保护机制，任何一个应用软件都可以任意访问所有的计算机资源，这样也就无从谈起操作系统设计了。

Intel 80386 的 `分段机制` 一直存在，无法屏蔽或避免。

ucore 的 bootloader 设计中，涉及到了从实模式到保护模式的处理。

ucore 操作系统功能（比如分页机制）是建立在 Intel 80386 的保护模式上来设计的。

#### 2.5.1.1 实模式

**问：所谓的实模式是什么？有啥特点？**

在 bootloader 接手 BIOS 的工作后，当前的 PC 系统处于实模式（16 位模式）运行状态。

在这种状态下软件可访问的物理内存空间不能超过 1MB，无法发挥 Intel 80386 以上级别的 32 位 CPU 的 4GB 内存管理能力。

- 实模式将整个物理内存看成分段的区域；
- 程序代码和数据位于不同区域；
- 操作系统和用户程序并没有区别对待；
- 每一个指针都是指向实际的物理地址。

用户程序的一个指针如果指向了操作系统区域或其他用户程序区域，并修改了内容，那么其后果就很可能是灾难性的。

**问：那如果想要改模式，怎么改？**

通过修改 A20 地址线可以完成从实模式到保护模式的转换。

#### 2.5.1.2 保护模式

**问：保护模式有什么特点？**

- 只有在保护模式下，80386 的全部 32 根地址线有效；
- 可寻址高达 4G 字节的线性地址空间和物理地址空间；
- 可访问 64TB（有 2^14 个段，每个段最大空间为 2^32 字节）的逻辑地址空间；
- 可采用分段存储管理机制和分页存储管理机制。

这不仅为存储共享和保护提供了硬件支持，而且为实现虚拟存储提供了硬件支持。

通过提供 `4 个特权级` 和完善的 `特权检查机制`，既能实现资源共享又能保证代码数据的安全及任务的隔离。

保护模式下，有两个段表：`GDT`（Global Descriptor Table）和 `LDT`（Local Descriptor Table）。

每一张段表可以包含 `8192 (2^13)` 个描述符，因而最多可以同时存在 `2 * 2^13 = 2^14` 个段。

虽然保护模式下可以有这么多段，逻辑地址空间看起来很大，但实际上段并不能扩展物理地址空间，很大程度上各个段的地址空间是相互重叠的。

目前所谓的 64TB（2^(14 + 32) = 2^46）逻辑地址空间是一个理论值，没有实际意义。

在 32 位保护模式下，真正的物理空间仍然只有 2^32 字节那么大。 

在 ucore 中只用到了 GDT，没有用 LDT。

### 2.5.2 分段机制

#### 2.5.2.1 分段存储管理机制

只有在保护模式下才能使用分段存储管理机制。

分段机制将内存划分成以 `起始地址` 和 `长度` 限制这 2 个 2 维参数表示的内存块，这些内存块就称之为 `段`（Segment）。

编译器把源程序编译成执行程序时用到的代码段、数据段、堆和栈等概念在这里可以与段联系起来，二者在含义上是一致的。

分段机制涉及 4 个关键内容。

- 逻辑地址；
- 段描述符（描述段的属性）；
- 段描述符表（包含多个段描述符的“数组”）；
- 段选择子（段寄存器，用于定位段描述符表中表项的索引）。

转换逻辑地址（Logical Address，应用程序员看到的地址）到物理地址（Physical Address，实际的物理内存地址）分以下 2 步。

- 分段地址转换；
    - CPU把逻辑地址（由段选择子 selector 和段偏移 offset 组成）中的段选择子的内容作为段描述符表的索引；
    - 找到表中对应的段描述符；
    - 把段描述符中保存的段基址加上段偏移值，形成线性地址（Linear Address）；
    - 如果不启动分页存储管理机制，则线性地址等于物理地址。
- 分页地址转换；
    - 把线性地址转换为物理地址。（注意：这一步是可选的，由操作系统决定是否需要。）

上述转换过程对于应用程序员来说是不可见的。

线性地址空间由一维的线性地址构成，线性地址空间和物理地址空间对等。

线性地址 32 位长，线性地址空间容量为 4G 字节。

分段存储管理机制需要在启动保护模式的前提下建立。

为了使得分段存储管理机制正常运行，需要建立好 `段描述符` 和 `段描述符表`（参看 `bootasm.S`、`mmu.h`、`pmm.c`）。

#### 2.5.2.2 段描述符

在分段存储管理机制的保护模式下，每个段由如下 3 个参数进行定义。

- 段基地址（Base Address)；
- 段界限（Limit）；
- 段属性（Attributes)。

在 ucore 中的 `kern/mm/mmu.h` 中的 `struct segdesc` 数据结构中有具体的定义。

[目前还在关注 bootloader，关注 kernel 时再回来补充，已经记不住了！！！！！]



### 2.5.3 Intel 80386 寄存器

80386 的寄存器可以分为 8 组。

1. 通用寄存器；
2. 段寄存器；
3. 指令指针寄存器；
4. 标志寄存器；
5. 系统地址寄存器；
6. 控制寄存器；
7. 调试寄存器；
8. 测试寄存器。

其宽度都是 32 位。

一般程序员看到的寄存器包括通用寄存器，段寄存器，指令指针寄存器，标志寄存器。

#### 2.5.3.1 通用寄存器

通用寄存器：General Register。

1. EAX：累加器；
2. EBX：基址寄存器；
3. ECX：计数器；
4. EDX：数据寄存器；

5. ESI：源地址指针寄存器；
6. EDI：目的地址指针寄存器；
7. EBP：基址指针寄存器；
8. ESP：堆栈指针寄存器；

这些寄存器的低 16 位就是 8086 的 AX、BX、CX、DX、SI、DI、BP、SP。

对于 AX、BX、CX、DX 这 4 个寄存器，可以单独存取它们的高 8 位和低 8 位 (AH、AL、BH、BL、CH、CL、DH、DL)

#### 2.5.3.2 段寄存器

段寄存器：Segment Register，也称 Segment Selector、段选择符、段选择子。

1. CS：代码段 (Code Segment)；
2. DS：数据段 (Data Segment)；
3. ES：附加数据段 (Extra Segment)；
4. SS：堆栈段 (Stack Segment)；
5. FS：附加段；
6. GS：附加段；

除了 8086 的 4 个段外（CS、DS、ES、SS)，80386 还增加了 2 个段 FS、GS。

这些段寄存器都是 16 位的，用于不同属性内存段的寻址。

#### 2.5.3.3 指令指针寄存器

指令指针寄存器：Instruction Pointer。

EIP 的低 16 位就是 8086 的 IP，它存储的是下一条要执行指令的内存地址，在分段地址转换中，表示指令的段内偏移地址。

#### 2.5.3.4 标志寄存器

标志寄存器：Flag Register。

1.  CF：进位标志位 (Carry Flag)；
2.  PF：奇偶标志位 (Parity Flag)；
3.  AF：辅助进位标志位 (Assistant Flag)；
4.  ZF：零标志位 (Zero Flag)；
5.  SF：符号标志位 (Singal Flag)；
6.  IF：中断允许标志位 (Interrupt Flag)；
    - 由 CLI、STI 两条指令来控制；
    - 设置 IF 位使 CPU 可识别外部（可屏蔽）中断请求；
    - 复位 IF 位则禁止中断；
    - IF 位对不可屏蔽外部中断和故障中断的识别没有任何作用；
7.  DF：向量标志位(Direction Flag)；
    - 由 CLD、STD 两条指令来控制；
8.  OF：溢出标志位(Overflow Flag)；
9.  IOPL：I/O 特权级字段 (I/O Privilege Level)；
    - 宽度为 2 位；
    - 指定了 I/O 指令的特权级；
    - 如果当前的特权级别在数值上小于或等于 IOPL，那么 I/O 指令可执行；
    - 否则，将发生一个保护性故障中断；
10. NT：控制中断返回指令 IRET (Nested Task)；
    - 宽度为 1 位；
    - 若 NT = 0，则用堆栈中保存的值恢复 EFLAGS、CS、EIP 从而实现中断返回；
    - 若 NT = 1，则通过任务切换实现中断返回；
    - 在 ucore 中，设置 NT 为 0。

EFLAGS 和 8086 的 16 位标志寄存器相比，增加了 4 个控制位。

#### 2.5.3.5 待补充

还有一些应用程序无法访问的控制寄存器，如 CR0、CR2、CR3 等，后面学到了再补充。







## bootblock 的实现

[操作系统ucore lab1笔记](https://www.yht7.com/news/101595)

- 当 CPU 刚加电初始化时，CS:IP 寄存器根据设定的初始值跳转到 BIOS 固件处执行第一条指令；
- 根据指令跳转到 BIOS 数据区执行 BIOS 代码；
- BIOS 在完成硬件的自检后，会将操作系统的启动代码加载到内存；
- 此时 CPU 还处于实模式，只能寻址20位，也就是1MB的内存空间（通常处于内存空间的低位地址）；
- 所以操作系统的启动代码需要加载在这 1MB 的寻址空间内；

- 实验环境下，启动代码需加载到内存地址 0x7C00处；
- 启动代码再将 CPU 从实模式转成保护模式，得以获得 32 位的寻址空间（4GB），去加载代码量庞大的操作系统。

bootblock 完成了 `主引导记录`、`活动分区文件系统识别`、`加载程序` 的功能。

bootblock 主要涉及到的源文件有 `bootmain.c`、`bootasm.S`、`sign.c`。

- sign.c：将生成的可执行文件 `bootblock.out` 拷贝重命名为 `bootblock`，文件结尾加入主引导记录标志 `0x55`、`0xAA`，控制拷贝完的文件大小为 `512` 字节。

## 为什么不利用 BIOS 直接加载操作系统？

1. 不同操作系统可能拥有不同的文件系统，BIOS无法编写所有文件系统的解析代码，所以将加载程序作为操作系统的一部分；

2. 让操作系统可以 `定制化` 实现自己的加载程序；

3. 主引导记录和活动分区的存在主要是硬盘分区的原因。

## bootasm.S

在实模式下，段寄存器和 ip 寄存器只提供 16 位的操作空间。

为了寻址 1MB 的内存空间，此时段寄存器存储的基值（16 位，base）会左移四位，加上偏移量（IP 寄存器，offset）作为逻辑地址。

### 设置重要数据段寄存器

一开始 CPU 还处于实模式，段机制还未启动，但是将 CPU 转成保护模式之前需要将重要的段寄存器设置好，转换前段寄存器 DS、ES、SS 需置 0。

```c
# 设置重要的数据段寄存器：DS、ES、SS；
xorw %ax, %ax                                   # Segment number zero
movw %ax, %ds                                   # -> Data Segment
movw %ax, %es                                   # -> Extra Segment
movw %ax, %ss                                   # -> Stack Segment
```

### 开启 A20 地址线

在进入保护模式之前，需要开启 A20 地址线。

1. 等待 8042 Input buffer 为空；
2. 发送 Write 8042 Output Port（P2）命令到 8042 Input buffer；
3. 等待 8042 Input buffer 为空；
4. 将 8042 Output Port（P2）得到字节的第 2 位置 1，然后写入 8042 Input buffer；

```c
seta20.1:
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al                                 # 如果 %al 第低 2 位为 1，则 ZF = 0, 则跳转；
    jnz seta20.1                                    # 如果 %al 第低 2 位为 0，则 ZF = 1, 则不跳转；

    movb $0xd1, %al                                 # 0xd1 -> port 0x64
    outb %al, $0x64                                 # 0xd1 means: write data to 8042's P2 port

seta20.2:
    inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
    testb $0x2, %al
    jnz seta20.2

    movb $0xdf, %al                                 # 0xdf -> port 0x60
    outb %al, $0x60                                 # 0xdf = 11011111, means set P2's A20 bit(the 1 bit) to 1
```

### 载入 GDT

接下来载入 GDT。

```c
    # 全局描述符表：存放 8 字节的段描述符，段描述符包含段的属性。
    # 段选择符   ：总共 16 位，高 13 位用作全局描述符表中的索引位，GDT 的第一项总是设为 0，
    #               因此孔断选择符的逻辑地址会被认为是无效的，从而引起一个处理器异常；
    #               GDT 表项最大数目是 8191 个，即 2^13 - 1；
    # Switch from real to protected mode, using a bootstrap GDT
    # and segment translation that makes virtual addresses
    # identical to physical addresses, so that the
    # effective memory map does not change during the switch.
    lgdt gdtdesc
    ...

# Bootstrap GDT
.p2align 2                                          # 强制 4 字节对齐；
gdt:
    SEG_NULLASM                                     # null seg
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel

gdtdesc:
    .word 0x17                                      # sizeof(gdt) - 1
    .long gdt                                       # address gdt
```

- CPU 会先读取 GDT 的描述信息，确定 GDT 的大小（24 字节）；
- 再跳转到 gdt 的所在地址，执行内存分段。
- 实验环境中，内存被分为代码段和数据段，大小都为 4G（0x0 ~ 0xffffffff）；
- 设置完成之后，进入 32 位的保护模式，进行相应的准备工作。

```c
.code32                                             # Assemble for 32-bit mode
protcseg:
    # Set up the protected-mode data segment registers
    movw $PROT_MODE_DSEG, %ax                       # Our data segment selector
    movw %ax, %ds                                   # -> DS: Data Segment
    movw %ax, %es                                   # -> ES: Extra Segment
    movw %ax, %fs                                   # -> FS
    movw %ax, %gs                                   # -> GS
    movw %ax, %ss                                   # -> SS: Stack Segment

    # 设置堆栈指针并调用 C 中的程序，堆栈区域从 0 到 start (0x7C00)；
    movl $0x0, %ebp
    movl $start, %esp
    call bootmain
```

- 一切准备工作就绪后，调用 C 函数 bootmain.c 继续执行以至可以加载操作系统内核；
- call bootmain、bootmain 负责将内核加载到内存 0x10000 处，并检查是否为合法的 ELF 文件。

`elf.h` 中对 elf 文件头部信息声明的结构体如下。

```c
#define ELF_MAGIC    0x464C457FU  

// 文件头部；
struct elfhdr {
    uint32_t e_magic;     // 必须等于 ELF_MAGIC；
    uint8_t e_elf[12];
    uint16_t e_type;      // 1 = 可重定位, 2 = 可执行, 3 = 共享对象, 4 = 内核镜像
    uint16_t e_machine;   // 3 = x86, 4 = 68K, etc.
    uint32_t e_version;   // 文件版本，总为 1；
    uint32_t e_entry;     // 可执行程序的入口地址；
    uint32_t e_phoff;     // 程序头部的位置，或者为 0；
    uint32_t e_shoff;     // 段头部的位置，或者为 0；
    uint32_t e_flags;     // 特殊架构的标志位，一般为 0；
    uint16_t e_ehsize;    // 当前这个 ELF 头部文件的大小；
    uint16_t e_phentsize; // 程序头部里入口的大小；
    uint16_t e_phnum;     // 程序头部里入口的数量，或者为 0；
    uint16_t e_shentsize; // 段头部里入口的大小；
    uint16_t e_shnum;     // 段头部里入口的数量，或者为 0；
    uint16_t e_shstrndx;  // 包含段名称字符串的段编号； 
};
```

使用 `make debug` 进行调试，ELFHDR 的值如下。

```bash
(gdb) p *ELFHDR
$1 = {
    e_magic = 1179403647,    // 0x464C457F
    e_elf = "\001\001\001\000\000\000\000\000\000\000\000", 
    e_type = 2, 
    e_machine = 3,
    e_version = 1, 
    e_entry = 1048576,       // 0x100000
    e_phoff = 52,            // 0x34
    e_shoff = 64136,         // 0xFA88
    e_flags = 0, 
    e_ehsize = 52,           // 0x34
    e_phentsize = 32,        // 0x20
    e_phnum = 3, 
    e_shentsize = 40,        // 0x28
    e_shnum = 11, 
    e_shstrndx = 8
}
```

ph 的值如下。

```bash
(gdb) p ph
$2 = (struct proghdr *) 0x10094
(gdb) p *ph
$3 = {
    p_type = 1, 
    p_offset = 4096,     // 0x1000
    p_va = 1048576,      // 0x100000
    p_pa = 1048576,      // 0x100000
    p_filesz = 54953,    // 0xD6A9
    p_memsz = 54953,     // 0xD6A9
    p_flags = 5,         // 0x5
    p_align = 4096       // 0x1000
}

(gdb) 
```



