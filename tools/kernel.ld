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
