

# 一、顶层规划

1. 第 1 问：如何配置和使用 qemu 来和我们写的代码关联起来？
2. 第 2 问：ucore.img 是如何生成的？
3. 第 3 问：bootblock 是如何生成？
4. 第 4 问：上电之后，如何一步步启动了机器？
5. 第 5 问：为什么不利用 BIOS 直接加载操作系统？
6. 第 6 问：bootloader 的实现中需要关注哪些硬件知识？
7. 第 7 问：bootloader 是怎么实现的？
9. 第 8 问：基本的 kernel 是如何启动的？

10. 第 10 问：基本的 kernel 包含哪些部分？
11. 第 11 问：基本的 kernel 是如何实现的？

# 二、环境

[uCore操作系统学习笔记](https://fivecakes.com/p/604606d1020188957c773348)

在百度网盘上下载 [mooc-os-2015.vdi.xz](https://pan.baidu.com/s/11zjRK) 虚拟机，是一个 ubuntu 的环境，各项环境已经配置好，该操作系统在此环境上的 qemu 可以成功运行。

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

```gdb
set architecture i8086
```

将处理器状态设置为实模式。

### 2.1.1 Makefile

#### 2.1.1.1 多目标与自动变量

运行如下命令：

```shell
touch foo bar fun makefile
```

在Makefile中添加如下内容：

```makefile
all: obj1 obj2 obj3

obj1 obj2 obj3: foo bar fun
	@echo $^
	@echo $<
	@echo $(subst obj,text,$@)
	@echo "\n"
```

运行`make`会得到如下结果。

```shell
foo bar fun
foo
text1


foo bar fun
foo
text2


foo bar fun
foo
text3
```

- `$^`：获取所有的依赖文件
- `$<`：获取第一个依赖文件
- `$@`：获取所有目标文件

> `(subst obj,text,$@)`中，两个`,`之间不能有空格，即`text`前后不能有空格，否则，在替换的时候就会出现空格替换的情况。

#### 2.1.1.2 后缀规则

对于`.SUFFIXES: .c .S .h`表示的后缀规则，展开为`% : %.c`，`% : %.S`，`% : %.h`。

即定义了 3 组默认的模式规则，相当于定义了自己的后缀列表。

删除了默认的后缀列表（`.out, .a, .ln, .o, .c, .cc, .C, .p, .f, .F, .r, .y, .l, .s, .S, .mod, .sym, .def, .h, .info, .dvi, .tex, .texinfo, .texi, .txinfo, .w, .ch .web, .sh, .elc, .el`）。

#### 2.1.1.3 Call 函数

在`makefile`中写入如下内容：

```makefile
reverse = $(2) $(1)
foo = $(call reverse,a,$(2))
bar = $(call reverse,a,b)
all:
	@echo $(foo)
	@echo $(bar)
```

输出结果如下。

````
a
b a
````

对于没有给定的输入参数`$(2)`，默认为空字符串。

#### 2.1.1.4 2 次拓展

[make 如何读入 makefile](https://www.gnu.org/software/make/manual/html_node/Reading-Makefiles.html#Reading-Makefiles)

[GNU Make 官方文档](https://www.gnu.org/software/make/manual/html_node/Secondary-Expansion.html)

GNU Make 的二次扩展只能用于`依赖部分`。

为了使用二次扩展，必须在第一个 `prerequisite`之前， 用`.SECONDEXPANSION` 做一个标注。

`make` 的工作分为两个阶段 `read-in phase` 和 `target-update phase` 。

每个阶段都会对变量做一次扩展，如下例所示。

```makefile
.SECONDEXPANSION:
ONEVAR = onefile
TWOVAR = twofile
myfile: $(ONEVAR) $$(TWOVAR)
```

- 第 1 阶段完成后，结果为`myfile: onefile $(TWOVAR)` ；
- 第 2 阶段，`onefile` 扩展后不引用任何变量，仍然保留原值 `onfile` ，而后面一个扩展之后变成 `twofile`；
- 最后结果为`myfile: onefile twofile`。

再看下一个例子。

```makefile
.SECONDEXPANSION:
AVAR = top
onefile: $(AVAR)
twofile: $$(AVAR)
AVAR = bottom
```

- 在第 1 次扩展时，按照顺序，`onefile` 会被立即扩展为 `top`；
- 在第 2 次扩展阶段，由于 `AVAR` 的值在第一阶段被复写了，因此 `twofile` 的值被扩展为 `bottom`。

再看下面一个例子。

```makefile
.SECONDEXPANSION:
main_OBJS := main.o try.o test.o
lib_OBJS := lib.o api.o

main lib: $$($$@_OBJS)
```

- 在第 1 次扩展后，结果为 `man lib: $($@_OBJS)`；
- 在第 2 次扩展时，`$@` 被设置为`man lib` 值，所以扩展之后会变成 `man: $(main_OBJS) ` 和 `lib: $(lib_OBJS)`。

将上面的例子再变化一下。

```makefile
main_SRCS := main.c try.c test.c
lib_SRCS := lib.c api.c

.SECONDEXPANSION:
main lib: $$(patsubst %.c,%.o,$$($$@_SRCS))
```

在二次扩展中，只有 `$$@ / $$^ / $$<` 可以使用，而 `$$* / $$?` 是不能使用的。

看下面的一个模式，在 `command` 模块里是不支持二次扩展的。

```makfile
file = /home/monster/Downloads

.SECONDEXPANSION:

define second
foo: $(1)
	@echo ---------------
	@echo $$(dir $$<)
	@echo $$$$(dir $$$$^)	
	@echo ---------------
endef

define first
$$(eval $$(call second, $(1)))
endef

$(info $(call second, $(file)))
$(info $(call first, $(file)))
$(eval $(call first, $(file)))
```

输出结果为：

```shell
foo:  /home/monster/Downloads
	@echo ---------------
	@echo $(dir $<)
	@echo $$(dir $$^)	
	@echo ---------------
$(eval $(call second,  /home/monster/Downloads))
---------------
/home/monster/
dir: cannot access '$^': No such file or directory
```

- 第 1 个执行的是 `echo /home/monster`；
- 第 2 个执行的是 `echo $(dir $^)`；
- 因此就会出现下面的错误提示；
- 注意：执行是在 shell 里面执行的。

多个美元符号的解释。

```makefile
DOLLAR:=$$
FOUR := $$$$
dollar:
	echo '$$'  >  $@
	echo "\$$" >> $@
	echo '$(DOLLAR)'  >> $@
	echo "\$(DOLLAR)" >> $@
	echo $(DOLLAR) >> $@
	echo $$(DOLLAR) >> $@
	echo $(FOUR)
	cat dollar
```

运行结果为：

```shell
echo '$'  >  dollar
echo "\$" >> dollar
echo '$'  >> dollar
echo "\$" >> dollar
echo $ >> dollar
echo $(DOLLAR) >> dollar
/bin/sh: 1: DOLLAR: not found
echo $$
9879
cat dollar
$
$
$
$
$

```

看一下下面这个例子。

```makefile
SLASH = /
all: foo.c boo.c poo.c

foo.c: bar | $(shell echo $(dir $(basename $@)$(SLASH)))
	@echo $^
	@echo $(basename $@)

boo.c: bar $(shell echo $(dir $(basename $@)$(SLASH)))
	@echo $^
	@echo $(basename $@)

poo.c: bar $(echo $(dir $(basename $@)$(SLASH)))
	@echo $^
	@echo $(basename $@)
```

输出结果为：

```shell
bar
foo
bar /
boo
bar
poo
```

可以看出 `Order-Only` 前提条件不会算作 `$^` 的依赖目标集。

看下面情况。

```makefile
SLASH = /
name = /home/monster/downloads
/home/monster/foo.c: bar | $(shell echo $(dir $(basename $@)$(SLASH)))
	@echo $^
	@echo $(basename $@)
	@echo $(dir $(basename $@)$(SLASH))
	@echo $(dir $(name))
```

输出结果为：

```shell
bar
/home/monster/foo
/home/monster/foo/
/home/monster/
```

- make 里面的`dir` 函数是取目录函数，即取出`name`中的最后一个`/`之前的所有部分，包括`/`；
- shell 里面的`dir` 函数是列出一个目录下的内容，相当于`ls`。

### 2.1.2 qemu

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

当 BIOS 加载完引导扇区的内容至内存后，CPU 便会跳转到 0x7c00 执行命令，此时 CPU 的控制权便交给了 ucore 的引导程序 bootloader，即 bootblock。

### 2.3.1 使用 sign 生成 bootblock

[清华大学操作系统课程 ucore Lab 1 系统软件启动过程 实验报告](https://www.jianshu.com/p/2f95d38afa1d)

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
# 查看 elf 文件信息；
objdump -S obj/bootblock.o > obj/bootblock.asm

# 去掉 elf 文件中的 elf header 和 section；
objcopy -S -O binary obj/bootblock.o obj/bootblock.out

# 用 bin/sign 保证主引导扇区程序长度为 512 字节，且最后两个字节为 55AA；
bin/sign obj/bootblock.out bin/bootblock

'obj/bootblock.out' size: 488 bytes
build 512 bytes boot sector: 'bin/bootblock' success!

finished
```

1. 使用 gcc 将源代码 bootasm.S 和 bootmain.c 文件编译为静态库文件 bootasm.o 和 bootmain.o；
2. 生成 bootasm.o 和 bootmain.o 文件之后，通过 ld 链接生成 bootblock.o 文件；
3. 通过反汇编 objdump 生成 bootblock.asm，便于分析，通过 objcopy 复制并将 bootblock.o 文件转为二进制文件 bootblock.out；
4. 使用 sign 编译出来的程序，将 bootblock.out 转为标准格式的 bootblock 启动文件。

### 2.3.2 sign 的实现

为了避免所加载的磁盘引导扇区是一个无效扇区 (可能引导扇区中的内容就是空的或是乱码)，要求 512 字节大小的扇区在其最后两字节必须是 0x55 0xAA (其余的空余空间可以用 0x00 填充)，否则无法通过 BIOS 的校验，引导失败。

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

### 2.4.3 操作系统启动过程

当 bootloader 通过读取硬盘扇区把 ucore 在系统加载到内存后，就转跳到 ucore 操作系统在内存中的入口位置（`kern/init.c` 中的 `kern_init` 函数的起始地址），这样 `ucore` 就接管了整个控制权。






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

### 2.5.4 地址空间

### 2.5.5 硬盘访问

### 2.5.6 ELF 文件格式

ELF (Executable and linking format) 文件格式是 Linux 系统下的一种常用目标文件 (object file) 格式。

有 3 种主要类型。

1. 用于执行的可执行文件 (executable file)；
    - 用于提供程序的进程映像，加载的内存执行；
2. 用于连接的可重定位文件 (relocatable file)；
    - 可与其它目标文件一起创建可执行文件和共享目标文件；
3. 共享目标文件 (shared object file)；
    - 连接器可将它与其它可重定位文件和共享目标文件连接成其它的目标文件；
    - 动态连接器又可将它与可执行文件和其它共享目标文件结合起来创建一个进程映像。

这里重点关注与 ucore 相关的用于可执行文件的 ELF 可执行文件类型。

ELF header 在文件开始处描述了整个文件的组织。

ELF 的文件头包含整个执行文件的控制结构，其定义在 `elf.h` 中。

```c
struct elfhdr {
    uint32_t e_magic;     // 必须等于 ELF_MAGIC；
    uint8_t e_elf[12];
    uint16_t e_type;      // 1 = 可重定位, 2 = 可执行, 3 = 共享对象, 4 = 内核镜像
    uint16_t e_machine;   // 3 = x86, 4 = 68K, etc.
    uint32_t e_version;   // 文件版本，总为 1；
    uint32_t e_entry;     // 可执行程序的入口地址；
    uint32_t e_phoff;     // 程序头部的位置，或者为 0；（program header 表的位置偏移；）
    uint32_t e_shoff;     // 段头部的位置，或者为 0；
    uint32_t e_flags;     // 特殊架构的标志位，一般为 0；
    uint16_t e_ehsize;    // 当前这个 ELF 头部文件的大小；
    uint16_t e_phentsize; // 程序头部里入口的大小；
    uint16_t e_phnum;     // 程序头部里入口的数量，或者为 0；（program header 表中的入口数目；）
    uint16_t e_shentsize; // 节区头部里入口的大小；
    uint16_t e_shnum;     // 节区头部里入口的数量，或者为 0；
    uint16_t e_shstrndx;  // 包含段名称字符串的节区编号； 
};
```

`program header` 描述与程序执行直接相关的目标文件结构信息，用来在文件中定位各个段的映像，同时包含其他一些用来为程序创建进程映像所必需的信息。

可执行文件的程序头部是一个 `program header` 结构的数组， 每个结构描述了一个段或者系统准备程序执行所必需的其它信息。

目标文件的 `段` 包含一个或者多个 `节区`（section） ，也就是 `段内容`（Segment Contents）。

程序头部仅对于可执行文件和共享目标文件有意义。

可执行目标文件在 ELF 头部的 `e_phentsize` 和 `e_phnum` 成员中给出其自身程序头部的大小。

```c
struct proghdr {
    uint32_t p_type;   // 可加载的代码或数据，动态链接信息等；（段类型；）
    uint32_t p_offset; // 段文件偏移地址；（段相对文件头的偏移值；）
    uint32_t p_va;     // 指向映射段的虚拟地址；（段的第一个字节将被放到内存中的虚拟地址；）
    uint32_t p_pa;     // 物理地址，该信息不再使用；
    uint32_t p_filesz; // 文件中段的大小；
    uint32_t p_memsz;  // 内存中段的大小 (bigger if contains bss）；（段在内存映像中占用的字节数；）
    uint32_t p_flags;  // 读、写、可执行位；
    uint32_t p_align;  // 需要对齐，硬件页面大小不变；
};
```

根据 elfhdr 和 proghdr 的结构描述，bootloader 就可以完成对 ELF 格式的 ucore 操作系统的加载过程。

> Link Address 是指编译器指定代码和数据所需要放置的内存地址，由链接器配置；
> Load Address 是指程序被实际加载到内存的位置（由程序加载器 ld 配置）；
> 一般由可执行文件结构信息和加载器可保证这两个地址相同。
>
> Link Addr 和 LoadAddr 不同会导致：
>   - 直接跳转位置错误；
>   - 直接内存访问（只读数据区或 bss 等直接地址访问）错误；
>   - 堆和栈等的使用不受影响，但是可能会覆盖程序、数据区域；
>
> 注意：也存在 Link 地址和 Load 地址不一样的情况（例如：动态链接库）。

### 2.5.7 A20 Gate

Intel 早期的 8086 CPU 提供了 20 根地址线，可寻址空间范围即 `0~2^20` (00000H ~ FFFFFH) 的 1MB 内存空间。

8086 的数据处理位宽位 16 位，无法直接寻址 1MB 内存空间，所以 8086 提供了段地址加偏移地址的地址转换机制。

PC 机的寻址结构是 `segment:offset`，`segment`、`offset` 都是 16 位的寄存器，最大值是 0ffffh。

换算成物理地址的计算方法是把 `segment` 左移 4 位，再加上 offset。

所以 `segment:offset` 所能表达的寻址空间最大应为 `0ffff0h + 0ffffh = 10ffefh`（前面的 `0ffffh` 是 `segment=0ffffh` 并向左移动 4 位的结果，后面的 `0ffffh` 是可能的最大 `offset`）。

这个计算出的 `10ffefh` 大约是 `1088KB`，`segment:offset` 的地址表示能力，超过了 20 位地址线的物理寻址能力。

当寻址到超过 1MB 的内存时，会发生 `回卷`（不会发生异常）。

下一代的基于 Intel 80286 CPU 的 PC AT 计算机系统提供了 24 根地址线，这样 CPU 的寻址范围变为 `2^24=16M`，

Intel 80286 提供了保护模式，可以访问到 1MB 以上的内存了，此时如果遇到寻址超过 1MB 的情况，系统不会再 `回卷` 了，这就造成了向下不兼容。

为了保持完全的向下兼容性，IBM 决定在 PC AT 计算机系统上加个硬件逻辑，来模仿以上的回绕特征，于是出现了 A20 Gate。

他们的方法就是把 A20 地址线控制和键盘控制器的一个输出进行 AND 操作，这样来控制 A20 地址线的打开（使能）和关闭（屏蔽\禁止）。

一开始时 A20 地址线控制是被屏蔽的（总为 0），直到系统软件通过一定的 IO 操作去打开它（参看 bootasm.S）。

在实模式下要访问高端内存区，这个开关必须打开。

在保护模式下，由于使用 32 位地址线，如果 A20 恒等于0，那么系统只能访问奇数兆的内存，即只能访问 0-1M、2-3M、4-5M......。

这是不行的，所以在保护模式下，这个开关也必须打开。

当 A20 地址线控制禁止时，则程序就像在 8086 中运行，1MB 以上的地址是不可访问的。

在保护模式下 A20 地址线控制是要打开的。

为了使能所有地址位的寻址能力,必须向键盘控制器 8042 发送一个命令。

键盘控制器 8042 将会将它的的某个输出引脚的输出置高电平，作为 A20 地址线控制的输入。

一旦设置成功之后，内存将不会再被绕回 (memory wrapping)，这样我们就可以寻址整个 286 的 16M 内存，或者是寻址 80386 级别机器的所有 4G 内存了。

**问：从软件的角度来看，如何控制键盘控制器 8042 呢？**

早期的 PC 机，控制键盘有一个单独的单片机 8042，现如今这个芯片已经给集成到了其它大片子中，但其功能和使用方法还是一样。

当 PC 机刚刚出现 A20 Gate 的时候，估计为节省硬件设计成本，工程师使用这个 8042 键盘控制器来控制 A20 Gate，但 A20 Gate 与键盘管理没有一点关系。

8042 键盘控制器的 IO 端口是 `0x60-0x6f`，实际上 IBM PC/AT 使用的只有 `0x60` 和 `0x64` 两个端口（0x61、0x62、0x63 用于与 XT 兼容目的）。

8042 通过这些端口给键盘控制器或键盘发送命令或读取状态。

输出端口 P2 用于特定目的。

位 0（P20 引脚）用于实现 CPU 复位操作，位 1（P21 引脚）用户控制 A20 信号线的开启与否。

系统向输入缓冲（端口 0x64）写入一个字节，即发送一个键盘控制器命令。

可以带一个参数，参数是通过 0x60 端口发送的，命令的返回值也从端口 0x60 去读。

8042 有 4 个寄存器。

- 1 个 8-bit 长的 Input buffer；Write-Only；
- 1 个 8-bit 长的 Output buffer；Read-Only；
- 1 个 8-bit 长的 Status Register；Read-Only；
- 1 个 8-bit 长的 Control Register；Read/Write。

有两个端口地址：60h 和 64h。

- 读 60h 端口，读 output buffer；
- 写 60h 端口，写 input buffer；
- 读 64h 端口，读 Status Register；
- 操作 Control Register；
    - 首先要向 64h 端口写一个命令（20h 为读命令，60h 为写命令）；
    - 然后根据命令从 60h 端口读出 Control Register 的数据或者向 60h 端口写入 Control Register 的数据（64h 端口还可以接受许多其它的命令）。

Status Register 的定义（要用 bit 0 和 bit 1）。

- 0：output register (60h) 中有数据；
- 1：input register (60h/64h) 有数据；
- 2：系统标志（上电复位后被置为0）；
- 3：data in input register is command (1) or data (0)；
- 4：1 = keyboard enabled, 0=keyboard disabled (via switch)；
- 5：1 = transmit timeout (data transmit not complete)；
- 6：1 = receive timeout (data transmit not complete)；
- 7：1 = even parity rec'd, 0=odd parity rec'd (should be odd)；

除了这些资源外，8042 还有 3 个内部端口：Input Port、Outport Port、Test Port。

这 3 个端口的操作都是通过向 64h 发送命令，然后在 60h 进行读写的方式完成。

其中本文要操作的 A20 Gate 被定义在 Output Port 的 bit 1 上，所以有必要对 Outport Port 的操作及端口定义做一个说明。

- 读 Output Port：向 64h 发送 0d0h 命令，然后从 60h 读取 Output Port 的内容；
- 写 Output Port：向 64h 发送 0d1h 命令，然后向 60h 写入 Output Port 的数据；
- 禁止键盘操作命令：向 64h 发送 0adh；
- 打开键盘操作命令：向 64h 发送 0aeh；

有了这些命令和知识，就可以实现操作 A20 Gate 来从实模式切换到保护模式了。

理论上讲，我们只要操作 8042 芯片的输出端口（64h）的 bit 1，就可以控制 A20 Gate。

但实际上，当我们准备向 8042 的输入缓冲区里写数据时，可能里面还有其它数据没有处理。

所以，要首先禁止键盘操作，同时等待数据缓冲区中没有数据以后，才能真正地去操作 8042 打开或者关闭 A20 Gate。

打开 A20 Gate 的具体步骤如下。（参考 bootasm.S）

1. 等待 8042 Input buffer 为空；
2. 发送 Write 8042 Output Port (P2) 命令到 8042 Input buffer；
3. 等待 8042 Input buffer 为空；
4. 将 8042 Output Port (P2) 得到字节的第 2 位置 1，然后写入 8042 Input buffer。

### 2.5.8 函数堆栈

理解调用栈最重要的两点如下。

1. 栈的结构；
2. EBP 寄存器的作用。

一个函数调用动作可分解为：0 到多个 PUSH 指令（用于参数入栈），一个 CALL 指令。

CALL 指令内部其实还暗含了一个将返回地址（即 CALL 指令下一条指令的地址）压栈的动作（由硬件完成）。

几乎所有本地编译器都会在每个函数体之前插入类似如下的汇编指令。

```c
pushl  %ebp
movl   %esp , %ebp
```

这样在程序执行到一个函数的实际指令前，已经有以下数据顺序入栈。

1. 参数；
2. 返回地址；
3. ebp 寄存器。

```bash
+|  栈底方向       | 高位地址
 |    ...        |
 |    ...        |
 |  参数 3        |
 |  参数 2        |
 |  参数 1        |
 |  返回地址      |
 |  上一层 [ebp]  | <-------- [ebp]
 |  局部变量      |  低位地址
```

这两条汇编指令的含义如下。

- 首先将 ebp 寄存器入栈；
- 然后将栈顶指针 esp 赋值给 ebp；
    - `mov ebp esp` 这条指令表面上看是用 esp 覆盖 ebp 原来的值，其实不然；
    - 因为给 ebp 赋值之前，原 ebp 值已经被压栈（位于栈顶），而新的 ebp 又恰恰指向栈顶；
    - 此时 ebp 寄存器就已经处于一个非常重要的地位，该寄存器中存储着栈中的 1 个地址（原 ebp 入栈后的栈顶）；
    - 从该地址为基准，向上（栈底方向）能获取返回地址、参数值，向下（栈顶方向）能获取函数局部变量值，而该地址处又存储着上一层函数调用时的ebp值；

一般而言。

- ss:[ebp+4] 处为返回地址；
- ss:[ebp+8] 处为第一个参数值（最后一个入栈的参数值，此处假设其占用 4 字节内存）；
- ss:[ebp-4] 处为第一个局部变量；
- ss:[ebp] 处为上一层 ebp 值。

由于 ebp 中的地址处总是 `上一层函数调用时的ebp值`，而在每一层函数调用中，都能通过当时的ebp值 `向上（栈底方向）` 能获取返回地址、参数值，`向下（栈顶方向）` 能获取函数局部变量值。

如此形成递归，直至到达栈底，这就是 **函数调用栈**。

### 2.5.9 中断与异常

操作系统需要对计算机系统中的各种外设进行管理，这就需要 CPU 和外设能够相互通信才行。一般外设的速度远慢于 CPU 的速度。如果让操作系统通过 CPU “主动关心” 外设的事件，即采用通常的轮询 (polling) 机制，则太浪费 CPU 资源了。所以需要操作系统和 CPU 能够一起提供某种机制，让外设在需要操作系统处理外设相关事件的时候，能够 “主动通知” 操作系统，即打断操作系统和应用的正常执行，让操作系统完成外设的相关处理，然后在恢复操作系统和应用的正常执行。在操作系统中，这种机制称为中断机制。

中断机制给操作系统提供了处理意外情况的能力，同时它也是实现进程/线程抢占式调度的一个重要基石。但中断的引入导致了对操作系统的理解更加困难。

在操作系统中，有 3 种特殊的中断事件。

-  异步中断 (asynchronous interrupt) 也称外部中断，简称中断 (interrupt)；
    - 由 CPU 外部设备引起的外部事件，是异步产生的（即产生的时刻不确定），与 CPU 的执行无关；
    - 如 I/O 中断、时钟中断、控制台中断等；
- 同步中断 (synchronous interrupt)，也称内部中断，简称异常 (exception)；
    - 在 CPU 执行指令期间检测到不正常的或非法的条件所引起的内部事件；
    - 如除零错、地址访问越界；
- 陷入中断 (trap interrupt)，也称软中断 (soft interrupt)、系统调用 (system call)，简称 trap。
    - 把在程序中使用请求系统服务的系统调用而引发的事件。

我们重点关注保护模式下的处理过程。

- 当 CPU 收到中断（通过 8259A 完成）或者异常的事件时，它会暂停执行当前的程序或任务；
- 通过一定的机制跳转到负责处理这个信号的相关处理例程中；
- 在完成对这个事件的处理后再跳回到刚才被打断的程序或任务中。

中断向量和中断服务例程的对应关系主要是由 `IDT（中断描述符表）` 负责。

操作系统在 IDT 中设置好各种中断向量对应的中断描述符，留待 CPU 在产生中断后查询对应中断服务例程的起始地址。

而 IDT 本身的起始地址保存在 idtr 寄存器中。

#### 2.5.9.1 Interrupt Descriptor Table

中断描述符表（Interrupt Descriptor Table）把每个中断或异常编号和一个指向中断服务例程的描述符联系起来。

同 GDT 一样，IDT 是一个 8 字节的描述符数组，但 IDT 的第一项可以包含一个描述符。

CPU 把中断（异常）号乘以 8 做为 IDT 的索引。

IDT 可以位于内存的任意位置，CPU 通过 IDT 寄存器（IDTR）的内容来寻址 IDT 的起始地址。

指令 LIDT 和 SIDT 用来操作 IDTR。

2 条指令都有一个显示的操作数：一个 6 字节表示的内存地址，指令的含义如下。

- LIDT（Load IDT Register）指令；
    - 使用 1 个包含线性地址基址和界限的内存操作数来加载 IDT；
    - 操作系统创建 IDT 时需要执行它来设定 IDT 的起始地址；
    - 这条指令只能在特权级 0 执行；
- SIDT（Store IDT Register）指令；
    - 拷贝 IDTR 的基址和界限部分到一个内存地址；
    - 这条指令可以在任意特权级执行。

在保护模式下，最多会存在 256 个 Interrupt/Exception Vectors。

范围 [0，31] 内的 32 个向量被异常 Exception 和 NMI 使用，但当前并非所有这 32 个向量都已经被使用，有几个当前没有被使用的，请不要擅自使用它们，它们被保留，以备将来可能增加新的 Exception。

范围 [32，255] 内的向量被保留给用户定义的 Interrupts。

Intel 没有定义，也没有保留这些 Interrupts。

用户可以将它们用作外部 I/O 设备中断（8259A IRQ），或者系统调用（System Call 、Software Interrupts）等。

关于 IDT gate descriptors。

#### 2.5.9.2 IDT gate descriptors

Interrupts/Exceptions 应该使用 Interrupt Gate 和 Trap Gate。

它们之间的唯一区别如下。

- 调用 Interrupt Gate 时，Interrupt 会被 CPU 自动禁止；
    - 所谓自动禁止，指的是 CPU 跳转到 interrupt gate 里的地址时，在将 EFLAGS 保存到栈上之后，清除 EFLAGS 里的 IF 位，以避免重复触发中断；
    - 在中断处理例程里，操作系统可以将 EFLAGS 里的 IF 设上，从而允许嵌套中断，但必须在此之前做好处理嵌套中断的必要准备，如保存必要的寄存器等；
- 调用 Trap Gate 时，CPU 则不会去禁止或打开中断，而是保留它原来的样子；
    - 在 ucore 中访问 Trap Gate 的目的是为了实现系统调用；
    - 用户进程在正常执行中是不能禁止中断的，而当它发出系统调用后，将通过 Trap Gate 完成了从用户态（ring 3）的用户进程进了核心态（ring 0）的 OS kernel；
    - 如果在到达 OS kernel 后禁止 EFLAGS 里的 IF 位；
        - 没意义（因为不会出现嵌套系统调用的情况）；
        - 还会导致某些中断得不到及时响应；
    - 所以调用 Trap Gate 时，CPU 则不会去禁止中断；
    
Interrupt gate 和 Trap gate 之间没有优先级之分，仅仅是 CPU 在处理中断时有不同的方法，供操作系统在实现时根据需要进行选择。

在 IDT 中，可以包含如下 3 种类型的 Descriptor。

- Task-gate descriptor （本内核没有使用）；
- Interrupt-gate descriptor （中断方式用到）；
- Trap-gate descriptor（系统调用用到）。

#### 2.5.9.3 中断处理中硬件负责完成的工作

中断服务例程包括具体负责处理中断（异常）的代码是操作系统的重要组成部分。

需要注意区别的是，有 2 个过程由硬件完成。

1. 硬件中断处理过程 1（起始）：从 CPU 收到中断事件后，打断当前程序或任务的执行，根据某种机制跳转到中断服务例程去执行的过程，其具体流程如下；
    - CPU 在执行完当前程序的每一条指令后，都会去确认在执行刚才的指令过程中中断控制器（如：8259A）是否发送中断请求过来；
        - 如果有，那么 CPU 就会在相应的时钟脉冲到来时从总线上读取中断请求对应的中断向量；
    - CPU 根据得到的中断向量（以此为索引）到 IDT 中找到该向量对应的中断描述符，中断描述符里保存着中断服务例程的段选择子；
    - CPU 使用 IDT 查到的中断服务例程的段选择子从 GDT 中取得相应的段描述符；
        - 段描述符里保存了中断服务例程的段基址和属性信息，此时 CPU 就得到了中断服务例程的起始地址，并跳转到该地址；
    - CPU 会根据 CPL 和中断服务例程的段描述符的 DPL 信息确认是否发生了特权级的转换；
        - 比如当前程序正运行在用户态，而中断程序是运行在内核态的，则意味着发生了特权级的转换；
    - 这时 CPU 会从当前程序的 TSS 信息（该信息在内存中的起始地址存在 TR 寄存器中）里取得该程序的内核栈地址；
        - 即包括内核态的 ss 和 esp 的值，并立即将系统当前使用的栈切换成新的内核栈；
        - 这个栈就是即将运行的中断服务程序要使用的栈；
    - 紧接着就将当前程序使用的用户态的 ss 和 esp 压到新的内核栈中保存起来；
    - CPU 需要开始保存当前被打断的程序的现场（即一些寄存器的值），以便于将来恢复被打断的程序继续执行；
        - 这需要利用内核栈来保存相关现场信息，即依次压入当前被打断程序使用的 eflags、cs、eip、errorCode（如果是有错误码的异常）信息；
    - CPU 利用中断服务例程的段描述符将其第一条指令的地址加载到 cs 和 eip 寄存器中，开始执行中断服务例程；
        - 这意味着先前的程序被暂停执行，中断服务程序正式开始工作。
2. 硬件中断处理过程 2（结束）：每个中断服务例程在有中断处理工作完成后需要通过 iret（或 iretd）指令恢复被打断的程序的执行，CPU 执行 IRET 指令的具体过程如下。
    - 程序执行这条 iret 指令时，首先会从内核栈里弹出先前保存的被打断的程序的现场信息，即 eflags、cs、eip 重新开始执行；
    - 如果存在特权级转换（从内核态转换到用户态），则还需要从内核栈中弹出用户态栈的 ss 和 esp，这样也意味着栈也被切换回原先使用的用户态的栈了；
    - 如果此次处理的是带有错误码（errorCode）的异常，CPU 在恢复先前程序的现场时，并不会弹出 errorCode；
        - 这一步需要通过软件完成，即要求相关的中断服务例程在调用 iret 返回之前添加出栈代码主动弹出 errorCode。

#### 2.5.9.4 中断处理的特权级转换

中断处理得特权级转换是通过门描述符（gate descriptor）和相关指令来完成的。

1 个门描述符就是 1 个系统类型的段描述符，一共有 4 个子类型。

- 调用门描述符（call-gate descriptor）；
- 中断门描述符（interrupt-gate descriptor）；
- 陷阱门描述符（trap-gate descriptor）；
- 任务门描述符（task-gate descriptor）。

与中断处理相关的是中断门描述符和陷阱门描述符。

这些门描述符被存储在中断描述符表（Interrupt Descriptor Table，简称 IDT）当中。

CPU 把中断向量作为 IDT 表项的索引，用来指出当中断发生时使用哪一个门描述符来处理中断。

中断门描述符和陷阱门描述符几乎是一样的。

门中的 DPL 和段选择符一起控制着访问，同时，段选择符结合偏移量（Offset）指出了中断处理例程的入口点。

内核一般在门描述符中填入内核代码段的段选择子。

产生中断后，CPU 一定不会将运行控制从高特权环转向低特权环，特权级必须要么保持不变（当操作系统内核自己被中断的时候），或被提升（当用户态程序被中断的时候）。

无论哪一种情况，作为结果的 CPL 必须等于目的代码段的 DPL。

如果 CPL 发生了改变，一个堆栈切换操作（通过 TSS 完成）就会发生。

如果中断是被用户态程序中的指令所触发的（比如软件执行 INT n 生产的中断），还会增加一个额外的检查：门的 DPL 必须具有与 CPL 相同或更低的特权。

这就防止了用户代码随意触发中断。

如果这些检查失败，会产生一个一般保护异常（general-protection exception）。

### 2.5.10 控制寄存器

[intel 手册卷三 2.5 Control Registers]()

- **CR0** — 包含系统控制标志，控制处理器的操作模式和状态；
  - **PG**：当置位时，允许页表映射，否则不允许页表映射，此时所有线性地址被看做物理地址；
- **CR1** — 保留；
- **CR2** — 包含  page-fault 线性地址 （造成 page-fault 的线性地址）；
- **CR3** — 包含页目录基址以及两个标志位；
- **CR4** — 包含一组使能几个 CPU 扩展的标志位；

## 2.6 为什么不利用 BIOS 直接加载操作系统？

1. 不同操作系统可能拥有不同的文件系统，BIOS无法编写所有文件系统的解析代码，所以将加载程序作为操作系统的一部分；

2. 让操作系统可以 `定制化` 实现自己的加载程序；

3. 主引导记录和活动分区的存在主要是硬盘分区的原因。

80386 CPU 在加电启动之初，会执行固化在 BIOS 中的程序。

BIOS 由于容量有限，自身不提供加载完整操作系统内核的功能，而是约定好会读取磁盘中第一个扇区(引导扇区)中的内容，将其加载至内存地址空 `0x7c00` 处，在加载完毕后，令 `CS:IP` 指向 `0x7c00`，跳转执行引导扇区中的引导程序的第 1 条指令。

## 2.7 bootasm.S 的实现

在实模式下，段寄存器和 ip 寄存器只提供 16 位的操作空间。

为了寻址 1MB 的内存空间，此时段寄存器存储的基值（16 位，base）会左移四位，加上偏移量（IP 寄存器，offset）作为逻辑地址。

### 2.7.1 关闭中断并设置代码执行方向

bootloader 开始的时候需要关闭中断，以临界段的形式安全执行启动代码。

设置代码向地址递增的方向执行。

```c
# 实模式的起始地址为 0:7c00，为 bootloader 的起始地址；
.globl start
start:
.code16                                             # 指定为 16 位模式；
    cli                                             # 失能中断；
    cld                                             # 代码向地址递增的方向执行；（方向标志位置 0 指令）；
```

### 2.7.2 设置重要数据段寄存器

一开始 CPU 还处于实模式，段机制还未启动，但是将 CPU 转成保护模式之前需要将重要的段寄存器设置好，转换前段寄存器 DS、ES、SS 需置 0。

```c
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
```

### 2.7.3 开启 A20 地址线

在进入保护模式之前，需要开启 A20 地址线，获得 32 位的寻址空间（4GB）。

1. 等待 8042 Input buffer 为空；
2. 发送 Write 8042 Output Port（P2）命令到 8042 Input buffer；
3. 等待 8042 Input buffer 为空；
4. 将 8042 Output Port（P2）得到字节的第 2 位置 1，然后写入 8042 Input buffer；

```c
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
```

### 2.7.4 载入 GDTR

接下来载入 GDTR（GDT 的大小和基地址），初始化全局描述符表。

这里需要用到 32 位控制寄存器。

- CR0
    - 包含了 6 个预定义标志；
    - 0 位是 `保护允许位 PE (Protedted Enable)`；
        - 用于启动保护模式；
        - PE = 1，保护模式启动；
        - PE = 0，在实模式下运行；
    - 1 位是 `监控协处理位 MP (Moniter coprocessor)`；
        - 它与第 3 位一起决定；
        - TS = 1，操作码 WAIT 产生一个协处理器不能使用的出错信号；
    - 2 位是 `模拟协处理器位 EM (Emulate coprocessor)`；
        - EM = 1，不能使用协处理器；
        - EM = 0，允许使用协处理器；
    - 3 位是 `任务转换位 (Task Switch)`；
        - 当一个任务转换完成之后，自动将它置 1；
        - TS = 1，就不能使用协处理器；
    - 4 位是 `微处理器的扩展类型位 ET (Processor Extension Type)`；
        - 其内保存着处理器扩展类型的信息；
        - ET = 0，标识系统使用的是 287 协处理器；
        - ET = 1，表示系统使用的是 387 浮点协处理器；
    - 31 位是 `分页允许位(Paging Enable)`；
        - 它表示芯片上的分页部件是否允许工作。
- CR1
    - 未定义的控制寄存器，供将来的处理器使用；
- CR2
    - 页故障线性地址寄存器，保存最后一次出现页故障的全 32 位线性地址；
- CR3
    - 页目录基址寄存器，保存页目录表的物理地址；
    - 页目录表总是放在以 4K 字节为单位的存储器边界上；
    - 它的地址的低12位总为0，不起作用，即使写上内容，也不会被理会。

这几个寄存器中保存 `全局性` 和 `任务无关` 的机器状态。

这几个寄存器是与 `分页机制` 密切相关的，因此，在进程管理及虚拟内存管理中会涉及到这几个寄存器，要记住 CR0、CR2、CR3 这 3 个寄存器的内容。

gdt 的引导程序如下。

```c
# GDTR 引导程序；
.p2align 2                                          # 强制 4 字节对齐；
gdt:                                                # #标识符，表示地址；
    SEG_NULLASM                                     # 第一段永远为 0，不用；
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel

gdtdesc:                                            # GDTR 寄存器，用 lgdt 加载；
    .word 0x17                                      # sizeof(gdt) - 1
    .long gdt                                       # address gdt
```

通过 `SEG_ASM` 设置全局描述符，只是简单的为内核的代码加载初始化 GDT 而已。

启动保护模式的程序如下。

```c
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
```

### 2.7.5 初始化段寄存器和 BIOS 的数据栈并跳转到 bootmain

通过段选择子跳转到内核代码开始的位置设置。

- DS、ES、FS、GS、SS；
- BIOS 的数据栈位 `0-0x7c00`；
    - ebp: 0
    - esp: 0x7c00

将数据段选择上之后，设置堆栈并跳转到 bootmain 中。

```c
.code32                                             # 汇编 32 位模式；
protcseg:
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

    movw $PROT_MODE_DSEG, %ax                       # 数据段选择器；
    movw %ax, %ds                                   # -> DS：数据段 (Data Segment)；
    movw %ax, %es                                   # -> ES：附加数据段 (Extra Segment)；
    movw %ax, %fs                                   # -> FS：附加段；
    movw %ax, %gs                                   # -> GS：附加段；
    movw %ax, %ss                                   # -> SS：堆栈段 (Stack Segment)；

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

    movl $0x0, %ebp                                 # 清空当前线程栈底指针；
    movl $start, %esp                               # 将 start 放到栈顶；
    call bootmain                                   # 调用 bootmain 函数；

    # bootmain 返回的地方，实际上不会执行到这里，若执行到此处则循环；
spin:
    jmp spin
```

## 2.8 bootmain.c 的实现

[JOS lab1 boot 加载操作系统](https://blog.csdn.net/Poundssss/article/details/50927974)

[MIT 6.828 学习笔记2 阅读main.c](https://blog.csdn.net/scnu20142005027/article/details/51150601)

- 一切准备工作就绪后，调用 C 文件 bootmain.c 中的函数 bootmain 继续执行以至可以加载操作系统内核；
- bootmain 负责将内核加载到内存 0x10000 处，并检查是否为合法的 ELF 文件。

### 2.8.1 读取磁盘第 1 页来获得 ELFHDR 的数据

定义一个暂存空间 `ELFHDR`，从地址 `0x10000` 开始，使用一个 elf 文件头部的结构体指针来指向该段区域。

```c
#define ELFHDR          ((struct elfhdr *)0x10000) 
```

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

首先进行数据的读取。

```c
/* 
 * 函数功能：bootloader 的入口；
 */
void
bootmain(void) {
    // 读取磁盘第 1 页来获得 ELFHDR 的数据；
    // 读取 4K 的数据；
    readseg((uintptr_t)ELFHDR, SECTSIZE * 8, 0);

    ...
}
```

其具体实现如下。

```c
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
```

内部读取扇区的实现如下。

```c
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
```

这 2 个函数中，比较令人疑惑的是 `0x1F2` 到 `0x1F7` 代表什么，还有为什么要写入 `offset`。

先来看看关于 ATA 和 LBA 的资料（这里的寻址方式应该是 28-bit LBA）。

- 0x1F0 R/W，数据寄存器；
- 0x1F0 R/W，错误诊断寄存器；
- 0x1F2 R/W，扇区数寄存器，记录操作的扇区数；
- 0x1F3 R/W，扇区号寄存器，记录操作的起始扇区号；
- 0x1F4 R/W，柱面号寄存器，记录柱面号的低 8 位；
- 0x1F5 R/W，柱面号寄存器，记录柱面号的高 8 位；
- 0x1F6 R/W，驱动器/磁头寄存器，记录操作的磁头号，驱动器号，和寻道方式；
    -   前 4 位代表逻辑扇区号的高 4 位；
    -   DRV = 0/1 代表主/从驱动器；
    -   LBA = 0/1 代表 CHS/LBA 方式；
- 0x1F7 R，状态寄存器，第 6、7 位分别代表驱动器准备好，驱动器忙；
- 0x1F8 W，命令寄存器，0x20 命令代表读取扇区；

ucore 这里的和该资料有一点区别，`0x1F7` 是命令寄存器，其他信息基本一致。

### 2.8.2 检查 ELF 的有效性

通过比对 ELFHDR 中 e_magic 字段的数值是否为 `0x464C457FU` 来判断 ELF 文件的有效性。

magic number 可以理解为识别文件类型的一段标识。

```c
#define ELF_MAGIC    0x464C457FU            // "\x7FELF" in little endian

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
}
```

如果无效，则使用 goto 语句跳转到 bad 函数，阻塞在这里。

```c
void
bootmain(void) {
    ...
bad:
    outw(0x8A00, 0x8A00);
    outw(0x8A00, 0x8E00);

    // 空循环，将程序阻塞在这里；
    while (1);
}
```

### 2.8.3 读取剩下的内核程序

ELF 文件的具体结构如下。

![ELF 文件](https://img-blog.csdnimg.cn/20210402144510536.png)

可以利用 `objdump -p kernel` 命令来查看内核程序中的 program header 条目。

```bash
moocos-> objdump -p kernel

kernel:     file format elf32-i386

Program Header:
    LOAD off    0x00001000 vaddr 0x00100000 paddr 0x00100000 align 2**12
         filesz 0x0000d6a9 memsz 0x0000d6a9 flags r-x
    LOAD off    0x0000f000 vaddr 0x0010e000 paddr 0x0010e000 align 2**12
         filesz 0x00000a16 memsz 0x00001d80 flags rw-
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
         filesz 0x00000000 memsz 0x00000000 flags rwx
```

第 1 段与第 1 段都是 4KB 对齐的，1 个扇区是 512KB，也就是占了 8 个扇区，而这两段也就是上面结构图中两个大括号表示的那 2 段。

第 2 段的 filesz 与 memsz 是不相同的，这是因为 .bss 节中的全局变量在文件中不占空间，在内存中才分配空间并初始化。

```c
void
bootmain(void) {
    ...

    // 加载每个程序段（忽略 ph 标志）；
    // 指向内核程序 program header table 头部；
    ph = (struct proghdr *)((uintptr_t)ELFHDR + ELFHDR->e_phoff);
    // 指向内核程序 program header table 尾部；
    eph = ph + ELFHDR->e_phnum;

    for (; ph < eph; ph ++) {
        // 逐段将内核程序读入内存；
        readseg(ph->p_va & 0xFFFFFF, ph->p_memsz, ph->p_offset);
    }

    ...
}
```

### 2.8.4 跳转到内核程序

```c
void
bootmain(void) {
    ...

    // 从 ELF 的头部信息中找到内核起始点的函数地址；
    // 运行之后不再返回；
    ((void (*)(void))(ELFHDR->e_entry & 0xFFFFFF))();

    ...
}
```

## 2.9 生成 kernel

### 2.9.1 Makefile 实现

建立一个伪目标 kernel 来生成 kernel。

Makefile 的核心代码如下。

```makefile
KINCLUDE	+= kern/debug/ \
			   kern/driver/ \
			   kern/trap/ \
			   kern/mm/

KSRCDIR		+= kern/init \
			   kern/libs \
			   kern/debug \
			   kern/driver \
			   kern/trap \
			   kern/mm

KCFLAGS		+= $(addprefix -I,$(KINCLUDE))

$(call add_files_cc,$(call listf_cc,$(KSRCDIR)),kernel,$(KCFLAGS))

KOBJS	= $(call read_packet,kernel libs)

# create kernel target
kernel = $(call totarget,kernel)

$(kernel): tools/kernel.ld

$(kernel): $(KOBJS)
	@echo + ld $@
	$(LD) $(LDFLAGS) -T tools/kernel.ld -o $@ $(KOBJS)
	$(OBJDUMP) -S $@ > $(call asmfile,kernel)
	$(OBJDUMP) -t $@ | $(SED) '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(call symfile,kernel)

$(call create_target,kernel)
```

运行的结果如下。

```bash
ld -m    elf_i386 -nostdlib -T tools/kernel.ld -o bin/kernel  obj/kern/init/init.o obj/kern/libs/stdio.o obj/kern/libs/readline.o obj/kern/debug/panic.o obj/kern/debug/kdebug.o obj/kern/debug/kmonitor.o obj/kern/driver/clock.o obj/kern/driver/console.o obj/kern/driver/picirq.o obj/kern/driver/intr.o obj/kern/trap/trap.o obj/kern/trap/vectors.o obj/kern/trap/trapentry.o obj/kern/mm/pmm.o  obj/libs/string.o obj/libs/printfmt.o
objdump -S bin/kernel > obj/kernel.asm
objdump -t bin/kernel | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$/d' > obj/kernel.sym
```

ld 将各个静态库进行连接，使用脚本 kernel.ld 中的规则快速生成了 kernel。

使用 objdump 将 kernel 的信息反汇编到了 kernel.asm、kernel.sym 便于学习。

### 2.9.2 ld 链接的规则

[u-boot链接脚本解析](https://blog.csdn.net/shanzhizi/article/details/9112765)

[MIT6.828 Lab1 Part3 The kernel Exercise 12](https://blog.csdn.net/qq_43012789/article/details/107494408)

#### 2.9.2.1 编译连接脚本

通过 kernel.ld 脚本传入 ld 中进行了链接，生成了 kernel 可执行程序。

这里重点关注 kernel.ld 文件对整个程序的组织。

kernel.ld 链接脚本用来描述输出文件的内存布局。

GNU 编译器生成的目标文件缺省为 elf 格式，elf 文件由若干段（section）组成，如不特殊指明，由 C 源程序生成的目标代码中包含如下段。

- .text (正文段) 
    - 包含程序的指令代码；
- .data (数据段)
    - 包含固定的数据，如常量、字符串；
- .bss (未初始化数据段)
    - 包含未初始化的变量、数组等；

C++ 源程序生成的目标代码中还包括如下。

- .fini (析构函数代码)
- .init (构造函数代码)
- 其他

链接器的任务就是将多个目标文件的 .text、.data、.bss 等段连接在一起，而连接脚本文件是告诉链接器从什么地址开始放置这些段。

由于一个工程中有多个 .c 文件，当它们生成 .o 文件后，如何安排它们在可执行文件中的顺序，这就是链接脚本的作用。

gcc 等编译器内置有缺省的连接脚本。

采用缺省脚本，生成的目标代码需要操作系统才能加载运行。

对于 uboot 和 kernel 这种需要在嵌入式系统上直接运行的程序，就不能使用编译器缺省脚本，而必须由我们编写连接脚本来进行链接。

#### 2.9.2.2 arm 程序的加载时域和运行时域

- 程序的加载时域：指程序被加载到什么地方、是 SDRAM 还是 nor flash；
- 运行时域是指程序执行时的地址。

镜像文件 `ucore.img` 的组成包含 `加载时域` 和 `运行时域`。

加载时域包含 RO、RW 段。

运行时域包含 RO、RW、ZI 3 个段。

其中 RO、RW 段的内容在加载时和运行时是一样的，但存储空间可能不同。

ZI 段是运行时由初始化函数创建的。

代码、数据和变量在镜像文件中的位置如下。

- 代码：一般是只读的，由编译器分配存储空间并放置镜像文件的 RO 段；

- 数据：这里的数据指常量、指针常量，它们属于只读数据、由编译器分配存储空间放在镜像文件的 RO 段；

- 变量：主要根据生存期划分；
    - 全局变量和静态变量：由编译器分配存储空间，已初始化的放到 RW 段、未初始化的放置 ZI 段；
    - 动态变量：局部变量，占用栈空间。

#### 2.9.2.3 编译地址与运行地址

- 地址无关: 编译地址不等于运行地址；
- 地址相关: 编译地址等于运行地址。

常见的一些 Boot (如 U-Boot、VIVI) 和 Linux Kernel 代码开始的一段是位置无关的。

意思就是说运行地址与编译地址无关。如：Kernel编译地址是 `0xc0008000`，而运行地址是 `0x30008000`。

为什么代码的编译地址和运行地址会不相等呢？

1. 对于 Boot，用于存放 Boot 代码的存储器容量小于代码量；
    - 如, Boot 片有 4K，而代码通常有 50-60K；
    - 通常会在前 4K 代码里，让 Boot 把自己复制到RAM，再接着运行；
    - 我们会选择前面一段代码量小的与地址无关；

2. 对于 Linux Kernel，它是运行在虚拟地址空间的，如 `0xc0008000`；
    - 在 MMU 打开之前，通常这个地址是不存在的；
    - 即，在 MMU 打开之前，Kernel 的代码必须是地址无关的。

怎么办？

对于位置无关的代码，寻址是基于 pc 值的, 在 pc 值上 +/- 一个偏移值，得到运行地址。

以 ARM 为例，用 adr 来寻址，adr 实际上是一个伪指令，在代码编译时，会被编译器替换成对 pc 的 +/- 运算。

对 pc 的 +/- 运行显然是有一个地址范围的，所以我们在上面选择代码量小的地址无关，是很明智的。

而访问地址相关的代码，只需要使用其它的寻址指令就行了。

但在这之前，必须保证代码被放在正确的地址上，所以通常都会有一个复制代码的过程，然后就是跳转到一个标号，地址相关代码就开始运行了。

### 2.9.3 kernel.ld 文件解析

[GNU官方网站上对 .lds 文件形式的完整描述](http://www.gnu.org/software/binutils/manual/ld-2.9.1/html_node/ld_21.html)

```ld
/* 查看 GNU 的 ld info 手册 (`info ld`) 来学习其语法； */

/* 指定输出的可执行文件格式为：elf32-i386； */
OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")

/* 指定输出可执行文件所运行 CPU 平台为 i386； */
OUTPUT_ARCH(i386)

/* 指定可执行文件的入口段为：kern_init； */
ENTRY(kern_init)

/* 段定义； */
SECTIONS {
	/* 以 0x100000 为地址来加载内核， . 符号代表当前地址； */
	. = 0x100000;

	/* 将所有静态库中的 text 正文段包含到当前的正文段中； */
	.text : {
		*(.text .stub .text.* .gnu.linkonce.t.*)
	}

	/* 为该值定义 etext 符号； */
	/* PROVIDE 关键字用于定义一个符号，仅仅是一个引用而不是定义； */
	PROVIDE(etext = .);	

	/* 指定只读数据段； */
	.rodata : {
		*(.rodata .rodata.* .gnu.linkonce.r.*)
	}

	/* 在内核代码的内存中包含调试信息； */
	.stab : {
		PROVIDE(__STAB_BEGIN__ = .);
		*(.stab);
		PROVIDE(__STAB_END__ = .);

		/* 强制链接器为该节分配空间； */
		BYTE(0)		
	}

	.stabstr : {
		PROVIDE(__STABSTR_BEGIN__ = .);
		*(.stabstr);
		PROVIDE(__STABSTR_END__ = .);

		/* 强制链接器为该节分配空间； */
		BYTE(0)		
	}

	/* 按页对齐，将数据段的地址调整到下一页； */
	/* 代码以 0x1000 4KB 对齐；*/
	. = ALIGN(0x1000);

	/* 将所有静态库中的 data 数据段包含到当前的正文段中； */
	.data : {
		*(.data)
	}

	PROVIDE(edata = .);

	/* 将所有静态库中的 bss 未初始化数据段包含到当前的正文段中； */
	.bss : {
		*(.bss)
	}

	PROVIDE(end = .);

	/DISCARD/ : {
		*(.eh_frame .note.GNU-stack)
	}
}
```

### 2.9.4 操作系统镜像文件 ucore.img 生成的步骤

运行 `make "V="` 显示整个编译过程中的信息。

```shell
# 编译 init.c 文件，生成 init.o 
+ cc kern/init/init.c
gcc -Ikern/init/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/init/init.c -o obj/kern/init/init.o

# 编译 stdio.c 文件，生成 stdio.o
+ cc kern/libs/stdio.c
gcc -Ikern/libs/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/libs/stdio.c -o obj/kern/libs/stdio.o

# 编译 readline.c 文件，生成 readline.o
+ cc kern/libs/readline.c
gcc -Ikern/libs/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/libs/readline.c -o obj/kern/libs/readline.o

# 编译 panic.c 文件，生成 painc.o
+ cc kern/debug/panic.c
gcc -Ikern/debug/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/panic.c -o obj/kern/debug/panic.o

# 编译 kdebug.c 文件，生成 kdebug.o
+ cc kern/debug/kdebug.c
gcc -Ikern/debug/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/kdebug.c -o obj/kern/debug/kdebug.o

# 编译 kmonitor.c 文件，生成 kmonitor.o
+ cc kern/debug/kmonitor.c
gcc -Ikern/debug/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/debug/kmonitor.c -o obj/kern/debug/kmonitor.o

# 编译 clock.c 文件，生成 clock.o
+ cc kern/driver/clock.c
gcc -Ikern/driver/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/clock.c -o obj/kern/driver/clock.o

# 编译 console.c 文件，生成 console.o
+ cc kern/driver/console.c
gcc -Ikern/driver/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/console.c -o obj/kern/driver/console.o

# 编译 picirq.c 文件，生成 picirq.o
+ cc kern/driver/picirq.c
gcc -Ikern/driver/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/picirq.c -o obj/kern/driver/picirq.o

# 编译 intr.c 文件，生成 intr.o
+ cc kern/driver/intr.c
gcc -Ikern/driver/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/driver/intr.c -o obj/kern/driver/intr.o

# 编译 trap.c 文件，生成 trap.o
+ cc kern/trap/trap.c
gcc -Ikern/trap/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/trap.c -o obj/kern/trap/trap.o

# 编译 vectors.S 生成 vectors.o
+ cc kern/trap/vectors.S
gcc -Ikern/trap/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/vectors.S -o obj/kern/trap/vectors.o

# 编译 trapentry.S 生成 trapentry.o
+ cc kern/trap/trapentry.S
gcc -Ikern/trap/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/trap/trapentry.S -o obj/kern/trap/trapentry.o

# 编译 pmm.c 生成 pmm.o
+ cc kern/mm/pmm.c
gcc -Ikern/mm/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Ikern/debug/ -Ikern/driver/ -Ikern/trap/ -Ikern/mm/ -c kern/mm/pmm.c -o obj/kern/mm/pmm.o

# 编译 string.c 生成 string.o
+ cc libs/string.c
gcc -Ilibs/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/  -c libs/string.c -o obj/libs/string.o

# 编译 printfmt.c 生成 printfmt.o
+ cc libs/printfmt.c
gcc -Ilibs/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/  -c libs/printfmt.c -o obj/libs/printfmt.o

# 链接生成的所有目标文件，并生成 kernel 二进制文件
+ ld bin/kernel
ld -m    elf_i386 -nostdlib -T tools/kernel.ld -o bin/kernel  obj/kern/init/init.o obj/kern/libs/stdio.o obj/kern/libs/readline.o obj/kern/debug/panic.o obj/kern/debug/kdebug.o obj/kern/debug/kmonitor.o obj/kern/driver/clock.o obj/kern/driver/console.o obj/kern/driver/picirq.o obj/kern/driver/intr.o obj/kern/trap/trap.o obj/kern/trap/vectors.o obj/kern/trap/trapentry.o obj/kern/mm/pmm.o  obj/libs/string.o obj/libs/printfmt.o

# 编译 bootasm.S / bootmain.c / sign.c / 
+ cc boot/bootasm.S
gcc -Iboot/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootasm.S -o obj/boot/bootasm.o
+ cc boot/bootmain.c
gcc -Iboot/ -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc  -fno-stack-protector -Ilibs/ -Os -nostdinc -c boot/bootmain.c -o obj/boot/bootmain.o
+ cc tools/sign.c
gcc -Itools/ -g -Wall -O2 -c tools/sign.c -o obj/sign/tools/sign.o

# 生成 sign 文件
gcc -g -Wall -O2 obj/sign/tools/sign.o -o bin/sign

# 链接生成 bootblock 二进制文件
+ ld bin/bootblock
ld -m    elf_i386 -nostdlib -N -e start -Ttext 0x7C00 obj/boot/bootasm.o obj/boot/bootmain.o -o obj/bootblock.o
'obj/bootblock.out' size: 488 bytes
build 512 bytes boot sector: 'bin/bootblock' success!

# 生成ucore.img 文件
dd if=/dev/zero of=bin/ucore.img count=10000
10000+0 records in
10000+0 records out
5120000 bytes (5.1 MB, 4.9 MiB) copied, 0.0242314 s, 211 MB/s
dd if=bin/bootblock of=bin/ucore.img conv=notrunc
1+0 records in
1+0 records out
512 bytes copied, 9.9196e-05 s, 5.2 MB/s
dd if=bin/kernel of=bin/ucore.img seek=1 conv=notrunc
146+1 records in
146+1 records out
74828 bytes (75 kB, 73 KiB) copied, 0.000607019 s, 123 MB/s
```

### 2.9.5 gcc 编译选项详解

[编译选项](https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html#C-Dialect-Options)

| 编译选项                |                             含义                              |
| :--------------------- | :----------------------------------------------------------: |
| `-I`                   | 指定库文件包含路径（① 指定值 ② 环境变量 ③ 标准系统搜索路径） |
| `-fno-builtin`         | 只识别以 `__builtin_`为前缀的 GCC 內建函数，禁用大多数內建函数，防止与其重名 |
| `-Wall`                | 编译后显示所有[警告信息](https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#Warning-Options) |
| `-ggdb`                | 使用 GDB 加入[调试信息](https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html#Debugging-Options) |
| `-m32`                 | 生成 32位机器代码,`int long pointer` 都是 32 位，指定[x86处理器特定选项](https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html#x86-Options)， [处理器依赖选项](https://gcc.gnu.org/onlinedocs/gcc/Submodel-Options.html#Submodel-Options) |
| `-gstabs`              |          产生 stabs 格式的调试信息，不包含 GDB 扩展          |
| `-nostdinc`            | 不搜索标准系统目录的头文件，只搜索 `-I / -iquote / -isystem / -dirafter`指定的头文件， [目录选项](https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html#Directory-Options) |
| `-fno-stack-protector` | 禁用堆栈保护机制，[工具选项](https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html#Instrumentation-Options) |
| `-c`                   | 编译或汇编源文件，但是不进行链接。将`.c/.i/.s`等后缀的文件编译成 `.o` 后缀。[输出类型控制](https://gcc.gnu.org/onlinedocs/gcc/Overall-Options.html#Overall-Options) |
| `-O`                   | 优化生成的代码，`-Os` 仅仅是优化生成代码的大小，它开启了所有的`-O2`优化选项，除了那些会使代码尺寸增大的选项。 [优化选项](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html#Optimize-Options) |

### 2.9.6 ld 链接选项详解

[链接选项](https://sourceware.org/binutils/docs-2.31/ld/Options.html#Options)

| 编译选项                              |                             含义                             |
| ------------------------------------- | :----------------------------------------------------------: |
| `-m`                                  | 指定生成文件的格式，默认使用 `LDEMULATION`环境变量，如果没有这个环境变量，则依赖与linker 的默认配置。通过 `ld -V` 可以查看它支持的 `emulation`。 |
| `-nostdlib`                           | 只搜索命令行中显示制定的库目录，链接脚本里面制定的目录被忽略，包括命令行中制定的链接脚本。 |
| `-N`                                  | 设置 `text and data section` 可读写，数据段不进行页对其，不链接动态链接库 |
| `-e entry`                            |       指定程序开始执行的入口函数，而不是默认的入口点。       |
| `-Tbss=org / -Tdata=org / -Ttext=org` |    通过 `org` 制定一个 `section` 在输出文件中的绝对地址。    |
|                                       |                                                              |

### 2.9.7 dd 磁盘维护命令详解

[磁盘维护命令](http://www.runoob.com/linux/linux-comm-dd.html)

Linux dd 命令用于读取、转换并输出数据。

dd 可从标准输入或文件中读取数据，根据指定的格式来转换数据，再输出到文件、设备或标准输出。

- if = 文件名：输入文件名，缺省为标准输入。
- of = 文件名：输出文件名，缺省为标准输出。
  - ibs = bytes：一次读入bytes个字节，即指定一个块大小为bytes个字节。（默认 512 字节）
  - obs = bytes：一次输出bytes个字节，即指定一个块大小为bytes个字节。（默认 512 字节）
  - bs = bytes：同时设置读入/输出的块大小为bytes个字节。
  - cbs = bytes：一次转换bytes个字节，即指定转换缓冲区大小。
- skip = blocks：从输入文件开头跳过blocks个块后再开始复制。
- seek = blocks：从输出文件开头跳过blocks个块后再开始复制。
- count = blocks：仅拷贝blocks个块，块大小等于ibs指定的字节数。
- conv = <关键字>，关键字可以有以下11种：
  - conversion：用指定的参数转换文件。
  - ascii：转换ebcdic为ascii
  - ebcdic：转换ascii为ebcdic
  - ibm：转换ascii为alternate ebcdic
  - block：把每一行转换为长度为cbs，不足部分用空格填充
  - unblock：使每一行的长度都为cbs，不足部分用空格填充
  - lcase：把大写字符转换为小写字符
  - ucase：把小写字符转换为大写字符
  - swab：交换输入的每对字节
  - noerror：出错时不停止
  - notrunc：不截短输出文件
  - sync：将每个输入块填充到ibs个字节，不足部分用空（NUL）字符补齐。

> N and BYTES may be followed by the following multiplicative suffixes:
> c =1, w =2, b =512, kB =1000, K =1024, MB =1000*1000, M =1024*1024, xM =M
> GB =1000*1000*1000, G =1024*1024*1024, and so on for T, P, E, Z, Y.

### 2.9.8 输入输出重定向

对于输出重定向，`2` 和 `>` 之间 **不能有空格**。

```shell
i386-elf-objdump -i 2 > test
cat test
```

上述结果输出为空。

```shell
i386-elf-objdump -i 2> test
cat test
#或者
i386-elf-objdump -i 2>test
cat test
```

上述输出结果为`i386-elf-objdump: command not found`

### 2.9.9 2>&1 和 1>&2

运行下列代码，可以看出区别：

- 2 表示 stderr；
- 1 表示 stdout。

```
i386-elf-objdump -i >test 2>&1
cat test
### 输出结果为：i386-elf-objdump: command not found

i386-elf-objdump -i >test 1>&2
cat test
### 输出结果为：<空>
```

- `2>&1`：表示将 `1` 的结果合并到 `2` 里面；
- `1>&2`：表示讲 `2` 的结果合并到 `1` 里面。

### 2.9.10 Makefile 的函数

#### 2.9.10.1 value 函数

`value` 函数提供了一种在不对变量进行展开的情况下获取变量值的方法。

> 语法：`$(value VARIABLE)`
> 功能：**不对变量 `VARIABLE` 进行任何展开操作**，直接返回变量 `VARIABLE` 的值。返回 `VARIABLE` 的值，它是一个变量名，一般不包含 `$` （除非计算的变量名）。
> 返回值：变量 `VARIABLE` 定义的文本值。

示例如下。

```makefile
FOO = $PATH
BAR = $(PATH)

first_second = Hello
a = first
b = second
c = $($a_$b)

all:
	@echo "1: $(FOO)"
	@echo "2: $(value FOO)"
	@echo "3: $(BAR)"
	@echo "4: $(value FOO)"
	@echo "5: $(c)"
	echo $(value c)
	$(info $(value FOO))
```

输出结果为：

```shell
1: ATH
2: /home/monster/bin:/home/monster/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
3: /home/monster/bin:/home/monster/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
4: /home/monster/bin:/home/monster/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
5: Hello
echo $($a_$b)
$PATH
```

第 1 行为：`ATH`。这是因为变量 `FOO` 定义为 `$PATH`，所以展开为 `ATH` （ `$P` 为空）。

第 2 行才是我们需要显示的系统环境变量 `PATH` 的值（value 函数得到变量 `FOO` 的值为 `$PATH`）。

#### 2.9.10.2 eval 函数

函数 `eval` 会对它的参数进行展开，展开的结果可以包含一个新变量、目标、隐含规则或者明确规则，展开结果作为 `makefile` 的一部分。

此函数的主要功能是根据其参数的关系、结构，对它们进行替换展开。

eval 函数执行时会对它的参数进行 2 次展开。

- 第 1 次展开过程是由 **函数本身完成** 的；
- 第 2 次是函数展开后的结果被作为 Makefile 内容时由 **make解析时展开** 的。

明确这一过程对于使用 eval 函数非常重要。

理解了函数 eval 二次展开的过程后，实际使用时，如果在函数的展开结果中存在引用（格式为：\$(x)），那么在函数的参数中应该使用 $$ 来代替 $。

因为这一点，所以通常它的参数中会 **使用函数 value 来取一个变量的文本值**。（文本值 vs 展开值）

示例如下。

```makefile
OBJ=a.o b.o c.o d.o main.o

define MA
main:$(OBJ)
	gcc -g -o main $$(OBJ)
endef

$(info $(call MA))
$(eval $(call MA))
```

运行如下命令。

```shell
touch a.c b.c c.c d.c main.c
make
```

得到如下结果。

```shell
main:a.o b.o c.o d.o main.o
	gcc  -g -o main $(OBJ)

cc    -c -o a.o a.c
cc    -c -o b.o b.c
cc    -c -o c.o c.c
cc    -c -o d.o d.c
cc    -c -o main.o main.c

gcc  -g -o main a.o b.o c.o d.o main.o
# 忽略后面的错误提示
```

从结果看出，第 1 次执行调用展开，在整个 makefile 调用代码中去掉了一个 `$` （即全部都进行了 1 次展开）。

接着看下面一个示例。

```makefile
pointer := pointed_value

define foo 
var := 123
arg := $1
$$($1) := ooooo
endef 
  
$(info $(call foo,pointer))
#$(eval $(call foo,pointer))
 
target:
	@echo -----------------------------
	@echo var: $(var), arg: $(arg)
	@echo pointer: $(pointer), pointed_value: $(pointed_value)
	@echo done.
	@echo -----------------------------
```

> 注意 `target` 下面的命令必须使用 `Tab` 开始，不能有空格开始，否则，由于里面有 `:`，在运行 `make` 的时候会提示 `*** multiple target patterns.  Stop.`

运行结果如下。

```shell
var := 123
arg := pointer
$(pointer) := ooooo
-----------------------------
var: , arg:
pointer: pointed_value, pointed_value:
done.
-----------------------------
```

`info` 函数只是将 `$(call foo,pointer)` 的返回值，也就是替换后的代码段，打印到标准输出，而并没有执行代码段，因此上述的各个值均为空。

`$(call foo, pointer)` 就是 makefile 对`foo`函数进行第一次求值，求值结果仍然是 makefile 代码段。

那么问题就来了，**既然求值出来的结果还是 Makefile 代码，那这段代码又要怎么运行呢？答案就是再包一个 eval, 所以 eval 就是第二次求值了**。

将上面的注释信息进行调整（注释掉 `info`，取消 `eval` 的注释），可以看到如下结果：

```shell
-----------------------------
var: 123, arg: pointer
pointer: pointed_value, pointed_value: ooooo
done.
-----------------------------
```

> 说明：在makefile中，一个 `$()` 表示引用变量里面的值，而 `$$` 表示的是一个单独的 `$` 符号。可以看成序列 `$1`，`$2`，`$3`...`$$`，相当于转义字符。

### 2.9.11 Order-Only 前提条件

makefile 中的生成规则格式为：

```makefile
target : normal-prerequisites | order-only-prerequisites
[TAB]command1
[TAB]command2
[TAB]...
[TAB]commandN
```

正常前提条件的作用如下。

- 在 `target` 目标下的命令被执行前，所有 `正常前提条件` 的生成命令都需要被执行；
- 任何一个前提目标 `normal-prerequisites` 比生成目标 `target` 新时，生成目标都被认为太旧而需要被重新生成。

命令前提条件的作用：

- 执行某个或某些规则，不引起生成目标被重新生成。

示例如下：

```makefile
LIBS=lib.c
foo: foo.c | $(LIBS)
	touch foo
	@echo "order"
```

运行如下过程：

```shell
touch foo.c lib.c
make
vim lib.c #修改 lib.c 的内容
make
vim foo.c #修改 foo.c 的内容
make
```

会得到如下结果：

```shell
---第一次make---
touch foo
order

---第二次make---
make: 'foo' is up to date.

---第三次make---
touch foo
order
```

可以看到 `lib.c` 的修改不会影响 `foo` 的重新生成。

## 2.10 基本 kernel 的启动过程

当 bootloader 通过读取硬盘扇区把 ucore 在系统加载到内存后，就转跳到 ucore 操作系统在内存中的入口位置（`kern/init.c` 中的 `kern_init` 函数的起始地址），这样 `ucore` 就接管了整个系统控制权。

当前的 ucore 只完成了基本的 `内存管理`、`外设中断管理` 功能。

- 初始化终端；
- 显示字符串；
- 显示堆栈中的多层函数调用关系；
- 切换到保护模式，启用分段机制；
- 初始化中断控制器，设置中断描述符表，初始化时钟中断，使能整个系统的中断机制；
- 执行 while（1）死循环。

ucore 启动后的物理内存布局如下。

![内存分布](https://img-blog.csdnimg.cn/20210405012701866.jpg#pic_center)

> 一个好问题：为什么上面操作的 0x1000000、ph->p_va 明明是虚拟地址，却和上图的物理地址一样呢？

先理解段机制。

访问一段数据，代码会给出一个32位地址，这是一个虚拟地址。

ds 寄存器作为段选择子去 GDT 找到对应的段描述符。

段描述符的 base 加上这个虚拟地址（offset）就是线性地址。

未开启分页时，线性地址 = 物理地址。

在 lab1 中，未开启分页，数据段描述符的 base 是0，0 加上 offset（虚拟地址）等于线性地址，所以虚拟地址 = 物理地址。

现在已经开启了段寻址，而且虚拟地址 = 线性地址 = 物理地址。

### 2.10.1 从 CPU 加电后执行的第 1 条指令开始单步跟踪 BIOS 的执行

```
make debug-nox
i r
x /2i 0xffff0 （CS:IP = 0xffff0
x /10i 0xfe05b (0xfe05b是BIOS跳转的地址)
```

指令 `i r` 的结果如下。

```shell
0x0000fff0 in ?? ()
(gdb) i r
eax            0x0	0
ecx            0x0	0
edx            0x663	1635
ebx            0x0	0
esp            0x0	0x0
ebp            0x0	0x0
esi            0x0	0
edi            0x0	0
eip            0xfff0	0xfff0
eflags         0x2	[ ]
cs             0xf000	61440
ss             0x0	0
ds             0x0	0
es             0x0	0
fs             0x0	0
gs             0x0	0
(gdb) x /2i 0xffff0
   0xffff0:	ljmp   $0x3630,$0xf000e05b
   0xffff7:	das  
   (gdb) x /10i 0xfe05b
   0xfe05b:	cmpw   $0xffa4,%cs:(%esi)
   0xfe060:	add    %cl,%gs:(%edi)
   0xfe063:	test   %edx,-0xe(%ebx)
   0xfe066:	xor    %eax,%eax
   0xfe068:	mov    %eax,%ss
   0xfe06a:	mov    $0x7000,%sp
   0xfe06e:	add    %al,(%eax)
   0xfe070:	mov    $0x3c4f,%dx
   0xfe074:	verw   %cx
   0xfe077:	mov    $0xf0,%cl
```

BIOS 里面的代码没啥好看的，都是写上电自检等硬件相关的例程，不需要过多关心。

### 2.10.2 在初始化位置 0x7c00 设置实地址断点来测试

`tools/gdbinit` 中的内容修改如下。

```gdb
file bin/kernel
target remote :1234
set architecture i8086
b *0x7c00
continue
x /2i $pc
```

运行 `make debug-nox` 调试，结果如下。

```gdb
Breakpoint 1, 0x00007c00 in ?? ()
=> 0x7c00:	cli    
   0x7c01:	cld  
```

### 2.10.3 从 0x7c00 开始跟踪代码运行，将单步跟踪反汇编得到的代码与 bootasm.S 和 bootblock.asm 进行比较

运行 `make debug-nox`，执行 `x /32i $pc` 查看 pc 指针的数据。

```gdb
(gdb) x /32i $pc
=> 0x7c00:	cli    
   0x7c01:	cld    
   0x7c02:	xor    %ax,%ax
   0x7c04:	mov    %ax,%ds
   0x7c06:	mov    %ax,%es
   0x7c08:	mov    %ax,%ss
   0x7c0a:	in     $0x64,%al
   0x7c0c:	test   $0x2,%al
   0x7c0e:	jne    0x7c0a
   0x7c10:	mov    $0xd1,%al
   0x7c12:	out    %al,$0x64
   0x7c14:	in     $0x64,%al
   0x7c16:	test   $0x2,%al
   0x7c18:	jne    0x7c14
   0x7c1a:	mov    $0xdf,%al
   0x7c1c:	out    %al,$0x60
   0x7c1e:	lgdtw  0x7c6c
   0x7c23:	mov    %cr0,%eax
   0x7c26:	or     $0x1,%eax
   0x7c2a:	mov    %eax,%cr0
   0x7c2d:	ljmp   $0x8,$0x7c32
   0x7c32:	mov    $0xd88e0010,%eax
   0x7c38:	mov    %ax,%es
   0x7c3a:	mov    %ax,%fs
   0x7c3c:	mov    %ax,%gs
   0x7c3e:	mov    %ax,%ss
   0x7c40:	mov    $0x0,%bp
   0x7c43:	add    %al,(%bx,%si)
   0x7c45:	mov    $0x7c00,%sp
   0x7c48:	add    %al,(%bx,%si)
   0x7c4a:	call   0x7cfe
   0x7c4d:	add    %al,(%bx,%si)

```

看到 `call bootmain` 对应的汇编代码如下。

```gdb
   0x7c4a:	call   0x7cfe
```

设置断点并继续执行，跳转到 `bootmain` 的执行代码。

```gdb
(gdb) b *0x7c4a
Breakpoint 2 at 0x7c4a
(gdb) c
Continuing.

Breakpoint 2, 0x00007c4a in ?? ()
(gdb) x /2i $pc
=> 0x7c4a:	call   0x7cfe
   0x7c4d:	add    %al,(%bx,%si)
```

把磁盘的前 4K 字节读入 0x10000 位置处，磁盘对应 ucore.img。

这前 4K 个字节包含了 ELF 头部。

然后执行 ELF 头部所指示的入口点（通过 `readelf -eW kernel` 可以查看 ucore.img 的入口点）。

```bash
moocos-> readelf -eW kernel
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x100000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          64136 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         3
  Size of section headers:           40 (bytes)
  Number of section headers:         11
  Section header string table index: 8

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        00100000 001000 003572 00  AX  0   0  1
  [ 2] .rodata           PROGBITS        00103580 004580 00090c 00   A  0   0 32
  [ 3] .stab             PROGBITS        00103e8c 004e8c 00780d 0c   A  4   0  4
  [ 4] .stabstr          STRTAB          0010b699 00c699 002010 00   A  0   0  1
  [ 5] .data             PROGBITS        0010e000 00f000 000a16 00  WA  0   0 32
  [ 6] .bss              NOBITS          0010ea20 00fa16 001360 00  WA  0   0 32
  [ 7] .comment          PROGBITS        00000000 00fa16 000024 01  MS  0   0  1
  [ 8] .shstrtab         STRTAB          00000000 00fa3a 00004c 00      0   0  1
  [ 9] .symtab           SYMTAB          00000000 00fc40 001950 10     10  81  4
  [10] .strtab           STRTAB          00000000 011590 000f1b 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x001000 0x00100000 0x00100000 0x0d6a9 0x0d6a9 R E 0x1000
  LOAD           0x00f000 0x0010e000 0x0010e000 0x00a16 0x01d80 RW  0x1000
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x10

 Section to Segment mapping:
  Segment Sections...
   00     .text .rodata .stab .stabstr 
   01     .data .bss 
   02     
```

之后程序就跳转到地址 0x100000 处执行。

> 注意：ucore.img 加载的位置是 0x1 0000，程序跳转执行的位置是 0x10 0000。

然后 `b *0x100000` 和 `c` 就可以看到程序跳转到内核初始化的代码部分了，至此，内核执行前的准备工作已经全部完成。

即：禁用中断，设置数据段寄存器，使能A20引脚，加载 GDT，进入保护模式，跳转到 bootmain，读取 ELF 头头部，跳转到内核初始化代码处。

### 2.10.4 内初初始化的操作逻辑

在 `tools/kernel.ld` 文件中定义了内核的各个段的分布情况。

1. 数据段之后的所有内容全部用 0 填充，即 `.bss` 段；
2. 初始化控制台；
3. 打印欢迎信息；
4. 打印内核信息。

## 2.11 基本 kernel 的实现

[ucore操作系统学习(一) ucore lab1系统启动流程分析](https://www.cnblogs.com/xiaoxiongcanguan/p/13714587.html)

[ucore操作系统](https://zhuanlan.zhihu.com/p/56678174)

在 bootloader 将 ucore 的 kernel 内核完整的加载至内存，并通过 ELF 文件头中指定的 entry 入口跳转至内核入口，即 `/kern/init.c` 中的 kern_init 函数。

kern_init 函数是内核的总控函数，内核中的各个组成部分都在 kern_init 函数中完成初始化。

### 2.11.1 kern_init 

1. 初始化与各种硬件的交互；
    - 显卡；
    - 中断控制器；
    - 定时器；
    - 其他；
2. 另一方面初始化各种内核功能；
    - 物理内存管理器；
    - 中断描述符表 IDT；
    - 其他；
3. 通过一个自旋死循环令操作系统常驻内存；
4. 监听各种中断提供操作系统服务并作出响应。

```c
void
kern_init(void){
    ...
    // 初始化控制台（控制显卡交互）；
    // 只有设置好了对显卡的控制后，std_out 输出的信息（例如 cprintf）才能显示在控制台中；
    cons_init();               
    ...
    // 初始化物理内存管理器；
    pmm_init();

    // 初始化中断控制器；
    pic_init();                
    // 初始化中断描述符表；
    idt_init();

    // 初始化定时芯片；
    clock_init();
    // 开中断；
    intr_enable();              
    ...
    // 阻塞，避免内核程序退出。通过监听中断事件进行服务；
    while (1);
}
```

从 `kern_init` 的实现中可以看出，其依次完成了如下的 6 个工作。

1. cons_init：初始化控制台（控制显卡交互）；
2. pmm_init：初始化物理内存管理器；
3. pic_init：初始化中断控制器；
    - 内部通过与 8259A 中断控制器芯片进行交互，令 ucore 能够接收到来自硬件的各种中断请求；
4. idt_init：初始化中断描述符表；
5. clock_init：初始化定时器；
    - 进行 8253 定时器的相关设置，将其设置为 10ms 发起一次时钟中断；
6. intr_enable：完成了内核结构的初始化后，开启中断；
    - 至此 ucore 内核正式开始运行。

### 2.11.2 初始化控制台

[cprintf函数调用到屏幕(cga)输出流程分析](https://blog.csdn.net/old_memory/article/details/79927282)

[并行端口](https://baike.baidu.com/item/%E5%B9%B6%E8%A1%8C%E7%AB%AF%E5%8F%A3/494023?fr=aladdin)

```c
/*
 * 函数功能：初始化终端设备；
 */
void
cons_init(void) {
    cga_init();         // 并口初始化；
    serial_init();      // 串口初始化；
    kbd_init();         // 键盘初始化；
    if (!serial_exists) {
        cprintf("serial port does not exist!!\n");
    }
}
```

### 2.11.3 初始化物理内存管理器

```c
/*
 * 函数功能：初始化终端设备；
 */
void
pmm_init(void) {
    gdt_init();
}
```

### 2.11.4 初始化中断控制器

操作系统如果要正确处理各种不同的中断事件，就需要安排应该由哪个中断服务例程负责处理特定的中断事件。

系统将所有的中断事件统一进行了编号（0 ~ 255），这个编号称为中断向量。

`trap` 函数（定义在 `trap.c` 中）是对中断进行处理的过程，所有的中断在经过中断入口函数 `__alltraps` 预处理后 (定义在 `trapasm.S` 中) ，都会跳转到这里。

在处理过程中，根据不同的中断类型，进行相应的处理。

在相应的处理过程结束以后，`trap` 将会返回，被中断的程序会继续运行。

1. trapasm.S
    - 产生中断后，CPU 跳转到相应的中断处理入口 (`vectors`)；
    - 并在桟中压入相应的 `error_code`（是否存在与异常号相关）以及 `trap_no`；
    - 然后跳转到 `alltraps` 函数入口；
    - 在栈中保存当前被打断程序的 `trapframe` 结构 (trapasm.S)；
    - 设置 kernel (内核) 的数据段寄存器
    - 最后压入 esp，作为 trap 函数参数 (struct trapframe * tf) 并跳转到中断处理函数 trap 处；
        - 此时的跳转是 call 调用，会压入返回地址 eip；
        - 注意区分此处 eip 与 trapframe 中 eip；
    - 进入 trap 函数，对中断进行相应的处理；
2. trap.c
    - 详细的中断分类以及处理流程如下。
    - 根据中断号对不同的中断进行处理；
        - 若中断号是 IRQ_OFFSET + IRQ_TIMER，为时钟中断，则把 ticks 将增加 1；
        - 若中断号是 IRQ_OFFSET + IRQ_COM1，为串口中断，则显示收到的字符；
        - 若中断号是 IRQ_OFFSET + IRQ_KBD 为键盘中断，则显示收到的字符；
        - 若为其他中断且产生在内核状态，则挂起系统；
3. trapasm.S
    - 结束 trap 函数的执行后，通过 ret 指令返回到 alltraps 执行过程；
    - 从栈中恢复所有寄存器的值；
    - 调整 esp 的值；
        - 跳过栈中的 trap_no 与 error_code，使 esp 指向中断返回 eip；
        - 通过 iret 调用恢复 cs、eflag 以及 eip，继续执行。

### 2.11.5 x86.h

[内联汇编官网](https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints)

在 `内联汇编官网` 搜索 x86，然后就能看到关于 `"A"` 约束的描述。

- 表示 eax 和 ebx 寄存器对，用来返回双字结果；
- 如果是单字的话，那么就会被随机分配到 eax 或者 ebx 中。

#### 2.11.5.1 do_div(n, base)

- `div val` 指令将 `ax, ax:ax, edx:eax, rdx:rax` 中存储的数除以`val`，并将结果存储在 `ax, ax:ax, edx:eax, rdx:rax` 中；
  - 商存在 rax 中，余数存在 rdx 中；
  - `val` 的字节数对应使用何种寄存器；
    - 例如 64 字节，则使用 rdx 和 rax。

代码的整体结构如下。

```assembly
#define do_div(n, base) ({                                        \
    unsigned long __upper, __low, __high, __mod, __base;        \
    __base = (base);                                            \
    asm("" : "=a" (__low), "=d" (__high) : "A" (n));            \
    __upper = __high;                                            \
    if (__high != 0) {                                            \
        __upper = __high % __base;                                \
        __high = __high / __base;                                \
    }                                                            \
    asm("divl %2" : "=a" (__low), "=d" (__mod)                    \
        : "rm" (__base), "0" (__low), "1" (__upper));            \
    asm("" : "=A" (n) : "a" (__low), "d" (__high));                \
    __mod;                                                        \
})                                       \
```

上面一整段的操作逻辑就是：`n / base ` 商存在`n` 中，余数存在 `mod` 中，并返回 `mod`。


#### 2.11.5.2 inb(unint16_t port)

从16位端口 port 读取 1 个字节存放到 data 中。

#### 2.11.5.3 insl(unit32_t port, void *addr, int cnt)

- **cld**：DF 置 0，ESI 或者 EDI 自增；

- The REP (repeat)

- REPE (repeat while equal)

- REPNE (repeat while not equal)：重复执行一个字符串操作指令；

- REPZ (repeat while zero)

- REPNZ (repeat while not zero) ：ZF = 0 表示运算结果非 0，则一直执行，直到 ZF = 1；

- **ins**：从指定的 I/O 端口读取到 ES:DI，ES:EDI 或者 RDI 及寄存器指定的内存地址；
  - 端口号由 DX 寄存器制定；

  - `"=D"` 表示 `edi` 约束；

  - `"cc"` 表示汇编代码会修改标志寄存器；

  - `"memory"` 表示汇编代码对输入和输出操作数中列出的项以外的项执行内存读取或写入操作（例如，访问其中一个输入参数指向的内存）；
    - 为确保内存包含正确的值，GCC 可能需要在执行 asm 之前将特定的寄存器值刷新到内存中；
    - 此外，编译器不会假定在 asm 执行前，从内存读取的数据会在 asm 执行后仍然保持不变；
    - 它会根据需要重新加载它们；
    - 使用 memory clobber 有效地形成了编译器的读/写内存屏障；
    - 将寄存器的值刷到内存会对性能产生影响；
    - memory clobber 使得 GCC 认为任何内存都可以由 asm 块任意读取或写入，因此会阻止编译器重新排序加载或存储在其中。

> 不管是编译器重排指令，还是 CPU 乱序处理，都要遵守一个最基本的原则：”不能违反指令之间的依赖“，即有依赖的指令之间是不能够重排或乱序的。

简单来说，memory 就是告诉编译器，这段汇编代码段我修改了内存，所以这段汇编代码前面的指令不能乱序到后面执行，后面的指令不能乱序到前面执行，就相当于一个内存屏障一样。

主要是防止 `-fschedule-insns` 优化时做代码重排。

从 32 位端口 port 读取 cnt 个字节到 addr 指向的内存区域。

#### 2.11.5.4 sti

设置中断标志位 IF，允许处理器响应可屏蔽硬件中断。

#### 2.11.5.5 cli

清除中断标志位 IF，使得处理器忽略可屏蔽外部中断。

- 这两个指令只能在内核模式下执行，不可以在用户模式下执行；
- 而且在内核模式下执行时，应该尽可能快的恢复中断，因为 CLI 会禁用硬件中断；
- 若长时间禁止中断会影响其他动作的执行（如移动鼠标等等），系统就会变得不稳定；
- 在标志寄存器中中断标志清零的情况下，可以以 int ×× 的形式调用软中断。

#### 2.11.5.6 ltr

加载任务寄存器。









$$
\left\{
    \begin{array}{}
        n = x:y; \\
    \_high = x; \\
    \_low = y; \\
    \_base = b; \\
    \_upper = u;
    \end{array}
\right.\\
u =  x \% b; \\
x = x / b; \\
u:y / b ==> 商给 \_low, 余数给 \_mod
x:\_low 组成了商，\_mod形成了余数。
$$










### 2.11.5 初始化中断描述符表

操作系统内核启动以后，会通过 `idt_init` 函数初始化 idt 表，而其中 `vectors` 中存储了中断处理程序的入口地址。

`vectors` 定义在 `vector.S` 文件中，通过一个工具程序 `vector.c` 生成，其中定义了每个中断的入口程序和入口地址 (保存在 `vectors` 数组中)。。

`vectors` 中仅有 `System call` 中断的权限为用户权限 (`DPL_USER`)，即仅能够使用 `int 0x30` 指令。

其中，中断可以分成 2 类。

1. 压入错误编码 (error code)；
2. 不压入错误编码；

- vector.S 自动压入一个 0；
- 压入相应中断的中断号；
- 在压入 2 个必要的参数之后，中断处理函数跳转到统一的入口 `alltraps` 处。



### 2.11.6 初始化定时器

时钟是一种有着特殊作用的外设，其作用并不仅仅是计时。

正是由于有了规律的时钟中断，才使得无论当前 CPU 运行在哪里，操作系统都可以在预先确定的时间点上获得 CPU 控制权。

当一个应用程序运行了一定时间后，操作系统会通过时钟中断获得 CPU 控制权，并可把 CPU 资源让给更需要 CPU 的其他应用程序。

`vectors` 对 `tickslock` 的初始化，该锁用于处理时钟中断。



