#ifndef __LIBS_ELF_H__
#define __LIBS_ELF_H__

#include <defs.h>

#define ELF_MAGIC    0x464C457FU            // "\x7FELF" in little endian

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

/* program section header */
struct proghdr {
    uint32_t p_type;   // loadable code or data, dynamic linking info,etc.
    uint32_t p_offset; // file offset of segment
    uint32_t p_va;     // virtual address to map segment
    uint32_t p_pa;     // physical address, not used
    uint32_t p_filesz; // size of segment in file
    uint32_t p_memsz;  // size of segment in memory (bigger if contains bss）
    uint32_t p_flags;  // read/write/execute bits
    uint32_t p_align;  // required alignment, invariably hardware page size
};

#endif /* !__LIBS_ELF_H__ */

