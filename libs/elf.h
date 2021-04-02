#ifndef __LIBS_ELF_H__
#define __LIBS_ELF_H__

#include <defs.h>

#define ELF_MAGIC    0x464C457FU            // "\x7FELF" in little endian

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
    uint16_t e_shentsize; // 节区头部里入口的大小；
    uint16_t e_shnum;     // 节区头部里入口的数量，或者为 0；
    uint16_t e_shstrndx;  // 包含段名称字符串的节区编号； 
};

// {
//     e_magic = 1179403647,    // 0x464C457F
//     e_elf = "\001\001\001\000\000\000\000\000\000\000\000", 
//     e_type = 2, 
//     e_machine = 3,
//     e_version = 1, 
//     e_entry = 1048576,       // 0x100000
//     e_phoff = 52,            // 0x34
//     e_shoff = 64136,         // 0xFA88
//     e_flags = 0, 
//     e_ehsize = 52,           // 0x34
//     e_phentsize = 32,        // 0x20
//     e_phnum = 3, 
//     e_shentsize = 40,        // 0x28
//     e_shnum = 11, 
//     e_shstrndx = 8
// }

// 程序段头部；
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

// {
//     p_type = 1, 
//     p_offset = 4096,     // 0x1000
//     p_va = 1048576,      // 0x100000
//     p_pa = 1048576,      // 0x100000
//     p_filesz = 54953,    // 0xD6A9
//     p_memsz = 54953,     // 0xD6A9
//     p_flags = 5,         // 0x5
//     p_align = 4096       // 0x1000
// }

#endif /* !__LIBS_ELF_H__ */

