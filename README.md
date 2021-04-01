
# 一、顶层规划

1. 第 1 问：如何配置和使用 qemu 来和我们写的代码关联起来？（答：2.1 启动 qemu ）
2. 第 2 问：ucore.img 是如何生成的？（答：2.2 生成 ucore.img ）
3. 第 3 问：bootblock 是如何生成？（答：2.3 生成 bootblock ）
4. 第 4 问：上电之后，bootblock 是如何一步一步将 CPU 启动，最后运行内核的？（答：2.4 bootblock 的实现 ）

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

## 2.4 bootblock 的实现

`elf.h` 中对 elf 文件头部信息声明的结构体如下。

```c
#define ELF_MAGIC    0x464C457FU  

/* file header */
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




